From: Jeff King <peff@peff.net>
Subject: [PATCH 12/12] t0001: drop subshells just for "cd"
Date: Thu, 20 Mar 2014 19:23:06 -0400
Message-ID: <20140320232306.GL8479@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmIs-0002rs-7O
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759856AbaCTXXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:23:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:43610 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759160AbaCTXXI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:23:08 -0400
Received: (qmail 28372 invoked by uid 102); 20 Mar 2014 23:23:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:23:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:23:06 -0400
Content-Disposition: inline
In-Reply-To: <20140320231159.GA7774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244615>

Many tests do something like:

  (
	mkdir foo &&
	cd foo &&
	git init
  )

You can do the same these days with "git init foo", which
makes the tests shorter and simpler to read.

Signed-off-by: Jeff King <peff@peff.net>
---
Unlike the last patch, this one _could_ have an affect. I made the
assumption that "git init foo" would behave sanely, but that other
complex things should be left alone. E.g., ones that set GIT_DIR in the
environment to a relative path might be affected based on when git does
the "chdir".

 t/t0001-init.sh | 56 +++++++++-----------------------------------------------
 1 file changed, 9 insertions(+), 47 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 55a68bc..68549d1 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -24,11 +24,7 @@ check_config () {
 }
 
 test_expect_success 'plain' '
-	(
-		mkdir plain &&
-		cd plain &&
-		git init
-	) &&
+	git init plain &&
 	check_config plain/.git false unset
 '
 
@@ -90,11 +86,7 @@ test_expect_success 'plain with GIT_WORK_TREE' '
 '
 
 test_expect_success 'plain bare' '
-	(
-		mkdir plain-bare-1 &&
-		cd plain-bare-1 &&
-		git --bare init
-	) &&
+	git --bare init plain-bare-1 &&
 	check_config plain-bare-1 true unset
 '
 
@@ -112,12 +104,7 @@ test_expect_success 'GIT_DIR bare' '
 '
 
 test_expect_success 'init --bare' '
-
-	(
-		mkdir init-bare.git &&
-		cd init-bare.git &&
-		git init --bare
-	) &&
+	git init --bare init-bare.git &&
 	check_config init-bare.git true unset
 '
 
@@ -166,26 +153,14 @@ test_expect_success 'reinit' '
 test_expect_success 'init with --template' '
 	mkdir template-source &&
 	echo content >template-source/file &&
-	(
-		mkdir template-custom &&
-		cd template-custom &&
-		git init --template=../template-source
-	) &&
+	git init --template=../template-source template-custom &&
 	test_cmp template-source/file template-custom/.git/file
 '
 
 test_expect_success 'init with --template (blank)' '
-	(
-		mkdir template-plain &&
-		cd template-plain &&
-		git init
-	) &&
+	git init template-plain &&
 	test_path_is_file template-plain/.git/info/exclude &&
-	(
-		mkdir template-blank &&
-		cd template-blank &&
-		git init --template=
-	) &&
+	git init --template= template-blank &&
 	test_path_is_missing template-blank/.git/info/exclude
 '
 
@@ -207,11 +182,7 @@ test_expect_success 'init with init.templatedir set' '
 test_expect_success 'init --bare/--shared overrides system/global config' '
 	test_config_global core.bare false &&
 	test_config_global core.sharedRepository 0640 &&
-	(
-		mkdir init-bare-shared-override &&
-		cd init-bare-shared-override &&
-		git init --bare --shared=0666
-	) &&
+	git init --bare --shared=0666 init-bare-shared-override &&
 	check_config init-bare-shared-override true unset &&
 	test x0666 = \
 	x`git config -f init-bare-shared-override/config core.sharedRepository`
@@ -219,22 +190,13 @@ test_expect_success 'init --bare/--shared overrides system/global config' '
 
 test_expect_success 'init honors global core.sharedRepository' '
 	test_config_global core.sharedRepository 0666 &&
-	(
-		mkdir shared-honor-global &&
-		cd shared-honor-global &&
-		git init
-	) &&
+	git init shared-honor-global &&
 	test x0666 = \
 	x`git config -f shared-honor-global/.git/config core.sharedRepository`
 '
 
 test_expect_success 'init rejects insanely long --template' '
-	(
-		insane=$(printf "x%09999dx" 1) &&
-		mkdir test &&
-		cd test &&
-		test_must_fail git init --template=$insane
-	)
+	test_must_fail git init --template=$(printf "x%09999dx" 1) test
 '
 
 test_expect_success 'init creates a new directory' '
-- 
1.9.0.560.g01ceb46
