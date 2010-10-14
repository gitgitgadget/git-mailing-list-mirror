From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] test-lib: allow test code to check the list of declared
 prerequisites
Date: Thu, 14 Oct 2010 15:40:01 -0500
Message-ID: <20101014204001.GB28958@burratino>
References: <20101014030220.GB20685@sigill.intra.peff.net>
 <20101014030505.GC5626@sigill.intra.peff.net>
 <20101014031642.GB14664@burratino>
 <20101014033448.GB28197@sigill.intra.peff.net>
 <20101014203721.GA28958@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <jrk@wrek.org>
X-From: git-owner@vger.kernel.org Thu Oct 14 22:43:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6UeF-0004sE-4U
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 22:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab0JNUna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 16:43:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57000 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab0JNUn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 16:43:29 -0400
Received: by wyb28 with SMTP id 28so2538384wyb.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FNgElImzKYeno43PULl5nUdpxWD6l5Czp6r7gZRcJXQ=;
        b=c/tH6Y/z9xlIvJq/1m5LdDiF5LLHfmGKX8jAP1ODwjVDJOEi0tWGx2OfZcANX2sthb
         i24+zvE8WCkaGBwvd/iyb7QHYPaCjbwBGz5HQeG02G3AWOxHPeHWLfVznxFQ6t68yNup
         3TVvFwQLp2BnAISSqzdxxriYRbLpN62cWypoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oLCLUHHEgGkohpR4MaVjNdL5N7GC9SRLRG0DsNspvsgWQHv7YVe8plrR/Y5+GtTGXE
         /N+gmiksNmSVfI3CenAyD6j8VZ3C3J+n1aw9t6uENxeBXFy3FEoz6PjO8nyzpyApfXpI
         60r7Wl+XuBi2a3JpWoqn+V2bdWLhH2pX6u/SQ=
Received: by 10.216.17.130 with SMTP id j2mr551788wej.47.1287089008408;
        Thu, 14 Oct 2010 13:43:28 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id y80sm4762560weq.27.2010.10.14.13.43.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 13:43:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101014203721.GA28958@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159072>

This is plumbing to prepare helpers like test_terminal to notice buggy
test scripts that do not declare all of the necessary prerequisites.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Applies on top of 892e6f7 (test-lib: make test_expect_code a test
command) from the en/and-cascade-tests branch.  On master,
text_expect_code would have to be adjusted, too.

 t/test-lib.sh |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d86edcd..cd69ffa 100644
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
@@ -482,11 +493,12 @@ test_expect_success () {
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
1.7.2.3
