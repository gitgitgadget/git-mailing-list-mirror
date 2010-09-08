From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/3] fast-import: Allow cat requests at arbitrary points in
	stream
Date: Tue, 7 Sep 2010 22:27:37 -0500
Message-ID: <20100908032736.GC23409@capella.cs.uchicago.edu>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino> <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 05:27:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtBK4-0005m8-0U
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 05:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675Ab0IHD1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 23:27:39 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:50404 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab0IHD1i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 23:27:38 -0400
Received: from capella.cs.uchicago.edu (capella.cs.uchicago.edu [128.135.24.228])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 802C8B944;
	Tue,  7 Sep 2010 22:27:37 -0500 (CDT)
Received: by capella.cs.uchicago.edu (Postfix, from userid 10442)
	id 3AD5F761AF; Tue,  7 Sep 2010 22:27:37 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20100905031528.GA2344@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155761>

Rather than planning in advance and saving up a bunch of objects
before a "commit" command, frontends might want to wait until the
middle of a commit and request objects then.

Allow them to.

The new rule: a "cat" request can be inserted wherever a comment
is allowed, which means at the start of any line except in the
middle of a "data" command.

Cc: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: David Barr <david.barr@cordelta.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's it for today.  I'll be on vacation for the next couple of weeks
so I can't promise to be responsive.  Comments are still welcome,
though (nothing is really different except that the latency may be
longer).

 Documentation/git-fast-import.txt |    4 ++
 fast-import.c                     |   27 ++++++++-----
 t/t9300-fast-import.sh            |   74 +++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 2cf48f5..b670c7d 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -920,6 +920,10 @@ a path within that tree to retrieve a subtree or blob.
 A `<path>` string should be surrounded with quotation marks and
 use C-style escaping.
 
+The `cat` command can be used anywhere that comments are
+acceptable.  In particular, the `cat` command can be used in the
+middle of a commit, but not in the middle of a `data` stream.
+
 `feature`
 ~~~~~~~~~
 Require that fast-import supports the specified feature, or abort if
diff --git a/fast-import.c b/fast-import.c
index f3c4123..87246d5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -55,9 +55,6 @@ Format of STDIN stream:
     ('from' sp committish lf)?
     lf?;
 
-  cat_request ::= 'cat' sp (hexsha1 | idnum) lf
-    | 'cat' sp hexsha1 sp path_str lf;
-
   checkpoint ::= 'checkpoint' lf
     lf?;
 
@@ -135,14 +132,18 @@ Format of STDIN stream:
   ts    ::= # time since the epoch in seconds, ascii base10 notation;
   tz    ::= # GIT style timezone;
 
-     # note: comments may appear anywhere in the input, except
-     # within a data command.  Any form of the data command
-     # always escapes the related input from comment processing.
+     # note: comments and cat requests may appear anywhere
+     # in the input, except within a data command.  Any form
+     # of the data command always escapes the related input
+     # from comment processing.
      #
      # In case it is not clear, the '#' that starts the comment
      # must be the first character on that line (an lf
      # preceded it).
      #
+  cat_request ::= 'cat' sp (hexsha1 | idnum) lf
+    | 'cat' sp hexsha1 sp path_str lf;
+
   comment ::= '#' not_lf* lf;
   not_lf  ::= # Any byte that is not ASCII newline (LF);
 */
@@ -368,6 +369,7 @@ static int seen_data_command;
 static int report_fd = -1;
 
 static void parse_argv(void);
+static void parse_cat_request(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1777,7 +1779,6 @@ static void read_marks(void)
 	fclose(f);
 }
 
-
 static int read_next_command(void)
 {
 	static int stdin_eof = 0;
@@ -1787,7 +1788,7 @@ static int read_next_command(void)
 		return EOF;
 	}
 
-	do {
+	for (;;) {
 		if (unread_command_buf) {
 			unread_command_buf = 0;
 		} else {
@@ -1820,7 +1821,13 @@ static int read_next_command(void)
 			rc->prev->next = rc;
 			cmd_tail = rc;
 		}
-	} while (command_buf.buf[0] == '#');
+		if (!prefixcmp(command_buf.buf, "cat ")) {
+			parse_cat_request();
+			continue;
+		}
+		if (command_buf.buf[0] != '#')
+			return 0;
+	}
 
 	return 0;
 }
@@ -3081,8 +3088,6 @@ int main(int argc, const char **argv)
 			parse_new_tag();
 		else if (!prefixcmp(command_buf.buf, "reset "))
 			parse_reset_branch();
-		else if (!prefixcmp(command_buf.buf, "cat "))
-			parse_cat_request();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 82e03e8..dcdfbd4 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1819,6 +1819,80 @@ test_expect_success PIPE 'R: report-fd: can feed back printed blob' '
 	compare_diff_raw expect actual
 '
 
+test_expect_success PIPE 'R: report-fd: cat commands mid-commit' '
+	cat >expect <<-EOF &&
+	:100755 100644 $file4_id $file4_id C100 file4	file4-copy
+	EOF
+	git cat-file commit refs/heads/branch >expect.commit &&
+	echo tree >expect.type &&
+	git cat-file tree refs/heads/branch >expect.tree &&
+
+	cat >frontend <<-\FRONTEND_END &&
+		#!/bin/sh
+
+		branch=$(git rev-parse --verify refs/heads/branch) &&
+		cat <<EOF &&
+		feature report-fd=3
+		commit refs/heads/catdemo
+		cat $branch
+		EOF
+
+		read commit_id type size <&3 &&
+		dd if=/dev/stdin of=commit bs=1 count=$size <&3 &&
+		read newline <&3 &&
+		read tree tree_id <commit &&
+
+		echo "cat $tree_id" &&
+
+		read tree_id2 type size <&3 &&
+		dd if=/dev/stdin of=tree bs=1 count=$size <&3 &&
+		read newline <&3 &&
+		echo $type >type &&
+
+		grep ^committer commit &&
+		cat <<EOF &&
+		data <<COMMIT
+		copy file4 as file4-copy
+		COMMIT
+
+		from refs/heads/branch^0
+		cat $tree_id "file4"
+		EOF
+
+		read blob_id type size <&3 &&
+		dd if=/dev/stdin of=/dev/null bs=1 count=$size <&3 &&
+		read newline <&3 &&
+
+		cat <<EOF &&
+		M 644 $blob_id "file4-copy"
+		cat $tree_id ""
+
+		EOF
+
+		read tree_id3 type size <&3 &&
+		dd if=/dev/stdin of=tree2 bs=1 count=$size <&3 &&
+		read newline <&3 &&
+		read cid <&3
+	FRONTEND_END
+	chmod +x frontend &&
+
+	mkfifo commits &&
+	test_when_finished "rm -f commits" &&
+	(
+		{
+			sh frontend 3<commits ||
+			exit
+		} |
+		git fast-import 3>commits
+	) &&
+	git diff-tree -C catdemo^ catdemo >actual &&
+	compare_diff_raw expect actual
+	test_cmp expect.commit commit &&
+	test_cmp expect.type type &&
+	test_cmp expect.tree tree &&
+	test_cmp expect.tree tree2
+'
+
 test_expect_success 'R: quiet option results in no stats being output' '
 	>empty &&
 	cat >input <<-\EOF &&
-- 
1.7.3.rc0.6.g7505a.dirty
