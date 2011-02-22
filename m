From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v4] fast-import: add 'ls' command
Date: Tue, 22 Feb 2011 03:04:31 -0600
Message-ID: <20110222090431.GA24337@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 10:04:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ProAt-0002HM-Pd
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 10:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab1BVJEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 04:04:45 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48950 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab1BVJEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 04:04:42 -0500
Received: by qyk7 with SMTP id 7so2683955qyk.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 01:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=6C5sh1u6W3uNZepSUkjxpb3wtIqsWsBEfAd1TlBmGPg=;
        b=xyFySq+NGeys71Gpb/9MzYHwpi5+z16BX9YBnKxPRXY/9sKWJuwDBV55VELXElhpxb
         NqZhR/Ls+fvV9D23AzRvcaBJb8XdyPtqFS0AqABlQ///UcgqUQoY9aCx1F5Ag9K4xwfz
         kwOd1C7nkDQ49l3sGdm7bFkq3IjjBFFqNyZAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=fnWTigPhJnUccrZfGB0r8EXbb4yuw/zBxSgUvf/VVuMag2MVIswfNcD2r9s2xBBQpe
         IiDFfXZpeE5+2meV3FKXz3Jch4P1/GZE36VLq7RTUkxFf8gQOkKOtNwA1eTTLeV/PpNc
         RmuZ23xhoao9FObDByCsT+ZzR6bJdwEe/zvj4=
Received: by 10.224.54.68 with SMTP id p4mr1927976qag.365.1298365480881;
        Tue, 22 Feb 2011 01:04:40 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id t7sm4475566qcs.16.2011.02.22.01.04.37
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 01:04:39 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167536>

From: David Barr <david.barr@cordelta.com>
Date: Thu, 2 Dec 2010 21:40:20 +1100

Lazy fast-import frontend authors that want to rely on the backend to
keep track of the content of the imported trees _almost_ have what
they need in the 'cat-blob' command (v1.7.4-rc0~30^2~3, 2010-11-28).
But it is not quite enough, since

 (1) cat-blob can be used to retrieve the content of files, but
     not their mode, and

 (2) using cat-blob requires the frontend to keep track of a name
     (mark number or object id) for each blob to be retrieved

Introduce an 'ls' command to complement cat-blob and take care of the
remaining needs.  The 'ls' command finds what is at a given path
within a given tree-ish (tag, commit, or tree):

	'ls' SP <dataref> SP <path> LF

or in fast-import's active commit:

	'ls' SP <path> LF

The response is a single line sent through the cat-blob channel,
imitating ls-tree output.  So for example:

	FE> ls :1 Documentation
	gfi> 040000 tree 9e6c2b599341d28a2a375f8207507e0a2a627fe9	Documentation
	FE> ls 9e6c2b599341d28a2a375f8207507e0a2a627fe9 git-fast-import.txt
	gfi> 100644 blob 4f92954396e3f0f97e75b6838a5635b583708870	git-fast-import.txt
	FE> ls :1 RelNotes
	gfi> 120000 blob b942e499449d97aeb50c73ca2bdc1c6e6d528743	RelNotes
	FE> cat-blob b942e499449d97aeb50c73ca2bdc1c6e6d528743
	gfi> b942e499449d97aeb50c73ca2bdc1c6e6d528743 blob 32
	gfi> Documentation/RelNotes/1.7.4.txt

The most interesting parts of the reply are the first word, which is
a 6-digit octal mode (regular file, executable, symlink, directory,
or submodule), and the part from the second space to the tab, which is
a <dataref> that can be used in later cat-blob, ls, and filemodify (M)
commands to refer to the content (blob, tree, or commit) at that path.

If there is nothing there, the response is "missing some/path".

The intent is for this command to be used to read files from the
active commit, so a frontend can apply patches to them, and to copy
files and directories from previous revisions.

For example, proposed updates to svn-fe use this command in place of
its internal representation of the repository directory structure.
This simplifies the frontend a great deal and means support for
resuming an import in a separate fast-import run (i.e., incremental
import) is basically free.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Improved-by: Sverre Rabbelier <srabbelier@gmail.com>
---
Han-Wen Nienhuys wrote[1], on 2007-02-18:

> BTW, I just had a brainwave
>
> Wouldn't it make sense to build a git-fast-export, which
> can be used to interrogate a git-repository: a GIT tool
> could run a single git command,
>
>   git-fast-export
>
> and communicate with that process in a similar fashion, eg.

I wrote[2], on 2010-06-30:

> if we have the assumption that copies from old revs are not that common
> then we can modify the tree that used to represent rN in place;
> when there is a copy from an old rev, fetch from the git object db (or
> wherever the objects are destined to go)

It's time.

Thanks for all your help.  Thoughts, improvements welcome as always.

[1] http://thread.gmane.org/gmane.comp.version-control.git/39339/focus=40075
[2] http://colabti.org/irclogger/irclogger_log/git-devel?date=2010-06-30#l972

 Documentation/git-fast-import.txt |   63 ++++++++++++++-
 fast-import.c                     |  162 ++++++++++++++++++++++++++++++++++++-
 t/t9300-fast-import.sh            |   92 +++++++++++++++++++--
 3 files changed, 303 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c3a2766..e1b7a0f 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -196,7 +196,8 @@ especially when a higher level language such as Perl, Python or
 Ruby is being used.
 
 fast-import is very strict about its input.  Where we say SP below we mean
-*exactly* one space.  Likewise LF means one (and only one) linefeed.
+*exactly* one space.  Likewise LF means one (and only one) linefeed
+and HT one (and only one) horizontal tab.
 Supplying additional whitespace characters will cause unexpected
 results, such as branch names or file names with leading or trailing
 spaces in their name, or early termination of fast-import when it encounters
@@ -334,6 +335,11 @@ and control the current import process.  More detailed discussion
 	format to the file descriptor set with `--cat-blob-fd` or
 	`stdout` if unspecified.
 
+`ls`::
+	Causes fast-import to print a line describing a directory
+	entry in 'ls-tree' format to the file descriptor set with
+	`--cat-blob-fd` or `stdout` if unspecified.
+
 `feature`::
 	Require that fast-import supports the specified feature, or
 	abort if it does not.
@@ -919,6 +925,55 @@ This command can be used anywhere in the stream that comments are
 accepted.  In particular, the `cat-blob` command can be used in the
 middle of a commit but not in the middle of a `data` command.
 
+`ls`
+~~~~
+Prints information about the object at a path to a file descriptor
+previously arranged with the `--cat-blob-fd` argument.  This allows
+printing a blob from the active commit (with `cat-blob`) or copying a
+blob or tree from a previous commit for use in the current one (with
+`filemodify`).
+
+The `ls` command can be used anywhere in the stream that comments are
+accepted, including the middle of a commit.
+
+Reading from the active commit::
+	This form can only be used in the middle of a `commit`.
+	The path names a directory entry within fast-import's
+	active commit.  The path must be quoted in this case.
++
+....
+	'ls' SP <path> LF
+....
+
+Reading from a named tree::
+	The `<dataref>` can be a mark reference (`:<idnum>`) or the
+	full 40-byte SHA-1 of a Git tag, commit, or tree object,
+	preexisting or waiting to be written.
+	The path is relative to the top level of the tree
+	named by `<dataref>`.
++
+....
+	'ls' SP <dataref> SP <path> LF
+....
+
+See `filemodify` above for a detailed description of `<path>`.
+
+Output uses the same format as `git ls-tree <tree> {litdd} <path>`:
+
+====
+	<mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT <path> LF
+====
+
+The <dataref> represents the blob, tree, or commit object at <path>
+and can be used in later 'cat-blob', 'filemodify', or 'ls' commands.
+
+If there is no file or subtree at that path, 'git fast-import' will
+instead report
+
+====
+	missing SP <path> LF
+====
+
 `feature`
 ~~~~~~~~~
 Require that fast-import supports the specified feature, or abort if
@@ -946,8 +1001,10 @@ import-marks::
 	any "feature import-marks" command in the stream.
 
 cat-blob::
-	Ignored.  Versions of fast-import not supporting the
-	"cat-blob" command will exit with a message indicating so.
+ls::
+	Require that the backend support the 'cat-blob' or 'ls' command.
+	Versions of fast-import not supporting the specified command
+	will exit with a message indicating so.
 	This lets the import error out early with a clear message,
 	rather than wasting time on the early part of an import
 	before the unsupported command is detected.
diff --git a/fast-import.c b/fast-import.c
index 3886a1b..6c37b84 100644
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
@@ -374,6 +378,7 @@ static int cat_blob_fd = STDOUT_FILENO;
 
 static void parse_argv(void);
 static void parse_cat_blob(void);
+static void parse_ls(struct branch *b);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -2614,6 +2619,8 @@ static void parse_new_commit(void)
 			note_change_n(b, prev_fanout);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
+		else if (!prefixcmp(command_buf.buf, "ls "))
+			parse_ls(b);
 		else {
 			unread_command_buf = 1;
 			break;
@@ -2837,6 +2844,153 @@ static void parse_cat_blob(void)
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
+	if (!mode) {
+		/* missing SP path LF */
+		strbuf_reset(&line);
+		strbuf_addstr(&line, "missing ");
+		quote_c_style(path, &line, NULL, 0);
+		strbuf_addch(&line, '\n');
+	} else {
+		/* mode SP type SP object_name TAB path LF */
+		strbuf_reset(&line);
+		strbuf_addf(&line, "%06o %s %s\t",
+				mode, type, sha1_to_hex(sha1));
+		quote_c_style(path, &line, NULL, 0);
+		strbuf_addch(&line, '\n');
+	}
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
+	/*
+	 * A directory in preparation would have a sha1 of zero
+	 * until it is saved.  Save, for simplicity.
+	 */
+	if (S_ISDIR(leaf.versions[1].mode))
+		store_tree(&leaf);
+
+	print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, p);
+	if (!b || root != &b->branch_tree)
+		release_tree_entry(root);
+}
+
 static void checkpoint(void)
 {
 	checkpoint_requested = 0;
@@ -3001,7 +3155,7 @@ static int parse_one_feature(const char *feature, int from_stream)
 		relative_marks_paths = 0;
 	} else if (!prefixcmp(feature, "force")) {
 		force_update = 1;
-	} else if (!strcmp(feature, "notes")) {
+	} else if (!strcmp(feature, "notes") || !strcmp(feature, "ls")) {
 		; /* do nothing; we have the feature */
 	} else {
 		return 0;
@@ -3142,6 +3296,8 @@ int main(int argc, const char **argv)
 	while (read_next_command() != EOF) {
 		if (!strcmp("blob", command_buf.buf))
 			parse_new_blob();
+		else if (!prefixcmp(command_buf.buf, "ls "))
+			parse_ls(NULL);
 		else if (!prefixcmp(command_buf.buf, "commit "))
 			parse_new_commit();
 		else if (!prefixcmp(command_buf.buf, "tag "))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 52ac0e5..6b1ba6c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -42,6 +42,14 @@ echo "$@"'
 
 >empty
 
+test_expect_success 'setup: have pipes?' '
+	rm -f frob &&
+	if mkfifo frob
+	then
+		test_set_prereq PIPE
+	fi
+'
+
 ###
 ### series A
 ###
@@ -898,6 +906,77 @@ test_expect_success \
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
+test_expect_success PIPE 'N: empty directory reads as missing' '
+	cat <<-\EOF >expect &&
+	OBJNAME
+	:000000 100644 OBJNAME OBJNAME A	unrelated
+	EOF
+	echo "missing src" >expect.response &&
+	git update-ref -d refs/heads/read-empty &&
+	rm -f backflow &&
+	mkfifo backflow &&
+	(
+		exec <backflow &&
+		cat <<-EOF &&
+		commit refs/heads/read-empty
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		read "empty" (missing) directory
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
+		read -r line &&
+		printf "%s\n" "$line" >response &&
+		cat <<-\EOF
+		D dst1
+		D dst2
+		EOF
+	) |
+	git fast-import --cat-blob-fd=3 3>backflow &&
+	test_cmp expect.response response &&
+	git rev-list read-empty |
+	git diff-tree -r --root --stdin |
+	sed "s/$_x40/OBJNAME/g" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success \
 	'N: copy root directory by tree hash' \
 	'cat >expect <<-\EOF &&
@@ -1861,6 +1940,11 @@ test_expect_success 'R: feature no-relative-marks should be honoured' '
     test_cmp marks.new non-relative.out
 '
 
+test_expect_success 'R: feature ls supported' '
+	echo "feature ls" |
+	git fast-import
+'
+
 test_expect_success 'R: feature cat-blob supported' '
 	echo "feature cat-blob" |
 	git fast-import
@@ -1986,14 +2070,6 @@ test_expect_success 'R: print two blobs to stdout' '
 	test_cmp expect actual
 '
 
-test_expect_success 'setup: have pipes?' '
-	rm -f frob &&
-	if mkfifo frob
-	then
-		test_set_prereq PIPE
-	fi
-'
-
 test_expect_success PIPE 'R: copy using cat-file' '
 	expect_id=$(git hash-object big) &&
 	expect_len=$(wc -c <big) &&
-- 
1.7.4.1
