From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] git-blame: Make the output human readable
Date: Sun, 5 Mar 2006 12:03:51 +0100
Message-ID: <20060305110351.GA23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 05 12:04:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFr2B-0004kh-Bt
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 12:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWCELEB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 06:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWCELEB
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 06:04:01 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:1002 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1750816AbWCELEB
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 06:04:01 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 7C1124118; Sun,  5 Mar 2006 12:19:11 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FFr1j-0007AU-00; Sun, 05 Mar 2006 12:03:51 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17220>

The default output mode is slightly different from git-annotate's.
However, git-annotate's output mode can be obtained by using the
'-c' flag.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 Makefile |    4 ++
 blame.c  |  164 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 149 insertions(+), 19 deletions(-)

3459b7c5032d1462d5857cf6afc2d3e3ef61b93b
diff --git a/Makefile b/Makefile
index b6d8804..eb1887d 100644
--- a/Makefile
+++ b/Makefile
@@ -534,6 +534,10 @@ git-rev-list$X: rev-list.o $(LIB_FILE)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LIBSSL)
 
+git-blame$X: blame.o $(LIB_FILE)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) -lm
+
 init-db.o: init-db.c
 	$(CC) -c $(ALL_CFLAGS) \
 		-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $*.c
diff --git a/blame.c b/blame.c
index 7308c36..6dccae5 100644
--- a/blame.c
+++ b/blame.c
@@ -5,6 +5,7 @@
 #include <assert.h>
 #include <time.h>
 #include <sys/time.h>
+#include <math.h>
 
 #include "cache.h"
 #include "refs.h"
@@ -17,8 +18,15 @@
 
 #define DEBUG 0
 
-struct commit **blame_lines;
-int num_blame_lines;
+static const char blame_usage[] = "[-c] [-l] [--] file [commit]\n"
+	"  -c, --compability Use the same output mode as git-annotate (Default: off)\n"
+	"  -l, --long        Show long commit SHA1 (Default: off)\n"
+	"  -h, --help        This message";
+
+static struct commit **blame_lines;
+static int num_blame_lines;
+static char* blame_contents;
+static int blame_len;
 
 struct util_info {
 	int *line_map;
@@ -388,9 +396,8 @@ static void init_first_commit(struct com
 	alloc_line_map(commit);
 
 	util = commit->object.util;
-	num_blame_lines = util->num_lines;
 
-	for (i = 0; i < num_blame_lines; i++)
+	for (i = 0; i < util->num_lines; i++)
 		util->line_map[i] = i;
 }
 
@@ -412,6 +419,9 @@ static void process_commits(struct rev_i
 	util = commit->object.util;
 	num_blame_lines = util->num_lines;
 	blame_lines = xmalloc(sizeof(struct commit *) * num_blame_lines);
+	blame_contents = util->buf;
+	blame_len = util->size;
+
 	for (i = 0; i < num_blame_lines; i++)
 		blame_lines[i] = NULL;
 
@@ -499,32 +509,128 @@ static void process_commits(struct rev_i
 	} while ((commit = get_revision(rev)) != NULL);
 }
 
+struct commit_info
+{
+	char* author;
+	char* author_mail;
+	unsigned long author_time;
+	char* author_tz;
+};
+
+static void get_commit_info(struct commit* commit, struct commit_info* ret)
+{
+	int len;
+	char* tmp;
+	static char author_buf[1024];
+
+	tmp = strstr(commit->buffer, "\nauthor ") + 8;
+	len = index(tmp, '\n') - tmp;
+	ret->author = author_buf;
+	memcpy(ret->author, tmp, len);
+
+	tmp = ret->author;
+	tmp += len;
+	*tmp = 0;
+	while(*tmp != ' ')
+		tmp--;
+	ret->author_tz = tmp+1;
+
+	*tmp = 0;
+	while(*tmp != ' ')
+		tmp--;
+	ret->author_time = strtoul(tmp, NULL, 10);
+
+	*tmp = 0;
+	while(*tmp != ' ')
+		tmp--;
+	ret->author_mail = tmp + 1;
+
+	*tmp = 0;
+}
+
+char* format_time(unsigned long time, const char* tz)
+{
+	static char time_buf[128];
+	time_t t = time;
+
+	strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S ", gmtime(&t));
+	strcat(time_buf, tz);
+	return time_buf;
+}
+
 int main(int argc, const char **argv)
 {
 	int i;
 	struct commit *initial = NULL;
 	unsigned char sha1[20];
-	const char* filename;
+
+	const char *filename = NULL, *commit = NULL;
+	char filename_buf[256];
+	int sha1_len = 8;
+	int compability = 0;
+	int options = 1;
+
 	int num_args;
 	const char* args[10];
 	struct rev_info rev;
 
-	setup_git_directory();
-
-	if (argc != 3)
-		die("Usage: blame commit-ish file");
+	struct commit_info ci;
+	const char *buf;
+	int max_digits;
+
+	const char* prefix = setup_git_directory();
+
+	for(i = 1; i < argc; i++) {
+		if(options) {
+			if(!strcmp(argv[i], "-h") ||
+			   !strcmp(argv[i], "--help"))
+				usage(blame_usage);
+			else if(!strcmp(argv[i], "-l") ||
+				!strcmp(argv[i], "--long")) {
+				sha1_len = 20;
+				continue;
+			} else if(!strcmp(argv[i], "-c") ||
+				  !strcmp(argv[i], "--compability")) {
+				compability = 1;
+				continue;
+			} else if(!strcmp(argv[i], "--")) {
+				options = 0;
+				continue;
+			} else if(argv[i][0] == '-')
+				usage(blame_usage);
+			else
+				options = 0;
+		}
 
+		if(!options) {
+			if(!filename)
+				filename = argv[i];
+			else if(!commit)
+				commit = argv[i];
+			else
+				usage(blame_usage);
+		}
+	}
 
-	filename = argv[2];
+	if(!filename)
+		usage(blame_usage);
+	if(!commit)
+		commit = "HEAD";
+
+	if(prefix)
+		sprintf(filename_buf, "%s%s", prefix, filename);
+	else
+		strcpy(filename_buf, filename);
+	filename = filename_buf;
 
 	{
-		struct commit* commit;
-		if (get_sha1(argv[1], sha1))
-			die("get_sha1 failed");
-		commit = lookup_commit_reference(sha1);
+		struct commit* c;
+		if (get_sha1(commit, sha1))
+			die("get_sha1 failed, commit '%s' not found", commit);
+		c = lookup_commit_reference(sha1);
 
-		if (fill_util_info(commit, filename)) {
-			printf("%s not found in %s\n", filename, argv[1]);
+		if (fill_util_info(c, filename)) {
+			printf("%s not found in %s\n", filename, commit);
 			return 1;
 		}
 	}
@@ -533,7 +639,7 @@ int main(int argc, const char **argv)
 	args[num_args++] = NULL;
 	args[num_args++] = "--topo-order";
 	args[num_args++] = "--remove-empty";
-	args[num_args++] = argv[1];
+	args[num_args++] = commit;
 	args[num_args++] = "--";
 	args[num_args++] = filename;
 	args[num_args] = NULL;
@@ -542,13 +648,33 @@ int main(int argc, const char **argv)
 	prepare_revision_walk(&rev);
 	process_commits(&rev, filename, &initial);
 
+	buf = blame_contents;
+	max_digits = 1 + log(num_blame_lines+1)/log(10);
 	for (i = 0; i < num_blame_lines; i++) {
 		struct commit *c = blame_lines[i];
 		if (!c)
 			c = initial;
 
-		printf("%d %.8s\n", i, sha1_to_hex(c->object.sha1));
-// printf("%d %s\n", i, find_unique_abbrev(blame_lines[i]->object.sha1, 6));
+		get_commit_info(c, &ci);
+		fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
+		if(compability)
+			printf("\t(%10s\t%10s\t%d)", ci.author,
+			       format_time(ci.author_time, ci.author_tz), i+1);
+		else
+			printf(" (%-15.15s %10s %*d) ", ci.author,
+			       format_time(ci.author_time, ci.author_tz),
+			       max_digits, i+1);
+
+		if(i == num_blame_lines - 1) {
+			fwrite(buf, blame_len - (buf - blame_contents),
+			       1, stdout);
+			if(blame_contents[blame_len-1] != '\n')
+				putc('\n', stdout);
+		} else {
+			char* next_buf = index(buf, '\n') + 1;
+			fwrite(buf, next_buf - buf, 1, stdout);
+			buf = next_buf;
+		}
 	}
 
 	if (DEBUG) {
-- 
1.2.4.g4644-dirty
