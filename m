From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] Renaming environment variables.
Date: Mon, 09 May 2005 13:05:00 -0700
Message-ID: <7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
	<2637.10.10.10.24.1115425225.squirrel@linux1>
	<7vis1vc27f.fsf@assigned-by-dhcp.cox.net>
	<2721.10.10.10.24.1115425962.squirrel@linux1>
	<7vbr7nbl89.fsf@assigned-by-dhcp.cox.net>
	<7vacn6ak7r.fsf@assigned-by-dhcp.cox.net> <427F6693.2080707@zytor.com>
	<7vll6oz755.fsf@assigned-by-dhcp.cox.net>
	<3087.10.10.10.24.1115656919.squirrel@linux1>
	<427FA5FD.1050000@zytor.com> <7vfywwz11t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon May 09 21:59:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVEP2-0005aJ-Bb
	for gcvg-git@gmane.org; Mon, 09 May 2005 21:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVEIUGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 16:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVEIUGE
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 16:06:04 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:11395 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261495AbVEIUFC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 16:05:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050509200501.SODO12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 May 2005 16:05:01 -0400
To: git@vger.kernel.org
Cc: Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfywwz11t.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 09 May 2005 11:50:22 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

H. Peter Anvin mentioned that using SHA1_whatever as an
environment variable name is not nice and we should instead use
names starting with "GIT_" prefix to avoid conflicts.

Here is a patch, requesting for comments.

 - Renames the following environment variables:

    New name                Old Name

    GIT_AUTHOR_DATE         AUTHOR_DATE
    GIT_AUTHOR_EMAIL        AUTHOR_EMAIL
    GIT_AUTHOR_NAME         AUTHOR_NAME
    GIT_COMMIT_AUTHOR_EMAIL COMMIT_AUTHOR_EMAIL
    GIT_COMMIT_AUTHOR_NAME  COMMIT_AUTHOR_NAME
    GIT_ALTERNATE_OBJECTS   SHA1_FILE_DIRECTORIES
    GIT_OBJECTS             SHA1_FILE_DIRECTORY

 - Changes all users of the environment variable to fetch
   environment variable with the new name.

 - Introduces a compatibility macro, gitenv(), which does an
   getenv() and if it fails calls gitenv_bc(), which in turn
   picks up the value from old name while giving a warning about
   using an old name.

I've also updated the documentation and scripts shipped with
Linus GIT distribution.

The transition plan is as follows:

 - We will keep the backward compatibility list used by gitenv()
   for now, so the current scripts and user environments
   continue to work as before.  The users will get warnings when
   they have old name but not new name in their environment to
   the stderr.

 - The Porcelain layers should start using new names.  However,
   just in case it ends up calling old Plumbing layer
   implementation, they should also export old names, taking
   values from the corresponding new names, during the
   transition period.

 - After a couple of weeks or so, we would drop the
   compatibility support and drop gitenv().  Revert the callers
   to directly call getenv() but keep using the new names.

   The last part is probably optional and the transition
   duration needs to be set to a reasonable value.

Not-quite-signed-off-yet-by: Junio C Hamano <junkio@cox.net>
------------

Documentation/core-git.txt |   17 +++++-----
Makefile                   |    3 +
README                     |    2 -
cache.h                    |   15 +++++++--
commit-tree.c              |   10 +++---
diff.c                     |   10 +++---
git-prune-script           |    8 +++--
gitenv.c                   |   70 +++++++++++++++++++++++++++++++++++++++++++++
init-db.c                  |    7 ++--
rsh.c                      |    4 +-
sha1_file.c                |    8 ++---
11 files changed, 120 insertions(+), 34 deletions(-)

# - HEAD: Fix git-update-cache --cacheinfo error message.
# + 7: Rename Environment Variables
--- a/Documentation/core-git.txt
+++ b/Documentation/core-git.txt
@@ -210,15 +210,16 @@ Environment Variables
 ---------------------
 Various git commands use the following environment variables:
 
-- 'AUTHOR_NAME'
-- 'AUTHOR_EMAIL'
-- 'AUTHOR_DATE'
-- 'COMMIT_AUTHOR_NAME'
-- 'COMMIT_AUTHOR_EMAIL'
+- 'GIT_AUTHOR_NAME'
+- 'GIT_AUTHOR_EMAIL'
+- 'GIT_AUTHOR_DATE'
+- 'GIT_COMMIT_AUTHOR_NAME'
+- 'GIT_COMMIT_AUTHOR_EMAIL'
 - 'GIT_DIFF_OPTS'
 - 'GIT_EXTERNAL_DIFF'
 - 'GIT_INDEX_FILE'
-- 'SHA1_FILE_DIRECTORY'
+- 'GIT_OBJECTS'
+- 'GIT_ALTERNATE_OBJECTS'
 
 
 NAME
@@ -876,7 +877,7 @@ sha1 mismatch <object>::
 Environment Variables
 ---------------------
 
-SHA1_FILE_DIRECTORY::
+GIT_OBJECTS::
 	used to specify the object database root (usually .git/objects)
 
 GIT_INDEX_FILE::
@@ -918,7 +919,7 @@ DESCRIPTION
 This simply creates an empty git object database - basically a `.git`
 directory and `.git/object/??/` directories.
 
-If the object storage directory is specified via the 'SHA1_FILE_DIRECTORY'
+If the object storage directory is specified via the 'GIT_OBJECTS'
 environment variable then the sha1 directories are created underneath -
 otherwise the default `.git/objects` directory is used.
 
--- a/Makefile
+++ b/Makefile
@@ -46,6 +46,8 @@ LIB_OBJS += strbuf.o
 LIB_H += diff.h
 LIB_OBJS += diff.o
 
+LIB_OBJS += gitenv.o
+
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
@@ -116,6 +118,7 @@ sha1_file.o: $(LIB_H)
 usage.o: $(LIB_H)
 diff.o: $(LIB_H)
 strbuf.o: $(LIB_H)
+gitenv.o: $(LIB_H)
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
--- a/README
+++ b/README
@@ -24,7 +24,7 @@ There are two object abstractions: the "
 
 
 
-	The Object Database (SHA1_FILE_DIRECTORY)
+	The Object Database (GIT_OBJECTS)
 
 
 The object database is literally just a content-addressable collection
--- a/cache.h
+++ b/cache.h
@@ -31,6 +31,13 @@
 #endif
 
 /*
+ * Environment variables transition.
+ * We accept older names for now but warn.
+ */
+extern char *gitenv_bc(const char *);
+#define gitenv(e) (getenv(e) ? : gitenv_bc(e))
+
+/*
  * Basic data structures for the directory cache
  *
  * NOTE NOTE NOTE! This is all in the native CPU byte format. It's
@@ -99,16 +106,16 @@ static inline unsigned int create_ce_mod
 struct cache_entry **active_cache;
 unsigned int active_nr, active_alloc, active_cache_changed;
 
-#define DB_ENVIRONMENT "SHA1_FILE_DIRECTORY"
+#define DB_ENVIRONMENT "GIT_OBJECTS"
 #define DEFAULT_DB_ENVIRONMENT ".git/objects"
-#define ALTERNATE_DB_ENVIRONMENT "SHA1_FILE_DIRECTORIES"
+#define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECTS"
 
-#define get_object_directory() (getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT)
+#define get_object_directory() (gitenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT)
 
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define DEFAULT_INDEX_ENVIRONMENT ".git/index"
 
-#define get_index_file() (getenv(INDEX_ENVIRONMENT) ? : DEFAULT_INDEX_ENVIRONMENT)
+#define get_index_file() (gitenv(INDEX_ENVIRONMENT) ? : DEFAULT_INDEX_ENVIRONMENT)
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -146,11 +146,11 @@ int main(int argc, char **argv)
 	datestamp(realdate, sizeof(realdate));
 	strcpy(date, realdate);
 
-	commitgecos = getenv("COMMIT_AUTHOR_NAME") ? : realgecos;
-	commitemail = getenv("COMMIT_AUTHOR_EMAIL") ? : realemail;
-	gecos = getenv("AUTHOR_NAME") ? : realgecos;
-	email = getenv("AUTHOR_EMAIL") ? : realemail;
-	audate = getenv("AUTHOR_DATE");
+	commitgecos = gitenv("GIT_COMMIT_AUTHOR_NAME") ? : realgecos;
+	commitemail = gitenv("GIT_COMMIT_AUTHOR_EMAIL") ? : realemail;
+	gecos = gitenv("GIT_AUTHOR_NAME") ? : realgecos;
+	email = gitenv("GIT_AUTHOR_EMAIL") ? : realemail;
+	audate = gitenv("GIT_AUTHOR_DATE");
 	if (audate)
 		parse_date(audate, date, sizeof(date));
 
--- a/diff.c
+++ b/diff.c
@@ -8,11 +8,11 @@
 #include "cache.h"
 #include "diff.h"
 
-static char *diff_opts = "-pu";
+static const char *diff_opts = "-pu";
 
 static const char *external_diff(void)
 {
-	static char *external_diff_cmd = NULL;
+	static const char *external_diff_cmd = NULL;
 	static int done_preparing = 0;
 
 	if (done_preparing)
@@ -26,11 +26,11 @@ static const char *external_diff(void)
 	 *
 	 * GIT_DIFF_OPTS="-c";
 	 */
-	if (getenv("GIT_EXTERNAL_DIFF"))
-		external_diff_cmd = getenv("GIT_EXTERNAL_DIFF");
+	if (gitenv("GIT_EXTERNAL_DIFF"))
+		external_diff_cmd = gitenv("GIT_EXTERNAL_DIFF");
 
 	/* In case external diff fails... */
-	diff_opts = getenv("GIT_DIFF_OPTS") ? : diff_opts;
+	diff_opts = gitenv("GIT_DIFF_OPTS") ? : diff_opts;
 
 	done_preparing = 1;
 	return external_diff_cmd;
--- a/git-prune-script
+++ b/git-prune-script
@@ -28,9 +28,13 @@ sed -ne '/unreachable /{
     s/unreachable [^ ][^ ]* //
     s|\(..\)|\1/|p
 }' | {
-	case "$SHA1_FILE_DIRECTORY" in
+	for d in "$GIT_OBJECTS" "$SHA1_FILE_DIRECTORY" ''
+	do
+		test "$d" != "" && test -d "$d" && break
+	done
+	case "$d" in
 	'') cd .git/objects/ ;;
-	*) cd "$SHA1_FILE_DIRECTORY" ;;
+	*) cd "$d" ;;
 	esac || exit
 	xargs -r $dryrun rm -f
 }
Created: gitenv.c (mode:100644)
--- /dev/null
+++ b/gitenv.c
@@ -0,0 +1,70 @@
+#include "cache.h"
+
+/*
+ * This array must be sorted by its canonical name, because
+ * we do look-up by binary search.
+ */
+static struct backward_compatible_env {
+	const char *canonical;
+	const char *old;
+} bc_name[] = {
+	{ "GIT_ALTERNATE_OBJECTS", "SHA1_FILE_DIRECTORIES" },
+	{ "GIT_AUTHOR_DATE", "AUTHOR_DATE" },
+	{ "GIT_AUTHOR_EMAIL", "AUTHOR_EMAIL" },
+	{ "GIT_AUTHOR_NAME", "AUTHOR_NAME" }, 
+	{ "GIT_COMMIT_AUTHOR_EMAIL", "COMMIT_AUTHOR_EMAIL" },
+	{ "GIT_COMMIT_AUTHOR_NAME", "COMMIT_AUTHOR_NAME" },
+	{ "GIT_OBJECTS", "SHA1_FILE_DIRECTORY" },
+};
+
+static void warn_old_environment(void)
+{
+	int i;
+	static int warned = 0;
+	if (warned)
+		return;
+
+	warned = 1;
+	fprintf(stderr,
+		"warning: GIT environment variables have been renamed.\n"
+		"warning: Please adjust your scripts and environment.\n");
+	for (i = 0; i < sizeof(bc_name) / sizeof(bc_name[0]); i++) {
+		/* warning is needed only when old name is there and
+		 * new name is not.
+		 */
+		if (!getenv(bc_name[i].canonical) && getenv(bc_name[i].old))
+			fprintf(stderr, "warning: old %s => new %s\n",
+				bc_name[i].old, bc_name[i].canonical);
+	}
+}
+
+char *gitenv_bc(const char *e)
+{
+	int first, last;
+	char *val = getenv(e);
+	if (val)
+		/* inefficient.  caller should use gitenv() not gitenv_bc() */
+		return val;
+
+	first = 0;
+	last = sizeof(bc_name) / sizeof(bc_name[0]);
+	while (last > first) {
+		int next = (last + first) >> 1;
+		int cmp = strcmp(e, bc_name[next].canonical);
+		if (!cmp) {
+			val = getenv(bc_name[next].old);
+			/* If the user has only old name, warn.
+			 * otherwise stay silent.
+			 */
+			if (val)
+				warn_old_environment();
+			return val;
+		}
+		if (cmp < 0) {
+			last = next;
+			continue;
+		}
+		first = next+1;
+	}
+	return NULL;
+}
--- a/init-db.c
+++ b/init-db.c
@@ -5,7 +5,7 @@
  */
 #include "cache.h"
 
-void safe_create_dir(char *dir)
+void safe_create_dir(const char *dir)
 {
 	if (mkdir(dir, 0755) < 0) {
 		if (errno != EEXIST) {
@@ -23,12 +23,13 @@ void safe_create_dir(char *dir)
  */
 int main(int argc, char **argv)
 {
-	char *sha1_dir, *path;
+	const char *sha1_dir;
+	char *path;
 	int len, i;
 
 	safe_create_dir(".git");
 
-	sha1_dir = getenv(DB_ENVIRONMENT);
+	sha1_dir = gitenv(DB_ENVIRONMENT);
 	if (!sha1_dir) {
 		sha1_dir = DEFAULT_DB_ENVIRONMENT;
 		fprintf(stderr, "defaulting to local storage area\n");
--- a/rsh.c
+++ b/rsh.c
@@ -36,8 +36,8 @@ int setup_connection(int *fd_in, int *fd
 	*(path++) = '\0';
 	/* ssh <host> 'cd /<path>; stdio-pull <arg...> <commit-id>' */
 	snprintf(command, COMMAND_SIZE, 
-		 "cd /%s; SHA1_FILE_DIRECTORY=objects %s",
-		 path, remote_prog);
+		 "cd /%s; %s=objects %s",
+		 path, DB_ENVIRONMENT, remote_prog);
 	posn = command + strlen(command);
 	for (i = 0; i < rmt_argc; i++) {
 		*(posn++) = ' ';
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -120,7 +120,7 @@ static void fill_sha1_path(char *pathbuf
  *
  * Also note that this returns the location for creating.  Reading
  * SHA1 file can happen from any alternate directory listed in the
- * SHA1_FILE_DIRECTORIES environment variable if it is not found in
+ * DB_ENVIRONMENT environment variable if it is not found in
  * the primary object database.
  */
 char *sha1_file_name(const unsigned char *sha1)
@@ -128,7 +128,7 @@ char *sha1_file_name(const unsigned char
 	static char *name, *base;
 
 	if (!base) {
-		char *sha1_file_directory = get_object_directory();
+		const char *sha1_file_directory = get_object_directory();
 		int len = strlen(sha1_file_directory);
 		base = xmalloc(len + 60);
 		memcpy(base, sha1_file_directory, len);
@@ -151,7 +151,7 @@ static struct alternate_object_database 
  * alt_odb points at an array of struct alternate_object_database.
  * This array is terminated with an element that has both its base
  * and name set to NULL.  alt_odb[n] comes from n'th non-empty
- * element from colon separated $SHA1_FILE_DIRECTORIES environment
+ * element from colon separated ALTERNATE_DB_ENVIRONMENT environment
  * variable, and its base points at a statically allocated buffer
  * that contains "/the/directory/corresponding/to/.git/objects/...",
  * while its name points just after the slash at the end of
@@ -167,7 +167,7 @@ static void prepare_alt_odb(void)
 	int pass, totlen, i;
 	const char *cp, *last;
 	char *op = 0;
-	const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT) ? : "";
+	const char *alt = gitenv(ALTERNATE_DB_ENVIRONMENT) ? : "";
 
 	/* The first pass counts how large an area to allocate to
 	 * hold the entire alt_odb structure, including array of

