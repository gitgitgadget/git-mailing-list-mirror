From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t1402-check-ref-format: skip tests of refs beginning with
 slash on Windows
Date: Thu, 13 Oct 2011 10:06:20 +0200
Message-ID: <4E969BFC.50706@viscovery.net>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 13 10:06:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REGJN-0004su-0h
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 10:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535Ab1JMIGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 04:06:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32455 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752139Ab1JMIGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 04:06:33 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1REGJ3-0004Cl-8V; Thu, 13 Oct 2011 10:06:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D7FEB1660F;
	Thu, 13 Oct 2011 10:06:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183462>

From: Johannes Sixt <j6t@kdbg.org>

Bash on Windows converts program arguments that look like absolute POSIX
paths to their Windows form, i.e., drive-letter-colon format. For this
reason, those tests in t1402 that check refs that begin with a slash do not
work as expected on Windows: valid_ref tests are doomed to fail, and
invalid_ref tests fail for the wrong reason (that there is a colon rather
than that they begin with a slash).

Skip these tests.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 10/13/2011 9:58, schrieb mhagger@alum.mit.edu:
> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> This is the next installment of the reference changes that I have been
> working on.  This batch includes a lot of tidying up in preparation
> for the real changes.

This patch is needed on top of mh/check-ref-format-3, or it could be
inserted in front of this batch (which probably amounts to the same
thing :-)

-- Hannes

 t/t1402-check-ref-format.sh |   64 +++++++++++++++++++++---------------------
 1 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 710fcca..dba5e97 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -5,38 +5,38 @@ test_description='Test git check-ref-format'
 . ./test-lib.sh
 
 valid_ref() {
-	if test "$#" = 1
-	then
-		test_expect_success "ref name '$1' is valid" \
-			"git check-ref-format '$1'"
-	else
-		test_expect_success "ref name '$1' is valid with options $2" \
+	prereq=
+	case $1 in
+	[A-Z]*)
+		prereq=$1
+		shift
+	esac
+	test_expect_success $prereq "ref name '$1' is valid${2:+ with options $2}" \
 			"git check-ref-format $2 '$1'"
-	fi
 }
 invalid_ref() {
-	if test "$#" = 1
-	then
-		test_expect_success "ref name '$1' is invalid" \
-			"test_must_fail git check-ref-format '$1'"
-	else
-		test_expect_success "ref name '$1' is invalid with options $2" \
+	prereq=
+	case $1 in
+	[A-Z]*)
+		prereq=$1
+		shift
+	esac
+	test_expect_success $prereq "ref name '$1' is invalid${2:+ with options $2}" \
 			"test_must_fail git check-ref-format $2 '$1'"
-	fi
 }
 
 invalid_ref ''
-invalid_ref '/'
-invalid_ref '/' --allow-onelevel
-invalid_ref '/' --normalize
-invalid_ref '/' '--allow-onelevel --normalize'
+invalid_ref NOT_MINGW '/'
+invalid_ref NOT_MINGW '/' --allow-onelevel
+invalid_ref NOT_MINGW '/' --normalize
+invalid_ref NOT_MINGW '/' '--allow-onelevel --normalize'
 valid_ref 'foo/bar/baz'
 valid_ref 'foo/bar/baz' --normalize
 invalid_ref 'refs///heads/foo'
 valid_ref 'refs///heads/foo' --normalize
 invalid_ref 'heads/foo/'
-invalid_ref '/heads/foo'
-valid_ref '/heads/foo' --normalize
+invalid_ref NOT_MINGW '/heads/foo'
+valid_ref NOT_MINGW '/heads/foo' --normalize
 invalid_ref '///heads/foo'
 valid_ref '///heads/foo' --normalize
 invalid_ref './foo'
@@ -115,14 +115,14 @@ invalid_ref "$ref" --refspec-pattern
 invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
 
 ref='/foo'
-invalid_ref "$ref"
-invalid_ref "$ref" --allow-onelevel
-invalid_ref "$ref" --refspec-pattern
-invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
-invalid_ref "$ref" --normalize
-valid_ref "$ref" '--allow-onelevel --normalize'
-invalid_ref "$ref" '--refspec-pattern --normalize'
-valid_ref "$ref" '--refspec-pattern --allow-onelevel --normalize'
+invalid_ref NOT_MINGW "$ref"
+invalid_ref NOT_MINGW "$ref" --allow-onelevel
+invalid_ref NOT_MINGW "$ref" --refspec-pattern
+invalid_ref NOT_MINGW "$ref" '--refspec-pattern --allow-onelevel'
+invalid_ref NOT_MINGW "$ref" --normalize
+valid_ref NOT_MINGW "$ref" '--allow-onelevel --normalize'
+invalid_ref NOT_MINGW "$ref" '--refspec-pattern --normalize'
+valid_ref NOT_MINGW "$ref" '--refspec-pattern --allow-onelevel --normalize'
 
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
@@ -155,21 +155,21 @@ test_expect_success 'check-ref-format --branch from subdir' '
 '
 
 valid_ref_normalized() {
-	test_expect_success "ref name '$1' simplifies to '$2'" "
+	test_expect_success $3 "ref name '$1' simplifies to '$2'" "
 		refname=\$(git check-ref-format --normalize '$1') &&
 		test \"\$refname\" = '$2'"
 }
 invalid_ref_normalized() {
-	test_expect_success "check-ref-format --normalize rejects '$1'" "
+	test_expect_success $2 "check-ref-format --normalize rejects '$1'" "
 		test_must_fail git check-ref-format --normalize '$1'"
 }
 
 valid_ref_normalized 'heads/foo' 'heads/foo'
 valid_ref_normalized 'refs///heads/foo' 'refs/heads/foo'
-valid_ref_normalized '/heads/foo' 'heads/foo'
+valid_ref_normalized '/heads/foo' 'heads/foo' NOT_MINGW
 valid_ref_normalized '///heads/foo' 'heads/foo'
 invalid_ref_normalized 'foo'
-invalid_ref_normalized '/foo'
+invalid_ref_normalized '/foo' NOT_MINGW
 invalid_ref_normalized 'heads/foo/../bar'
 invalid_ref_normalized 'heads/./foo'
 invalid_ref_normalized 'heads\foo'
-- 
"Atomic objects are neither active nor radioactive." --
Programming Languages -- C++, Final Committee Draft (Doc.N3092)
