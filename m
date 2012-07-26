From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/5] test-lib: provide UTF8 behaviour as a prerequisite
Date: Thu, 26 Jul 2012 15:39:56 +0200
Message-ID: <2d9b28dacc3e83d7aab1c3266bfbc53a3d3db906.1343309173.git.git@drmicha.warpmail.net>
References: <5001B82B.1060201@web.de>
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 15:40:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuOIm-0004Uk-18
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 15:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab2GZNkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 09:40:18 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39537 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751808Ab2GZNkG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2012 09:40:06 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E797720AA5;
	Thu, 26 Jul 2012 09:40:05 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 26 Jul 2012 09:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=oA
	e1Dc6DEEhGfQQbvYU8gVV6IPY=; b=RixXpVFeFMtkxn1mGgaGsrVqdvYTn11XSf
	GUusoeTQy5+Pm3KhO9CURwGqRWC0DoDr9QAjKckMH7M7jLOapiF1eASoylVsnzRH
	Rxhb42KdznuWvPJq6kB1RA8/g2HJhcEFtzpXhi7HKskvshgpCuGhGfC591u7ILys
	Kh7tLb6zk=
X-Sasl-enc: kWLzHWxHO0R8PCXNJcaWANKB6M0GeuVNn6fFJK+W6FIf 1343310005
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7FD248E01FB;
	Thu, 26 Jul 2012 09:40:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc0.198.gd66b616
In-Reply-To: <5001B82B.1060201@web.de>
In-Reply-To: <cover.1343309173.git.git@drmicha.warpmail.net>
References: <cover.1343309173.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202267>

UTF8 behaviour of the filesystem (conversion from nfd to nfc)  plays a
role in several tests and is tested in several tests. Therefore, move
the test from t0050 into the test lib and use the prerequisite in t0050.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/README              |  5 +++++
 t/t0050-filesystem.sh | 24 +++++++-----------------
 t/test-lib.sh         | 14 ++++++++++++++
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/t/README b/t/README
index 5725607..e4128e5 100644
--- a/t/README
+++ b/t/README
@@ -629,6 +629,11 @@ use these, and "test_set_prereq" for how to define your own.
 
    Test is run on a case insensitive file system.
 
+ - UTF8_NFD_TO_NFC
+
+   Test is run on a filesystem which converts decomposed utf-8 (nfd)
+   to precomposed utf-8 (nfc).
+
 Tips for Writing Tests
 ----------------------
 
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index b46ae72..78816d9 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -7,22 +7,6 @@ test_description='Various filesystem issues'
 auml=$(printf '\303\244')
 aumlcdiar=$(printf '\141\314\210')
 
-unibad=
-test_expect_success 'see what we expect' '
-
-	test_unicode=test_expect_success &&
-	mkdir junk &&
-	>junk/"$auml" &&
-	case "$(cd junk && echo *)" in
-	"$aumlcdiar")
-		test_unicode=test_expect_failure &&
-		unibad=t
-		;;
-	*)	;;
-	esac &&
-	rm -fr junk
-'
-
 if test_have_prereq CASE_INSENSITIVE_FS
 then
 	say "will test on a case insensitive filesystem"
@@ -31,8 +15,14 @@ else
 	test_case=test_expect_success
 fi
 
-test "$unibad" &&
+if test_have_prereq UTF8_NFD_TO_NFC
+then
 	say "will test on a unicode corrupting filesystem"
+	test_unicode=test_expect_failure
+else
+	test_unicode=test_expect_success
+fi
+
 test_have_prereq SYMLINKS ||
 	say "will test on a filesystem lacking symbolic links"
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 57fc1f2..057ac1d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -676,3 +676,17 @@ then
 	test_set_prereq CASE_INSENSITIVE_FS
 fi
 rm -rf junk
+
+# check whether FS converts nfd unicode to nfc
+auml=$(printf '\303\244')
+aumlcdiar=$(printf '\141\314\210')
+
+mkdir junk &&
+>junk/"$auml" &&
+case "$(cd junk && echo *)" in
+"$aumlcdiar")
+	test_set_prereq UTF8_NFD_TO_NFC
+	;;
+*)	;;
+esac
+rm -fr junk
-- 
1.7.12.rc0.198.gd66b616
