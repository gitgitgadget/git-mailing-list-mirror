From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 03/12] t4151: am --abort will keep dirty index intact
Date: Fri,  3 Jul 2015 02:16:31 +0800
Message-ID: <1435861000-25278-4-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:17:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj3A-0006Jd-8j
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbbGBSRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:23 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35591 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbbGBSRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:17 -0400
Received: by pdbci14 with SMTP id ci14so49034126pdb.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=148+YchM7A15SXe3W6FfdA/Exa6KERFowRxt5k2pBd8=;
        b=gdwwLO4pRmDdrdFJ+iK6Ys8gEDfkltUgWeanoFWqSN9Ts+smgf4t+4DDlms+HPI8zN
         4jxJ70Q0b8frJ6LK9bXBsZUNr53ESpHVg0f+ivbRTOlkteGTzqKjICx8ekXKlRU43ufZ
         zY41VUvjBFj4/2MkyYSs5Io44mLtoVxx753sA9ga3L2yRgmaiEBZ9ueosD6PzMgEzM+g
         PxkdE0M498qjixRRa51H+q6mg6yEqYmZFLXXR/7a+jchZW8cZ7IC0MhlYtGLCouXTiaM
         WKgN2gw406B2ji7c7bJngnXO0pB6iE1YPxdLtlfHOnp7N3PCPho7vrOYJM0ayDIjTiT8
         k1mQ==
X-Received: by 10.70.131.4 with SMTP id oi4mr68885869pdb.95.1435861036472;
        Thu, 02 Jul 2015 11:17:16 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273257>

Since 7b3b7e3 (am --abort: keep unrelated commits since the last failure
and warn, 2010-12-21), git-am --abort will not touch the index if on the
previous invocation, git-am failed because the index is dirty. This is
to ensure that the user's modifications to the index are not discarded.

Add a test for this.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4151-am-abort.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 833e7b2..05bdc3e 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -95,6 +95,21 @@ test_expect_success 'am --abort will keep the local commits intact' '
 	test_cmp expect actual
 '
 
+test_expect_success 'am --abort will keep dirty index intact' '
+	git reset --hard initial &&
+	echo dirtyfile >dirtyfile &&
+	cp dirtyfile dirtyfile.expected &&
+	git add dirtyfile &&
+	test_must_fail git am 0001-*.patch &&
+	test_cmp_rev initial HEAD &&
+	test_path_is_file dirtyfile &&
+	test_cmp dirtyfile.expected dirtyfile &&
+	git am --abort &&
+	test_cmp_rev initial HEAD &&
+	test_path_is_file dirtyfile &&
+	test_cmp dirtyfile.expected dirtyfile
+'
+
 test_expect_success 'am -3 stops on conflict on unborn branch' '
 	git checkout -f --orphan orphan &&
 	git reset &&
-- 
2.5.0.rc1.81.gfe77482
