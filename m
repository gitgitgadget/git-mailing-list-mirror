From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 21/23] git-check-attr: Drive two tests using the same raw data
Date: Thu,  4 Aug 2011 06:36:31 +0200
Message-ID: <1312432593-9841-22-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopgr-0005WA-Ib
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab1HDEhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:40 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39687 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab1HDEhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:08 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agI1029203;
	Thu, 4 Aug 2011 06:37:04 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178684>


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
