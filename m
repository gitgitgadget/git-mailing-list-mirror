From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/19] git-check-attr: Drive two tests using the same raw data
Date: Tue, 26 Jul 2011 16:13:00 +0200
Message-ID: <1311689582-3116-18-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:34:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QliiC-0006B9-4w
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab1GZOeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:34:16 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40293 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab1GZOeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:34:13 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-Te; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177884>


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
