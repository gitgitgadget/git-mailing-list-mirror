From: Adam Butcher <dev.lists@jessamine.co.uk>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Sat, 4 Aug 2012 21:07:35 +0000 (UTC)
Message-ID: <loom.20120804T230218-811@post.gmane.org>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net> <7vehnpc5ti.fsf@alter.siamese.dyndns.org> <551f7f77570c84017ae93988f9202854@imap.force9.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 23:15:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxlhU-0002m6-EA
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 23:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab2HDVPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 17:15:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:58865 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390Ab2HDVPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 17:15:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Sxlgg-0002H3-DG
	for git@vger.kernel.org; Sat, 04 Aug 2012 23:15:06 +0200
Received: from munkyhouse.force9.co.uk ([84.92.244.81])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Aug 2012 23:15:06 +0200
Received: from dev.lists by munkyhouse.force9.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Aug 2012 23:15:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.92.244.81 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202891>

When operating in --break-rewrites (-B) mode on a file with no newline
terminator (and assuming --break-rewrites determines that the diff
_is_ a rewrite), git diff previously concatenated the indicator comment
'\ No newline at end of file' directly to the terminating line rather
than on a line of its own.  The resulting diff is broken; claiming
that the last line actually contains the indicator text.  Without -B
there is no problem with the same files.

This patch fixes the former case by inserting a newline into the
output prior to emitting the indicator comment.

A couple of tests have been added to the rewrite suite to confirm that
the indicator comment is generated on its own line in both plain diff
and rewrite mode.  The latter test fails if the functional part of
this patch (i.e. diff.c) is reverted.
---

Updates: Test only:

  - removed redundant para from commit msg
  - use test_seq shell function instead of seq
  - pull prep statements into individual tests
  - test expected success of git commands in prep
  - confirm that rewrite is considered a rewrite by diff -B
  - remove superfluous comments in favor of test descriptions
  - use variable to spell 'no newline' annotation to support simpler
    maintenance whilst still allowing to check for unexpected leading
    or trailing characters.

 diff.c                  |  1 +
 t/t4022-diff-rewrite.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/diff.c b/diff.c
index 1a594df..f333de8 100644
--- a/diff.c
+++ b/diff.c
@@ -574,6 +574,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 	if (!endp) {
 		const char *plain = diff_get_color(ecb->color_diff,
 						   DIFF_PLAIN);
+		putc('\n', ecb->opt->file);
 		emit_line_0(ecb->opt, plain, reset, '\\',
 			    nneof, strlen(nneof));
 	}
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index c00a94b..1b7ae9f 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -66,5 +66,47 @@ test_expect_success 'suppress deletion diff with -B -D' '
 	grep -v "Linus Torvalds" actual
 '
 
+test_expect_success 'generate initial "no newline at eof" sequence file and 
commit' '
+
+   test_seq 1 99 >seq &&
+   printf 100 >>seq &&
+   git add seq &&
+   git commit seq -m seq
+'
+
+test_expect_success 'rewrite the middle 90% of sequence file and terminate with 
newline' '
+
+   test_seq 1 5 >seq &&
+   test_seq 9331 9420 >>seq &&
+   test_seq 96 100 >>seq
+'
+
+test_expect_success 'confirm that sequence file is considered a rewrite' '
+
+   git diff -B seq >res &&
+   grep "dissimilarity index" res
+'
+
+# Full annotation string used to check for erroneous leading or
+# trailing characters.  Backslash is double escaped due to usage
+# within dq argument to grep expansion below.  
+no_newline_anno='\\\\ No newline at end of file'
+
+test_expect_success 'no newline at eof is on its own line without -B' '
+
+	git diff seq >res &&
+	grep "^'"$no_newline_anno"'$" res &&
+	grep -v "^.\\+'"$no_newline_anno"'" res &&
+	grep -v "'"$no_newline_anno"'.\\+$" res
+'
+
+test_expect_success 'no newline at eof is on its own line with -B' '
+
+	git diff -B seq >res &&
+	grep "^'"$no_newline_anno"'$" res &&
+	grep -v "^.\\+'"$no_newline_anno"'" res &&
+	grep -v "'"$no_newline_anno"'.\\+$" res
+'
+
 test_done
 
-- 
1.7.11.msysgit.1.1.gf0affa1
