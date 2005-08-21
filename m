From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "git-ls-files" work in subdirectories
Date: Sun, 21 Aug 2005 12:55:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508211210500.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Aug 21 23:13:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6x7R-0003Pl-SO
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 23:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVHUVMg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 17:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVHUVMg
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 17:12:36 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:60105 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751114AbVHUVMe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2005 17:12:34 -0400
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LJwn8J002016
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 12:58:49 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7LJtYjA029724
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Aug 2005 12:55:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7LJtXbK009746;
	Sun, 21 Aug 2005 12:55:33 -0700
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


This makes git-ls-files work inside a relative directory, and also adds
some rudimentary filename globbing support. For example, in the kernel you
can now do

	cd arch/i386
	git-ls-files

and it will show all files under that subdirectory (and it will have
removed the "arch/i386/" prefix unless you give it the "--full-name"  
option, so that you can feed the result to "xargs grep" or similar).

The filename globbing is kind of strange: it does _not_ follow normal 
globbing rules, although it does look "almost" like a normal file glob 
(and it uses the POSIX.2 "fnmatch()" function).

The glob pattern (there can be only one) is always split into a "directory 
part" and a "glob part", where the directory part is defined as any full 
directory path without any '*' or '?' characters. The "glob" part is 
whatever is left over.

For example, when doing

	git-ls-files 'arch/i386/p*/*.c'

the "directory part" is is "arch/i386/", and the "glob part" is "p*/*.c". 
The directory part will be added to the prefix, and handled efficiently 
(ie we will not be searching outside of that subdirectory), while the glob 
part (if anything is left over) will be used to trigger "fnmatch()" 
matches.

This is efficient and very useful, but can result in somewhat
non-intuitive behaviour.

For example:

	git-ls-files 'arch/i386/*.[ch]'

will find all .c and .h files under arch/i386/, _including_ things in
lower subdirectories (ie it will match "arch/i386/kernel/process.c",
because "kernel/process.c" will match the "*.c" specifier).

Also, while

	git-ls-files arch/i386/

will show all files under that subdirectory, doing the same without the
final slash would try to show the file "i386" under the "arch/"  
subdirectory, and since there is no such file (even if there is such a
_directory_) it will not match anything at all.

These semantics may not seem intuitive, but they are actually very
practical. In particular, it makes it very simple to do

	git-ls-files fs/*.c | xargs grep some_pattern

and it does what you want.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
[ Implementation note: the difference between "prefix_len" and 
  "prefix_offset" is that "prefix_len" is used for all the compare logic, 
  while "prefix_offset" is used to determine how much of the prefix not to
  print out. So "--full-name" just clears prefix_offset, which keeps all
  the comparisons the same, but prints out the full absolute git path,
  rather than the relative one.

  Also: unlike things like "git-diff-files" etc, we do _not_ handle 
  prefixes containint ".." and "./" etc gracefully. That's partly exactly 
  because the result of git-ls-files is normally a relative pathname, and
  it just makes it almost impossible to do what the git-diff-* functions 
  do efficiently and with sane semantics ]

---
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -19,6 +19,10 @@ static int show_unmerged = 0;
 static int show_killed = 0;
 static int line_terminator = '\n';
 
+static int prefix_len = 0, prefix_offset = 0;
+static const char *prefix = NULL;
+static const char *glob = NULL;
+
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
 static const char *tag_removed = "";
@@ -222,6 +226,7 @@ static void add_name(const char *pathnam
 	ent = xmalloc(sizeof(*ent) + len + 1);
 	ent->len = len;
 	memcpy(ent->name, pathname, len);
+	ent->name[len] = 0;
 	dir[nr_dir++] = ent;
 }
 
@@ -297,6 +302,20 @@ static int cmp_name(const void *p1, cons
 				  e2->name, e2->len);
 }
 
+static void show_dir_entry(const char *tag, struct nond_on_fs *ent)
+{
+	int len = prefix_len;
+	int offset = prefix_offset;
+
+	if (len >= ent->len)
+		die("git-ls-files: internal error - directory entry not superset of prefix");
+
+	if (glob && fnmatch(glob, ent->name + len, 0))
+		return;
+
+	printf("%s%s%c", tag, ent->name + offset, line_terminator);
+}
+
 static void show_killed_files(void)
 {
 	int i;
@@ -342,25 +361,48 @@ static void show_killed_files(void)
 			}
 		}
 		if (killed)
-			printf("%s%.*s%c", tag_killed,
-			       dir[i]->len, dir[i]->name,
-			       line_terminator);
+			show_dir_entry(tag_killed, dir[i]);
 	}
 }
 
+static void show_ce_entry(const char *tag, struct cache_entry *ce)
+{
+	int len = prefix_len;
+	int offset = prefix_offset;
+
+	if (len >= ce_namelen(ce))
+		die("git-ls-files: internal error - cache entry not superset of prefix");
+
+	if (glob && fnmatch(glob, ce->name + len, 0))
+		return;
+
+	if (!show_stage)
+		printf("%s%s%c", tag, ce->name + offset, line_terminator);
+	else
+		printf("%s%06o %s %d\t%s%c",
+		       tag,
+		       ntohl(ce->ce_mode),
+		       sha1_to_hex(ce->sha1),
+		       ce_stage(ce),
+		       ce->name + offset, line_terminator); 
+}
+
 static void show_files(void)
 {
 	int i;
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
-		read_directory(".", "", 0);
+		const char *path = ".", *base = "";
+		int baselen = prefix_len;
+
+		if (baselen)
+			path = base = prefix;
+		read_directory(path, base, baselen);
 		qsort(dir, nr_dir, sizeof(struct nond_on_fs *), cmp_name);
 		if (show_others)
 			for (i = 0; i < nr_dir; i++)
-				printf("%s%.*s%c", tag_other,
-				       dir[i]->len, dir[i]->name,
-				       line_terminator);
+				show_dir_entry(tag_other, dir[i]);
 		if (show_killed)
 			show_killed_files();
 	}
@@ -371,19 +413,7 @@ static void show_files(void)
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
-			if (!show_stage)
-				printf("%s%s%c",
-				       ce_stage(ce) ? tag_unmerged :
-				       tag_cached,
-				       ce->name, line_terminator);
-			else
-				printf("%s%06o %s %d\t%s%c",
-				       ce_stage(ce) ? tag_unmerged :
-				       tag_cached,
-				       ntohl(ce->ce_mode),
-				       sha1_to_hex(ce->sha1),
-				       ce_stage(ce),
-				       ce->name, line_terminator); 
+			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
 	if (show_deleted) {
@@ -394,9 +424,66 @@ static void show_files(void)
 				continue;
 			if (!lstat(ce->name, &st))
 				continue;
-			printf("%s%s%c", tag_removed, ce->name,
-			       line_terminator);
+			show_ce_entry(tag_removed, ce);
+		}
+	}
+}
+
+/*
+ * Prune the index to only contain stuff starting with "prefix"
+ */
+static void prune_cache(void)
+{
+	int pos = cache_name_pos(prefix, prefix_len);
+	unsigned int first, last;
+
+	if (pos < 0)
+		pos = -pos-1;
+	active_cache += pos;
+	active_nr -= pos;
+	first = 0;
+	last = active_nr;
+	while (last > first) {
+		int next = (last + first) >> 1;
+		struct cache_entry *ce = active_cache[next];
+		if (!strncmp(ce->name, prefix, prefix_len)) {
+			first = next+1;
+			continue;
 		}
+		last = next;
+	}
+	active_nr = last;
+}
+
+/*
+ * If the glob starts with a subdirectory, append it to
+ * the prefix instead, for more efficient operation.
+ *
+ * But we do not update the "prefix_offset", which tells
+ * how much of the name to ignore at printout.
+ */
+static void extend_prefix(void)
+{
+	const char *p, *slash;
+	char c;
+
+	p = glob;
+	slash = NULL;
+	while ((c = *p++) != '\0') {
+		if (c == '*')
+			break;
+		if (c == '/')
+			slash = p;
+	}
+	if (slash) {
+		int len = slash - glob;
+		char *newprefix = xmalloc(len + prefix_len + 1);
+		memcpy(newprefix, prefix, prefix_len);
+		memcpy(newprefix + prefix_len, glob, len);
+		prefix_len += len;
+		newprefix[prefix_len] = 0;
+		prefix = newprefix;
+		glob = *slash ? slash : NULL;
 	}
 }
 
@@ -410,54 +497,94 @@ int main(int argc, char **argv)
 	int i;
 	int exc_given = 0;
 
+	prefix = setup_git_directory();
+	if (prefix)
+		prefix_offset = prefix_len = strlen(prefix);
+
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
 		if (!strcmp(arg, "-z")) {
 			line_terminator = 0;
-		} else if (!strcmp(arg, "-t")) {
+			continue;
+		}
+		if (!strcmp(arg, "-t")) {
 			tag_cached = "H ";
 			tag_unmerged = "M ";
 			tag_removed = "R ";
 			tag_other = "? ";
 			tag_killed = "K ";
-		} else if (!strcmp(arg, "-c") || !strcmp(arg, "--cached")) {
+			continue;
+		}
+		if (!strcmp(arg, "-c") || !strcmp(arg, "--cached")) {
 			show_cached = 1;
-		} else if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
+			continue;
+		}
+		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
 			show_deleted = 1;
-		} else if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
+			continue;
+		}
+		if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
 			show_others = 1;
-		} else if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
+			continue;
+		}
+		if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
 			show_ignored = 1;
-		} else if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
+			continue;
+		}
+		if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
 			show_stage = 1;
-		} else if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
+			continue;
+		}
+		if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
 			show_killed = 1;
-		} else if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
+			continue;
+		}
+		if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
 			/* There's no point in showing unmerged unless
 			 * you also show the stage information.
 			 */
 			show_stage = 1;
 			show_unmerged = 1;
-		} else if (!strcmp(arg, "-x") && i+1 < argc) {
+			continue;
+		}
+		if (!strcmp(arg, "-x") && i+1 < argc) {
 			exc_given = 1;
 			add_exclude(argv[++i], "", 0, &exclude_list[EXC_CMDL]);
-		} else if (!strncmp(arg, "--exclude=", 10)) {
+			continue;
+		}
+		if (!strncmp(arg, "--exclude=", 10)) {
 			exc_given = 1;
 			add_exclude(arg+10, "", 0, &exclude_list[EXC_CMDL]);
-		} else if (!strcmp(arg, "-X") && i+1 < argc) {
+			continue;
+		}
+		if (!strcmp(arg, "-X") && i+1 < argc) {
 			exc_given = 1;
 			add_excludes_from_file(argv[++i]);
-		} else if (!strncmp(arg, "--exclude-from=", 15)) {
+			continue;
+		}
+		if (!strncmp(arg, "--exclude-from=", 15)) {
 			exc_given = 1;
 			add_excludes_from_file(arg+15);
-		} else if (!strncmp(arg, "--exclude-per-directory=", 24)) {
+			continue;
+		}
+		if (!strncmp(arg, "--exclude-per-directory=", 24)) {
 			exc_given = 1;
 			exclude_per_dir = arg + 24;
-		} else
+			continue;
+		}
+		if (!strcmp(arg, "--full-name")) {
+			prefix_offset = 0;
+			continue;
+		}
+		if (glob || *arg == '-')
 			usage(ls_files_usage);
+		glob = arg;
 	}
 
+	if (glob)
+		extend_prefix();
+
 	if (show_ignored && !exc_given) {
 		fprintf(stderr, "%s: --ignored needs some exclude pattern\n",
 			argv[0]);
@@ -469,6 +596,8 @@ int main(int argc, char **argv)
 		show_cached = 1;
 
 	read_cache();
+	if (prefix)
+		prune_cache();
 	show_files();
 	return 0;
 }
