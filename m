From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] fast-import: add 'ls' command
Date: Mon, 3 Jan 2011 02:37:27 -0600
Message-ID: <20110103083727.GD8842@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tomas Carnecky <tom@dbservice.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Jan 03 09:37:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZfvF-0007BM-8Z
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 09:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab1ACIhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 03:37:38 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57628 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab1ACIhh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 03:37:37 -0500
Received: by iwn9 with SMTP id 9so13150151iwn.19
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 00:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=N30W9g8NurJiWemU0+XzQ1q7yVG8M2AC2qfBg05ZB/0=;
        b=gAepcFyLoMu7Wsmz8vCJPaO4dFB6IKu9G1MMvP1xiv+H6Ei9n52hucK1MQTor4j1SC
         3dB3RTx3nq7VjjR/Y6MiGjDg+M8uh7E0P0gZoZSibYlm49aHqzp7r2h7CjX06T5HTt6l
         x2b6sNgbMK3ogPT1y1n1oAZD5jIJyGxV0+cCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fT9LBCcrcbNbRXg4UlD2ouzYOzJ8/bSADIC5SpcNkk4X2tbSWrueC9HBpTISIunGe7
         oGI+9CafEmwtKELNppOXR+ghP4PViQ9whfSHe9dhvUPib4C3KqHIuebP5Z71BwoOw1CF
         fZaOWFcIn3xnoc8FBqTgZUctx0eW3k2MlygpA=
Received: by 10.42.180.7 with SMTP id bs7mr19332861icb.297.1294043857045;
        Mon, 03 Jan 2011 00:37:37 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id o8sm1643373icz.4.2011.01.03.00.37.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 00:37:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103080130.GA8842@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164448>

From: David Barr <david.barr@cordelta.com>
Date: Thu, 2 Dec 2010 21:40:20 +1100

The vcs-svn library currently maintains an in-core index of all paths
in all revisions. Introducing an `ls` command to fast-import would
allow this responsibility to be delegated; and reading this
information from the target repository instead of an in-core data
structure would result in support for resuming an import partway
through (i.e., incremental imports) for free.

There are two forms of the 'ls' command: the two-argument form prints
the entry at <path> for the tree underlying the tree, commit, or tag
named by <dataref>:

	'ls' SP <dataref> SP <path> LF

The one-argument form prints the entry at <path> in fast-import's
active commit.

	'ls' SP <path> LF

Output uses ls-tree format.

Dirty hack: missing paths are assumed to represent the empty
subtree and are printed as

 040000 tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904	path/to/nowhere

to avoid confusing frontends that inserted such a path before.  But
frontends should also be prepared to accept

 missing path/to/nowhere

from backends that (unlike git) distinguish between empty subtrees and
nonentities.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The empty tree handling is an evil hack.  One of the tests illustrates
the kind of operation this is meant to support.  It would be easy to
convince me that some other evil hack is better.

This doesn't have tests for the basic functionality.  Maybe there
should be a new t9302-fast-import-bidi.sh so there is less to read to
get started?

No new "feature" for this.  Frontends can easily make a feature test
for themselves if they need it. ;-)  And I still have plans for
"feature command ls" et al, as part of a series including Tomas's
simplified command dispatch.

Only compile tested.  (Something similar to this is very well tested
but that is not enough to prevent accidents.)

Changes from v1:
 - new documentation and demo (tests)
 - refactored peel-to-tree routines
 - mode is always 6 digits
 - path output uses quoting (especially important for filenames
   with \n [though that wouldn't come up in the svn-fe case])
 - persistent buffers to avoid allocation overhead
 - the empty tree hackery
 - mode is based on type, not based on extracting the object itself
 - path after <dataref> does not have to be quoted
 - no-<dataref> form is 'ls "<path>"' instead of 'ls index "<path>"'

Thanks for the original patch and a lot of help improving it go to
David.

'night,
Jonathan

 Documentation/git-fast-import.txt |   49 +++++++++++-
 fast-import.c                     |  162 ++++++++++++++++++++++++++++++++++++-
 t/t9300-fast-import.sh            |   91 +++++++++++++++++++++
 3 files changed, 299 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index f56dfca..3957f70 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -192,7 +192,8 @@ especially when a higher level language such as Perl, Python or
 Ruby is being used.
 
 fast-import is very strict about its input.  Where we say SP below we mean
-*exactly* one space.  Likewise LF means one (and only one) linefeed.
+*exactly* one space.  Likewise LF means one (and only one) linefeed
+and HT one (and only one) horizontal tab.
 Supplying additional whitespace characters will cause unexpected
 results, such as branch names or file names with leading or trailing
 spaces in their name, or early termination of fast-import when it encounters
@@ -330,6 +331,11 @@ and control the current import process.  More detailed discussion
 	format to the file descriptor set with `--cat-blob-fd` or
 	`stdout` if unspecified.
 
+`ls`::
+	Causes fast-import to print a directory entry in 'ls-tree'
+	format to the file descriptor set with `--cat-blob-fd` or
+	`stdout` if unspecified.
+
 `feature`::
 	Require that fast-import supports the specified feature, or
 	abort if it does not.
@@ -916,6 +922,47 @@ This command can be used anywhere in the stream that comments are
 accepted.  In particular, the `cat-blob` command can be used in the
 middle of a commit but not in the middle of a `data` command.
 
+`ls`
+~~~~
+Prints a directory entry to a file descriptor previously arranged with
+the `--cat-blob-fd` argument.  In the current implementation, if that
+entry represents a subdirectory in the current commit, it will be
+stored in the object database, but it is not advisable to rely on this
+detail since it maybe change.
+
+....
+	'ls' (SP <dataref>)? SP <path> LF
+....
+
+The `<dataref>` can be either a mark reference (`:<idnum>`) or a full
+40-byte SHA-1 of a Git tag, commit, or tree object, preexisting or
+waiting to be written.  The directory entry printed is that named by
+the path, relative to the top level of that tree.
+
+The `ls` command can be used anywhere in the stream that comments are
+accepted, including the middle of a commit.
+
+In the middle of a `commit`, the `<dataref>` part of the command can
+be omitted, in which case the path names a directory entry within
+fast-import's active commit.  The path must be quoted in this case.
+
+Output uses the same format as `git ls-tree <tree> -- <path>`:
+
+====
+	<mode> SP ('blob' | 'tree') SP <dataref> HT <path> LF
+====
+
+Since git repositories do not distinguish between missing paths and
+empty subtrees, if a path is not found it will be reported as an
+empty tree.  Backends for version control systems that do have a
+notion of empty trees may write
+
+====
+	missing SP <path> LF
+====
+
+for paths that do not correspond to a blob or subtree.
+
 `feature`
 ~~~~~~~~~
 Require that fast-import supports the specified feature, or abort if
diff --git a/fast-import.c b/fast-import.c
index 385d12d..21cb109 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -24,10 +24,12 @@ Format of STDIN stream:
     commit_msg
     ('from' sp committish lf)?
     ('merge' sp committish lf)*
-    file_change*
+    (file_change | ls)*
     lf?;
   commit_msg ::= data;
 
+  ls ::= 'ls' sp '"' quoted(path) '"' lf;
+
   file_change ::= file_clr
     | file_del
     | file_rnm
@@ -132,7 +134,7 @@ Format of STDIN stream:
   ts    ::= # time since the epoch in seconds, ascii base10 notation;
   tz    ::= # GIT style timezone;
 
-     # note: comments and cat requests may appear anywhere
+     # note: comments, ls and cat requests may appear anywhere
      # in the input, except within a data command.  Any form
      # of the data command always escapes the related input
      # from comment processing.
@@ -141,7 +143,9 @@ Format of STDIN stream:
      # must be the first character on that line (an lf
      # preceded it).
      #
+
   cat_blob ::= 'cat-blob' sp (hexsha1 | idnum) lf;
+  ls_tree  ::= 'ls' sp (hexsha1 | idnum) sp path_str lf;
 
   comment ::= '#' not_lf* lf;
   not_lf  ::= # Any byte that is not ASCII newline (LF);
@@ -373,6 +377,7 @@ static int cat_blob_fd = STDOUT_FILENO;
 
 static void parse_argv(void);
 static void parse_cat_blob(void);
+static void parse_ls(struct branch *b);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -2613,6 +2618,8 @@ static void parse_new_commit(void)
 			note_change_n(b, prev_fanout);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
+		else if (!prefixcmp(command_buf.buf, "ls "))
+			parse_ls(b);
 		else {
 			unread_command_buf = 1;
 			break;
@@ -2836,6 +2843,155 @@ static void parse_cat_blob(void)
 	cat_blob(oe, sha1);
 }
 
+static struct object_entry *dereference(struct object_entry *oe,
+					unsigned char sha1[20])
+{
+	unsigned long size;
+	void *buf = NULL;
+	if (!oe) {
+		enum object_type type = sha1_object_info(sha1, NULL);
+		if (type < 0)
+			die("object not found: %s", sha1_to_hex(sha1));
+		/* cache it! */
+		oe = insert_object(sha1);
+		oe->type = type;
+		oe->pack_id = MAX_PACK_ID;
+		oe->idx.offset = 1;
+	}
+	switch (oe->type) {
+	case OBJ_TREE:	/* easy case. */
+		return oe;
+	case OBJ_COMMIT:
+	case OBJ_TAG:
+		break;
+	default:
+		die("Not a treeish: %s", command_buf.buf);
+	}
+
+	if (oe->pack_id != MAX_PACK_ID) {	/* in a pack being written */
+		buf = gfi_unpack_entry(oe, &size);
+	} else {
+		enum object_type unused;
+		buf = read_sha1_file(sha1, &unused, &size);
+	}
+	if (!buf)
+		die("Can't load object %s", sha1_to_hex(sha1));
+
+	/* Peel one layer. */
+	switch (oe->type) {
+	case OBJ_TAG:
+		if (size < 40 + strlen("object ") ||
+		    get_sha1_hex(buf + strlen("object "), sha1))
+			die("Invalid SHA1 in tag: %s", command_buf.buf);
+		break;
+	case OBJ_COMMIT:
+		if (size < 40 + strlen("tree ") ||
+		    get_sha1_hex(buf + strlen("tree "), sha1))
+			die("Invalid SHA1 in commit: %s", command_buf.buf);
+	}
+
+	free(buf);
+	return find_object(sha1);
+}
+
+static struct object_entry *parse_treeish_dataref(const char **p)
+{
+	unsigned char sha1[20];
+	struct object_entry *e;
+
+	if (**p == ':') {	/* <mark> */
+		char *endptr;
+		e = find_mark(strtoumax(*p + 1, &endptr, 10));
+		if (endptr == *p + 1)
+			die("Invalid mark: %s", command_buf.buf);
+		if (!e)
+			die("Unknown mark: %s", command_buf.buf);
+		*p = endptr;
+		hashcpy(sha1, e->idx.sha1);
+	} else {	/* <sha1> */
+		if (get_sha1_hex(*p, sha1))
+			die("Invalid SHA1: %s", command_buf.buf);
+		e = find_object(sha1);
+		*p += 40;
+	}
+
+	while (!e || e->type != OBJ_TREE)
+		e = dereference(e, sha1);
+	return e;
+}
+
+static void print_ls(int mode, const unsigned char *sha1, const char *path)
+{
+	static struct strbuf line = STRBUF_INIT;
+
+	/* See show_tree(). */
+	const char *type =
+		S_ISGITLINK(mode) ? commit_type :
+		S_ISDIR(mode) ? tree_type :
+		blob_type;
+
+	/* mode SP type SP object_name TAB path LF */
+	strbuf_reset(&line);
+	strbuf_addf(&line, "%06o %s %s\t",
+			mode, type, sha1_to_hex(sha1));
+	quote_c_style(path, &line, NULL, 0);
+	strbuf_addch(&line, '\n');
+	cat_blob_write(line.buf, line.len);
+}
+
+static void parse_ls(struct branch *b)
+{
+	const char *p;
+	struct tree_entry *root = NULL;
+	struct tree_entry leaf = {0};
+
+	/* ls SP (<treeish> SP)? <path> */
+	p = command_buf.buf + strlen("ls ");
+	if (*p == '"') {
+		if (!b)
+			die("Not in a commit: %s", command_buf.buf);
+		root = &b->branch_tree;
+	} else {
+		struct object_entry *e = parse_treeish_dataref(&p);
+		root = new_tree_entry();
+		hashcpy(root->versions[1].sha1, e->idx.sha1);
+		load_tree(root);
+		if (*p++ != ' ')
+			die("Missing space after tree-ish: %s", command_buf.buf);
+	}
+	if (*p == '"') {
+		static struct strbuf uq = STRBUF_INIT;
+		const char *endp;
+		strbuf_reset(&uq);
+		if (unquote_c_style(&uq, p, &endp))
+			die("Invalid path: %s", command_buf.buf);
+		if (*endp)
+			die("Garbage after path in: %s", command_buf.buf);
+		p = uq.buf;
+	}
+	tree_content_get(root, p, &leaf);
+	if (!leaf.versions[1].mode) {
+		/*
+		 * Missing path?  Must be an empty subtree!
+		 *
+		 * When git learns to track empty directories, we can report
+		 * this by saying 'missing "path/to/directory"' instead.
+		 */
+		print_ls(S_IFDIR, (const unsigned char *) EMPTY_TREE_SHA1_BIN, p);
+	} else {
+		/*
+		 * A directory in preparation would have a sha1 of zero
+		 * until it is saved.  Save, for simplicity.
+		 */
+		if (S_ISDIR(leaf.versions[1].mode))
+			store_tree(&leaf);
+
+		print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, p);
+	}
+	if (!b || root != &b->branch_tree)
+		release_tree_entry(root);
+}
+
 static void checkpoint(void)
 {
 	checkpoint_requested = 0;
@@ -3131,6 +3287,8 @@ int main(int argc, const char **argv)
 	while (read_next_command() != EOF) {
 		if (!strcmp("blob", command_buf.buf))
 			parse_new_blob();
+		else if (!prefixcmp(command_buf.buf, "ls "))
+			parse_ls(NULL);
 		else if (!prefixcmp(command_buf.buf, "commit "))
 			parse_new_commit();
 		else if (!prefixcmp(command_buf.buf, "tag "))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index b9aa3f0..6842b1f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -906,6 +906,97 @@ test_expect_success \
 	 git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
 	 compare_diff_raw expect actual'
 
+test_expect_success PIPE 'N: read and copy directory' '
+	cat >expect <<-\EOF
+	:100755 100755 f1fb5da718392694d0076d677d6d0e364c79b0bc f1fb5da718392694d0076d677d6d0e364c79b0bc C100	file2/newf	file3/newf
+	:100644 100644 7123f7f44e39be127c5eb701e5968176ee9d78b1 7123f7f44e39be127c5eb701e5968176ee9d78b1 C100	file2/oldf	file3/oldf
+	EOF
+	git update-ref -d refs/heads/N4 &&
+	rm -f backflow &&
+	mkfifo backflow &&
+	(
+		exec <backflow &&
+		cat <<-EOF &&
+		commit refs/heads/N4
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		copy by tree hash, part 2
+		COMMIT
+
+		from refs/heads/branch^0
+		ls "file2"
+		EOF
+		read mode type tree filename &&
+		echo "M 040000 $tree file3"
+	) |
+	git fast-import --cat-blob-fd=3 3>backflow &&
+	git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
+	compare_diff_raw expect actual
+'
+
+test_expect_success PIPE 'N: read and copy "empty" directory' '
+	cat <<-\EOF >expect &&
+	OBJNAME
+	:000000 100644 OBJNAME OBJNAME A	greeting
+	OBJNAME
+	:100644 000000 OBJNAME OBJNAME D	unrelated
+	OBJNAME
+	:000000 100644 OBJNAME OBJNAME A	unrelated
+	EOF
+	git update-ref -d refs/heads/copy-empty &&
+	rm -f backflow &&
+	mkfifo backflow &&
+	(
+		exec <backflow &&
+		cat <<-EOF &&
+		commit refs/heads/copy-empty
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		copy "empty" (missing) directory
+		COMMIT
+
+		M 100644 inline src/greeting
+		data <<BLOB
+		hello
+		BLOB
+		C src/greeting dst1/non-greeting
+		C src/greeting unrelated
+		# leave behind "empty" src directory
+		D src/greeting
+		ls "src"
+		EOF
+		read mode type tree filename &&
+		sed -e "s/X\$//" <<-EOF
+		M $mode $tree dst1
+		M $mode $tree dst2
+
+		commit refs/heads/copy-empty
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		copy empty directory to root
+		COMMIT
+
+		M $mode $tree X
+
+		commit refs/heads/copy-empty
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		add another file
+		COMMIT
+
+		M 100644 inline greeting
+		data <<BLOB
+		hello
+		BLOB
+		EOF
+	) |
+	git fast-import --cat-blob-fd=3 3>backflow &&
+	git rev-list copy-empty |
+	git diff-tree -r --root --stdin |
+	sed "s/$_x40/OBJNAME/g" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success \
 	'N: delete directory by copying' \
 	'cat >expect <<-\EOF &&
-- 
1.7.4.rc0.580.g89dc.dirty
