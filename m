From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 3/8] test-lib: allow test code to check the list of declared prerequisites
Date: Sun, 17 Oct 2010 02:36:58 +0800
Message-ID: <1287254223-4496-4-git-send-email-rctay89@gmail.com>
References: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
 <1287254223-4496-2-git-send-email-rctay89@gmail.com>
 <1287254223-4496-3-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 20:38:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Bdt-0002rt-HY
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 20:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591Ab0JPShi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 14:37:38 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59579 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab0JPShh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 14:37:37 -0400
Received: by pxi16 with SMTP id 16so272997pxi.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=M5/RfU/f8Nro7EzRAXQZfk5hr9r/Eqr5y3JJ6K/oqno=;
        b=WM+KWR7p2Om6DzN0PMbZe0M5m9HKbMOsNL9Gr1fa6UhjuTwVAE1jnR1k7a/HjF+S61
         Uyq70vxSSTHRmJ2Bt3CkwXmYPC6fH/lFCluPtVd77mZ2WXUHhiXc3aDHvtZ+4OTidtTL
         CJrnxt1t6n8YFgmyVfF4e3aJyKXq5Ew4/7eWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e+QCShY+tB9UAf343K0jDIUY5KQY1dKxdqjN2cZbtiWPgWxwugDsrqMDWdJWyvX1aJ
         ZqI6GrengCXp+j+MbwR/fM/Qez9/5skDdOSXwV99eizUIWyEP+9JdZQWH4wO0KbHYGX/
         6AVANolDVpY+3BPDiHeWBCJLELuu0vIXbZzAA=
Received: by 10.142.44.14 with SMTP id r14mr1853349wfr.152.1287254254443;
        Sat, 16 Oct 2010 11:37:34 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id x18sm8029156wfa.23.2010.10.16.11.37.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 11:37:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <1287254223-4496-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159172>

From: Jonathan Nieder <jrnieder@gmail.com>

This is plumbing to prepare helpers like test_terminal to notice buggy
test scripts that do not declare all of the necessary prerequisites.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---

  No change.

 t/test-lib.sh |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index dff5e25..94bff17 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -362,6 +362,15 @@ test_have_prereq () {
 	test $total_prereq = $ok_prereq
 }
 
+test_declared_prereq () {
+	case ",$test_prereq," in
+	*,$1,*)
+		return 0
+		;;
+	esac
+	return 1
+}
+
 # You are not expected to call test_ok_ and test_failure_ directly, use
 # the text_expect_* functions instead.
 
@@ -414,17 +423,17 @@ test_skip () {
 			break
 		esac
 	done
-	if test -z "$to_skip" && test -n "$prereq" &&
-	   ! test_have_prereq "$prereq"
+	if test -z "$to_skip" && test -n "$test_prereq" &&
+	   ! test_have_prereq "$test_prereq"
 	then
 		to_skip=t
 	fi
 	case "$to_skip" in
 	t)
 		of_prereq=
-		if test "$missing_prereq" != "$prereq"
+		if test "$missing_prereq" != "$test_prereq"
 		then
-			of_prereq=" of $prereq"
+			of_prereq=" of $test_prereq"
 		fi
 
 		say_color skip >&3 "skipping test: $@"
@@ -438,9 +447,10 @@ test_skip () {
 }
 
 test_expect_failure () {
-	test "$#" = 3 && { prereq=$1; shift; } || prereq=
+	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
+	export test_prereq
 	if ! test_skip "$@"
 	then
 		say >&3 "checking known breakage: $2"
@@ -456,9 +466,10 @@ test_expect_failure () {
 }
 
 test_expect_success () {
-	test "$#" = 3 && { prereq=$1; shift; } || prereq=
+	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
+	export test_prereq
 	if ! test_skip "$@"
 	then
 		say >&3 "expecting success: $2"
@@ -500,11 +511,12 @@ test_expect_code () {
 # Usage: test_external description command arguments...
 # Example: test_external 'Perl API' perl ../path/to/test.pl
 test_external () {
-	test "$#" = 4 && { prereq=$1; shift; } || prereq=
+	test "$#" = 4 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 3 ||
 	error >&5 "bug in the test script: not 3 or 4 parameters to test_external"
 	descr="$1"
 	shift
+	export test_prereq
 	if ! test_skip "$descr" "$@"
 	then
 		# Announce the script to reduce confusion about the
-- 
1.7.2.2.513.ge1ef3
