From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: [PATCH v2] allow user aliases for the --author parameter
Date: Tue, 26 Aug 2008 10:02:56 +0200
Message-ID: <48B3B8B0.4020609@fastmail.fm>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080822211902.GA31884@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 10:04:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXtXH-000837-Js
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 10:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbYHZIDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 04:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbYHZIDO
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 04:03:14 -0400
Received: from main.gmane.org ([80.91.229.2]:34681 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbYHZIDL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 04:03:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KXtW8-0003ZZ-S6
	for git@vger.kernel.org; Tue, 26 Aug 2008 08:03:09 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 08:03:08 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 08:03:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <20080822211902.GA31884@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93723>

This allows the use of author abbreviations when specifying commit
authors via the --author option to git commit. "--author=$key" is
resolved by looking up "user.$key.name" and "user.$key.email" in the
config.

In an ideal word, all my collaborators would exchange changes as git
patches (or even via pull/push). In the real world, they send new
versions which I integrate (after dealing with their whitespace and
encoding changes...). Therefore, being able to say "git commit
--author=mickey" and having git translate "mickey" into "Mickey Mouse
<mickey@ducktown.us>" is a real time saver. The patch accomplishes
this by reading config keys "user.mickey.name" and "user.mickey.email"
when encountering an --author argument without "<>".

Signed-off-by: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
---

I tried to apply everything I've learned from this thread:
- Justification in commit message rather than cover
- minor style adjustments
- xstrdup two more strings to spare future leakage cleanup-a-thons a few
  unpleasant surprises
- comes with documentation patch now

I think the relation to and distinction from "git-svn -A" and ".mailmap"
has become clear through the discussion (should a summary go in the commit
message?).
I really like Junio's alias (git who). It's certainly helpful. For the
case of "git commit --author key" I think we should not simply go by the
first, possibly non-unique match returned by "git show". Also, being able
to say "git commit --author=nitpicker" may make some days brighter ;)

 Documentation/config.txt     |    8 +++++
 Documentation/git-commit.txt |    5 ++-
 builtin-commit.c             |   67 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9020675..9bea3a3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1107,6 +1107,14 @@ user.signingkey::
 	unchanged to gpg's --local-user parameter, so you may specify a key
 	using any method that gpg supports.
 
+user.<author>.email::
+	The email address to be recorded in a newly created commit if you
+	specify the option \--author=<author> to linkgit:git-commit[1].
+
+user.<author>.name::
+	The full name to be recorded in a newly created commit if you
+	specify the option \--author=<author> to linkgit:git-commit[1].
+
 imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0e25bb8..1685cf6 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -76,7 +76,10 @@ OPTIONS
 
 --author=<author>::
 	Override the author name used in the commit.  Use
-	`A U Thor <author@example.com>` format.
+	`A U Thor <author@example.com>` format. Alternatively, if
+	<author> does not contain `<>` then the configuration
+	variables `user.<author>.name` and `user.<author>.email`
+	are used if present (see linkgit:git-config[1]).
 
 -m <msg>::
 --message=<msg>::
diff --git a/builtin-commit.c b/builtin-commit.c
index 649c8be..c36e60f 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -53,6 +53,14 @@ static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty;
 static char *untracked_files_arg;
+struct user {
+	char *name;
+	char *full_name;
+	char *email;
+};
+static struct user **users;
+static int users_alloc;
+static int users_nr;
 /*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
@@ -406,6 +414,7 @@ static const char sign_off_header[] = "Signed-off-by: ";
 static void determine_author_info(void)
 {
 	char *name, *email, *date;
+	int i;
 
 	name = getenv("GIT_AUTHOR_NAME");
 	email = getenv("GIT_AUTHOR_EMAIL");
@@ -429,10 +438,22 @@ static void determine_author_info(void)
 		date = xstrndup(rb + 2, eol - (rb + 2));
 	}
 
+	author_date = date;
+
 	if (force_author) {
 		const char *lb = strstr(force_author, " <");
 		const char *rb = strchr(force_author, '>');
 
+		if (!lb && !rb) {
+			for (i = 0; i < users_nr; i++) {
+				if (!strcmp(force_author, users[i]->name)) {
+					author_name = xstrdup(users[i]->full_name);
+					author_email = xstrdup(users[i]->email);
+					return;
+				}
+			}
+		}
+
 		if (!lb || !rb)
 			die("malformed --author parameter");
 		name = xstrndup(force_author, lb - force_author);
@@ -441,7 +462,6 @@ static void determine_author_info(void)
 
 	author_name = name;
 	author_email = email;
-	author_date = date;
 }
 
 static int prepare_to_commit(const char *index_file, const char *prefix)
@@ -888,11 +908,56 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
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
