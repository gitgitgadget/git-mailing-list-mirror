From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] t1503: test rev-parse --verify --quiet with deleted reflogs
Date: Sun, 14 Sep 2014 01:30:42 -0700
Message-ID: <1410683442-74523-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 10:31:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT5D7-0003Cu-TH
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbaINIa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 04:30:58 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61569 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbaINIax (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:30:53 -0400
Received: by mail-pd0-f173.google.com with SMTP id ft15so4285405pdb.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OlXVLMd4Aqn3w54y6zrE/M2h8vWgr1dJZPFubvc6Its=;
        b=rvCk6nP4sQydhxtpYbynBXTAOiREfv1eshzTc2hCWa+5xJJi3CgIRiuuW93JJrDL4T
         CGa0E9iRxmVlwkTChYkGGDvVeb0C67/kYFfiQcwQLDcbx1qAVHOQ82BmYjH9kCdlR4R8
         zY1mUfWLjdjvLihUhQkVCjBx265tvYgJZQ0nnHoE5mmn1hDxSZyULrKurrdhKFUJfZlr
         6FTNi7+iNhmb/m3ZDaKjgFOJJlL97EDn484y7mQshf1hfHUjp3qWSv1p/TJjVmZCyKEL
         JgUvfiie0UYAA/zJeR4pwuHZyx3bjFTiAvut//KrsNyyHkl8MhYyVzy8DWEFYXWEg165
         CRGw==
X-Received: by 10.67.15.172 with SMTP id fp12mr28810512pad.4.1410683452530;
        Sun, 14 Sep 2014 01:30:52 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id cu3sm8282467pbb.48.2014.09.14.01.30.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Sep 2014 01:30:51 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.29.gf6d9003.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257008>

Ensure that rev-parse --verify --quiet is silent when asked
about deleted reflog entries.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This verifies and depends on "refs: make rev-parse --quiet actually quiet".

 t/t1503-rev-parse-verify.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 813cc1b..731c21c 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -83,6 +83,15 @@ test_expect_success 'fails silently when using -q' '
 	test -z "$(cat error)"
 '
 
+test_expect_success 'fails silently when using -q with deleted reflogs' '
+	ref=$(git rev-parse HEAD) &&
+	: >.git/logs/refs/test &&
+	git update-ref -m test refs/test "$ref" &&
+	git reflog delete --updateref --rewrite refs/test@{0} &&
+	test_must_fail git rev-parse --verify --quiet refs/test@{0} 2>error &&
+	test -z "$(cat error)"
+'
+
 test_expect_success 'no stdout output on error' '
 	test -z "$(git rev-parse --verify)" &&
 	test -z "$(git rev-parse --verify foo)" &&
-- 
2.1.0.29.gf6d9003.dirty
