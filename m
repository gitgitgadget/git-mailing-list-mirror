From: Adam Butcher <dev.lists@jessamine.co.uk>
Subject: [PATCH] Fix '\ No newline...' annotation in rewrite diffs
Date: Sun,  5 Aug 2012 08:06:05 +0100
Message-ID: <1344150365-86764-1-git-send-email-dev.lists@jessamine.co.uk>
References: <7vobmq6sd9.fsf@alter.siamese.dyndns.org>
Cc: Adam Butcher <dev.lists@jessamine.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 09:07:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxuvb-0006N5-UM
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 09:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688Ab2HEHG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 03:06:57 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35374 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab2HEHG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 03:06:56 -0400
Received: by weyx8 with SMTP id x8so1264166wey.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=xEpEz3HcRzUV1ChzdqArTEaxzGtIU07NVXAkdlWanIE=;
        b=OnJIKGIXNyZh1kmsJAlu7jmYAhL80eTSpFCw+OjVuuGxrPHEugY00tP3fyG+Yvc7tM
         eUgpe88a+AJ7S6yASRe6apIPNW2oGZr7hTjK0n38kpsKsO8iDdDKLRh/5nsd9hCeMV43
         lXs9AAVimQH4z6bcO2Anwy7IciYb/NZm2OoWdTEqSqpBhFm1OgRhCFyIjzU6barDSwoe
         e65Kj2DfOHt+S6iDSjcKGqIIZ9P9YpP3CfytgPCl1XSAvSO0Eyx2rPnBqYu05ms0vkix
         T1ve/yQctUZQJYeLlbElea/hwGQACYxUQ4zcEePjw4OrQShIEuEjdumaNrdgYKwPLCLJ
         KQng==
Received: by 10.216.135.159 with SMTP id u31mr2024485wei.160.1344150415662;
        Sun, 05 Aug 2012 00:06:55 -0700 (PDT)
Received: from localhost (munkyhouse.force9.co.uk. [84.92.244.81])
        by mx.google.com with ESMTPS id ep14sm9592397wid.0.2012.08.05.00.06.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 00:06:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.msysgit.1.1.gf0affa1
In-Reply-To: <7vobmq6sd9.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vobmq6sd9.fsf@alter.siamese.dyndns.org>
References: <7vobmq6sd9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202903>

When a file that ends with an incomplete line is expressed as a
complete rewrite with the -B option, git diff incorrectly appends the
incomplete line indicator "\ No newline at end of file" after such a
line, rather than writing it on a line of its own (the output codepath
for normal output without -B does not have this problem).  Add a LF
after the incomplete line before writing the "\ No newline ..." out
to fix this.

Add a couple of tests to confirm that the indicator comment is
generated on its own line in both plain diff and rewrite mode.

Signed-off-by: Adam Butcher <dev.lists@jessamine.co.uk>
---

Updates:

  - replace commit msg with revised suggestion from Junio
  - remove hardcoded 'No newline...' in tests and simplify

 diff.c                  |  1 +
 t/t4022-diff-rewrite.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

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
index c00a94b..05ac3e9 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -66,5 +66,38 @@ test_expect_success 'suppress deletion diff with -B -D' '
 	grep -v "Linus Torvalds" actual
 '
 
+test_expect_success 'generate initial "no newline at eof" sequence file and commit' '
+
+	test_seq 1 99 >seq &&
+	printf 100 >>seq &&
+	git add seq &&
+	git commit seq -m seq
+'
+
+test_expect_success 'rewrite the middle 90% of sequence file and terminate with newline' '
+
+	test_seq 1 5 >seq &&
+	test_seq 9331 9420 >>seq &&
+	test_seq 96 100 >>seq
+'
+
+test_expect_success 'confirm that sequence file is considered a rewrite' '
+
+	git diff -B seq >res &&
+	grep "dissimilarity index" res
+'
+
+test_expect_success 'no newline at eof is on its own line without -B' '
+
+	git diff seq >res &&
+	grep "^\\\\ " res && ! grep "^..*\\\\ " res
+'
+
+test_expect_success 'no newline at eof is on its own line with -B' '
+
+	git diff -B seq >res &&
+	grep "^\\\\ " res && ! grep "^..*\\\\ " res
+'
+
 test_done
 
-- 
1.7.11.msysgit.1.1.gf0affa1
