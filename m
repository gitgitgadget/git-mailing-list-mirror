From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3] fast-import: allow 'ls' and filecopy to read the root
Date: Sat, 10 Mar 2012 02:53:55 -0600
Message-ID: <20120310085354.GE1992@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 09:54:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6I3z-00034f-BJ
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 09:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab2CJIyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 03:54:01 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50054 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab2CJIx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 03:53:59 -0500
Received: by iagz16 with SMTP id z16so3538963iag.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 00:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q9Kk30zeSUmXOIvpWrSjf6DTjEuMHIn6GGBihHetv94=;
        b=OB7E5p/Gt7dMKb6v93ZOCvAwMgZ/1bdHtohNEuonU3IEVznG2k8/RilYxQ2omS1fTa
         8j9nrPfRNX4lHRp2H9/qTmfiS8NCZjxdXLC6BTQCjzI2Mj5F6TpT6z59m7b+b+wYFBtW
         fxGa8dXew6PYaqNnZZqsjENm8rVIiwabl5v1iL00efuiZ4y4ADZGgX8/zlJjQRofTVaC
         whkk/A6ID7+EM2GGHITWTMdul9OoibtPXcQzBNiCn7N9guVGWbqVmI7HD3zUOsbUXCBu
         /82kGqjIq/4HZpxa8A6wt2ApuB13H3wXg9qAmzJGTrZSuvQZN7JI0gRvwhQeGAM/qkFC
         J+mw==
Received: by 10.50.34.166 with SMTP id a6mr1259861igj.57.1331369639041;
        Sat, 10 Mar 2012 00:53:59 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j4sm3456242igq.5.2012.03.10.00.53.58
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 00:53:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1331184656-98629-1-git-send-email-davidbarr@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192773>

In the same spirit as v1.7.4-rc0~177 (fast-import: Allow filemodify to
set the root, 2010-10-10), teach the 'ls' and 'C' commands the
following syntax:

	ls ""
	ls <dataref> ""
	C "" <path>

All three are requests to read from the directory at the top of the
hierarchy.

The potential usefulness of this extension was discovered by using
svn-fe to import from a repository whose history included a
pathological Subversion operation:

  svn cp $SVN_ROOT $SVN_ROOT/subdirectory

Since v1.7.10-rc0~118^2~4^2~5^2~4 (vcs-svn: eliminate repo_tree
structure, 2010-12-10) svn-fe handles this by sending the command
'ls :1 ' to fast-import, expecting output in the form

  '040000' SP 'tree' SP <dataref> HT LF

describing the toplevel directory so it can be copied.  After this
patch, the import works, with no modification to svn-fe needed.

Subtleties:

The 'ls <dataref> ""' command involves printing the makeshift "root"
tree that represents <dataref>, so we need to initialize its mode.

The 'C "" <path>' command needs to be careful not to copy an empty
tree to a subdirectory, as explained in v1.7.4~2^2~2^2 (fast-import:
treat filemodify with empty tree as delete, 2011-01-27).

Based on a patch by David Barr that made the same change at the
parse_ls level.  David's tests were carried over and some new ones
added.

Reported-by: Andrew Sayers <andrew-git@pileofstuff.org>
Signed-off-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Dmitry Ivankov <divanorama@gmail.com>
---
Ok, here's a patch for the svn-fe bug that I could live with.

It has a semantic conflict with the fast-import-ls-fixes series that
I sent separately, which is fixed by adding

			if (!slash1[1])
				die("Empty path component found in input");

after

			if (!slash1)
				goto last_component;

and removing the now-useless

	if (!n)
		die("Empty path component found in input");

I'll send a fixup patch as a reply, for squashing into the merge or
this patch, whichever is the first commit that contains both topics.

 fast-import.c          |   43 ++++++++----
 t/t9010-svn-fe.sh      |   69 +++++++++++++++++++
 t/t9300-fast-import.sh |  174 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+), 14 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c1486cab..75da2954 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1473,6 +1473,9 @@ static void tree_content_replace(
 	root->tree = newtree;
 }
 
+static int tree_content_remove(struct tree_entry *,
+					const char *, struct tree_entry *);
+
 static int tree_content_set(
 	struct tree_entry *root,
 	const char *p,
@@ -1495,6 +1498,15 @@ static int tree_content_set(
 	if (!slash1 && !S_ISDIR(mode) && subtree)
 		die("Non-directories cannot have subtrees");
 
+	/* Git does not track empty directories. */
+	if (S_ISDIR(mode)) {
+		if ((is_null_sha1(sha1) && !subtree->entry_count)
+		    || !memcmp(sha1, EMPTY_TREE_SHA1_BIN, 20)) {
+			tree_content_remove(root, p, NULL);
+			return 1;
+		}
+	}
+
 	if (!root->tree)
 		load_tree(root);
 	t = root->tree;
@@ -1636,6 +1648,11 @@ static int tree_content_get(
 	unsigned int i, n;
 	struct tree_entry *e;
 
+	if (!*p) {
+		e = root;
+		goto last_component;
+	}
+
 	slash1 = strchr(p, '/');
 	if (slash1)
 		n = slash1 - p;
@@ -1648,14 +1665,8 @@ static int tree_content_get(
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
-			if (!slash1) {
-				memcpy(leaf, e, sizeof(*leaf));
-				if (e->tree && is_null_sha1(e->versions[1].sha1))
-					leaf->tree = dup_tree_content(e->tree);
-				else
-					leaf->tree = NULL;
-				return 1;
-			}
+			if (!slash1)
+				goto last_component;
 			if (!S_ISDIR(e->versions[1].mode))
 				return 0;
 			if (!e->tree)
@@ -1664,6 +1675,14 @@ static int tree_content_get(
 		}
 	}
 	return 0;
+
+last_component:
+	memcpy(leaf, e, sizeof(*leaf));
+	if (e->tree && is_null_sha1(e->versions[1].sha1))
+		leaf->tree = dup_tree_content(e->tree);
+	else
+		leaf->tree = NULL;
+	return 1;
 }
 
 static int update_branch(struct branch *b)
@@ -2256,12 +2275,6 @@ static void file_change_m(struct branch *b)
 		p = uq.buf;
 	}
 
-	/* Git does not track empty, non-toplevel directories. */
-	if (S_ISDIR(mode) && !memcmp(sha1, EMPTY_TREE_SHA1_BIN, 20) && *p) {
-		tree_content_remove(&b->branch_tree, p, NULL);
-		return;
-	}
-
 	if (S_ISGITLINK(mode)) {
 		if (inline_data)
 			die("Git links cannot be specified 'inline': %s",
@@ -2369,6 +2382,7 @@ static void file_change_cr(struct branch *b, int rename)
 			leaf.tree);
 		return;
 	}
+
 	tree_content_set(&b->branch_tree, d,
 		leaf.versions[1].sha1,
 		leaf.versions[1].mode,
@@ -3005,6 +3019,7 @@ static void parse_ls(struct branch *b)
 		struct object_entry *e = parse_treeish_dataref(&p);
 		root = new_tree_entry();
 		hashcpy(root->versions[1].sha1, e->idx.sha1);
+		root->versions[1].mode = S_IFDIR;
 		load_tree(root);
 		if (*p++ != ' ')
 			die("Missing space after tree-ish: %s", command_buf.buf);
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b7eed248..45706bde 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -271,6 +271,75 @@ test_expect_success PIPE 'directory with files' '
 	test_cmp hi directory/file2
 '
 
+test_expect_success PIPE 'copy from root to directory' '
+	reinit_git &&
+	echo hello >hello &&
+	hello_blob=$(git hash-object -w -t blob hello) &&
+	subtree=$(
+		echo "100644 blob $hello_blob	README.txt" |
+		git mktree
+	) &&
+	expect=$(
+		git mktree <<-EOF
+			100644 blob $hello_blob	README.txt
+			040000 tree $subtree	trunk
+		EOF
+	) &&
+
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "2012-10-10T00:01:003.000000Z" \
+			svn:log "created README.txt" &&
+		echo PROPS-END
+	} >r1.props &&
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "2012-10-10T00:02:005.000000Z" \
+			svn:log "created trunk" &&
+		echo PROPS-END
+	} >r2.props &&
+	{
+		cat <<-EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		echo Prop-content-length: $(wc -c <r1.props) &&
+		echo Content-length: $(wc -c <r1.props) &&
+		echo &&
+		cat r1.props &&
+		cat <<-\EOF &&
+
+		Node-path: README.txt
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hello &&
+		echo Revision-number: 2
+		echo Prop-content-length: $(wc -c <r2.props) &&
+		echo Content-length: $(wc -c <r2.props) &&
+		echo &&
+		cat r2.props &&
+		sed -e "s/X\$//" <<-\EOF
+
+		Node-path: trunk
+		Node-kind: dir
+		Node-action: add
+		Node-copyfrom-rev: 1
+		Node-copyfrom-path: X
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+		EOF
+	} >copy-root.dump &&
+	try_dump copy-root.dump &&
+
+	git diff-tree --exit-code $expect HEAD
+'
+
 test_expect_success PIPE 'branch name with backslash' '
 	reinit_git &&
 	sort <<-\EOF >expect.branch-files &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 438aaf6b..e5460994 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1047,6 +1047,49 @@ test_expect_success \
 	 git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
 	 compare_diff_raw expect actual'
 
+test_tick
+cat >input <<INPUT_END
+commit refs/heads/N-root-to-subdir
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+copy to subdir
+COMMIT
+
+from refs/heads/branch^0
+C "" subdir
+
+INPUT_END
+
+cat >expect <<\EOF
+:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	subdir/file2/newf
+:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	subdir/file2/oldf
+:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 C100	file4	subdir/file4
+:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 C100	newdir/exec.sh	subdir/newdir/exec.sh
+:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	subdir/newdir/interesting
+EOF
+test_expect_success \
+	'N: copy with empty source path' \
+	'git fast-import <input &&
+	 git diff-tree -C -C -r --no-commit-id N-root-to-subdir >actual &&
+	 compare_diff_raw expect actual'
+
+test_tick
+cat >input <<INPUT_END
+commit refs/heads/N-unquoted-root-to-subdir
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+increase nesting
+COMMIT
+
+from refs/heads/branch^0
+C  subdir
+
+INPUT_END
+test_expect_success \
+	'N: copy with unquoted empty source path' \
+	'git fast-import <input &&
+	 git diff --exit-code N-root-to-subdir N-unquoted-root-to-subdir'
+
 cat >input <<INPUT_END
 commit refs/heads/N2
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -1400,6 +1443,137 @@ test_expect_success \
 	 test_cmp expect.qux actual.qux &&
 	 test_cmp expect.qux actual.quux'
 
+test_expect_success 'N: root of unborn branch reads as present and empty' '
+	empty_tree=$(git mktree </dev/null) &&
+	echo "040000 tree $empty_tree	" >expect &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-empty
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read empty root directory via ls
+	COMMIT
+
+	ls ""
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'N: copying unborn branch root has no effect' '
+	empty_tree=$(git mktree </dev/null) &&
+	echo tree $empty_tree >expect &&
+	git fast-import <<-EOF &&
+	commit refs/heads/N-copy-unborn
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy empty root directory
+	COMMIT
+
+	C "" subdir
+	EOF
+	git cat-file commit N-copy-unborn >cmit &&
+	head -n1 cmit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'N: empty root reads as present and empty' '
+	empty_tree=$(git mktree </dev/null) &&
+	echo "040000 tree $empty_tree	" >expect &&
+	echo empty >msg &&
+	cmit=$(git commit-tree "$empty_tree" -p refs/heads/branch^0 <msg) &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-empty-existing
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read empty root directory via ls
+	COMMIT
+
+	ls ""
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'N: copying empty root has no effect' '
+	empty_tree=$(git mktree </dev/null) &&
+	echo tree $empty_tree >expect &&
+	echo empty >msg &&
+	cmit=$(git commit-tree "$empty_tree" -p refs/heads/branch^0 <msg) &&
+	git fast-import <<-EOF &&
+	commit refs/heads/N-copy-empty
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy empty root directory
+	COMMIT
+
+	C "" subdir
+	EOF
+	git cat-file commit N-copy-empty >cmit &&
+	head -n1 cmit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'N: "ls" command can read subdir of named tree' '
+	branch_cmit=$(git rev-parse --verify refs/heads/branch^0) &&
+	subdir_tree=$(git rev-parse $branch_cmit:newdir) &&
+	echo "040000 tree $subdir_tree	newdir" >expect &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-subdir-of-named-tree
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read from commit with ls
+	COMMIT
+
+	ls $branch_cmit "newdir"
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'N: "ls" command can read root of named commit' '
+	branch_cmit=$(git rev-parse --verify refs/heads/branch^0) &&
+	branch_tree=$(git rev-parse --verify $branch_cmit^{tree}) &&
+	echo "040000 tree $branch_tree	" >expect &&
+	git fast-import --cat-blob-fd=3 3>actual <<-EOF &&
+	commit refs/heads/N-root-of-named-tree
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	read root directory of commit with ls
+	COMMIT
+
+	ls $branch_cmit ""
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success PIPE 'N: read and copy root' '
+	cat >expect <<-\EOF &&
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/file2/newf
+	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/file2/oldf
+	:100755 100755 85df50785d62d3b05ab03d9cbf7e4a0b49449730 85df50785d62d3b05ab03d9cbf7e4a0b49449730 C100	file4	file3/file4
+	:100755 100755 e74b7d465e52746be2b4bae983670711e6e66657 e74b7d465e52746be2b4bae983670711e6e66657 C100	newdir/exec.sh	file3/newdir/exec.sh
+	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/newdir/interesting
+	EOF
+	git update-ref -d refs/heads/N12 &&
+	rm -f backflow &&
+	mkfifo backflow &&
+	(
+		exec <backflow &&
+		cat <<-EOF &&
+		commit refs/heads/N12
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		copy root directory by tree hash read via ls
+		COMMIT
+
+		from refs/heads/branch^0
+		ls ""
+		EOF
+		read mode type tree filename &&
+		echo "M 040000 $tree file3"
+	) |
+	git fast-import --cat-blob-fd=3 3>backflow &&
+	git diff-tree -C --find-copies-harder -r N12^ N12 >actual &&
+	compare_diff_raw expect actual
+'
+
 ###
 ### series O
 ###
-- 
1.7.9.2
