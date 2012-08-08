From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH 1/2] t9300: Add a test covering 'sub/testname' to 'sub/testname/testfile' renaming
Date: Thu,  9 Aug 2012 03:42:49 +0800
Message-ID: <1344454971-19559-1-git-send-email-techlivezheng@gmail.com>
Cc: Techlive Zheng <techlivezheng@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 08 21:42:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzC9W-0002Kx-JP
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 21:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413Ab2HHTml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 15:42:41 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41953 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759060Ab2HHTmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 15:42:40 -0400
Received: by pbbrr13 with SMTP id rr13so1929231pbb.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=r2Cm8PZFoAiEtKtVQjovHuyFRM1SzfxDIteSdQWSwU4=;
        b=mFZ1XOH2jlOYKPWvBSH/OReMGYgkTcwiIqlP1smVKHOdlo2lWkkVAKEO+ypQSWcOnQ
         4wO4QX9BuqoVxGJlIigxH4hgDWbsNwddm0RGe/qeJEsSjHs2BpNm7DPCc4LROyvZ8dLH
         8JpBPTKzHz0jn8C4F/u/P/IXcXsgwC+zRcX4pcJ26K/tEIpcsQL6rg/fK436wsUAu2iz
         rjjbxiHX5wPwtj7ZpksSpbyKYK2hwqGNmM8PurQf1qpPAWVY/CjPaK/KiCkA22Wo2+fA
         40YIyxAAyhmdyt2m1wc80PjoFsknCibF+8OpknqWxbbMg2FKlJqTLHj6omJS8mIZTxwl
         /hpQ==
Received: by 10.68.231.10 with SMTP id tc10mr1701298pbc.107.1344454959841;
        Wed, 08 Aug 2012 12:42:39 -0700 (PDT)
Received: from home.techlive.me ([122.244.158.188])
        by mx.google.com with ESMTPS id tv6sm10526553pbc.24.2012.08.08.12.42.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2012 12:42:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203119>

This test would fail at the moment.
---
 t/t9300-fast-import.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2fcf269..2a8368e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1039,6 +1039,37 @@ test_expect_success \
 	 git diff-tree -M -r M3^ M3 >actual &&
 	 compare_diff_raw expect actual'
 
+cat >input <<INPUT_END
+blob
+mark :1
+data 10
+test file
+
+reset refs/heads/M4
+commit refs/heads/M4
+mark :2
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 8
+initial
+M 100644 :1 testname
+
+commit refs/heads/M5
+mark :3
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data 8
+initial
+from refs/heads/M4
+M 100644 :1 testname/testfile
+D testname
+
+INPUT_END
+
+test_expect_success \
+	'M: rename file into new subdirectory with same name' \
+	'git fast-import <input &&
+	 git checkout M5 &&
+	 test -d testname && test -f testname/testfile'
+
 ###
 ### series N
 ###
-- 
1.7.11.4
