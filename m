From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/5] test-lib: provide case insensitivity as a prerequisite
Date: Thu, 26 Jul 2012 15:39:53 +0200
Message-ID: <c4385d6e48c19db3ac1fe6be50a9926111b6da1b.1343309173.git.git@drmicha.warpmail.net>
References: <5001B82B.1060201@web.de>
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 15:40:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuOIe-0004LP-Qs
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 15:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab2GZNkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 09:40:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54159 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751049Ab2GZNkB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2012 09:40:01 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3939E20ACA;
	Thu, 26 Jul 2012 09:40:01 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 26 Jul 2012 09:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=rD
	BGVO0FJ4ThHoOJ8QXD3/MxZYY=; b=arJqRu2wC4fOnxSiEU5A4LSdRS7fHGBh1H
	CUGSmSoEwSARjoMuUGvEMWxpLY3GRmnY6oUzIPA1xz7HH1ButiDbFFoCp5Ab2x3C
	30KzHcV4S2kSdCO3N9i9TWVV7MQ8PEcv9cumjUKSK6oxrCS+cRzckCZycSz8kIWA
	TRPE2AJu8=
X-Sasl-enc: hMJmE0ddFOJsDfBAhGz71vpdsE2IVeTFe2QWfihSf1ES 1343310000
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C94224825DF;
	Thu, 26 Jul 2012 09:40:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc0.198.gd66b616
In-Reply-To: <5001B82B.1060201@web.de>
In-Reply-To: <cover.1343309173.git.git@drmicha.warpmail.net>
References: <cover.1343309173.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202265>

Case insensitivity plays a role in several tests and is tested in several
tests. Therefore, move the test from t003 into the test lib and use the
prerequisite in t0003.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/README              |  4 ++++
 t/t0003-attributes.sh | 10 ----------
 t/test-lib.sh         | 10 ++++++++++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/t/README b/t/README
index 4c3ea25..5725607 100644
--- a/t/README
+++ b/t/README
@@ -625,6 +625,10 @@ use these, and "test_set_prereq" for how to define your own.
    Git was compiled with USE_LIBPCRE=YesPlease. Wrap any tests
    that use git-grep --perl-regexp or git-grep -P in these.
 
+ - CASE_INSENSITIVE_FS
+
+   Test is run on a case insensitive file system.
+
 Tips for Writing Tests
 ----------------------
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 51f3045..febc45c 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -123,16 +123,6 @@ test_expect_success 'attribute matching is case insensitive when core.ignorecase
 
 '
 
-test_expect_success 'check whether FS is case-insensitive' '
-	mkdir junk &&
-	echo good >junk/CamelCase &&
-	echo bad >junk/camelcase &&
-	if test "$(cat junk/CamelCase)" != good
-	then
-		test_set_prereq CASE_INSENSITIVE_FS
-	fi
-'
-
 test_expect_success CASE_INSENSITIVE_FS 'additional case insensitivity tests' '
 	test_must_fail attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=0" &&
 	test_must_fail attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=0" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bb4f886..57fc1f2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -666,3 +666,13 @@ rm -f y
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
+
+# check whether FS is case-insensitive
+mkdir junk &&
+echo good >junk/CamelCase && 
+echo bad >junk/camelcase &&
+if test "$(cat junk/CamelCase)" != good
+then
+	test_set_prereq CASE_INSENSITIVE_FS
+fi
+rm -rf junk
-- 
1.7.12.rc0.198.gd66b616
