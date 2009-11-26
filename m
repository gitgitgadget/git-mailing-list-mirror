From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [PATCH 7/8] Extend merge-subtree tests to test -Xsubtree=dir.
Date: Wed, 25 Nov 2009 21:23:59 -0500
Message-ID: <3acdc84af78453622df67b8c7ce6763bd316db4b.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com> <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com> <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com> <73a42e99b4a083c74b017caf2970d1bbf5886b96.1259201377.git.apenwarr@gmail.com> <1ff0b2f7e3fae4cc6c7610c92711f33df9a3d07c.1259201377.git.apenwarr@gmail.com> <c78d4c177f470e0f2f64314321df12e1a59077bf.1259201377.git.apenwarr@gmail.com>
Cc: <gitster@pobox.com>, "Avery Pennarun" <apenwarr@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 03:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDUKN-0004ry-1e
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 03:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091AbZKZCmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 21:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbZKZCmu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 21:42:50 -0500
Received: from mailhost.pwcorp.com ([216.13.111.70]:4746 "EHLO
	mailhost.pwcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbZKZCmg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 21:42:36 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 21:42:31 EST
X-Language-Identified: TRUE
X-Brightmail-Tracker: AAAAAgAAA+kAAAPr
thread-index: AcpuP/6xyddo6zdAQmmGvp3wme3yug==
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959); Wed, 25 Nov 2009 21:27:26 -0500
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Received: (qmail 5761 invoked from network); 26 Nov 2009 02:25:49 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:49 -0000
Received: (qmail 5665 invoked from network); 26 Nov 2009 02:25:45 -0000
Received: from unknown (HELO harmony.mtl.versabanq.com) (10.65.1.133)  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:45 -0000
Received: by harmony.mtl.versabanq.com (sSMTP sendmail emulation); Wed, 25 Nov 2009 21:24:20 -0500
X-Mailer: git-send-email 1.6.6.rc0.62.gaccf
In-Reply-To: <c78d4c177f470e0f2f64314321df12e1a59077bf.1259201377.git.apenwarr@gmail.com>
In-Reply-To: <cover.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
X-OriginalArrivalTime: 26 Nov 2009 02:27:26.0559 (UTC) FILETIME=[FE84C6F0:01CA6E3F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133758>

This tests the configurable -Xsubtree feature of merge-recursive.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 t/t6029-merge-subtree.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 5bbfa44..3900d9f 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -52,6 +52,7 @@ test_expect_success 'initial merge' '
 	git merge -s ours --no-commit gui/master &&
 	git read-tree --prefix=git-gui/ -u gui/master &&
 	git commit -m "Merge git-gui as our subdirectory" &&
+	git checkout -b work &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o1 0	git-gui/git-gui.sh"
@@ -65,9 +66,10 @@ test_expect_success 'merge update' '
 	echo git-gui2 > git-gui.sh &&
 	o3=$(git hash-object git-gui.sh) &&
 	git add git-gui.sh &&
+	git checkout -b master2 &&
 	git commit -m "update git-gui" &&
 	cd ../git &&
-	git pull -s subtree gui master &&
+	git pull -s subtree gui master2 &&
 	git ls-files -s >actual &&
 	(
 		echo "100644 $o3 0	git-gui/git-gui.sh"
@@ -76,4 +78,47 @@ test_expect_success 'merge update' '
 	test_cmp expected actual
 '
 
+test_expect_success 'initial ambiguous subtree' '
+	cd ../git &&
+	git reset --hard master &&
+	git checkout -b master2 &&
+	git merge -s ours --no-commit gui/master &&
+	git read-tree --prefix=git-gui2/ -u gui/master &&
+	git commit -m "Merge git-gui2 as our subdirectory" &&
+	git checkout -b work2 &&
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o1 0	git-gui/git-gui.sh"
+		echo "100644 $o1 0	git-gui2/git-gui.sh"
+		echo "100644 $o2 0	git.c"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge using explicit' '
+	cd ../git &&
+	git reset --hard master2 &&
+	git pull -Xsubtree=git-gui gui master2 &&
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o3 0	git-gui/git-gui.sh"
+		echo "100644 $o1 0	git-gui2/git-gui.sh"
+		echo "100644 $o2 0	git.c"
+	) >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge2 using explicit' '
+	cd ../git &&
+	git reset --hard master2 &&
+	git pull -Xsubtree=git-gui2 gui master2 &&
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o1 0	git-gui/git-gui.sh"
+		echo "100644 $o3 0	git-gui2/git-gui.sh"
+		echo "100644 $o2 0	git.c"
+	) >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.6.6.rc0.62.gaccf
