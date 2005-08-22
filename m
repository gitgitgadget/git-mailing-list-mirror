From: Linus Torvalds <torvalds@osdl.org>
Subject: git-ls-files: generalized pathspecs
Date: Sun, 21 Aug 2005 17:27:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508211622570.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 23 01:15:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7LUG-0002kJ-Oa
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 01:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVHVXNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 19:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHVXNq
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 19:13:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:22673 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932376AbVHVXNl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2005 19:13:41 -0400
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M0V4UT009518
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 17:31:04 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7M0RpjA014402
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Aug 2005 17:27:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7M0Rowq020580;
	Sun, 21 Aug 2005 17:27:50 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This generalizes the git "glob" string to be a lot more like the 
git-diff-* pathspecs (but there are still differences: the diff family 
doesn't do any globbing, and because the diff family always generates the 
full native pathname, it doesn't have the issue with "..").

It does three things: 

 - it allows multiple matching strings, ie you can do things like

	git-ls-files arch/i386/ include/asm-i386/ | xargs grep pattern

 - the "matching" criteria is a combination of "exact path component 
   match" (the same as the git-diff-* family), and "fnmatch()". However, 
   you should be careful with the confusion between the git-ls-files
   internal globbing and the standard shell globbing, ie

	git-ls-files fs/*.c

   does globbing in the shell, and does something totally different from 

	git-ls-files 'fs/*.c'

   which does the globbing inside git-ls-files.

   The latter has _one_ pathspec with a wildcard, and will match any .c 
   file anywhere under the fs/ directory, while the former has been 
   expanded by the shell into having _lots_ of pathspec entries, all of 
   which are just in the top-level fs/ subdirectory. They will happily
   be matched exactly, but we will thus miss all the subdirectories under 
   fs/.

   As a result, the first one will (on the current kernel) match 55 files,
   while the second one will match 664 files!

 - it uses the generic path prefixing, so that ".." and friends at the 
   beginning of the path spec work automatically

   NOTE! When generating relative pathname output (the default), a 
   pathspec that causes the base to be outside the current working 
   directory will be rejected with an error message like:

	fatal: git-ls-files: cannot generate relative filenames containing '..'

   because we do not actually generate ".." in the output. However, the 
   ".." format works fine for the --full-name case:

	cd arch/i386/kernel
	git-ls-files --full-name ../mm/

   results in

	arch/i386/mm/Makefile
	arch/i386/mm/boot_ioremap.c
	arch/i386/mm/discontig.c
	arch/i386/mm/extable.c
	arch/i386/mm/fault.c
	arch/i386/mm/highmem.c
	arch/i386/mm/hugetlbpage.c
	arch/i386/mm/init.c
	arch/i386/mm/ioremap.c
	arch/i386/mm/mmap.c
	arch/i386/mm/pageattr.c
	arch/i386/mm/pgtable.c

   Perhaps more commonly, the generic path prefixing means that "." and 
   "./" automatically get simplified and work properly.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -21,7 +21,7 @@ static int line_terminator = '\n';
 
 static int prefix_len = 0, prefix_offset = 0;
 static const char *prefix = NULL;
-static const char *glob = NULL;
+static const char **pathspec = NULL;
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
@@ -302,6 +302,33 @@ static int cmp_name(const void *p1, cons
 				  e2->name, e2->len);
 }
 
+/*
+ * Match a pathspec against a filename. The first "len" characters
+ * are the common prefix
+ */
+static int match(const char **spec, const char *filename, int len)
+{
+	const char *m;
+
+	while ((m = *spec++) != NULL) {
+		int matchlen = strlen(m + len);
+
+		if (!matchlen)
+			return 1;
+		if (!strncmp(m + len, filename + len, matchlen)) {
+			if (m[len + matchlen - 1] == '/')
+				return 1;
+			switch (filename[len + matchlen]) {
+			case '/': case '\0':
+				return 1;
+			}
+		}
+		if (!fnmatch(m + len, filename + len, 0))
+			return 1;
+	}
+	return 0;
+}
+
 static void show_dir_entry(const char *tag, struct nond_on_fs *ent)
 {
 	int len = prefix_len;
@@ -310,7 +337,7 @@ static void show_dir_entry(const char *t
 	if (len >= ent->len)
 		die("git-ls-files: internal error - directory entry not superset of prefix");
 
-	if (glob && fnmatch(glob, ent->name + len, 0))
+	if (pathspec && !match(pathspec, ent->name, len))
 		return;
 
 	printf("%s%s%c", tag, ent->name + offset, line_terminator);
@@ -373,7 +400,7 @@ static void show_ce_entry(const char *ta
 	if (len >= ce_namelen(ce))
 		die("git-ls-files: internal error - cache entry not superset of prefix");
 
-	if (glob && fnmatch(glob, ce->name + len, 0))
+	if (pathspec && !match(pathspec, ce->name, len))
 		return;
 
 	if (!show_stage)
@@ -455,36 +482,44 @@ static void prune_cache(void)
 	active_nr = last;
 }
 
-/*
- * If the glob starts with a subdirectory, append it to
- * the prefix instead, for more efficient operation.
- *
- * But we do not update the "prefix_offset", which tells
- * how much of the name to ignore at printout.
- */
-static void extend_prefix(void)
+static void verify_pathspec(void)
 {
-	const char *p, *slash;
-	char c;
+	const char **p, *n, *prev;
+	char *real_prefix;
+	unsigned long max;
+
+	prev = NULL;
+	max = PATH_MAX;
+	for (p = pathspec; (n = *p) != NULL; p++) {
+		int i, len = 0;
+		for (i = 0; i < max; i++) {
+			char c = n[i];
+			if (prev && prev[i] != c)
+				break;
+			if (c == '*' || c == '?')
+				break;
+			if (c == '/')
+				len = i+1;
+		}
+		prev = n;
+		if (len < max) {
+			max = len;
+			if (!max)
+				break;
+		}
+	}
+
+	if (prefix_offset > max || memcmp(prev, prefix, prefix_offset))
+		die("git-ls-files: cannot generate relative filenames containing '..'");
 
-	p = glob;
-	slash = NULL;
-	while ((c = *p++) != '\0') {
-		if (c == '*')
-			break;
-		if (c == '/')
-			slash = p;
-	}
-	if (slash) {
-		int len = slash - glob;
-		char *newprefix = xmalloc(len + prefix_len + 1);
-		memcpy(newprefix, prefix, prefix_len);
-		memcpy(newprefix + prefix_len, glob, len);
-		prefix_len += len;
-		newprefix[prefix_len] = 0;
-		prefix = newprefix;
-		glob = *slash ? slash : NULL;
+	real_prefix = NULL;
+	prefix_len = max;
+	if (max) {
+		real_prefix = xmalloc(max + 1);
+		memcpy(real_prefix, prev, max);
+		real_prefix[max] = 0;
 	}
+	prefix = real_prefix;
 }
 
 static const char ls_files_usage[] =
@@ -499,7 +534,7 @@ int main(int argc, char **argv)
 
 	prefix = setup_git_directory();
 	if (prefix)
-		prefix_offset = prefix_len = strlen(prefix);
+		prefix_offset = strlen(prefix);
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -577,13 +612,16 @@ int main(int argc, char **argv)
 			prefix_offset = 0;
 			continue;
 		}
-		if (glob || *arg == '-')
+		if (*arg == '-')
 			usage(ls_files_usage);
-		glob = arg;
+		break;
 	}
 
-	if (glob)
-		extend_prefix();
+	pathspec = get_pathspec(prefix, argv + i);
+
+	/* Verify that the pathspec matches the prefix */
+	if (pathspec)
+		verify_pathspec();
 
 	if (show_ignored && !exc_given) {
 		fprintf(stderr, "%s: --ignored needs some exclude pattern\n",
