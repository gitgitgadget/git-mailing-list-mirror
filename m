From: Adam Butcher <dev.lists@jessamine.co.uk>
Subject: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Thu, 02 Aug 2012 22:11:02 +0100
Message-ID: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
Reply-To: <dev.lists@jessamine.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:17:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx2lh-0003zp-Cq
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 23:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab2HBVRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 17:17:12 -0400
Received: from avasout02.plus.net ([212.159.14.17]:56355 "EHLO
	avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab2HBVRK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 17:17:10 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Aug 2012 17:17:10 EDT
Received: from webmail.plus.net ([212.159.8.87])
	by avasout02 with smtp
	id hxB21j0051sg6PG01xB3q7; Thu, 02 Aug 2012 22:11:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.0 cv=GvbACzJC c=1 sm=1 a=w/v6d3Yw9YqO0eqsxHCYQw==:17
 a=EDeDkkTReK4A:10 a=fIUNk3G47tUA:10 a=SxdvwhXVL_AA:10 a=5LfTt-Tm1vgA:10
 a=JRq8KZZ3GZoA:10 a=IkcTkHD0fZMA:10 a=ZBkl__CYAAAA:8 a=mrHjP8x4AAAA:8
 a=yBF27LH5QYv2fMUEYwMA:9 a=QEXdDO2ut3YA:10 a=aVC6qsWM_lQA:10
 a=w/v6d3Yw9YqO0eqsxHCYQw==:117
X-AUTH: jessaminenet+dev.lists:2501
Received: from munkyhouse.force9.co.uk ([84.92.244.81])
 by webmail.plus.net
 with HTTP (HTTP/1.1 POST); Thu, 02 Aug 2012 22:11:02 +0100
Mail-Reply-To: <dev.lists@jessamine.co.uk>
X-Sender: dev.lists@jessamine.co.uk
User-Agent: Roundcube Webmail/0.7.2
X-Originating-IP: [84.92.244.81]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202793>

 From 01730a741cc5fd7d0a5d8bd0d3df80d12c81fe48 Mon Sep 17 00:00:00 2001
 From: Adam Butcher <dev.lists@jessamine.co.uk>
Date: Wed, 1 Aug 2012 22:25:09 +0100
Subject: [PATCH] Fix 'No newline...' annotation in rewrite diffs.

When operating in --break-rewrites (-B) mode on a file with no newline
terminator (and assuming --break-rewrites determines that the diff
_is_ a rewrite), git diff previously concatenated the indicator comment
'\ No newline at end of file' directly to the terminating line rather
than on a line of its own.  The resulting diff is broken; claiming
that the last line actually contains the indicator text.  Without -B
there is no problem with the same files.

This patch fixes the former case by inserting a newline into the
output prior to emitting the indicator comment.

Potential issue: Currently this emits an ASCII 10 newline character
only.  I'm not sure whether this will be okay on all platforms; it
seems to work fine on Windows and GNU at least.

A couple of tests have been added to the rewrite suite to confirm that
the indicator comment is generated on its own line in both plain diff
and rewrite mode.  The latter test fails if the functional part of
this patch (i.e. diff.c) is reverted.
---
  diff.c                  |  1 +
  t/t4022-diff-rewrite.sh | 27 +++++++++++++++++++++++++++
  2 files changed, 28 insertions(+)

diff --git a/diff.c b/diff.c
index 95706a5..77d4e84 100644
--- a/diff.c
+++ b/diff.c
@@ -574,6 +574,7 @@ static void emit_rewrite_lines(struct emit_callback 
*ecb,
  	if (!endp) {
  		const char *plain = diff_get_color(ecb->color_diff,
  						   DIFF_PLAIN);
+		putc('\n', ecb->opt->file);
  		emit_line_0(ecb->opt, plain, reset, '\\',
  			    nneof, strlen(nneof));
  	}
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index c00a94b..c85154d 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -66,5 +66,32 @@ test_expect_success 'suppress deletion diff with -B 
-D' '
  	grep -v "Linus Torvalds" actual
  '

+# create a file containing numbers with no newline at
+# the end and modify it such that the starting 10 lines
+# are unchanged, the next 101 are rewritten and the last
+# line differs only in that in is terminated by a newline.
+seq 1 10 > seq
+seq 100 +1 200 >> seq
+printf 201 >> seq
+(git add seq; git commit seq -m seq) >/dev/null
+seq 1 10 > seq
+seq 300 -1 200 >> seq
+
+test_expect_success 'no newline at eof is on its own line without -B' 
'
+
+	(git diff seq; true) > res &&
+	grep "^\\\\ No newline at end of file$" res &&
+	grep -v "^.\\+\\\\ No newline at end of file" res &&
+	grep -v "\\\\ No newline at end of file.\\+$" res
+'
+
+test_expect_success 'no newline at eof is on its own line with -B' '
+
+	(git diff -B seq; true) > res &&
+	grep "^\\\\ No newline at end of file$" res &&
+	grep -v "^.\\+\\\\ No newline at end of file" res &&
+	grep -v "\\\\ No newline at end of file.\\+$" res
+'
+
  test_done

-- 
1.7.11.msysgit.0
