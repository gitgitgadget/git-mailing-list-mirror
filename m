From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] git-submodules.sh: fix '/././' path normalization
Date: Fri, 30 Jan 2015 16:14:03 +0100
Message-ID: <1422630843-9559-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 16:16:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHDIc-0003Oj-E1
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 16:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762636AbbA3PPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 10:15:54 -0500
Received: from sender1.zohomail.com ([74.201.84.155]:29772 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762415AbbA3PPx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 10:15:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id; 
  b=kpNIysuUTST60DxCUy8zCRNx40EZEkZG0ROZvbLZZBZn2G2yjvH8rJkj1awQcB6+sec8z62SiNvO
    5PQzyV9VE+kEO9m8h6DhxWMtoh/PS2VYIv9hoB2Hi246zLwkIYgY2WO1ML2WX/Ty5GCSW5XKrbP3
    vewLfiR7Pjnc8UNix24=  
Received: from pks-tp.elego.de (46.189.27.162 [46.189.27.162]) by mx.zohomail.com
	with SMTPS id 1422630950412982.937248084104; Fri, 30 Jan 2015 07:15:50 -0800 (PST)
X-Mailer: git-send-email 2.2.2
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT UW1 UB2468 iCHF_INT_SMD_EXT UW1 iSFP_NO_WHTCNT_EXT UW1 UB2468  SGR3_0_22015_263
X-ZohoMail-Owner: <1422630843-9559-1-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 46.189.27.162
X-Zoho-Virus-Status: 2
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263178>

When we add a new submodule the path of the submodule is being normalized. We
fail to normalize multiple adjacent '/./', though. Thus 'path/to/././submodule'
will become 'path/to/./submodule' where it should be 'path/to/submodule'
instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-submodule.sh           |  2 +-
 t/t7400-submodule-basic.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9245abf..36797c3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -423,7 +423,7 @@ cmd_add()
 		sed -e '
 			s|//*|/|g
 			s|^\(\./\)*||
-			s|/\./|/|g
+			s|/\(\./\)*|/|g
 			:start
 			s|\([^/]*\)/\.\./||
 			tstart
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 7c88245..5811a98 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -171,6 +171,23 @@ test_expect_success 'submodule add with ./ in path' '
 	test_cmp empty untracked
 '
 
+test_expect_success 'submodule add with /././ in path' '
+	echo "refs/heads/master" >expect &&
+	>empty &&
+
+	(
+		cd addtest &&
+		git submodule add "$submodurl" dotslashdotsubmod/././frotz/./ &&
+		git submodule init
+	) &&
+
+	rm -f heads head untracked &&
+	inspect addtest/dotslashdotsubmod/frotz ../../.. &&
+	test_cmp expect heads &&
+	test_cmp expect head &&
+	test_cmp empty untracked
+'
+
 test_expect_success 'submodule add with // in path' '
 	echo "refs/heads/master" >expect &&
 	>empty &&
-- 
2.2.2
