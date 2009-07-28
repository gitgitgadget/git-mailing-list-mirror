From: Johan Herland <johan@herland.net>
Subject: [RFC 06/11 v2] fast-import: Add support for importing commit notes
Date: Tue, 28 Jul 2009 03:43:56 +0200
Message-ID: <200907280343.56586.johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
 <200907272026.46150.johan@herland.net> <20090727183517.GN11191@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, barkalow@iabervon.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 03:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVbjn-0003fp-UM
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 03:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbZG1BoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 21:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbZG1BoD
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 21:44:03 -0400
Received: from mx.getmail.no ([84.208.15.66]:62535 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752143AbZG1BoB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2009 21:44:01 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNG00IAZY5BJH70@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 28 Jul 2009 03:43:59 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNG00LKTY58L050@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 28 Jul 2009 03:43:59 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.28.13035
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <20090727183517.GN11191@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124204>

Introduce a 'notemodify' subcommand of the 'commit' command. This subcommand
is similar to 'filemodify', except that no mode is supplied (all notes have
mode 0644), and the path is set to the hex SHA1 of the given "comittish".

This enables fast import of note objects along with their associated commits,
since the notes can now be named using the mark references of their
corresponding commits.

The patch also includes a test case of the added functionality.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Monday 27 July 2009, Shawn O. Pearce wrote:
> Though you might want the "note" command to be a subcommand of
> commit, like M/D/R/C are, because notes are wrapped up inside of
> a commit and you can modify multiple notes in a single commit.

Thanks for the suggestion. Here's a replacement patch introducing a new
'notemodify' ("N") command.

Note that this patch also makes the preceding patch superfluous:

  [RFC 05/11] Refactor path name parsing into new function: get_path_str()

If you think that patch is useful in its own right, I can keep it in the
series, although it has no connection to the rest of the series at this
point.

Finally, this patch should probably migrate into the jh/notes topic...


Have fun! :)

...Johan


 Documentation/git-fast-import.txt |   45 +++++++++--
 fast-import.c                     |   88 +++++++++++++++++++-
 t/t9300-fast-import.sh            |  166 +++++++++++++++++++++++++++++++++++++
 3 files changed, 289 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c2f483a..288032c 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -316,7 +316,7 @@ change to the project.
 	data
 	('from' SP <committish> LF)?
 	('merge' SP <committish> LF)?
-	(filemodify | filedelete | filecopy | filerename | filedeleteall)*
+	(filemodify | filedelete | filecopy | filerename | filedeleteall | notemodify)*
 	LF?
 ....
 
@@ -339,14 +339,13 @@ commit message use a 0 length data.  Commit messages are free-form
 and are not interpreted by Git.  Currently they must be encoded in
 UTF-8, as fast-import does not permit other encodings to be specified.
 
-Zero or more `filemodify`, `filedelete`, `filecopy`, `filerename`
-and `filedeleteall` commands
+Zero or more `filemodify`, `filedelete`, `filecopy`, `filerename`,
+`filedeleteall` and `notemodify` commands
 may be included to update the contents of the branch prior to
 creating the commit.  These commands may be supplied in any order.
 However it is recommended that a `filedeleteall` command precede
-all `filemodify`, `filecopy` and `filerename` commands in the same
-commit, as `filedeleteall`
-wipes the branch clean (see below).
+all `filemodify`, `filecopy`, `filerename` and `notemodify` commands in
+the same commit, as `filedeleteall` wipes the branch clean (see below).
 
 The `LF` after the command is optional (it used to be required).
 
@@ -595,6 +594,40 @@ more memory per active branch (less than 1 MiB for even most large
 projects); so frontends that can easily obtain only the affected
 paths for a commit are encouraged to do so.
 
+`notemodify`
+^^^^^^^^^^^^
+Included in a `commit` command to add a new note (annotating a given
+commit) or change the content of an existing note.  This command has
+two different means of specifying the content of the note.
+
+External data format::
+	The data content for the note was already supplied by a prior
+	`blob` command.  The frontend just needs to connect it to the
+	commit that is to be annotated.
++
+....
+	'N' SP <dataref> SP <committish> LF
+....
++
+Here `<dataref>` can be either a mark reference (`:<idnum>`)
+set by a prior `blob` command, or a full 40-byte SHA-1 of an
+existing Git blob object.
+
+Inline data format::
+	The data content for the note has not been supplied yet.
+	The frontend wants to supply it as part of this modify
+	command.
++
+....
+	'N' SP 'inline' SP <committish> LF
+	data
+....
++
+See below for a detailed description of the `data` command.
+
+In both formats `<committish>` is any of the commit specification
+expressions also accepted by `from` (see above).
+
 `mark`
 ~~~~~~
 Arranges for fast-import to save a reference to the current object, allowing
diff --git a/fast-import.c b/fast-import.c
index 8a7cdc1..a366c61 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -22,8 +22,8 @@ Format of STDIN stream:
     ('author' sp name sp '<' email '>' sp when lf)?
     'committer' sp name sp '<' email '>' sp when lf
     commit_msg
-    ('from' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf)?
-    ('merge' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf)*
+    ('from' sp committish lf)?
+    ('merge' sp committish lf)*
     file_change*
     lf?;
   commit_msg ::= data;
@@ -41,15 +41,18 @@ Format of STDIN stream:
   file_obm ::= 'M' sp mode sp (hexsha1 | idnum) sp path_str lf;
   file_inm ::= 'M' sp mode sp 'inline' sp path_str lf
     data;
+  note_obm ::= 'N' sp (hexsha1 | idnum) sp committish lf;
+  note_inm ::= 'N' sp 'inline' sp committish lf
+    data;
 
   new_tag ::= 'tag' sp tag_str lf
-    'from' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf
+    'from' sp committish lf
     ('tagger' sp name sp '<' email '>' sp when lf)?
     tag_msg;
   tag_msg ::= data;
 
   reset_branch ::= 'reset' sp ref_str lf
-    ('from' sp (ref_str | hexsha1 | sha1exp_str | idnum) lf)?
+    ('from' sp committish lf)?
     lf?;
 
   checkpoint ::= 'checkpoint' lf
@@ -88,6 +91,7 @@ Format of STDIN stream:
      # stream formatting is: \, " and LF.  Otherwise these values
      # are UTF8.
      #
+  committish  ::= (ref_str | hexsha1 | sha1exp_str | idnum);
   ref_str     ::= ref;
   sha1exp_str ::= sha1exp;
   tag_str     ::= tag;
@@ -2007,6 +2011,80 @@ static void file_change_cr(struct branch *b, int rename)
 		leaf.tree);
 }
 
+static void note_change_n(struct branch *b)
+{
+	const char *p = command_buf.buf + 2;
+	static struct strbuf uq = STRBUF_INIT;
+	struct object_entry *oe = oe;
+	struct branch *s;
+	unsigned char sha1[20], commit_sha1[20];
+	uint16_t inline_data = 0;
+
+	/* <dataref> or 'inline' */
+	if (*p == ':') {
+		char *x;
+		oe = find_mark(strtoumax(p + 1, &x, 10));
+		hashcpy(sha1, oe->sha1);
+		p = x;
+	} else if (!prefixcmp(p, "inline")) {
+		inline_data = 1;
+		p += 6;
+	} else {
+		if (get_sha1_hex(p, sha1))
+			die("Invalid SHA1: %s", command_buf.buf);
+		oe = find_object(sha1);
+		p += 40;
+	}
+	if (*p++ != ' ')
+		die("Missing space after SHA1: %s", command_buf.buf);
+
+	/* <committish> */
+	s = lookup_branch(p);
+	if (s) {
+		hashcpy(commit_sha1, s->sha1);
+	} else if (*p == ':') {
+		uintmax_t commit_mark = strtoumax(p + 1, NULL, 10);
+		struct object_entry *commit_oe = find_mark(commit_mark);
+		if (commit_oe->type != OBJ_COMMIT)
+			die("Mark :%" PRIuMAX " not a commit", commit_mark);
+		hashcpy(commit_sha1, commit_oe->sha1);
+	} else if (!get_sha1(p, commit_sha1)) {
+		unsigned long size;
+		char *buf = read_object_with_reference(commit_sha1,
+			commit_type, &size, commit_sha1);
+		if (!buf || size < 46)
+			die("Not a valid commit: %s", p);
+		free(buf);
+	} else
+		die("Invalid ref name or SHA1 expression: %s", p);
+
+	if (inline_data) {
+		static struct strbuf buf = STRBUF_INIT;
+
+		if (p != uq.buf) {
+			strbuf_addstr(&uq, p);
+			p = uq.buf;
+		}
+		read_next_command();
+		parse_data(&buf);
+		store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0);
+	} else if (oe) {
+		if (oe->type != OBJ_BLOB)
+			die("Not a blob (actually a %s): %s",
+				typename(oe->type), command_buf.buf);
+	} else {
+		enum object_type type = sha1_object_info(sha1, NULL);
+		if (type < 0)
+			die("Blob not found: %s", command_buf.buf);
+		if (type != OBJ_BLOB)
+			die("Not a blob (actually a %s): %s",
+			    typename(type), command_buf.buf);
+	}
+
+	tree_content_set(&b->branch_tree, sha1_to_hex(commit_sha1), sha1,
+		S_IFREG | 0644, NULL);
+}
+
 static void file_change_deleteall(struct branch *b)
 {
 	release_tree_content_recursive(b->branch_tree.tree);
@@ -2176,6 +2254,8 @@ static void parse_new_commit(void)
 			file_change_cr(b, 1);
 		else if (!prefixcmp(command_buf.buf, "C "))
 			file_change_cr(b, 0);
+		else if (!prefixcmp(command_buf.buf, "N "))
+			note_change_n(b);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
 		else {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 821be7c..b49815d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1088,4 +1088,170 @@ INPUT_END
 test_expect_success 'P: fail on blob mark in gitlink' '
     test_must_fail git fast-import <input'
 
+###
+### series Q (notes)
+###
+
+note1_data="Note for the first commit"
+note2_data="Note for the second commit"
+note3_data="Note for the third commit"
+
+test_tick
+cat >input <<INPUT_END
+blob
+mark :2
+data <<EOF
+$file2_data
+EOF
+
+commit refs/heads/notes-test
+mark :3
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+first (:3)
+COMMIT
+
+M 644 :2 file2
+
+blob
+mark :4
+data $file4_len
+$file4_data
+commit refs/heads/notes-test
+mark :5
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+second (:5)
+COMMIT
+
+M 644 :4 file4
+
+commit refs/heads/notes-test
+mark :6
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+third (:6)
+COMMIT
+
+M 644 inline file5
+data <<EOF
+$file5_data
+EOF
+
+M 755 inline file6
+data <<EOF
+$file6_data
+EOF
+
+blob
+mark :7
+data <<EOF
+$note1_data
+EOF
+
+blob
+mark :8
+data <<EOF
+$note2_data
+EOF
+
+commit refs/notes/foobar
+mark :9
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+notes (:9)
+COMMIT
+
+N :7 :3
+N :8 :5
+N inline :6
+data <<EOF
+$note3_data
+EOF
+
+INPUT_END
+test_expect_success \
+	'Q: commit notes' \
+	'git fast-import <input &&
+	 git whatchanged notes-test'
+test_expect_success \
+	'Q: verify pack' \
+	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
+
+commit1=$(git rev-parse notes-test~2)
+commit2=$(git rev-parse notes-test^)
+commit3=$(git rev-parse notes-test)
+
+cat >expect <<EOF
+author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+first (:3)
+EOF
+test_expect_success \
+	'Q: verify first commit' \
+	'git cat-file commit notes-test~2 | sed 1d >actual &&
+	test_cmp expect actual'
+
+cat >expect <<EOF
+parent $commit1
+author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+second (:5)
+EOF
+test_expect_success \
+	'Q: verify second commit' \
+	'git cat-file commit notes-test^ | sed 1d >actual &&
+	test_cmp expect actual'
+
+cat >expect <<EOF
+parent $commit2
+author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+third (:6)
+EOF
+test_expect_success \
+	'Q: verify third commit' \
+	'git cat-file commit notes-test | sed 1d >actual &&
+	test_cmp expect actual'
+
+cat >expect <<EOF
+author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+notes (:9)
+EOF
+test_expect_success \
+	'Q: verify notes commit' \
+	'git cat-file commit refs/notes/foobar | sed 1d >actual &&
+	test_cmp expect actual'
+
+cat >expect.unsorted <<EOF
+100644 blob $commit1
+100644 blob $commit2
+100644 blob $commit3
+EOF
+cat expect.unsorted | sort >expect
+test_expect_success \
+	'Q: verify notes tree' \
+	'git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+	 test_cmp expect actual'
+
+echo "$note1_data" >expect
+test_expect_success \
+	'Q: verify note for first commit' \
+	'git cat-file blob refs/notes/foobar:$commit1 >actual && test_cmp expect actual'
+
+echo "$note2_data" >expect
+test_expect_success \
+	'Q: verify note for second commit' \
+	'git cat-file blob refs/notes/foobar:$commit2 >actual && test_cmp expect actual'
+
+echo "$note3_data" >expect
+test_expect_success \
+	'Q: verify note for third commit' \
+	'git cat-file blob refs/notes/foobar:$commit3 >actual && test_cmp expect actual'
+
 test_done
-- 
1.6.4.rc3.138.ga6b98.dirty
