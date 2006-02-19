From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Delay "empty ident" errors until they really matter.
Date: Sat, 18 Feb 2006 20:56:46 -0800
Message-ID: <7v8xs8lze9.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vzmkpqco1.fsf@assigned-by-dhcp.cox.net>
	<20060218172731.GV31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Feb 19 05:56:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAgcv-00044b-Iv
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 05:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWBSE4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 23:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWBSE4s
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 23:56:48 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:3258 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750895AbWBSE4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 23:56:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060219045414.CRCT17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 23:54:14 -0500
To: git@vger.kernel.org
In-Reply-To: <20060218172731.GV31278@pasky.or.cz> (Petr Baudis's message of
	"Sat, 18 Feb 2006 18:27:31 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16423>

Previous one warned people upfront to encourage fixing their
environment early, but some people just use repositories and git
tools read-only without making any changes, and in such a case
there is not much point insisting on them having a usable ident.

This round attempts to move the error until either "git-var"
asks for the ident explicitly or "commit-tree" wants to use it.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
  Petr Baudis <pasky@suse.cz> writes:

  > One dislike from me - you shouldn't care if you ain't gonna do it - it
  > makes no sense to require valid gecos if you are never committing
  > anything.

  You are absolutely right.  This is to fix the previous one.

 cache.h       |    4 ++--
 commit-tree.c |    4 ++--
 ident.c       |   47 +++++++++++++++++++++++++----------------------
 var.c         |    6 +++---
 4 files changed, 32 insertions(+), 29 deletions(-)

749be728d469e9a0acfdc020feff17c2da510083
diff --git a/cache.h b/cache.h
index b5db01f..da73fb3 100644
--- a/cache.h
+++ b/cache.h
@@ -246,8 +246,8 @@ void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
 
 extern int setup_ident(void);
-extern const char *git_author_info(void);
-extern const char *git_committer_info(void);
+extern const char *git_author_info(int);
+extern const char *git_committer_info(int);
 
 struct checkout {
 	const char *base_dir;
diff --git a/commit-tree.c b/commit-tree.c
index b1c8dca..88871b0 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -118,8 +118,8 @@ int main(int argc, char **argv)
 		add_buffer(&buffer, &size, "parent %s\n", sha1_to_hex(parent_sha1[i]));
 
 	/* Person/date information */
-	add_buffer(&buffer, &size, "author %s\n", git_author_info());
-	add_buffer(&buffer, &size, "committer %s\n\n", git_committer_info());
+	add_buffer(&buffer, &size, "author %s\n", git_author_info(1));
+	add_buffer(&buffer, &size, "committer %s\n\n", git_committer_info(1));
 
 	/* And add the comment */
 	while (fgets(comment, sizeof(comment), stdin) != NULL)
diff --git a/ident.c b/ident.c
index 09d4d71..7c81fe8 100644
--- a/ident.c
+++ b/ident.c
@@ -46,15 +46,6 @@ static void copy_gecos(struct passwd *w,
 
 }
 
-static const char au_env[] = "GIT_AUTHOR_NAME";
-static const char co_env[] = "GIT_COMMITTER_NAME";
-static const char env_hint[] =
-"\n*** Environment problem:\n"
-"*** Your name cannot be determined from your system services (gecos).\n"
-"*** You would need to set %s and %s\n"
-"*** environment variables; otherwise you won't be able to perform\n"
-"*** certain operations because of \"empty ident\" errors.\n\n";
-
 int setup_ident(void)
 {
 	int len;
@@ -66,11 +57,6 @@ int setup_ident(void)
 	/* Get the name ("gecos") */
 	copy_gecos(pw, git_default_name, sizeof(git_default_name));
 
-	if (!*git_default_name) {
-		if (!getenv(au_env) || !getenv(co_env))
-			fprintf(stderr, env_hint, au_env, co_env);
-	}
-
 	/* Make up a fake email address (name + '@' + hostname [+ '.' + domainname]) */
 	len = strlen(pw->pw_name);
 	if (len > sizeof(git_default_email)/2)
@@ -170,8 +156,18 @@ static int copy(char *buf, int size, int
 	return offset;
 }
 
+static const char au_env[] = "GIT_AUTHOR_NAME";
+static const char co_env[] = "GIT_COMMITTER_NAME";
+static const char *env_hint =
+"\n*** Environment problem:\n"
+"*** Your name cannot be determined from your system services (gecos).\n"
+"*** You would need to set %s and %s\n"
+"*** environment variables; otherwise you won't be able to perform\n"
+"*** certain operations because of \"empty ident\" errors.\n"
+"*** Alternatively, you can use user.name configuration variable.\n\n";
+
 static const char *get_ident(const char *name, const char *email,
-			     const char *date_str)
+			     const char *date_str, int error_on_no_name)
 {
 	static char buffer[1000];
 	char date[50];
@@ -182,9 +178,14 @@ static const char *get_ident(const char 
 	if (!email)
 		email = git_default_email;
 
-	if (!*name || !*email)
-		die("empty ident %s <%s> not allowed",
-		    name, email);
+	if (!*name) {
+		if (name == git_default_name && env_hint) {
+			fprintf(stderr, env_hint, au_env, co_env);
+			env_hint = NULL; /* warn only once, for "git-var -l" */
+		}
+		if (error_on_no_name)
+			die("empty ident %s <%s> not allowed", name, email);
+	}
 
 	strcpy(date, git_default_date);
 	if (date_str)
@@ -201,16 +202,18 @@ static const char *get_ident(const char 
 	return buffer;
 }
 
-const char *git_author_info(void)
+const char *git_author_info(int error_on_no_name)
 {
 	return get_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
-			 getenv("GIT_AUTHOR_DATE"));
+			 getenv("GIT_AUTHOR_DATE"),
+			 error_on_no_name);
 }
 
-const char *git_committer_info(void)
+const char *git_committer_info(int error_on_no_name)
 {
 	return get_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
-			 getenv("GIT_COMMITTER_DATE"));
+			 getenv("GIT_COMMITTER_DATE"),
+			 error_on_no_name);
 }
diff --git a/var.c b/var.c
index 59da56d..a57a33b 100644
--- a/var.c
+++ b/var.c
@@ -12,7 +12,7 @@ static const char var_usage[] = "git-var
 
 struct git_var {
 	const char *name;
-	const char *(*read)(void);
+	const char *(*read)(int);
 };
 static struct git_var git_vars[] = {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
@@ -24,7 +24,7 @@ static void list_vars(void)
 {
 	struct git_var *ptr;
 	for(ptr = git_vars; ptr->read; ptr++) {
-		printf("%s=%s\n", ptr->name, ptr->read());
+		printf("%s=%s\n", ptr->name, ptr->read(0));
 	}
 }
 
@@ -35,7 +35,7 @@ static const char *read_var(const char *
 	val = NULL;
 	for(ptr = git_vars; ptr->read; ptr++) {
 		if (strcmp(var, ptr->name) == 0) {
-			val = ptr->read();
+			val = ptr->read(1);
 			break;
 		}
 	}
-- 
1.2.1.g2902
