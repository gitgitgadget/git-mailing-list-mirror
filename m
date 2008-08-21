From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: [PATCH] allow user aliases for the --author parameter
Date: Thu, 21 Aug 2008 11:19:41 +0200
Message-ID: <g8jbvd$18k$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 11:20:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW6Lh-0005OH-Bg
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 11:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbYHUJTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 05:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbYHUJTw
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 05:19:52 -0400
Received: from main.gmane.org ([80.91.229.2]:40440 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391AbYHUJTu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 05:19:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KW6Kb-0005pp-8U
	for git@vger.kernel.org; Thu, 21 Aug 2008 09:19:49 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 09:19:49 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 09:19:49 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93127>

This allows the use of author abbreviations when specifying commit
authors via the --author option to git commit. "--author=$key" is
resolved by looking up "user.$key.name" and "user.$key.email" in the
config.

Signed-off-by: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
---
In an ideal word, all my collaborators would exchange changes as git 
patches (or even via pull/push). In the real world, they send new
versions which I integrate (after dealing with their whitespace and encoding changes...).
Therefore, being able to say 
"git commit --author=mickey"
and having git translate "mickey" into "Mickey Mouse <mickey@ducktown.us>"
is a real time saver. The patch accomplishes this by reading config keys "user.mickey.name" and "user.mickey.email" when encountering an 
--author argument without "<>".

If there's interest in this patch I'll follow up with a documentation patch.

The "--committer" argument to git commit is not treated because I don't
consider it worthwhile.

Note that the implementation is different from git-svn's author file on
purpose because it serves a different purpose.

Michael

P.S.: That's my first patch here. Yes, I've read Doc/SubmittingPatches.
So, if something's wrong, please be gentle but not overly so ;) 

 builtin-commit.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 649c8be..d90e2f4 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -53,6 +53,12 @@ static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty;
 static char *untracked_files_arg;
+struct user {
+	char *name, *full_name, *email;
+};
+static struct user **users;
+static int users_alloc;
+static int users_nr;
 /*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
@@ -406,6 +412,7 @@ static const char sign_off_header[] = "Signed-off-by: ";
 static void determine_author_info(void)
 {
 	char *name, *email, *date;
+	int i;
 
 	name = getenv("GIT_AUTHOR_NAME");
 	email = getenv("GIT_AUTHOR_EMAIL");
@@ -429,10 +436,22 @@ static void determine_author_info(void)
 		date = xstrndup(rb + 2, eol - (rb + 2));
 	}
 
+	author_date = date;
+
 	if (force_author) {
 		const char *lb = strstr(force_author, " <");
 		const char *rb = strchr(force_author, '>');
 
+		if (!lb && !rb) {
+			for (i=0; i < users_nr; i++) {
+				if (!strcmp(force_author, users[i]->name)) {
+					author_name = users[i]->full_name;
+					author_email = users[i]->email;
+					return;
+				}
+			}
+		}
+
 		if (!lb || !rb)
 			die("malformed --author parameter");
 		name = xstrndup(force_author, lb - force_author);
@@ -441,7 +460,6 @@ static void determine_author_info(void)
 
 	author_name = name;
 	author_email = email;
-	author_date = date;
 }
 
 static int prepare_to_commit(const char *index_file, const char *prefix)
@@ -888,11 +906,56 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	}
 }
 
+static struct user *make_user(const char *name, int len)
+{
+	struct user *ret;
+	int i;
+
+	for (i = 0; i < users_nr; i++) {
+		if (len ? (!strncmp(name, users[i]->name, len) &&
+			   !users[i]->name[len]) :
+		    !strcmp(name, users[i]->name))
+			return users[i];
+	}
+
+	ALLOC_GROW(users, users_nr + 1, users_alloc);
+	ret = xcalloc(1, sizeof(struct user));
+	users[users_nr++] = ret;
+	if (len)
+		ret->name = xstrndup(name, len);
+	else
+		ret->name = xstrdup(name);
+
+	return ret;
+}
+
 static int git_commit_config(const char *k, const char *v, void *cb)
 {
+	const char *name;
+	const char *subkey;
+	struct user *user;
+
 	if (!strcmp(k, "commit.template"))
 		return git_config_string(&template_file, k, v);
 
+	if (!prefixcmp(k, "user.")) {
+		name = k + 5;
+		subkey = strrchr(name, '.');
+		if (!subkey)
+			return 0;
+		user = make_user(name, subkey - name);
+		if (!strcmp(subkey, ".name")) {
+			if (!v)
+				return config_error_nonbool(k);
+			user->full_name = xstrdup(v);
+		} else if (!strcmp(subkey, ".email")) {
+			if (!v)
+				return config_error_nonbool(k);
+			user->email = xstrdup(v);
+		}
+		return 0;
+	}
+
 	return git_status_config(k, v, cb);
 }
 
-- 
1.6.0
