From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git wrapper: basic fixes.
Date: Tue, 15 Nov 2005 23:17:31 -0800
Message-ID: <7vfypxawok.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051116002318.A46C55BF97@nox.op5.se>
	<437AAB48.7090904@zytor.com> <437AD82B.1050404@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 08:18:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcHYB-0004ks-CR
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 08:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbVKPHRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 02:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVKPHRe
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 02:17:34 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:15066 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751468AbVKPHRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 02:17:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116071706.BZWU15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 02:17:06 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437AD82B.1050404@op5.se> (Andreas Ericsson's message of "Wed, 16
	Nov 2005 07:56:43 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12008>

Andreas Ericsson <ae@op5.se> writes:

> PATH_TO_MAN *was* the original. This is the updated version. I think 
> Junio imported the wrong one by mistake, cause I sent this one 
> specifically to fix the first one.

Actually, I already had the original three in my tree before I
sent out the message about problems like PATH_TO_MAN and
getcwd/chdir pair, because they were not such a big deal to fix
later in-tree, and I wanted to have the rest.

How does this one look, on top of what we have on the "master"
branch?

-- >8 --
Updates to fix the nits found during the list discussion.

 - Lose PATH_TO_MAN; just rely on execlp() to find whereever the
   "man" command is installed.

 - Do not randomly chdir(), but concatenate to the current
   working directory only if the given path is not absolute.

 - Lose use of glob(); read from exec_path and do sorting
   ourselves -- it is not that much more work.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git.c |  152 +++++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 97 insertions(+), 55 deletions(-)

applies-to: 1a3192c27df352fb11cb1f430ad174ecd90a3734
7dbc2c0402d728a206d4f1bc59729bf3a5cc4455
diff --git a/git.c b/git.c
index 583923d..b9b8c62 100644
--- a/git.c
+++ b/git.c
@@ -1,11 +1,13 @@
 #include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <dirent.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
 #include <limits.h>
 #include <stdarg.h>
-#include <glob.h>
 
 #ifndef PATH_MAX
 # define PATH_MAX 4096
@@ -14,12 +16,6 @@
 static const char git_usage[] =
 	"Usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--help] COMMAND [ ARGS ]";
 
-struct string_list {
-	size_t len;
-	char *str;
-	struct string_list *next;
-};
-
 /* most gui terms set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
@@ -32,30 +28,69 @@ static int term_columns(void)
 	return 80;
 }
 
+static void oom(void)
+{
+	fprintf(stderr, "git: out of memory\n");
+	exit(1);
+}
+
 static inline void mput_char(char c, unsigned int num)
 {
 	while(num--)
 		putchar(c);
 }
 
-static void pretty_print_string_list(struct string_list *list, int longest)
+static struct cmdname {
+	size_t len;
+	char name[1];
+} **cmdname;
+static int cmdname_alloc, cmdname_cnt;
+
+static void add_cmdname(const char *name, int len)
+{
+	struct cmdname *ent;
+	if (cmdname_alloc <= cmdname_cnt) {
+		cmdname_alloc = cmdname_alloc + 200;
+		cmdname = realloc(cmdname, cmdname_alloc * sizeof(*cmdname));
+		if (!cmdname)
+			oom();
+	}
+	ent = malloc(sizeof(*ent) + len);
+	if (!ent)
+		oom();
+	ent->len = len;
+	memcpy(ent->name, name, len+1);
+	cmdname[cmdname_cnt++] = ent;
+}
+
+static int cmdname_compare(const void *a_, const void *b_)
+{
+	struct cmdname *a = *(struct cmdname **)a_;
+	struct cmdname *b = *(struct cmdname **)b_;
+	return strcmp(a->name, b->name);
+}
+
+static void pretty_print_string_list(struct cmdname **cmdname, int longest)
 {
 	int cols = 1;
 	int space = longest + 1; /* min 1 SP between words */
 	int max_cols = term_columns() - 1; /* don't print *on* the edge */
+	int i;
 
 	if (space < max_cols)
 		cols = max_cols / space;
 
-	while (list) {
+	qsort(cmdname, cmdname_cnt, sizeof(*cmdname), cmdname_compare);
+
+	for (i = 0; i < cmdname_cnt; ) {
 		int c;
 		printf("  ");
 
-		for (c = cols; c && list; list = list->next) {
-			printf("%s", list->str);
+		for (c = cols; c && i < cmdname_cnt; i++) {
+			printf("%s", cmdname[i]->name);
 
 			if (--c)
-				mput_char(' ', space - list->len);
+				mput_char(' ', space - cmdname[i]->len);
 		}
 		putchar('\n');
 	}
@@ -63,54 +98,53 @@ static void pretty_print_string_list(str
 
 static void list_commands(const char *exec_path, const char *pattern)
 {
-	struct string_list *list = NULL, *tail = NULL;
-	unsigned int longest = 0, i;
-	glob_t gl;
+	unsigned int longest = 0;
+	char path[PATH_MAX];
+	int dirlen;
+	DIR *dir = opendir(exec_path);
+	struct dirent *de;
 
-	if (chdir(exec_path) < 0) {
-		printf("git: '%s': %s\n", exec_path, strerror(errno));
+	if (!dir) {
+		fprintf(stderr, "git: '%s': %s\n", exec_path, strerror(errno));
 		exit(1);
 	}
 
-	i = glob(pattern, 0, NULL, &gl);
-	switch(i) {
-	case GLOB_NOSPACE:
-		puts("Out of memory when running glob()");
-		exit(2);
-	case GLOB_ABORTED:
-		printf("'%s': Read error: %s\n", exec_path, strerror(errno));
-		exit(2);
-	case GLOB_NOMATCH:
-		printf("No git commands available in '%s'.\n", exec_path);
-		printf("Do you need to specify --exec-path or set GIT_EXEC_PATH?\n");
+	dirlen = strlen(exec_path);
+	if (PATH_MAX - 20 < dirlen) {
+		fprintf(stderr, "git: insanely long exec-path '%s'\n",
+			exec_path);
 		exit(1);
 	}
 
-	for (i = 0; i < gl.gl_pathc; i++) {
-		int len = strlen(gl.gl_pathv[i] + 4);
+	memcpy(path, exec_path, dirlen);
+	path[dirlen++] = '/';
+
+	while ((de = readdir(dir)) != NULL) {
+		struct stat st;
+		int entlen;
 
-		if (access(gl.gl_pathv[i], X_OK))
+		if (strncmp(de->d_name, "git-", 4))
+			continue;
+		strcpy(path+dirlen, de->d_name);
+		if (stat(path, &st) || /* stat, not lstat */
+		    !S_ISREG(st.st_mode) ||
+		    !(st.st_mode & S_IXUSR))
 			continue;
 
-		if (longest < len)
-			longest = len;
+		entlen = strlen(de->d_name);
 
-		if (!tail)
-			tail = list = malloc(sizeof(struct string_list));
-		else {
-			tail->next = malloc(sizeof(struct string_list));
-			tail = tail->next;
-		}
-		tail->len = len;
-		tail->str = gl.gl_pathv[i] + 4;
-		tail->next = NULL;
+		if (longest < entlen)
+			longest = entlen;
+
+		add_cmdname(de->d_name + 4, entlen-4);
 	}
+	closedir(dir);
 
 	printf("git commands available in '%s'\n", exec_path);
 	printf("----------------------------");
 	mput_char('-', strlen(exec_path));
 	putchar('\n');
-	pretty_print_string_list(list, longest);
+	pretty_print_string_list(cmdname, longest - 4);
 	putchar('\n');
 }
 
@@ -146,7 +180,7 @@ static void prepend_to_path(const char *
 	int path_len = len;
 
 	if (!old_path)
-		old_path = "/bin:/usr/bin:.";
+		old_path = "/usr/local/bin:/usr/bin:/bin";
 
 	path_len = len + strlen(old_path) + 1;
 
@@ -160,8 +194,6 @@ static void prepend_to_path(const char *
 	setenv("PATH", path, 1);
 }
 
-/* has anyone seen 'man' installed anywhere else than in /usr/bin? */
-#define PATH_TO_MAN "/usr/bin/man"
 static void show_man_page(char *git_cmd)
 {
 	char *page;
@@ -177,7 +209,7 @@ static void show_man_page(char *git_cmd)
 		page[page_len] = 0;
 	}
 
-	execlp(PATH_TO_MAN, "man", page, NULL);
+	execlp("man", "man", page, NULL);
 }
 
 int main(int argc, char **argv, char **envp)
@@ -226,15 +258,25 @@ int main(int argc, char **argv, char **e
 		show_man_page(argv[i]);
 	}
 
-	/* allow relative paths, but run with exact */
-	if (chdir(exec_path)) {
-		printf("git: '%s': %s\n", exec_path, strerror(errno));
-		exit (1);
-	}
-
-	getcwd(git_command, sizeof(git_command));
-	chdir(wd);
+	if (*exec_path != '/') {
+		if (!getcwd(git_command, sizeof(git_command))) {
+			fprintf(stderr,
+				"git: cannot determine current directory");
+			exit(1);
+		}
+		len = strlen(git_command);
 
+		/* Trivial cleanup */
+		while (!strncmp(exec_path, "./", 2)) {
+			exec_path += 2;
+			while (*exec_path == '/')
+				*exec_path++;
+		}
+		snprintf(git_command + len, sizeof(git_command) - len,
+			 "/%s", exec_path);
+	}
+	else
+		strcpy(git_command, exec_path);
 	len = strlen(git_command);
 	prepend_to_path(git_command, len);
 
---
0.99.9.GIT
