From: Linus Torvalds <torvalds@osdl.org>
Subject: Use git config file for committer name and email info
Date: Tue, 11 Oct 2005 17:54:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510111735300.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 12 02:56:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPUts-0002RW-C4
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 02:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVJLAzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 20:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVJLAzH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 20:55:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751102AbVJLAzG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 20:55:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9C0sj4s013802
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Oct 2005 17:54:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9C0sidD006505;
	Tue, 11 Oct 2005 17:54:45 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9994>


This starts using the "user.name" and "user.email" config variables if
they exist as the default name and email when committing.  This means
that you don't have to use the GIT_COMMITTER_EMAIL environment variable
to override your email - you can just edit the config file instead.

The patch looks bigger than it is because it makes the default name and
email information non-static and renames it appropriately.  And it moves
the common git environment variables into a new library file, so that
you can link against libgit.a and get the git environment without having
to link in zlib and libcrypt.

In short, most of it is renaming and moving, the real change core is
just a few new lines in "git_default_config()" that copies the user
config values to the new base.

It also changes "git-var -l" to list the config variables.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

With this, you can now have a .git/config file that has something like 
this in it:

	[user]
	   name = Linus Torvalds
	   email = torvalds@osdl.org

	[core]
	   filemode = false

and it will do the obvious thing. The "user.name" and "user.email" 
variables will be used by default for the name information, overriding any 
system information from /etc/passwd etc.

NOTE! The GIT_{COMMITTER|AUTHOR}_NAME and GIT_{COMMITTER|AUTHOR}_EMAIL 
environment variables continue to override any config file information. 

Also, we should probably verify that the name/email is valid (ie doesn't 
contain any of the characters "<>\n" that could cause invalid commit 
objects).

The fact that "git-var -l" now also shows all config info can be useful. 

For example, scripts can use it to pick up stuff from the config file, ie 
we could make "git tag" get the default key from there by adding something 
like

	key=$(git-var -l | sed -n '/^user\.key=/ { s/user.key=//;p;q}')

to the script, which again allows us to have a convenient default value in 
the config file without littering us up with more environment variables.

Hmm?

This hasn't gotten a ton of testing, but I did do a test-commit with this, 
and it all seems to work.

---
 Makefile      |    2 +-
 cache.h       |    4 +++
 commit-tree.c |    4 ++-
 config.c      |   10 ++++++++
 environment.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ident.c       |   30 +++++++++++------------
 read-cache.c  |    1 -
 sha1_file.c   |   59 ---------------------------------------------
 var.c         |   11 ++++++++
 9 files changed, 118 insertions(+), 78 deletions(-)

diff --git a/Makefile b/Makefile
index 8697d52..ee3a752 100644
--- a/Makefile
+++ b/Makefile
@@ -158,7 +158,7 @@ LIB_OBJS = \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
-	tag.o tree.o usage.o config.o $(DIFF_OBJS)
+	tag.o tree.o usage.o config.o environment.o $(DIFF_OBJS)
 
 LIBS = $(LIB_FILE)
 LIBS += -lz
diff --git a/cache.h b/cache.h
index 41cc22c..1a7e047 100644
--- a/cache.h
+++ b/cache.h
@@ -382,4 +382,8 @@ extern int git_config(config_fn_t fn);
 extern int git_config_int(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
 
+#define MAX_GITNAME (1000)
+extern char git_default_email[MAX_GITNAME];
+extern char git_default_name[MAX_GITNAME];
+
 #endif /* CACHE_H */
diff --git a/commit-tree.c b/commit-tree.c
index b1ef0b5..030fb70 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -89,6 +89,9 @@ int main(int argc, char **argv)
 	char *buffer;
 	unsigned int size;
 
+	setup_ident();
+	git_config(git_default_config);
+
 	if (argc < 2 || get_sha1_hex(argv[1], tree_sha1) < 0)
 		usage(commit_tree_usage);
 
@@ -104,7 +107,6 @@ int main(int argc, char **argv)
 	}
 	if (!parents)
 		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
-	setup_ident();
 
 	init_buffer(&buffer, &size);
 	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
diff --git a/config.c b/config.c
index 510456c..cf80358 100644
--- a/config.c
+++ b/config.c
@@ -207,6 +207,16 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "user.name")) {
+		strncpy(git_default_name, value, sizeof(git_default_name));
+		return 0;
+	}
+
+	if (!strcmp(var, "user.email")) {
+		strncpy(git_default_email, value, sizeof(git_default_email));
+		return 0;
+	}
+
 	/* Add other config variables here.. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
new file mode 100644
index 0000000..1dc7af5
--- /dev/null
+++ b/environment.c
@@ -0,0 +1,75 @@
+/*
+ * We put all the git config variables in this same object
+ * file, so that programs can link against the config parser
+ * without having to link against all the rest of git.
+ *
+ * In particular, no need to bring in libz etc unless needed,
+ * even if you might want to know where the git directory etc
+ * are.
+ */
+#include "cache.h"
+
+char git_default_email[MAX_GITNAME];
+char git_default_name[MAX_GITNAME];
+int trust_executable_bit = 1;
+
+static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
+	*git_graft_file;
+static void setup_git_env(void)
+{
+	git_dir = getenv(GIT_DIR_ENVIRONMENT);
+	if (!git_dir)
+		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+	git_object_dir = getenv(DB_ENVIRONMENT);
+	if (!git_object_dir) {
+		git_object_dir = xmalloc(strlen(git_dir) + 9);
+		sprintf(git_object_dir, "%s/objects", git_dir);
+	}
+	git_refs_dir = xmalloc(strlen(git_dir) + 6);
+	sprintf(git_refs_dir, "%s/refs", git_dir);
+	git_index_file = getenv(INDEX_ENVIRONMENT);
+	if (!git_index_file) {
+		git_index_file = xmalloc(strlen(git_dir) + 7);
+		sprintf(git_index_file, "%s/index", git_dir);
+	}
+	git_graft_file = getenv(GRAFT_ENVIRONMENT);
+	if (!git_graft_file)
+		git_graft_file = strdup(git_path("info/grafts"));
+}
+
+char *get_git_dir(void)
+{
+	if (!git_dir)
+		setup_git_env();
+	return git_dir;
+}
+
+char *get_object_directory(void)
+{
+	if (!git_object_dir)
+		setup_git_env();
+	return git_object_dir;
+}
+
+char *get_refs_directory(void)
+{
+	if (!git_refs_dir)
+		setup_git_env();
+	return git_refs_dir;
+}
+
+char *get_index_file(void)
+{
+	if (!git_index_file)
+		setup_git_env();
+	return git_index_file;
+}
+
+char *get_graft_file(void)
+{
+	if (!git_graft_file)
+		setup_git_env();
+	return git_graft_file;
+}
+
+
diff --git a/ident.c b/ident.c
index 562f5f1..7a9f567 100644
--- a/ident.c
+++ b/ident.c
@@ -11,9 +11,7 @@
 #include <time.h>
 #include <ctype.h>
 
-static char real_email[1000];
-static char real_name[1000];
-static char real_date[50];
+static char git_default_date[50];
 
 static void copy_gecos(struct passwd *w, char *name, int sz)
 {
@@ -58,22 +56,22 @@ int setup_ident(void)
 		die("You don't exist. Go away!");
 
 	/* Get the name ("gecos") */
-	copy_gecos(pw, real_name, sizeof(real_name));
+	copy_gecos(pw, git_default_name, sizeof(git_default_name));
 
 	/* Make up a fake email address (name + '@' + hostname [+ '.' + domainname]) */
 	len = strlen(pw->pw_name);
-	if (len > sizeof(real_email)/2)
+	if (len > sizeof(git_default_email)/2)
 		die("Your sysadmin must hate you!");
-	memcpy(real_email, pw->pw_name, len);
-	real_email[len++] = '@';
-	gethostname(real_email + len, sizeof(real_email) - len);
-	if (!strchr(real_email+len, '.')) {
-		len = strlen(real_email);
-		real_email[len++] = '.';
-		getdomainname(real_email+len, sizeof(real_email)-len);
+	memcpy(git_default_email, pw->pw_name, len);
+	git_default_email[len++] = '@';
+	gethostname(git_default_email + len, sizeof(git_default_email) - len);
+	if (!strchr(git_default_email+len, '.')) {
+		len = strlen(git_default_email);
+		git_default_email[len++] = '.';
+		getdomainname(git_default_email+len, sizeof(git_default_email)-len);
 	}
 	/* And set the default date */
-	datestamp(real_date, sizeof(real_date));
+	datestamp(git_default_date, sizeof(git_default_date));
 	return 0;
 }
 
@@ -159,10 +157,10 @@ char *get_ident(const char *name, const 
 	int i;
 
 	if (!name)
-		name = real_name;
+		name = git_default_name;
 	if (!email)
-		email = real_email;
-	strcpy(date, real_date);
+		email = git_default_email;
+	strcpy(date, git_default_date);
 	if (date_str)
 		parse_date(date_str, date, sizeof(date));
 
diff --git a/read-cache.c b/read-cache.c
index c7f3b26..d2aebdd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,7 +5,6 @@
  */
 #include "cache.h"
 
-int trust_executable_bit = 1;
 struct cache_entry **active_cache = NULL;
 unsigned int active_nr = 0, active_alloc = 0, active_cache_changed = 0;
 
diff --git a/sha1_file.c b/sha1_file.c
index 6e3ea23..f059004 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -48,65 +48,6 @@ int get_sha1_hex(const char *hex, unsign
 	return 0;
 }
 
-static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
-	*git_graft_file;
-static void setup_git_env(void)
-{
-	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-	if (!git_dir)
-		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
-	git_object_dir = getenv(DB_ENVIRONMENT);
-	if (!git_object_dir) {
-		git_object_dir = xmalloc(strlen(git_dir) + 9);
-		sprintf(git_object_dir, "%s/objects", git_dir);
-	}
-	git_refs_dir = xmalloc(strlen(git_dir) + 6);
-	sprintf(git_refs_dir, "%s/refs", git_dir);
-	git_index_file = getenv(INDEX_ENVIRONMENT);
-	if (!git_index_file) {
-		git_index_file = xmalloc(strlen(git_dir) + 7);
-		sprintf(git_index_file, "%s/index", git_dir);
-	}
-	git_graft_file = getenv(GRAFT_ENVIRONMENT);
-	if (!git_graft_file)
-		git_graft_file = strdup(git_path("info/grafts"));
-}
-
-char *get_git_dir(void)
-{
-	if (!git_dir)
-		setup_git_env();
-	return git_dir;
-}
-
-char *get_object_directory(void)
-{
-	if (!git_object_dir)
-		setup_git_env();
-	return git_object_dir;
-}
-
-char *get_refs_directory(void)
-{
-	if (!git_refs_dir)
-		setup_git_env();
-	return git_refs_dir;
-}
-
-char *get_index_file(void)
-{
-	if (!git_index_file)
-		setup_git_env();
-	return git_index_file;
-}
-
-char *get_graft_file(void)
-{
-	if (!git_graft_file)
-		setup_git_env();
-	return git_graft_file;
-}
-
 int safe_create_leading_directories(char *path)
 {
 	char *pos = path;
diff --git a/var.c b/var.c
index 3f13126..51cf86a 100644
--- a/var.c
+++ b/var.c
@@ -42,6 +42,15 @@ static const char *read_var(const char *
 	return val;
 }
 
+static int show_config(const char *var, const char *value)
+{
+	if (value)
+		printf("%s=%s\n", var, value);
+	else
+		printf("%s\n", var);
+	return git_default_config(var, value);
+}
+
 int main(int argc, char **argv)
 {
 	const char *val;
@@ -52,9 +61,11 @@ int main(int argc, char **argv)
 	val = NULL;
 
 	if (strcmp(argv[1], "-l") == 0) {
+		git_config(show_config);
 		list_vars();
 		return 0;
 	}
+	git_config(git_default_config);
 	val = read_var(argv[1]);
 	if (!val)
 		usage(var_usage);
