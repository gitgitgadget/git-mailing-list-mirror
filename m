From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Support wholesale directory renames in fast-import
Date: Mon, 9 Jul 2007 23:10:36 -0400
Message-ID: <20070710031036.GA9045@spearce.org>
References: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Frech <david@nimblemachines.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 05:10:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I867h-0001fs-SD
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 05:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760957AbXGJDKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 23:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760936AbXGJDKl
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 23:10:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47180 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758935AbXGJDKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 23:10:40 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I867O-0004uJ-A5; Mon, 09 Jul 2007 23:10:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9496920FBAE; Mon,  9 Jul 2007 23:10:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52035>

Some source material (e.g. Subversion dump files) perform directory
renames without telling us exactly which files in that subdirectory
were moved.  This makes it hard for a frontend to convert such data
formats to a fast-import stream, as all the frontend has on hand
is "Rename a/ to b/" with no details about what files are in a/,
unless the frontend also kept track of all files.

The new 'R' subcommand within a commit allows the frontend to
rename either a file or an entire subdirectory, without needing to
know the object's SHA-1 or the specific files contained within it.
The rename is performed as efficiently as possible internally,
making it cheaper than a 'D'/'M' pair for a file rename.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 David Frech <david@nimblemachines.com> wrote:
 > Git can track file renames implicitly. If I delete and then add (under
 > a different name) the same content, git will figure that out.
 > 
 > But if a directory was renamed, I have no way to tell fast-import
 > about it. I can't delete the directory (using a 'D' command) and then
 > add it back (with a different name) with all its contents, because my
 > source material (an svn dump file) doesn't tell me, at that point,
 > about all the files involved because nothing about them has changed.
 > 
 > fast-import knows about the contents of the directory I want to
 > rename, but doesn't give me a primitive to do the rename. Is this
 > something we need to add? My frontend could keep track of this, but I
 > would duplicating work that fast-import is already doing.

 Does the following do the trick for you?  It is also available
 from my fastimport.git master branch:

	git://repo.or.cz/git/fastimport.git      master
	http://repo.or.cz/r/git/fastimport.git   master

 Yes, it passes all tests...

 Documentation/git-fast-import.txt |   28 ++++++++++-
 fast-import.c                     |   91 ++++++++++++++++++++++++++++++-------
 t/t9300-fast-import.sh            |   68 +++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c66af7c..80a8ee0 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -302,7 +302,7 @@ change to the project.
 	data
 	('from' SP <committish> LF)?
 	('merge' SP <committish> LF)?
-	(filemodify | filedelete | filedeleteall)*
+	(filemodify | filedelete | filerename | filedeleteall)*
 	LF
 ....
 
@@ -325,11 +325,13 @@ commit message use a 0 length data.  Commit messages are free-form
 and are not interpreted by Git.  Currently they must be encoded in
 UTF-8, as fast-import does not permit other encodings to be specified.
 
-Zero or more `filemodify`, `filedelete` and `filedeleteall` commands
+Zero or more `filemodify`, `filedelete`, `filename` and
+`filedeleteall` commands
 may be included to update the contents of the branch prior to
 creating the commit.  These commands may be supplied in any order.
 However it is recommended that a `filedeleteall` command preceed
-all `filemodify` commands in the same commit, as `filedeleteall`
+all `filemodify` and `filerename` commands in the same commit, as
+`filedeleteall`
 wipes the branch clean (see below).
 
 `author`
@@ -495,6 +497,26 @@ here `<path>` is the complete path of the file or subdirectory to
 be removed from the branch.
 See `filemodify` above for a detailed description of `<path>`.
 
+`filerename`
+^^^^^^^^^^^^
+Renames an existing file or subdirectory to a different location
+within the branch.  The existing file or directory must exist. If
+the destination exists it will be replaced by the source directory.
+
+....
+	'R' SP <path> SP <path> LF
+....
+
+here the first `<path>` is the source location and the second
+`<path>` is the destination.  See `filemodify` above for a detailed
+description of what `<path>` may look like.  To use a source path
+that contains SP the path must be quoted.
+
+A `filerename` command takes effect immediately.  Once the source
+location has been renamed to the destination any future commands
+applied to the source location will create new files there and not
+impact the destination of the rename.
+
 `filedeleteall`
 ^^^^^^^^^^^^^^^
 Included in a `commit` command to remove all files (and also all
diff --git a/fast-import.c b/fast-import.c
index f9bfcc7..a1cb13f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -26,9 +26,10 @@ Format of STDIN stream:
     lf;
   commit_msg ::= data;
 
-  file_change ::= file_clr | file_del | file_obm | file_inm;
+  file_change ::= file_clr | file_del | file_rnm | file_obm | file_inm;
   file_clr ::= 'deleteall' lf;
   file_del ::= 'D' sp path_str lf;
+  file_rnm ::= 'R' sp path_str sp path_str lf;
   file_obm ::= 'M' sp mode sp (hexsha1 | idnum) sp path_str lf;
   file_inm ::= 'M' sp mode sp 'inline' sp path_str lf
     data;
@@ -1154,7 +1155,8 @@ static int tree_content_set(
 	struct tree_entry *root,
 	const char *p,
 	const unsigned char *sha1,
-	const uint16_t mode)
+	const uint16_t mode,
+	struct tree_content *subtree)
 {
 	struct tree_content *t = root->tree;
 	const char *slash1;
@@ -1168,20 +1170,22 @@ static int tree_content_set(
 		n = strlen(p);
 	if (!n)
 		die("Empty path component found in input");
+	if (!slash1 && !S_ISDIR(mode) && subtree)
+		die("Non-directories cannot have subtrees");
 
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
 			if (!slash1) {
-				if (e->versions[1].mode == mode
+				if (!S_ISDIR(mode)
+						&& e->versions[1].mode == mode
 						&& !hashcmp(e->versions[1].sha1, sha1))
 					return 0;
 				e->versions[1].mode = mode;
 				hashcpy(e->versions[1].sha1, sha1);
-				if (e->tree) {
+				if (e->tree)
 					release_tree_content_recursive(e->tree);
-					e->tree = NULL;
-				}
+				e->tree = subtree;
 				hashclr(root->versions[1].sha1);
 				return 1;
 			}
@@ -1191,7 +1195,7 @@ static int tree_content_set(
 			}
 			if (!e->tree)
 				load_tree(e);
-			if (tree_content_set(e, slash1 + 1, sha1, mode)) {
+			if (tree_content_set(e, slash1 + 1, sha1, mode, subtree)) {
 				hashclr(root->versions[1].sha1);
 				return 1;
 			}
@@ -1209,9 +1213,9 @@ static int tree_content_set(
 	if (slash1) {
 		e->tree = new_tree_content(8);
 		e->versions[1].mode = S_IFDIR;
-		tree_content_set(e, slash1 + 1, sha1, mode);
+		tree_content_set(e, slash1 + 1, sha1, mode, subtree);
 	} else {
-		e->tree = NULL;
+		e->tree = subtree;
 		e->versions[1].mode = mode;
 		hashcpy(e->versions[1].sha1, sha1);
 	}
@@ -1219,7 +1223,10 @@ static int tree_content_set(
 	return 1;
 }
 
-static int tree_content_remove(struct tree_entry *root, const char *p)
+static int tree_content_remove(
+	struct tree_entry *root,
+	const char *p,
+	struct tree_entry *backup_leaf)
 {
 	struct tree_content *t = root->tree;
 	const char *slash1;
@@ -1239,13 +1246,14 @@ static int tree_content_remove(struct tree_entry *root, const char *p)
 				goto del_entry;
 			if (!e->tree)
 				load_tree(e);
-			if (tree_content_remove(e, slash1 + 1)) {
+			if (tree_content_remove(e, slash1 + 1, backup_leaf)) {
 				for (n = 0; n < e->tree->entry_count; n++) {
 					if (e->tree->entries[n]->versions[1].mode) {
 						hashclr(root->versions[1].sha1);
 						return 1;
 					}
 				}
+				backup_leaf = NULL;
 				goto del_entry;
 			}
 			return 0;
@@ -1254,10 +1262,11 @@ static int tree_content_remove(struct tree_entry *root, const char *p)
 	return 0;
 
 del_entry:
-	if (e->tree) {
+	if (backup_leaf)
+		memcpy(backup_leaf, e, sizeof(*backup_leaf));
+	else if (e->tree)
 		release_tree_content_recursive(e->tree);
-		e->tree = NULL;
-	}
+	e->tree = NULL;
 	e->versions[1].mode = 0;
 	hashclr(e->versions[1].sha1);
 	hashclr(root->versions[1].sha1);
@@ -1629,7 +1638,7 @@ static void file_change_m(struct branch *b)
 			    typename(type), command_buf.buf);
 	}
 
-	tree_content_set(&b->branch_tree, p, sha1, S_IFREG | mode);
+	tree_content_set(&b->branch_tree, p, sha1, S_IFREG | mode, NULL);
 	free(p_uq);
 }
 
@@ -1645,10 +1654,58 @@ static void file_change_d(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = p_uq;
 	}
-	tree_content_remove(&b->branch_tree, p);
+	tree_content_remove(&b->branch_tree, p, NULL);
 	free(p_uq);
 }
 
+static void file_change_r(struct branch *b)
+{
+	const char *s, *d;
+	char *s_uq, *d_uq;
+	const char *endp;
+	struct tree_entry leaf;
+
+	s = command_buf.buf + 2;
+	s_uq = unquote_c_style(s, &endp);
+	if (s_uq) {
+		if (*endp != ' ')
+			die("Missing space after source: %s", command_buf.buf);
+	}
+	else {
+		endp = strchr(s, ' ');
+		if (!endp)
+			die("Missing space after source: %s", command_buf.buf);
+		s_uq = xmalloc(endp - s + 1);
+		memcpy(s_uq, s, endp - s);
+		s_uq[endp - s] = 0;
+	}
+	s = s_uq;
+
+	endp++;
+	if (!*endp)
+		die("Missing dest: %s", command_buf.buf);
+
+	d = endp;
+	d_uq = unquote_c_style(d, &endp);
+	if (d_uq) {
+		if (*endp)
+			die("Garbage after dest in: %s", command_buf.buf);
+		d = d_uq;
+	}
+
+	memset(&leaf, 0, sizeof(leaf));
+	tree_content_remove(&b->branch_tree, s, &leaf);
+	if (!leaf.versions[1].mode)
+		die("Path %s not in branch", s);
+	tree_content_set(&b->branch_tree, d,
+		leaf.versions[1].sha1,
+		leaf.versions[1].mode,
+		leaf.tree);
+
+	free(s_uq);
+	free(d_uq);
+}
+
 static void file_change_deleteall(struct branch *b)
 {
 	release_tree_content_recursive(b->branch_tree.tree);
@@ -1816,6 +1873,8 @@ static void cmd_new_commit(void)
 			file_change_m(b);
 		else if (!prefixcmp(command_buf.buf, "D "))
 			file_change_d(b);
+		else if (!prefixcmp(command_buf.buf, "R "))
+			file_change_r(b);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
 		else
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 53774c8..bf3720d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -580,4 +580,72 @@ test_expect_success \
 	 git diff --raw L^ L >output &&
 	 git diff expect output'
 
+###
+### series M
+###
+
+test_tick
+cat >input <<INPUT_END
+commit refs/heads/M1
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+file rename
+COMMIT
+
+from refs/heads/branch^0
+R file2/newf file2/n.e.w.f
+
+INPUT_END
+
+cat >expect <<EOF
+:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	file2/n.e.w.f
+EOF
+test_expect_success \
+	'M: rename file in same subdirectory' \
+	'git-fast-import <input &&
+	 git diff-tree -M -r M1^ M1 >actual &&
+	 compare_diff_raw expect actual'
+
+cat >input <<INPUT_END
+commit refs/heads/M2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+file rename
+COMMIT
+
+from refs/heads/branch^0
+R file2/newf i/am/new/to/you
+
+INPUT_END
+
+cat >expect <<EOF
+:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	file2/newf	i/am/new/to/you
+EOF
+test_expect_success \
+	'M: rename file to new subdirectory' \
+	'git-fast-import <input &&
+	 git diff-tree -M -r M2^ M2 >actual &&
+	 compare_diff_raw expect actual'
+
+cat >input <<INPUT_END
+commit refs/heads/M3
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+file rename
+COMMIT
+
+from refs/heads/M2^0
+R i other/sub
+
+INPUT_END
+
+cat >expect <<EOF
+:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc R100	i/am/new/to/you	other/sub/am/new/to/you
+EOF
+test_expect_success \
+	'M: rename subdirectory to new subdirectory' \
+	'git-fast-import <input &&
+	 git diff-tree -M -r M3^ M3 >actual &&
+	 compare_diff_raw expect actual'
+
 test_done
-- 
1.5.3.rc0.879.g64b8
