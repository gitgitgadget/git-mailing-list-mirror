From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Teach fast-import to recursively copy files/directories
Date: Sun, 15 Jul 2007 01:45:15 -0400
Message-ID: <20070715054515.GA32550@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 07:45:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9wv7-0003F8-1o
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 07:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbXGOFpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 01:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbXGOFpV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 01:45:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45731 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbXGOFpU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 01:45:20 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I9wv0-0003Ok-42; Sun, 15 Jul 2007 01:45:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5799720FBAE; Sun, 15 Jul 2007 01:45:16 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52525>

Some source material (e.g. Subversion dump files) perform directory
renames by telling us the directory was copied, then deleted in the
same revision.  This makes it difficult for a frontend to convert
such data formats to a fast-import stream, as all the frontend has
on hand is "Copy a/ to b/; Delete a/" with no details about what
files are in a/, unless the frontend also kept track of all files.

The new 'C' subcommand within a commit allows the frontend to make a
recursive copy of one path to another path within the branch, without
needing to keep track of the individual file paths.  The metadata
copy is performed in memory efficiently, but is implemented as a
copy-immediately operation, rather than copy-on-write.

With this new 'C' subcommand frontends could obviously implement an
'R' (rename) on their own as a combination of 'C' and 'D' (delete),
but since we have already offered up 'R' in the past and it is a
trivial thing to keep implemented I'm not going to deprecate it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
  
    This and the following changes since commit 9d6f220cc8ffbd71b4c68765b52c3a7c41dd729b:
      Josh Triplett (1):
            Remove useless uses of cat, and replace with filename arguments
    
    are available in the git repository at:
    
      repo.or.cz:/srv/git/git/fastimport.git master
    
    Marius Storm-Olsen (1):
          Fix git-p4 on Windows to not use the Posix sysconf function.
    
    Shawn O. Pearce (2):
          Correct trivial typo in fast-import documentation
          Teach fast-import to recursively copy files/directories
    
     Documentation/git-fast-import.txt |   40 +++++++++++++++--
     contrib/fast-import/git-p4        |    6 ++-
     fast-import.c                     |   81 ++++++++++++++++++++++++++++++++++--
     t/t9300-fast-import.sh            |   83 +++++++++++++++++++++++++++++++++++++
     4 files changed, 200 insertions(+), 10 deletions(-)

 Hopefully this stuff will make it into 1.5.3 final.  This should
 be the last fastimport update before then.

 --
 Documentation/git-fast-import.txt |   40 +++++++++++++++--
 fast-import.c                     |   81 ++++++++++++++++++++++++++++++++++--
 t/t9300-fast-import.sh            |   83 +++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index bf1ba67..30ee98d 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -302,7 +302,7 @@ change to the project.
 	data
 	('from' SP <committish> LF)?
 	('merge' SP <committish> LF)?
-	(filemodify | filedelete | filerename | filedeleteall)*
+	(filemodify | filedelete | filecopy | filerename | filedeleteall)*
 	LF
 ....
 
@@ -325,13 +325,13 @@ commit message use a 0 length data.  Commit messages are free-form
 and are not interpreted by Git.  Currently they must be encoded in
 UTF-8, as fast-import does not permit other encodings to be specified.
 
-Zero or more `filemodify`, `filedelete`, `filerename` and
-`filedeleteall` commands
+Zero or more `filemodify`, `filedelete`, `filecopy`, `filerename`
+and `filedeleteall` commands
 may be included to update the contents of the branch prior to
 creating the commit.  These commands may be supplied in any order.
 However it is recommended that a `filedeleteall` command preceed
-all `filemodify` and `filerename` commands in the same commit, as
-`filedeleteall`
+all `filemodify`, `filecopy` and `filerename` commands in the same
+commit, as `filedeleteall`
 wipes the branch clean (see below).
 
 `author`
@@ -497,6 +497,27 @@ here `<path>` is the complete path of the file or subdirectory to
 be removed from the branch.
 See `filemodify` above for a detailed description of `<path>`.
 
+`filecopy`
+^^^^^^^^^^^^
+Recursively copies an existing file or subdirectory to a different
+location within the branch.  The existing file or directory must
+exist.  If the destination exists it will be completely replaced
+by the content copied from the source.
+
+....
+	'C' SP <path> SP <path> LF
+....
+
+here the first `<path>` is the source location and the second
+`<path>` is the destination.  See `filemodify` above for a detailed
+description of what `<path>` may look like.  To use a source path
+that contains SP the path must be quoted.
+
+A `filecopy` command takes effect immediately.  Once the source
+location has been copied to the destination any future commands
+applied to the source location will not impact the destination of
+the copy.
+
 `filerename`
 ^^^^^^^^^^^^
 Renames an existing file or subdirectory to a different location
@@ -517,6 +538,15 @@ location has been renamed to the destination any future commands
 applied to the source location will create new files there and not
 impact the destination of the rename.
 
+Note that a `filerename` is the same as a `filecopy` followed by a
+`filedelete` of the source location.  There is a slight performance
+advantage to using `filerename`, but the advantage is so small
+that it is never worth trying to convert a delete/add pair in
+source material into a rename for fast-import.  This `filerename`
+command is provided just to simplify frontends that already have
+rename information and don't want bother with decomposing it into a
+`filecopy` followed by a `filedelete`.
+
 `filedeleteall`
 ^^^^^^^^^^^^^^^
 Included in a `commit` command to remove all files (and also all
diff --git a/fast-import.c b/fast-import.c
index a1cb13f..99a19d8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -26,10 +26,16 @@ Format of STDIN stream:
     lf;
   commit_msg ::= data;
 
-  file_change ::= file_clr | file_del | file_rnm | file_obm | file_inm;
+  file_change ::= file_clr
+    | file_del
+    | file_rnm
+    | file_cpy
+    | file_obm
+    | file_inm;
   file_clr ::= 'deleteall' lf;
   file_del ::= 'D' sp path_str lf;
   file_rnm ::= 'R' sp path_str sp path_str lf;
+  file_cpy ::= 'C' sp path_str sp path_str lf;
   file_obm ::= 'M' sp mode sp (hexsha1 | idnum) sp path_str lf;
   file_inm ::= 'M' sp mode sp 'inline' sp path_str lf
     data;
@@ -623,6 +629,31 @@ static void release_tree_entry(struct tree_entry *e)
 	avail_tree_entry = e;
 }
 
+static struct tree_content *dup_tree_content(struct tree_content *s)
+{
+	struct tree_content *d;
+	struct tree_entry *a, *b;
+	unsigned int i;
+
+	if (!s)
+		return NULL;
+	d = new_tree_content(s->entry_count);
+	for (i = 0; i < s->entry_count; i++) {
+		a = s->entries[i];
+		b = new_tree_entry();
+		memcpy(b, a, sizeof(*a));
+		if (a->tree && is_null_sha1(b->versions[1].sha1))
+			b->tree = dup_tree_content(a->tree);
+		else
+			b->tree = NULL;
+		d->entries[i] = b;
+	}
+	d->entry_count = s->entry_count;
+	d->delta_depth = s->delta_depth;
+
+	return d;
+}
+
 static void start_packfile(void)
 {
 	static char tmpfile[PATH_MAX];
@@ -1273,6 +1304,43 @@ del_entry:
 	return 1;
 }
 
+static int tree_content_get(
+	struct tree_entry *root,
+	const char *p,
+	struct tree_entry *leaf)
+{
+	struct tree_content *t = root->tree;
+	const char *slash1;
+	unsigned int i, n;
+	struct tree_entry *e;
+
+	slash1 = strchr(p, '/');
+	if (slash1)
+		n = slash1 - p;
+	else
+		n = strlen(p);
+
+	for (i = 0; i < t->entry_count; i++) {
+		e = t->entries[i];
+		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+			if (!slash1) {
+				memcpy(leaf, e, sizeof(*leaf));
+				if (e->tree && is_null_sha1(e->versions[1].sha1))
+					leaf->tree = dup_tree_content(e->tree);
+				else
+					leaf->tree = NULL;
+				return 1;
+			}
+			if (!S_ISDIR(e->versions[1].mode))
+				return 0;
+			if (!e->tree)
+				load_tree(e);
+			return tree_content_get(e, slash1 + 1, leaf);
+		}
+	}
+	return 0;
+}
+
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
@@ -1658,7 +1726,7 @@ static void file_change_d(struct branch *b)
 	free(p_uq);
 }
 
-static void file_change_r(struct branch *b)
+static void file_change_cr(struct branch *b, int rename)
 {
 	const char *s, *d;
 	char *s_uq, *d_uq;
@@ -1694,7 +1762,10 @@ static void file_change_r(struct branch *b)
 	}
 
 	memset(&leaf, 0, sizeof(leaf));
-	tree_content_remove(&b->branch_tree, s, &leaf);
+	if (rename)
+		tree_content_remove(&b->branch_tree, s, &leaf);
+	else
+		tree_content_get(&b->branch_tree, s, &leaf);
 	if (!leaf.versions[1].mode)
 		die("Path %s not in branch", s);
 	tree_content_set(&b->branch_tree, d,
@@ -1874,7 +1945,9 @@ static void cmd_new_commit(void)
 		else if (!prefixcmp(command_buf.buf, "D "))
 			file_change_d(b);
 		else if (!prefixcmp(command_buf.buf, "R "))
-			file_change_r(b);
+			file_change_cr(b, 1);
+		else if (!prefixcmp(command_buf.buf, "C "))
+			file_change_cr(b, 0);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
 		else
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index bf3720d..4b920be 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -648,4 +648,87 @@ test_expect_success \
 	 git diff-tree -M -r M3^ M3 >actual &&
 	 compare_diff_raw expect actual'
 
+###
+### series N
+###
+
+test_tick
+cat >input <<INPUT_END
+commit refs/heads/N1
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+file copy
+COMMIT
+
+from refs/heads/branch^0
+C file2/newf file2/n.e.w.f
+
+INPUT_END
+
+cat >expect <<EOF
+:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file2/n.e.w.f
+EOF
+test_expect_success \
+	'N: copy file in same subdirectory' \
+	'git-fast-import <input &&
+	 git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
+	 compare_diff_raw expect actual'
+
+cat >input <<INPUT_END
+commit refs/heads/N2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+clean directory copy
+COMMIT
+
+from refs/heads/branch^0
+C file2 file3
+
+commit refs/heads/N2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+modify directory copy
+COMMIT
+
+M 644 inline file3/file5
+data <<EOF
+$file5_data
+EOF
+
+INPUT_END
+
+cat >expect <<EOF
+:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
+:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
+:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+EOF
+test_expect_success \
+	'N: copy then modify subdirectory' \
+	'git-fast-import <input &&
+	 git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
+	 compare_diff_raw expect actual'
+
+cat >input <<INPUT_END
+commit refs/heads/N3
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+dirty directory copy
+COMMIT
+
+from refs/heads/branch^0
+M 644 inline file2/file5
+data <<EOF
+$file5_data
+EOF
+
+C file2 file3
+D file2/file5
+
+INPUT_END
+
+test_expect_success \
+	'N: copy dirty subdirectory' \
+	'git-fast-import <input &&
+	 test `git-rev-parse N2^{tree}` = `git-rev-parse N3^{tree}`'
+
 test_done
-- 
1.5.3.rc0.900.ge7568
