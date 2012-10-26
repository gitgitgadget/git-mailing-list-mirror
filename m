From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2 2/2] Add tests for submodule sync --recursive
Date: Fri, 26 Oct 2012 13:31:31 -0400
Message-ID: <1351272691-24718-3-git-send-email-hordp@cisco.com>
References: <5089BBE1.3040107@web.de>
 <1351272691-24718-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Jens Lehmann <Jens.Lehmann@web.de>,
	Jeff King <peff@peff.net>, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 19:32:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRnlk-0006HY-97
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 19:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965500Ab2JZRcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 13:32:16 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:26566 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965459Ab2JZRcP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 13:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3565; q=dns/txt; s=iport;
  t=1351272735; x=1352482335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fcce3t68xVspbQ4MJOJSXbSo2lmf+5yjouwnNdeOxP8=;
  b=N64i1Lbuv56k06/T0GdbMlJgIPuJAxUYpOVUTgqlwVvuUGQzT692tfiZ
   TpyBZ2sJ9+gqYnm2gmjOddI5Q0sEG9AOYsMiyhofpCmSedlw4rOecs0W6
   aBRlBXCZ4wKb68ZSHU9r7JN8lQeUqlVNIA7VX6yb7fZpHSdJVV1p8a+os
   E=;
X-IronPort-AV: E=Sophos;i="4.80,654,1344211200"; 
   d="scan'208";a="135748770"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-2.cisco.com with ESMTP; 26 Oct 2012 17:32:14 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id q9QHVp4A026203;
	Fri, 26 Oct 2012 17:32:14 GMT
X-Mailer: git-send-email 1.8.0.2.g35128e8
In-Reply-To: <1351272691-24718-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208470>

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 t/t7403-submodule-sync.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 524d5c1..94e26c4 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -17,18 +17,25 @@ test_expect_success setup '
 	git commit -m upstream &&
 	git clone . super &&
 	git clone super submodule &&
+	(cd submodule &&
+	 git submodule add ../submodule sub-submodule &&
+	 test_tick &&
+	 git commit -m "sub-submodule"
+	) &&
 	(cd super &&
 	 git submodule add ../submodule submodule &&
 	 test_tick &&
 	 git commit -m "submodule"
 	) &&
 	git clone super super-clone &&
-	(cd super-clone && git submodule update --init) &&
+	(cd super-clone && git submodule update --init --recursive) &&
 	git clone super empty-clone &&
 	(cd empty-clone && git submodule init) &&
 	git clone super top-only-clone &&
 	git clone super relative-clone &&
-	(cd relative-clone && git submodule update --init)
+	(cd relative-clone && git submodule update --init --recursive) &&
+	git clone super recursive-clone &&
+	(cd recursive-clone && git submodule update --init --recursive)
 '
 
 test_expect_success 'change submodule' '
@@ -46,6 +53,11 @@ test_expect_success 'change submodule url' '
 	 git pull
 	) &&
 	mv submodule moved-submodule &&
+	(cd moved-submodule &&
+	 git config -f .gitmodules submodule.sub-submodule.url ../moved-submodule &&
+	 test_tick &&
+	 git commit -a -m moved-sub-submodule
+	) &&
 	(cd super &&
 	 git config -f .gitmodules submodule.submodule.url ../moved-submodule &&
 	 test_tick &&
@@ -61,6 +73,9 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
 	test -d "$(cd super-clone/submodule &&
 	 git config remote.origin.url
 	)" &&
+	test ! -d "$(cd super-clone/submodule/sub-submodule &&
+	 git config remote.origin.url
+	)" &&
 	(cd super-clone/submodule &&
 	 git checkout master &&
 	 git pull
@@ -70,6 +85,25 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
 	)
 '
 
+test_expect_success '"git submodule sync --recursive" should update all submodule URLs' '
+	(cd super-clone &&
+	 (cd submodule &&
+	  git pull --no-recurse-submodules
+	 ) &&
+	 git submodule sync --recursive
+	) &&
+	test -d "$(cd super-clone/submodule &&
+	 git config remote.origin.url
+	)" &&
+	test -d "$(cd super-clone/submodule/sub-submodule &&
+	 git config remote.origin.url
+	)" &&
+	(cd super-clone/submodule/sub-submodule &&
+	 git checkout master &&
+	 git pull
+	)
+'
+
 test_expect_success '"git submodule sync" should update known submodule URLs' '
 	(cd empty-clone &&
 	 git pull &&
@@ -107,6 +141,23 @@ test_expect_success '"git submodule sync" handles origin URL of the form foo/bar
 	 #actual foo/submodule
 	 test "$(git config remote.origin.url)" = "../foo/submodule"
 	)
+	(cd submodule/sub-submodule &&
+	 test "$(git config remote.origin.url)" != "../../foo/submodule"
+	)
+	)
+'
+
+test_expect_success '"git submodule sync --recursive" propagates changes in origin' '
+	(cd recursive-clone &&
+	 git remote set-url origin foo/bar &&
+	 git submodule sync --recursive &&
+	(cd submodule &&
+	 #actual foo/submodule
+	 test "$(git config remote.origin.url)" = "../foo/submodule"
+	)
+	(cd submodule/sub-submodule &&
+	 test "$(git config remote.origin.url)" = "../../foo/submodule"
+	)
 	)
 '
 
-- 
1.8.0.2.g35128e8
