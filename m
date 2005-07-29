From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-files: rework exclude patterns.
Date: Fri, 29 Jul 2005 00:50:34 -0700
Message-ID: <7vhdeejbjp.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<20050722205948.GE11916@pasky.ji.cz>
	<7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
	<20050728155210.GA17952@pasky.ji.cz>
	<7vack6mcd7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Fri Jul 29 09:54:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyPhV-0006JG-5x
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 09:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVG2Hxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 03:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVG2Hv3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 03:51:29 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:8399 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262493AbVG2Hug (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 03:50:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729075025.JFCZ16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 03:50:25 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vack6mcd7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 28 Jul 2005 22:04:36 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pasky and others raised many valid points on the problems
initial exclude pattern enhancement work had.  Based on the
list discussion, rework the exclude logic to use "last match
determines its fate" rule, and order the list by exclude-from
(the fallback default pattern file), exclude-per-directory
(shallower to deeper, so deeper ones can override), and then
command line exclude patterns.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 ls-files.c |  100 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 72 insertions(+), 28 deletions(-)

a908ed1b0fed52bfdcfc8b3ada366ce05e44c887
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -26,30 +26,45 @@ static const char *tag_other = "";
 static const char *tag_killed = "";
 
 static char *exclude_per_dir = NULL;
-static int nr_excludes;
-static int excludes_alloc;
-static struct exclude {
-	const char *pattern;
-	const char *base;
-	int baselen;
-} **excludes;
 
-static void add_exclude(const char *string, const char *base, int baselen)
+/* We maintain three exclude pattern lists:
+ * EXC_CMDL lists patterns explicitly given on the command line.
+ * EXC_DIRS lists patterns obtained from per-directory ignore files.
+ * EXC_FILE lists patterns from fallback ignore files.
+ */
+#define EXC_CMDL 0
+#define EXC_DIRS 1
+#define EXC_FILE 2
+static struct exclude_list {
+	int nr;
+	int alloc;
+	struct exclude {
+		const char *pattern;
+		const char *base;
+		int baselen;
+	} **excludes;
+} exclude_list[3];
+
+static void add_exclude(const char *string, const char *base,
+			int baselen, struct exclude_list *which)
 {
 	struct exclude *x = xmalloc(sizeof (*x));
 
 	x->pattern = string;
 	x->base = base;
 	x->baselen = baselen;
-	if (nr_excludes == excludes_alloc) {
-		excludes_alloc = alloc_nr(excludes_alloc);
-		excludes = realloc(excludes, excludes_alloc*sizeof(char *));
+	if (which->nr == which->alloc) {
+		which->alloc = alloc_nr(which->alloc);
+		which->excludes = realloc(which->excludes,
+					  which->alloc * sizeof(x));
 	}
-	excludes[nr_excludes++] = x;
+	which->excludes[which->nr++] = x;
 }
 
 static int add_excludes_from_file_1(const char *fname,
-				    const char *base, int baselen)
+				    const char *base,
+				    int baselen,
+				    struct exclude_list *which)
 {
 	int fd, i;
 	long size;
@@ -76,7 +91,7 @@ static int add_excludes_from_file_1(cons
 		if (buf[i] == '\n') {
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i] = 0;
-				add_exclude(entry, base, baselen);
+				add_exclude(entry, base, baselen, which);
 			}
 			entry = buf + i + 1;
 		}
@@ -91,38 +106,45 @@ static int add_excludes_from_file_1(cons
 
 static void add_excludes_from_file(const char *fname)
 {
-	if (add_excludes_from_file_1(fname, "", 0) < 0)
+	if (add_excludes_from_file_1(fname, "", 0,
+				     &exclude_list[EXC_FILE]) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
 
 static int push_exclude_per_directory(const char *base, int baselen)
 {
 	char exclude_file[PATH_MAX];
-	int current_nr = nr_excludes;
+	struct exclude_list *el = &exclude_list[EXC_DIRS];
+	int current_nr = el->nr;
 
 	if (exclude_per_dir) {
 		memcpy(exclude_file, base, baselen);
 		strcpy(exclude_file + baselen, exclude_per_dir);
-		add_excludes_from_file_1(exclude_file, base, baselen);
+		add_excludes_from_file_1(exclude_file, base, baselen, el);
 	}
 	return current_nr;
 }
 
 static void pop_exclude_per_directory(int stk)
 {
-	while (stk < nr_excludes)
-		free(excludes[--nr_excludes]);
+	struct exclude_list *el = &exclude_list[EXC_DIRS];
+
+	while (stk < el->nr)
+		free(el->excludes[--el->nr]);
 }
 
-static int excluded(const char *pathname)
+/* Scan the list and let the last match determines the fate.
+ * Return 1 for exclude, 0 for include and -1 for undecided.
+ */
+static int excluded_1(const char *pathname,
+		      int pathlen,
+		      struct exclude_list *el)
 {
 	int i;
 
-	if (nr_excludes) {
-		int pathlen = strlen(pathname);
-
-		for (i = 0; i < nr_excludes; i++) {
-			struct exclude *x = excludes[i];
+	if (el->nr) {
+		for (i = el->nr - 1; 0 <= i; i--) {
+			struct exclude *x = el->excludes[i];
 			const char *exclude = x->pattern;
 			int to_exclude = 1;
 
@@ -158,6 +180,22 @@ static int excluded(const char *pathname
 			}
 		}
 	}
+	return -1; /* undecided */
+}
+
+static int excluded(const char *pathname)
+{
+	int pathlen = strlen(pathname);
+	int st;
+
+	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
+		switch (excluded_1(pathname, pathlen, &exclude_list[st])) {
+		case 0:
+			return 0;
+		case 1:
+			return 1;
+		}
+	}
 	return 0;
 }
 
@@ -371,6 +409,7 @@ static const char *ls_files_usage =
 int main(int argc, char **argv)
 {
 	int i;
+	int exc_given = 0;
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -402,20 +441,25 @@ int main(int argc, char **argv)
 			show_stage = 1;
 			show_unmerged = 1;
 		} else if (!strcmp(arg, "-x") && i+1 < argc) {
-			add_exclude(argv[++i], "", 0);
+			exc_given = 1;
+			add_exclude(argv[++i], "", 0, &exclude_list[EXC_CMDL]);
 		} else if (!strncmp(arg, "--exclude=", 10)) {
-			add_exclude(arg+10, "", 0);
+			exc_given = 1;
+			add_exclude(arg+10, "", 0, &exclude_list[EXC_CMDL]);
 		} else if (!strcmp(arg, "-X") && i+1 < argc) {
+			exc_given = 1;
 			add_excludes_from_file(argv[++i]);
 		} else if (!strncmp(arg, "--exclude-from=", 15)) {
+			exc_given = 1;
 			add_excludes_from_file(arg+15);
 		} else if (!strncmp(arg, "--exclude-per-directory=", 24)) {
+			exc_given = 1;
 			exclude_per_dir = arg + 24;
 		} else
 			usage(ls_files_usage);
 	}
 
-	if (show_ignored && !nr_excludes) {
+	if (show_ignored && !exc_given) {
 		fprintf(stderr, "%s: --ignored needs some exclude pattern\n",
 			argv[0]);
 		exit(1);
