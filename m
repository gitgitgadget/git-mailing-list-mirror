From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] test: errors preparing for a test are not special
Date: Wed, 14 Dec 2011 02:22:03 -0600
Message-ID: <20111214082203.GB13166@elie.hsd1.il.comcast.net>
References: <1323815706-10560-1-git-send-email-jratt0@gmail.com>
 <1323815706-10560-2-git-send-email-jratt0@gmail.com>
 <4EE853C0.20505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 14 09:22:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rak6Q-0002D9-IJ
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 09:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457Ab1LNIWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 03:22:10 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62880 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab1LNIWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 03:22:08 -0500
Received: by qadc12 with SMTP id c12so3900788qad.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 00:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pJ9F4dASOBCJe1z6gXCMZY+LiD4vY+0W7LAC3KbNXco=;
        b=TTV9HjZ1uJCghciHygJod0bLGW3pTh/P5UWboByharDIp69dXisO2/NeM4xDq7mdQs
         vTGe7xZ6dHTdjVwZaCiS1iKo/ru1AAIoOTK3bZDK0m4+PV5lpr9L9DGnSewXPxytzf6y
         JawNAorh3ZPXrrUUfmsNc43bG+TefBaorCqIc=
Received: by 10.224.216.197 with SMTP id hj5mr7790455qab.15.1323850927853;
        Wed, 14 Dec 2011 00:22:07 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id du5sm4175903qab.14.2011.12.14.00.22.06
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 00:22:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EE853C0.20505@viscovery.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187100>

This script uses the following idiom to start each test in a known
good state:

	test_expect_success 'some commands use a pager' '
		rm -f paginated.out || cleanup_fail &&
		test_terminal git log &&
		test -e paginated.out
	'

where "cleanup_fail" is a function that prints an error message and
errors out.

That is bogus on three levels:

 - Cleanup commands like "rm -f" and "test_unconfig" are designed not
   to fail, so this logic would never trip.

 - If they were to malfunction anyway, it is not useful to set apart
   cleanup commands as a special kind of failure with a special error
   message.  Whichever command fails, the next step is to investigate
   which command that was, for example by running tests with
   "prove -e 'sh -x'", and fix it.

 - Relying on left-associativity of mixed &&/|| lists makes the code
   somewhat cryptic.

The fix is simple: drop the "|| cleanup_fail" in each test and the
definition of the "cleanup_fail" function so no new callers can arise.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Johannes Sixt wrote:
> Am 12/13/2011 23:35, schrieb Joe Ratterman:

>>  test_expect_success TTY 'no pager with --no-pager' '
>>  	rm -f paginated.out ||
>>  	cleanup_fail &&
>
> What kind of bogosity do I see in the context of this hunk
[...]
> Wouldn't rm -f always succeed under normal circumstances, and then the
> rest of the test would be skipped?

No, && and || are left-associative.

That said, I think the || was a mistake.  At the time, I had not yet
understood why some tests in other scripts had cleanup commands
outside the test body.  I wrongly thought it was to make sure errors
during cleanup are not mistaken for errors in the test proper (rather
than to ensure cleanup happens when needed even if some tests are
skipped).

 t/t7006-pager.sh |   73 ++++++++++++-----------------------------------------
 1 files changed, 17 insertions(+), 56 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 320e1d1d..ff259084 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -6,11 +6,6 @@ test_description='Test automatic use of a pager.'
 . "$TEST_DIRECTORY"/lib-pager.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-cleanup_fail() {
-	echo >&2 cleanup failed
-	(exit 1)
-}
-
 test_expect_success 'setup' '
 	sane_unset GIT_PAGER GIT_PAGER_IN_USE &&
 	test_unconfig core.pager &&
@@ -22,9 +17,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success TTY 'some commands use a pager' '
-	rm -f paginated.out ||
-	cleanup_fail &&
-
+	rm -f paginated.out &&
 	test_terminal git log &&
 	test -e paginated.out
 '
@@ -45,49 +38,37 @@ test_expect_failure TTY 'pager runs from subdir' '
 '
 
 test_expect_success TTY 'some commands do not use a pager' '
-	rm -f paginated.out ||
-	cleanup_fail &&
-
+	rm -f paginated.out &&
 	test_terminal git rev-list HEAD &&
 	! test -e paginated.out
 '
 
 test_expect_success 'no pager when stdout is a pipe' '
-	rm -f paginated.out ||
-	cleanup_fail &&
-
+	rm -f paginated.out &&
 	git log | cat &&
 	! test -e paginated.out
 '
 
 test_expect_success 'no pager when stdout is a regular file' '
-	rm -f paginated.out ||
-	cleanup_fail &&
-
+	rm -f paginated.out &&
 	git log >file &&
 	! test -e paginated.out
 '
 
 test_expect_success TTY 'git --paginate rev-list uses a pager' '
-	rm -f paginated.out ||
-	cleanup_fail &&
-
+	rm -f paginated.out &&
 	test_terminal git --paginate rev-list HEAD &&
 	test -e paginated.out
 '
 
 test_expect_success 'no pager even with --paginate when stdout is a pipe' '
-	rm -f file paginated.out ||
-	cleanup_fail &&
-
+	rm -f file paginated.out &&
 	git --paginate log | cat &&
 	! test -e paginated.out
 '
 
 test_expect_success TTY 'no pager with --no-pager' '
-	rm -f paginated.out ||
-	cleanup_fail &&
-
+	rm -f paginated.out &&
 	test_terminal git --no-pager log &&
 	! test -e paginated.out
 '
@@ -136,9 +117,7 @@ colorful() {
 }
 
 test_expect_success 'tests can detect color' '
-	rm -f colorful.log colorless.log ||
-	cleanup_fail &&
-
+	rm -f colorful.log colorless.log &&
 	git log --no-color >colorless.log &&
 	git log --color >colorful.log &&
 	! colorful colorless.log &&
@@ -147,18 +126,14 @@ test_expect_success 'tests can detect color' '
 
 test_expect_success 'no color when stdout is a regular file' '
 	rm -f colorless.log &&
-	test_config color.ui auto ||
-	cleanup_fail &&
-
+	test_config color.ui auto &&
 	git log >colorless.log &&
 	! colorful colorless.log
 '
 
 test_expect_success TTY 'color when writing to a pager' '
 	rm -f paginated.out &&
-	test_config color.ui auto ||
-	cleanup_fail &&
-
+	test_config color.ui auto &&
 	(
 		TERM=vt100 &&
 		export TERM &&
@@ -181,9 +156,7 @@ test_expect_success TTY 'colors are suppressed by color.pager' '
 
 test_expect_success 'color when writing to a file intended for a pager' '
 	rm -f colorful.log &&
-	test_config color.ui auto ||
-	cleanup_fail &&
-
+	test_config color.ui auto &&
 	(
 		TERM=vt100 &&
 		GIT_PAGER_IN_USE=true &&
@@ -242,9 +215,7 @@ test_default_pager() {
 	$test_expectation SIMPLEPAGER,TTY "$cmd - default pager is used by default" "
 		sane_unset PAGER GIT_PAGER &&
 		test_unconfig core.pager &&
-		rm -f default_pager_used ||
-		cleanup_fail &&
-
+		rm -f default_pager_used &&
 		cat >\$less <<-\EOF &&
 		#!/bin/sh
 		wc >default_pager_used
@@ -265,9 +236,7 @@ test_PAGER_overrides() {
 	$test_expectation TTY "$cmd - PAGER overrides default pager" "
 		sane_unset GIT_PAGER &&
 		test_unconfig core.pager &&
-		rm -f PAGER_used ||
-		cleanup_fail &&
-
+		rm -f PAGER_used &&
 		PAGER='wc >PAGER_used' &&
 		export PAGER &&
 		$full_command &&
@@ -292,9 +261,7 @@ test_core_pager() {
 
 	$test_expectation TTY "$cmd - repository-local core.pager setting $used_if_wanted" "
 		sane_unset GIT_PAGER &&
-		rm -f core.pager_used ||
-		cleanup_fail &&
-
+		rm -f core.pager_used &&
 		PAGER=wc &&
 		export PAGER &&
 		test_config core.pager 'wc >core.pager_used' &&
@@ -321,9 +288,7 @@ test_pager_subdir_helper() {
 	$test_expectation TTY "$cmd - core.pager $used_if_wanted from subdirectory" "
 		sane_unset GIT_PAGER &&
 		rm -f core.pager_used &&
-		rm -fr sub ||
-		cleanup_fail &&
-
+		rm -fr sub &&
 		PAGER=wc &&
 		stampname=\$(pwd)/core.pager_used &&
 		export PAGER stampname &&
@@ -341,9 +306,7 @@ test_GIT_PAGER_overrides() {
 	parse_args "$@"
 
 	$test_expectation TTY "$cmd - GIT_PAGER overrides core.pager" "
-		rm -f GIT_PAGER_used ||
-		cleanup_fail &&
-
+		rm -f GIT_PAGER_used &&
 		test_config core.pager wc &&
 		GIT_PAGER='wc >GIT_PAGER_used' &&
 		export GIT_PAGER &&
@@ -356,9 +319,7 @@ test_doesnt_paginate() {
 	parse_args "$@"
 
 	$test_expectation TTY "no pager for '$cmd'" "
-		rm -f GIT_PAGER_used ||
-		cleanup_fail &&
-
+		rm -f GIT_PAGER_used &&
 		GIT_PAGER='wc >GIT_PAGER_used' &&
 		export GIT_PAGER &&
 		$full_command &&
-- 
1.7.8
