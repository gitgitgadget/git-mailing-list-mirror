From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 28 Jan 2007 00:29:31 -0800
Message-ID: <7v7iv7h7v8.fsf@assigned-by-dhcp.cox.net>
References: <7vps90lvoh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271415280.3021@xanadu.home>
	<7vhcuci0z0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701272049480.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 09:29:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB5Px-0004if-0f
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 09:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbXA1I3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 03:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbXA1I3d
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 03:29:33 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:60514 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461AbXA1I3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 03:29:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128082932.RUZQ19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 03:29:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GYUZ1W00V1kojtg0000000; Sun, 28 Jan 2007 03:28:34 -0500
In-Reply-To: <Pine.LNX.4.64.0701272049480.3021@xanadu.home> (Nicolas Pitre's
	message of "Sat, 27 Jan 2007 21:51:34 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38023>

Nicolas Pitre <nico@cam.org> writes:

> Well, it _is_ recorded:

It is recorded but not in a readily accessible way.  You have to
scan it.

I think the --pretty=oneline change to the git-log walker you
did would help it somewhat.

By the way, I think there is something wrong for an anonymous
user when coming back from detached HEAD to an existing branch.

An user 'u' (who has empty Gecos) on machine 'git.ster' did:

	$ git checkout master^
        $ git checkout -f master

and got these two entries:

9414... f491... u <u@git.ster> 1169971276 -0800 checkout: moving to master^
f491... 9414... u <>        checkout: moving to master

The latter entry is corrupt; adding setup_ident() before
git_config() in builtin-symbolic-ref.c would fix it.

diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index d41b406..c184679 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -27,6 +27,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	const char *msg = NULL;
 
+	setup_ident();
 	git_config(git_default_config);
 
 	while (1 < argc) {

But now I am thinking maybe we should rearrange things so that
we do not have to do setup_ident() in each and every programs.

It used to be a sensible way because only commit and tag making
program needed to do so, but with reflog leaving the committer
names from everywhere, it does not make much sense anymore.

-- >8 --
[PATCH] don't force everybody to call setup_ident().

Back when only handful commands that created commit and tag were
the only users of committer identity information it made sense
to explicitly calling setup_ident() to pre-fill the default
value from the gecos information.  But it is much simpler for
programs to make the call automatic when get_ident() is called.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 ident.c                |   51 ++++++++++++++++++++++++++++++++---------------
 builtin-branch.c       |    1 -
 builtin-commit-tree.c  |    1 -
 builtin-log.c          |    1 -
 builtin-update-ref.c   |    1 -
 cache.h                |    1 -
 fetch-pack.c           |    1 -
 http-fetch.c           |    1 -
 http-push.c            |    1 -
 local-fetch.c          |    1 -
 receive-pack.c         |    1 -
 ssh-fetch.c            |    1 -
 var.c                  |    1 -
 13 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/ident.c b/ident.c
index f967790..6de7eea 100644
--- a/ident.c
+++ b/ident.c
@@ -43,19 +43,13 @@ static void copy_gecos(struct passwd *w, char *name, int sz)
 
 }
 
-int setup_ident(void)
+static void copy_email(struct passwd *pw)
 {
-	int len;
-	struct passwd *pw = getpwuid(getuid());
-
-	if (!pw)
-		die("You don't exist. Go away!");
-
-	/* Get the name ("gecos") */
-	copy_gecos(pw, git_default_name, sizeof(git_default_name));
-
-	/* Make up a fake email address (name + '@' + hostname [+ '.' + domainname]) */
-	len = strlen(pw->pw_name);
+	/*
+	 * Make up a fake email address
+	 * (name + '@' + hostname [+ '.' + domainname])
+	 */
+	int len = strlen(pw->pw_name);
 	if (len > sizeof(git_default_email)/2)
 		die("Your sysadmin must hate you!");
 	memcpy(git_default_email, pw->pw_name, len);
@@ -68,13 +62,37 @@ int setup_ident(void)
 		len = strlen(git_default_email);
 		git_default_email[len++] = '.';
 		if (he && (domainname = strchr(he->h_name, '.')))
-			strlcpy(git_default_email + len, domainname + 1, sizeof(git_default_email) - len);
+			strlcpy(git_default_email + len, domainname + 1,
+				sizeof(git_default_email) - len);
 		else
-			strlcpy(git_default_email + len, "(none)", sizeof(git_default_email) - len);
+			strlcpy(git_default_email + len, "(none)",
+				sizeof(git_default_email) - len);
 	}
+}
+
+static void setup_ident(void)
+{
+	struct passwd *pw = NULL;
+
+	/* Get the name ("gecos") */
+	if (!git_default_name[0]) {
+		pw = getpwuid(getuid());
+		if (!pw)
+			die("You don't exist. Go away!");
+		copy_gecos(pw, git_default_name, sizeof(git_default_name));
+	}
+
+	if (!git_default_email[0]) {
+		if (!pw)
+			pw = getpwuid(getuid());
+		if (!pw)
+			die("You don't exist. Go away!");
+		copy_email(pw);
+	}
+
 	/* And set the default date */
-	datestamp(git_default_date, sizeof(git_default_date));
-	return 0;
+	if (!git_default_date[0])
+		datestamp(git_default_date, sizeof(git_default_date));
 }
 
 static int add_raw(char *buf, int size, int offset, const char *str)
@@ -174,6 +192,7 @@ static const char *get_ident(const char *name, const char *email,
 	char date[50];
 	int i;
 
+	setup_ident();
 	if (!name)
 		name = git_default_name;
 	if (!email)
diff --git a/builtin-branch.c b/builtin-branch.c
index b709b2f..869e753 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -395,7 +395,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
-	setup_ident();
 	git_config(git_branch_config);
 
 	for (i = 1; i < argc; i++) {
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 0651e59..2a818a0 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -94,7 +94,6 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	unsigned int size;
 	int encoding_is_utf8;
 
-	setup_ident();
 	git_config(git_default_config);
 
 	if (argc < 2)
diff --git a/builtin-log.c b/builtin-log.c
index 56acc13..982d871 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -380,7 +380,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	char message_id[1024];
 	char ref_message_id[1024];
 
-	setup_ident();
 	git_config(git_format_config);
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index b34e598..1461937 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -13,7 +13,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	int i, delete;
 
 	delete = 0;
-	setup_ident();
 	git_config(git_default_config);
 
 	for (i = 1; i < argc; i++) {
diff --git a/cache.h b/cache.h
index 2873f9f..3902a14 100644
--- a/cache.h
+++ b/cache.h
@@ -320,7 +320,6 @@ int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
 
-extern int setup_ident(void);
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 83a1d7b..c787106 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -670,7 +670,6 @@ int main(int argc, char **argv)
 	struct stat st;
 
 	setup_git_directory();
-	setup_ident();
 	git_config(fetch_pack_config);
 
 	if (0 <= transfer_unpack_limit)
diff --git a/http-fetch.c b/http-fetch.c
index 67dfb0a..efd494a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1003,7 +1003,6 @@ int main(int argc, const char **argv)
 	int arg = 1;
 	int rc = 0;
 
-	setup_ident();
 	setup_git_directory();
 	git_config(git_default_config);
 
diff --git a/http-push.c b/http-push.c
index 0a15f53..b128c01 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2299,7 +2299,6 @@ int main(int argc, char **argv)
 	struct ref *ref;
 
 	setup_git_directory();
-	setup_ident();
 
 	remote = xcalloc(sizeof(*remote), 1);
 
diff --git a/local-fetch.c b/local-fetch.c
index cf99cb7..7cfe8b3 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -210,7 +210,6 @@ int main(int argc, const char **argv)
 	char **commit_id;
 	int arg = 1;
 
-	setup_ident();
 	setup_git_directory();
 	git_config(git_default_config);
 
diff --git a/receive-pack.c b/receive-pack.c
index c4a4757..c51f417 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -429,7 +429,6 @@ int main(int argc, char **argv)
 	if (is_repository_shallow())
 		die("attempt to push into a shallow repository");
 
-	setup_ident();
 	git_config(receive_pack_config);
 
 	if (0 <= transfer_unpack_limit)
diff --git a/ssh-fetch.c b/ssh-fetch.c
index 4c172b6..bdf51a7 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -124,7 +124,6 @@ int main(int argc, char **argv)
 	prog = getenv("GIT_SSH_PUSH");
 	if (!prog) prog = "git-ssh-upload";
 
-	setup_ident();
 	setup_git_directory();
 	git_config(git_default_config);
 
diff --git a/var.c b/var.c
index 39977b9..e585e59 100644
--- a/var.c
+++ b/var.c
@@ -56,7 +56,6 @@ int main(int argc, char **argv)
 	}
 
 	setup_git_directory();
-	setup_ident();
 	val = NULL;
 
 	if (strcmp(argv[1], "-l") == 0) {
