From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH/RFC] t0000-*.sh: Fix the GIT_SKIP_TESTS sub-tests
Date: Tue, 20 May 2014 22:26:58 +0100
Message-ID: <537BC8A2.9060009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 20 23:27:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmrZ4-0005gg-4M
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbaETV1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:27:07 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:39854 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750931AbaETV1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:27:06 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id EA3F5400C30;
	Tue, 20 May 2014 22:27:07 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 96F6F400C2D;
	Tue, 20 May 2014 22:27:07 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Tue, 20 May 2014 22:27:04 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249746>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

The test suite has been failing for me on the pu branch for
a while now. I finally found a few minutes to take a look.

This failure is specific to the dash shell (/bin/sh) on my
system (ie it may well affect other shells, but I haven't
tested them all ... :). This does not affect bash (or bash
as /bin/sh aka bash --posix).

The GIT_SKIP_TESTS, 13-15, all fail with verbose output
similar to:

  $ ./t0000-basic.sh -i -v
  ...
  --- expect	2014-05-20 20:55:54.138342361 +0000
  +++ out	2014-05-20 20:55:54.134342341 +0000
  @@ -1,5 +1,5 @@
   ok 1 - passing test #1
  -ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
  +ok 2 - passing test #2
   ok 3 - passing test #3
   # passed all 3 test(s)
   1..3
  not ok 13 - GIT_SKIP_TESTS
  #	
  #		GIT_SKIP_TESTS='git.2' 		run_sub_test_lib_test git-skip-tests-basic 		'GIT_SKIP_TESTS' <<-\EOF &&
  #		for i in 1 2 3
  #		do
  #			test_expect_success "passing test #$i" 'true'
  #		done
  #		test_done
  #		EOF
  #		check_sub_test_lib_test git-skip-tests-basic <<-\EOF
  #		> ok 1 - passing test #1
  #		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
  #		> ok 3 - passing test #3
  #		> # passed all 3 test(s)
  #		> 1..3
  #		EOF
  #	
  $ 

... which looks like the sub-test does not see the GIT_SKIP_TESTS
variable at all. Indeed, if I put the entire test in a sub-shell
and replace the use of that variable on the run_sub_test_lib_test
invocation with a separate explicit assignment and export, then
the tests start working. (ie if I do the opposite of some other
recent commits!)

This patch is an RFC, because I take a different approach to the
above solution, only because the diff is much smaller and easier
to read! Is it a better solution?

ATB,
Ramsay Jones

 t/t0000-basic.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 8345c8a..373ad8f 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -296,8 +296,9 @@ test_expect_success 'test --verbose-only' '
 '
 
 test_expect_success 'GIT_SKIP_TESTS' "
-	GIT_SKIP_TESTS='git.2' \
-		run_sub_test_lib_test git-skip-tests-basic \
+	GIT_SKIP_TESTS='git.2' && export GIT_SKIP_TESTS &&
+	test_when_finished sane_unset GIT_SKIP_TESTS &&
+	run_sub_test_lib_test git-skip-tests-basic \
 		'GIT_SKIP_TESTS' <<-\\EOF &&
 	for i in 1 2 3
 	do
@@ -315,8 +316,9 @@ test_expect_success 'GIT_SKIP_TESTS' "
 "
 
 test_expect_success 'GIT_SKIP_TESTS several tests' "
-	GIT_SKIP_TESTS='git.2 git.5' \
-		run_sub_test_lib_test git-skip-tests-several \
+	GIT_SKIP_TESTS='git.2 git.5' && export GIT_SKIP_TESTS &&
+	test_when_finished sane_unset GIT_SKIP_TESTS &&
+	run_sub_test_lib_test git-skip-tests-several \
 		'GIT_SKIP_TESTS several tests' <<-\\EOF &&
 	for i in 1 2 3 4 5 6
 	do
@@ -337,8 +339,9 @@ test_expect_success 'GIT_SKIP_TESTS several tests' "
 "
 
 test_expect_success 'GIT_SKIP_TESTS sh pattern' "
-	GIT_SKIP_TESTS='git.[2-5]' \
-		run_sub_test_lib_test git-skip-tests-sh-pattern \
+	GIT_SKIP_TESTS='git.[2-5]' && export GIT_SKIP_TESTS &&
+	test_when_finished sane_unset GIT_SKIP_TESTS &&
+	run_sub_test_lib_test git-skip-tests-sh-pattern \
 		'GIT_SKIP_TESTS sh pattern' <<-\\EOF &&
 	for i in 1 2 3 4 5 6
 	do
-- 
1.9.0
