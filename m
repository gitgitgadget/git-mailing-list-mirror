From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] blame: prevent a segv when -L given start > EOF
Date: Mon,  8 Feb 2010 22:48:13 -0500
Message-ID: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 04:48:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neh5W-0007Te-MG
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 04:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab0BIDs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 22:48:29 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:52448 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab0BIDs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 22:48:28 -0500
Received: by ywh27 with SMTP id 27so6147618ywh.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 19:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=c4b6dL9NnywMma5rKYICX+GIdY6x5MFud59jlyHkK2g=;
        b=p41+yhzs7UYEGbTYD++7RwwEGcw+WnPesq7AXt5QkD17DRjaNbrFmciOYrhLRXa7Jq
         yFEVyFocDbLHf9ECoJ4tU1oU82nsbFRJeMIKQsIJILt1PIhemAVsNoA2ZB7+knR+Ku7J
         gCxHmYJ3vfo3TxlsT4ZCKuAJ3grzkMhSqBmG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=yEfOk/GtVIwWhQ3MLhSRFFI3sWCQrfnVpdQxuhwWtFag8n1mpkJBUtoroU3VShssp8
         EmMMMq7oLwYKURV0g+vp439MHNR8xrYUAQdU1FIRvCEdRUkNUDacUBVexwLuIJfJwS3W
         pUgTZEhTLBN13SPDVzI2F3uAaGHhdhW+mslaQ=
Received: by 10.101.93.3 with SMTP id v3mr351157anl.155.1265687307126;
        Mon, 08 Feb 2010 19:48:27 -0800 (PST)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id 13sm3376106gxk.1.2010.02.08.19.48.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Feb 2010 19:48:26 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc1.200.g9c1f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139355>

blame would segv if given -L <lineno> with <lineno> past the end of the file.
While we're fixing the bug, add test cases for an invalid <start> when called
as -L <start>,<end> or -L<start>.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
bottom is start and top is end, which seems backwards to me, but alas, it is
what it is. :-)

 builtin-blame.c  |    2 +-
 t/t8003-blame.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 6408ec8..10f7eac 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2433,7 +2433,7 @@ parse_done:
 	if (top < 1)
 		top = lno;
 	bottom--;
-	if (lno < top)
+	if (lno < top || lno < bottom)
 		die("file %s has only %lu lines", path, lno);
 
 	ent = xcalloc(1, sizeof(*ent));
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index ad834f2..4a8db74 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -157,4 +157,12 @@ EOF
   git --no-pager blame $COMMIT -- uno >/dev/null
 '
 
+test_expect_success 'blame -L with invalid start' '
+	test_must_fail git blame -L5 tres 2>&1 | grep "has only 2 lines"
+'
+
+test_expect_success 'blame -L with invalid end' '
+	git blame -L1,5 tres 2>&1 | grep "has only 2 lines"
+'
+
 test_done
-- 
1.7.0.rc1.200.g9c1f9
