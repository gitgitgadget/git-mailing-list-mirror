From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 03/12] t4151: am --abort will keep dirty index intact
Date: Tue,  7 Jul 2015 22:08:25 +0800
Message-ID: <1436278114-28057-4-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:09:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTYa-0005YQ-27
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570AbbGGOI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:08:59 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:32971 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572AbbGGOI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:08:57 -0400
Received: by pdbdz6 with SMTP id dz6so31799075pdb.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yc2nKDjG8zt5gP6goiNPwlRKv8YU8RpM+Hto6FuyrVQ=;
        b=0YLxme2RvvBb0A1T65UO5kV/rHu9Zu4UxhxvWiiFXNo+BSJlzcfVbzlPaVeoaumCfm
         iH/sgO1ljW35E+Gxj53irPukerGufbdRLzzPOpwSQrQp+6platGpc/ykMkQoCPaWz7i1
         Q1hQkRfqWtr0mReT+ZNLYwVY+OrEweApvJszLPH9K+EreYXMGK8XtphBylz3i4SuUoQR
         u0l2yuqfCCYf2+hqP/V9GAgPEh+eWcBJkVsuyQXPH0eTEvxRFYG8GnA7xiw2bmGFn63a
         WMU9jM9lwSk6Cdrn7Wo4Zyb2z6D64hVfanvYEwztEoKzAEwuk4V2NRh2kzmon+2Lkltx
         B5QQ==
X-Received: by 10.66.90.166 with SMTP id bx6mr9372024pab.76.1436278136814;
        Tue, 07 Jul 2015 07:08:56 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.08.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:08:55 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273509>

Since 7b3b7e3 (am --abort: keep unrelated commits since the last failure
and warn, 2010-12-21), git-am --abort will not touch the index if on the
previous invocation, git-am failed because the index is dirty. This is
to ensure that the user's modifications to the index are not discarded.

Add a test for this.

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
2.5.0.rc1.76.gf60a929
