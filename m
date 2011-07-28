From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/19] git-check-attr: Drive two tests using the same raw data
Date: Thu, 28 Jul 2011 06:46:56 +0200
Message-ID: <1311828418-2676-18-git-send-email-mhagger@alum.mit.edu>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 28 06:55:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIdM-0007um-3O
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab1G1EzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:55:15 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57347 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab1G1EzM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:55:12 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmITD-000889-Lt; Thu, 28 Jul 2011 06:45:15 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178033>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0003-attributes.sh |   59 +++++++++++++++++++-----------------------------
 1 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 8892ba3..a49f8a9 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -38,7 +38,25 @@ test_expect_success 'setup' '
 	) >a/b/.gitattributes &&
 	(
 		echo "global test=global"
-	) >"$HOME"/global-gitattributes
+	) >"$HOME"/global-gitattributes &&
+	cat <<EOF >expect-all
+f: test: f
+a/f: test: f
+a/c/f: test: f
+a/g: test: a/g
+a/b/g: test: a/b/g
+b/g: test: unspecified
+a/b/h: test: a/b/h
+a/b/d/g: test: a/b/d/*
+onoff: test: unset
+offon: test: set
+no: notest: set
+no: test: unspecified
+a/b/d/no: notest: set
+a/b/d/no: test: a/b/d/*
+a/b/d/yes: notest: set
+a/b/d/yes: test: unspecified
+EOF
 
 '
 
@@ -87,47 +105,16 @@ test_expect_success 'core.attributesfile' '
 
 test_expect_success 'attribute test: read paths from stdin' '
 
-	cat <<EOF > expect &&
-f: test: f
-a/f: test: f
-a/c/f: test: f
-a/g: test: a/g
-a/b/g: test: a/b/g
-b/g: test: unspecified
-a/b/h: test: a/b/h
-a/b/d/g: test: a/b/d/*
-onoff: test: unset
-offon: test: set
-no: test: unspecified
-a/b/d/no: test: a/b/d/*
-a/b/d/yes: test: unspecified
-EOF
-
+	grep -v notest < expect-all > expect &&
 	sed -e "s/:.*//" < expect | git check-attr --stdin test > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'attribute test: --all option' '
 
-	cat <<EOF > all &&
-f: test: f
-a/f: test: f
-a/c/f: test: f
-a/g: test: a/g
-a/b/g: test: a/b/g
-b/g: test: unspecified
-a/b/h: test: a/b/h
-a/b/d/g: test: a/b/d/*
-onoff: test: unset
-offon: test: set
-no: notest: set
-a/b/d/no: test: a/b/d/*
-a/b/d/no: notest: set
-a/b/d/yes: notest: set
-EOF
-
-	grep -v unspecified < all | sort > expect &&
-	sed -e "s/:.*//" < all | uniq | git check-attr --stdin --all | sort > actual &&
+	grep -v unspecified < expect-all | sort > expect &&
+	sed -e "s/:.*//" < expect-all | uniq |
+		git check-attr --stdin --all | sort > actual &&
 	test_cmp expect actual
 '
 
-- 
1.7.6.8.gd2879
