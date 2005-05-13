From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Add git-ls-files -k.
Date: Thu, 12 May 2005 17:17:54 -0700
Message-ID: <7vr7gcasi5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 02:11:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWNla-0008Av-BQ
	for gcvg-git@gmane.org; Fri, 13 May 2005 02:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVEMASm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 20:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVEMASm
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 20:18:42 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:15491 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262193AbVEMAR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 20:17:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050513001753.RFCG8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 20:17:53 -0400
To: Petr Baudis <pasky@ucw.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When checkout-cache attempts to check out a non-directory where
a directory exists on the work tree, or to check out a file
under directory D when path D is a non-directory on the work
tree, the attempt fails.  Before running checkout-cache, the
user can run git-ls-files with the -k (killed) option to get a
list of such paths.  The tagged output format uses "K" to denote
them.  This is useful for Porcelain layer to be careful when
dealing with the recently corrected behaviour of checkout-cache.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This should be considered a companion patch to the
*** checkout-cache fix you merged recently.  An extra safety
*** net just like git-check-files.

Documentation/git-ls-files.txt |   10 +++-
ls-files.c                     |  101 ++++++++++++++++++++++++++++++++++-------
2 files changed, 92 insertions(+), 19 deletions(-)

--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -10,8 +10,8 @@
 SYNOPSIS
 --------
 'git-ls-files' [-z] [-t]
-		(--[cached|deleted|others|ignored|stage|unmerged])\*
-		(-[c|d|o|i|s|u])\*
+		(--[cached|deleted|others|ignored|stage|unmerged|killed])\*
+		(-[c|d|o|i|s|u|k])\*
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 
@@ -45,6 +45,11 @@
 -u|--unmerged::
 	Show unmerged files in the output (forces --stage)
 
+-k|--killed::
+	Show files on the filesystem that need to be removed due
+	to file/directory conflicts for checkout-cache to
+	succeed.
+
 -z::
 	\0 line termination on output
 
@@ -65,6 +70,7 @@
 	H	cached
 	M	unmerged
 	R	removed/deleted
+	K	to be killed
 	?	other
 
 Output
--- a/ls-files.c
+++ b/ls-files.c
@@ -16,12 +16,14 @@
 static int show_ignored = 0;
 static int show_stage = 0;
 static int show_unmerged = 0;
+static int show_killed = 0;
 static int line_terminator = '\n';
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
 static const char *tag_removed = "";
 static const char *tag_other = "";
+static const char *tag_killed = "";
 
 static int nr_excludes;
 static const char **excludes;
@@ -87,24 +89,30 @@
 	return 0;
 }
 
-static const char **dir;
+struct nond_on_fs {
+	int len;
+	char name[0];
+};
+
+static struct nond_on_fs **dir;
 static int nr_dir;
 static int dir_alloc;
 
 static void add_name(const char *pathname, int len)
 {
-	char *name;
+	struct nond_on_fs *ent;
 
 	if (cache_name_pos(pathname, len) >= 0)
 		return;
 
 	if (nr_dir == dir_alloc) {
 		dir_alloc = alloc_nr(dir_alloc);
-		dir = xrealloc(dir, dir_alloc*sizeof(char *));
+		dir = xrealloc(dir, dir_alloc*sizeof(ent));
 	}
-	name = xmalloc(len + 1);
-	memcpy(name, pathname, len + 1);
-	dir[nr_dir++] = name;
+	ent = xmalloc(sizeof(*ent) + len + 1);
+	ent->len = len;
+	memcpy(ent->name, pathname, len);
+	dir[nr_dir++] = ent;
 }
 
 /*
@@ -164,11 +172,62 @@
 
 static int cmp_name(const void *p1, const void *p2)
 {
-	const char *n1 = *(const char **)p1;
-	const char *n2 = *(const char **)p2;
-	int l1 = strlen(n1), l2 = strlen(n2);
+	const struct nond_on_fs *e1 = *(const struct nond_on_fs **)p1;
+	const struct nond_on_fs *e2 = *(const struct nond_on_fs **)p2;
+
+	return cache_name_compare(e1->name, e1->len,
+				  e2->name, e2->len);
+}
 
-	return cache_name_compare(n1, l1, n2, l2);
+static void show_killed_files()
+{
+	int i;
+	for (i = 0; i < nr_dir; i++) {
+		struct nond_on_fs *ent = dir[i];
+		char *cp, *sp;
+		int pos, len, killed = 0;
+
+		for (cp = ent->name; cp - ent->name < ent->len; cp = sp + 1) {
+			sp = strchr(cp, '/');
+			if (!sp) {
+				/* If ent->name is prefix of an entry in the
+				 * cache, it will be killed.
+				 */
+				pos = cache_name_pos(ent->name, ent->len);
+				if (0 <= pos)
+					die("bug in show-killed-files");
+				pos = -pos - 1;
+				while (pos < active_nr &&
+				       ce_stage(active_cache[pos]))
+					pos++; /* skip unmerged */
+				if (active_nr <= pos)
+					break;
+				/* pos points at a name immediately after
+				 * ent->name in the cache.  Does it expect
+				 * ent->name to be a directory?
+				 */
+				len = ce_namelen(active_cache[pos]);
+				if ((ent->len < len) &&
+				    !strncmp(active_cache[pos]->name,
+					     ent->name, ent->len) &&
+				    active_cache[pos]->name[ent->len] == '/')
+					killed = 1;
+				break;
+			}
+			if (0 <= cache_name_pos(ent->name, sp - ent->name)) {
+				/* If any of the leading directories in
+				 * ent->name is registered in the cache,
+				 * ent->name will be killed.
+				 */
+				killed = 1;
+				break;
+			}
+		}
+		if (killed)
+			printf("%s%.*s%c", tag_killed,
+			       dir[i]->len, dir[i]->name,
+			       line_terminator);
+	}
 }
 
 static void show_files(void)
@@ -176,11 +235,16 @@
 	int i;
 
 	/* For cached/deleted files we don't need to even do the readdir */
-	if (show_others) {
+	if (show_others || show_killed) {
 		read_directory(".", "", 0);
-		qsort(dir, nr_dir, sizeof(char *), cmp_name);
-		for (i = 0; i < nr_dir; i++)
-			printf("%s%s%c", tag_other, dir[i], line_terminator);
+		qsort(dir, nr_dir, sizeof(struct nond_on_fs *), cmp_name);
+		if (show_others)
+			for (i = 0; i < nr_dir; i++)
+				printf("%s%.*s%c", tag_other,
+				       dir[i]->len, dir[i]->name,
+				       line_terminator);
+		if (show_killed)
+			show_killed_files();
 	}
 	if (show_cached | show_stage) {
 		for (i = 0; i < active_nr; i++) {
@@ -219,8 +283,8 @@
 }
 
 static const char *ls_files_usage =
-	"ls-files [-z] [-t] (--[cached|deleted|others|stage|unmerged])* "
-	"[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]";
+"ls-files [-z] [-t] (--[cached|deleted|others|stage|unmerged|killed])* "
+"[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]";
 
 int main(int argc, char **argv)
 {
@@ -236,6 +300,7 @@
 			tag_unmerged = "M ";
 			tag_removed = "R ";
 			tag_other = "? ";
+			tag_killed = "K ";
 		} else if (!strcmp(arg, "-c") || !strcmp(arg, "--cached")) {
 			show_cached = 1;
 		} else if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
@@ -246,6 +311,8 @@
 			show_ignored = 1;
 		} else if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
 			show_stage = 1;
+		} else if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
+			show_killed = 1;
 		} else if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
 			/* There's no point in showing unmerged unless
 			 * you also show the stage information.
@@ -271,7 +338,7 @@
 	}
 
 	/* With no flags, we default to showing the cached files */
-	if (!(show_stage | show_deleted | show_others | show_unmerged))
+	if (!(show_stage | show_deleted | show_others | show_unmerged | show_killed))
 		show_cached = 1;
 
 	read_cache();
------------------------------------------------

