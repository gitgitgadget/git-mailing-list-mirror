From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 2/7] fast-import: Let importers retrieve the objects being written
Date: Wed, 13 Oct 2010 00:50:19 +1100
Message-ID: <1286891424-2067-3-git-send-email-david.barr@cordelta.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 12 15:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5fFa-0004Px-J0
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 15:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373Ab0JLNue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 09:50:34 -0400
Received: from static-198-196.grapevine.transact.net.au ([121.127.198.196]:63919
	"EHLO mailhost.cordelta" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932219Ab0JLNud (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 09:50:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id BA5AAC072;
	Wed, 13 Oct 2010 00:50:34 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RsnbHEKmNcU6; Wed, 13 Oct 2010 00:50:29 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.127])
	by mailhost.cordelta (Postfix) with ESMTP id 92AF5C069;
	Wed, 13 Oct 2010 00:50:29 +1100 (EST)
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158840>

From: Jonathan Nieder <jrnieder@gmail.com>

As the description of the "progress" option in git-fast-import.1
hints, there is no convenient way to immediately access the objects
written to a new repository through fast-import.  Until a checkpoint
has been started and finishes writing the pack index, any new blobs,
trees, and commits will not be accessible using standard git tools.

So introduce another way: a "cat" command introduced in the command
stream requests for fast-import to print an object to the same
report-fd stream used to report commits being written.

The output uses the same format as "git cat-file --batch".

Like cat-file --batch, this does not provide an option to dereference
objects to a type of the requestor's choosing.  Tags are presented
as tags, commits as commits, and trees as trees.

Objects can be specified by path within a tree as well, using a

 cat TREE "PATH"

syntax.  With this syntax, also, the tree can only be specified by
:n marker or 40-digit tree id.

Cc: Shawn O. Pearce <spearce@spearce.org>
Cc: David Barr <david.barr@cordelta.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fast-import.txt |   34 +++++++++++-
 fast-import.c                     |  108 +++++++++++++++++++++++++++++++++++++
 t/t9300-fast-import.sh            |  102 ++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index e217635..2cf48f5 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -102,7 +102,8 @@ OPTIONS
 +
 The described objects are not necessarily accessible
 using standard git plumbing tools until a little while
-after the next checkpoint.
+after the next checkpoint.  To request access to the
+objects before then, use `cat` lines in the command stream.
 
 --export-pack-edges=<file>::
 	After creating a packfile, print a line of data to
@@ -332,6 +333,10 @@ and control the current import process.  More detailed discussion
 	standard output.  This command is optional and is not needed
 	to perform an import.
 
+`cat`::
+	Causes fast-import to print an object in 'cat-file --batch'
+	format to the file descriptor set with "feature report-fd".
+
 `feature`::
 	Require that fast-import supports the specified feature, or
 	abort if it does not.
@@ -888,6 +893,33 @@ Placing a `progress` command immediately after a `checkpoint` will
 inform the reader when the `checkpoint` has been completed and it
 can safely access the refs that fast-import updated.
 
+`cat`
+~~~~~
+Causes fast-import to print an object to a file descriptor
+previously arranged with the `--report-fd` option.  The command
+otherwise has no impact on the current import; its main purpose is to
+retrieve objects that may be in fast-import's memory but not
+accessible from the target repository a little quicker than by the
+method suggested by the description of the `progress` option.
+
+....
+	'cat' SP <dataref> LF
+....
+
+The `<dataref>` can be either a mark reference (`:<idnum>`)
+set previously, or a full 40-byte SHA-1 of any Git object,
+preexisting or ready to be written.
+
+If `<dataref>` refers to a tree object, it may be followed by
+a path within that tree to retrieve a subtree or blob.
+
+....
+	'cat' SP <treeref> SP <path> LF
+....
+
+A `<path>` string should be surrounded with quotation marks and
+use C-style escaping.
+
 `feature`
 ~~~~~~~~~
 Require that fast-import supports the specified feature, or abort if
diff --git a/fast-import.c b/fast-import.c
index ef0cee7..099f63e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -55,6 +55,9 @@ Format of STDIN stream:
     ('from' sp committish lf)?
     lf?;
 
+  cat_request ::= 'cat' sp (hexsha1 | idnum) lf
+    | 'cat' sp hexsha1 sp path_str lf;
+
   checkpoint ::= 'checkpoint' lf
     lf?;
 
@@ -2688,6 +2691,109 @@ static void parse_reset_branch(void)
 		unread_command_buf = 1;
 }
 
+static void quoted_path_sha1(unsigned char sha1[20], struct tree_entry *root,
+				const char *path, const char *line)
+{
+	struct strbuf uq = STRBUF_INIT;
+	struct tree_entry leaf = {0};
+	const char *x;
+
+	if (unquote_c_style(&uq, path, &x))
+		die("Invalid path: %s", line);
+	if (*x)
+		die("Garbage after path: %s", line);
+	tree_content_get(root, uq.buf, &leaf);
+	if (!leaf.versions[1].mode)
+		die("Path %s not in branch", uq.buf);
+	hashcpy(sha1, leaf.versions[1].sha1);
+}
+
+static void sendreport(const char *buf, unsigned long size)
+{
+	if (write_in_full(report_fd, buf, size) != size)
+		die_errno("Write to frontend failed");
+}
+
+static void cat_object(struct object_entry *oe, unsigned char sha1[20])
+{
+	struct strbuf line = STRBUF_INIT;
+	unsigned long size;
+	enum object_type type = 0;
+	char *buf;
+
+	if (report_fd < 0)
+		die("Internal error: bad report_fd %d", report_fd);
+	if (oe && oe->pack_id != MAX_PACK_ID) {
+		type = oe->type;
+		buf = gfi_unpack_entry(oe, &size);
+	} else {
+		buf = read_sha1_file(sha1, &type, &size);
+	}
+	if (!buf)
+		die("Can't read object %s", sha1_to_hex(sha1));
+
+	/*
+	 * Output based on batch_one_object() from cat-file.c.
+	 */
+	if (type <= 0) {
+		strbuf_reset(&line);
+		strbuf_addf(&line, "%s missing\n", sha1_to_hex(sha1));
+		if (write_in_full(report_fd, line.buf, line.len) != line.len)
+			die_errno("Write to frontend failed 1");
+	}
+	strbuf_reset(&line);
+	strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
+						typename(type), size);
+	sendreport(line.buf, line.len);
+	sendreport(buf, size);
+	sendreport("\n", 1);
+	free(buf);
+}
+
+
+static void parse_cat_request(void)
+{
+	const char *p;
+	struct object_entry *oe = oe;
+	unsigned char sha1[20];
+	struct tree_entry root = {0};
+
+	/* cat SP <object> */
+	p = command_buf.buf + strlen("cat ");
+	if (report_fd < 0)
+		die("The cat command requires the report-fd feature.");
+	if (*p == ':') {
+		char *x;
+		oe = find_mark(strtoumax(p + 1, &x, 10));
+		if (x == p + 1)
+			die("Invalid mark: %s", command_buf.buf);
+		if (!oe)
+			die("Unknown mark: %s", command_buf.buf);
+		p = x;
+		hashcpy(sha1, oe->idx.sha1);
+	} else {
+		if (get_sha1_hex(p, sha1))
+			die("Invalid SHA1: %s", command_buf.buf);
+		p += 40;
+		if (!*p)
+			oe = find_object(sha1);
+	}
+
+	/* [ SP "<path>" ] */
+	if (*p) {
+		if (*p++ != ' ')
+			die("Missing space after SHA1: %s", command_buf.buf);
+
+		/* cat <tree> "<path>" form. */
+		hashcpy(root.versions[1].sha1, sha1);
+		load_tree(&root);
+		quoted_path_sha1(sha1, &root, p, command_buf.buf);
+		oe = find_object(sha1);
+	}
+
+	cat_object(oe, sha1);
+}
+
 static void parse_checkpoint(void)
 {
 	if (object_count) {
@@ -2971,6 +3077,8 @@ int main(int argc, const char **argv)
 			parse_new_tag();
 		else if (!prefixcmp(command_buf.buf, "reset "))
 			parse_reset_branch();
+		else if (!prefixcmp(command_buf.buf, "cat "))
+			parse_cat_request();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 4371308..8155b85 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1647,6 +1647,108 @@ test_expect_success PIPE 'R: fast-import --report-fd' '
 	test_cmp real received
 '
 
+test_expect_success PIPE 'R: report-fd: can feed back printed tree' '
+	cat >frontend <<-\FRONTEND_END &&
+	#!/bin/sh
+	cat <<EOF &&
+	commit refs/heads/printed
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	to be printed
+	COMMIT
+
+	from refs/heads/master
+	D file3
+
+	EOF
+
+	read commit_id <&3 &&
+	echo "$commit_id" >printed &&
+	echo "$commit_id commit" >expect.response &&
+	echo "cat $commit_id" &&
+	read cid2 type size <&3 &&
+	echo "$cid2 $type" >response &&
+	dd if=/dev/stdin of=commit bs=1 count=$size <&3 &&
+	read newline <&3 &&
+	read tree tree_id <commit &&
+
+	cat <<EOF &&
+	commit refs/heads/printed
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	to be printed
+	COMMIT
+
+	from refs/heads/printed^0
+	M 040000 $tree_id old
+
+	EOF
+	read cid <&3
+	FRONTEND_END
+
+	mkfifo commits &&
+	test_when_finished "rm -f commits" &&
+	sh frontend 3<commits |
+	git fast-import --report-fd=3 3>commits &&
+	git rev-parse printed^ >expect.printed &&
+	git cat-file commit printed^ >expect.commit &&
+
+	test_cmp expect.printed printed &&
+	test_cmp expect.response response &&
+	test_cmp expect.commit commit
+'
+
+test_expect_success PIPE 'R: report-fd: can feed back printed blob' '
+	file6_id=$(echo "$file6_data" | git hash-object --stdin) &&
+	cat >expect <<-EOF &&
+	:100755 100644 $file6_id $file6_id C100	newdir/exec.sh	file6
+	EOF
+
+	cat >frontend <<-\FRONTEND_END &&
+	#!/bin/sh
+
+	branch=$(git rev-parse --verify refs/heads/branch) &&
+	cat <<EOF &&
+	feature report-fd=3
+	cat $branch
+	EOF
+
+	read commit_id type size <&3 &&
+	dd if=/dev/stdin of=commit bs=1 count=$size <&3 &&
+	read newline <&3 &&
+	read tree tree_id <commit &&
+
+	echo "cat $tree_id \"newdir/exec.sh\"" &&
+	read blob_id type size <&3 &&
+	dd if=/dev/stdin of=blob bs=1 count=$size <&3 &&
+	read newline <&3 &&
+
+	cat <<EOF &&
+	commit refs/heads/copyblob
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	copy file6 to top level
+	COMMIT
+
+	from refs/heads/branch^0
+	M 644 inline "file6"
+	data $size
+	EOF
+	cat blob &&
+	echo &&
+	echo &&
+
+	read cid <&3
+	FRONTEND_END
+
+	mkfifo commits &&
+	test_when_finished "rm -f commits" &&
+	sh frontend 3<commits |
+	git fast-import 3>commits &&
+	git diff-tree -C --find-copies-harder -r copyblob^ copyblob >actual &&
+	compare_diff_raw expect actual
+'
+
 cat >input << EOF
 option git quiet
 blob
-- 
1.7.3.1
