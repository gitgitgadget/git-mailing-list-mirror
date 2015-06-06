From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 6/6] am --abort: keep unrelated commits on unborn branch
Date: Sat,  6 Jun 2015 19:46:12 +0800
Message-ID: <1433591172-27077-7-git-send-email-pyokagan@gmail.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 13:46:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1CYs-0005Il-F7
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 13:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbbFFLqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 07:46:48 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35568 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbbFFLqo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 07:46:44 -0400
Received: by pacyx8 with SMTP id yx8so28367481pac.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZH+H1pwviiyVswF47nzrM5TA21mm6mGMTzp0xM1TEEs=;
        b=0kGOQlnqc1IbQDNgjcAeDJk5vWA2DPBRPT1TTvlyBHydfxWdDzQSV29gfDIITrXw+3
         dkGLwv/VyUJ3xREiHoVQwKmyD0EXeIZ5m5sY5Hd1/e5rmCOA0KHx6Nkj0BJ4yBSo6gkK
         xeDbHpc9WWY1Ch1q+M2/UuC9n5qVn2sRBbZepVkMXMQrZJOilI3kGPH4oSxcCe2k+L7C
         fzd7hiW50hXiNyhsTYwSbDG4MHaxyJJ3rNHFs2jchtHd+DRMZgMI6VY4uFlVtcDjEAYy
         AnW/iaZZdQLweB765mHNLU4RxQE1ediR1Tx05mNJ/2ADnVrfTQCZi1Kr1hBKE5h35r12
         JYzA==
X-Received: by 10.68.222.167 with SMTP id qn7mr13437548pbc.136.1433591204254;
        Sat, 06 Jun 2015 04:46:44 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id on3sm9344587pbc.69.2015.06.06.04.46.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 04:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270919>

Since 7b3b7e3 (am --abort: keep unrelated commits since the last failure
and warn, 2010-12-21), git-am would refuse to rewind HEAD if commits
were made since the last git-am failure. This check was implemented in
safe_to_abort(), which checked to see if HEAD's hash matched the
abort-safety file.

However, this check was skipped if the abort-safety file was empty,
which can happen if git-am failed while on an unborn branch. As such, if
any commits were made since then, they would be discarded. Fix this by
carrying on the abort safety check even if the abort-safety file is
empty.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-am.sh           |  2 +-
 t/t4151-am-abort.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index 95f90a0..4324bb1 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -87,7 +87,7 @@ safe_to_abort () {
 		return 1
 	fi
 
-	if ! test -s "$dotest/abort-safety"
+	if ! test -f "$dotest/abort-safety"
 	then
 		return 0
 	fi
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index b2a7fc5..833e7b2 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -142,4 +142,15 @@ test_expect_success 'am -3 --abort on unborn branch removes applied commits' '
 	test refs/heads/orphan = "$(git symbolic-ref HEAD)"
 '
 
+test_expect_success 'am --abort on unborn branch will keep local commits intact' '
+	git checkout -f --orphan orphan &&
+	git reset &&
+	test_must_fail git am 0004-*.patch &&
+	test_commit unrelated2 &&
+	git rev-parse HEAD >expect &&
+	git am --abort &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.4
