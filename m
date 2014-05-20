From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH/RFC] t0000-*.sh: Fix the GIT_SKIP_TESTS sub-tests
Date: Wed, 21 May 2014 00:33:46 +0100
Message-ID: <537BE65A.5040009@ramsay1.demon.co.uk>
References: <537BC8A2.9060009@ramsay1.demon.co.uk> <20140520214006.GT12314@google.com> <537BD514.4040708@ramsay1.demon.co.uk> <20140520224427.GU12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Ilya Bobyr <ilya.bobyr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 01:33:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmtXg-0001jf-Ai
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 01:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbaETXdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 19:33:52 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:32776 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750721AbaETXdw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 19:33:52 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 68817128081;
	Wed, 21 May 2014 00:33:57 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 1197E12807A;
	Wed, 21 May 2014 00:33:57 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Wed, 21 May 2014 00:33:55 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140520224427.GU12314@google.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249761>

On 20/05/14 23:44, Jonathan Nieder wrote:
> Hi,
> 
> Ramsay Jones wrote:
>> On 20/05/14 22:40, Jonathan Nieder wrote:
> 
>>> What should happen if I have set GIT_SKIP_TESTS explicitly to run
>>> only some of the tests in t0000-basic?
>>
>> A quick test (with the above patch applied) shows that
>> it works as I would expect:
>>
>>   $  GIT_SKIP_TESTS=t0000.1[2-6] ./t0000-basic.sh
>>   ...
>>   ok 11 - test --verbose
>>   ok 12 # skip test --verbose-only (GIT_SKIP_TESTS)
>>   ok 13 # skip GIT_SKIP_TESTS (GIT_SKIP_TESTS)
>>   ok 14 # skip GIT_SKIP_TESTS several tests (GIT_SKIP_TESTS)
>>   ok 15 # skip GIT_SKIP_TESTS sh pattern (GIT_SKIP_TESTS)
>>   ok 16 # skip --run basic (GIT_SKIP_TESTS)
>>   ok 17 - --run with a range
> 
> Try GIT_SKIP_TESTS=t0000.17 ./t0000-basic.sh:
> 
>  ok 13 - GIT_SKIP_TESTS
>  ok 14 - GIT_SKIP_TESTS several tests
>  ok 15 - GIT_SKIP_TESTS sh pattern
>  ok 16 - --run basic
>  ok 17 - --run with a range

Ah, yes. So my original patch was the better patch. :-P

That patch is given below; 'git diff -w' makes it easier
to see. However, given that this is still in pu on the
'ib/test-selectively-run' branch, hopefully Ilya can
simply squash this into a re-roll of his patches.

ATB,
Ramsay Jones

-- >8 --
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t0000-*.sh: Fix the GIT_SKIP_TESTS sub-tests

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t0000-basic.sh | 108 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 57 insertions(+), 51 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 8345c8a..f10ba4a 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -296,66 +296,72 @@ test_expect_success 'test --verbose-only' '
 '
 
 test_expect_success 'GIT_SKIP_TESTS' "
-	GIT_SKIP_TESTS='git.2' \
+	(
+		GIT_SKIP_TESTS='git.2' && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-basic \
-		'GIT_SKIP_TESTS' <<-\\EOF &&
-	for i in 1 2 3
-	do
-		test_expect_success \"passing test #\$i\" 'true'
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test git-skip-tests-basic <<-\\EOF
-	> ok 1 - passing test #1
-	> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
-	> ok 3 - passing test #3
-	> # passed all 3 test(s)
-	> 1..3
-	EOF
+			'GIT_SKIP_TESTS' <<-\\EOF &&
+		for i in 1 2 3
+		do
+			test_expect_success \"passing test #\$i\" 'true'
+		done
+		test_done
+		EOF
+		check_sub_test_lib_test git-skip-tests-basic <<-\\EOF
+		> ok 1 - passing test #1
+		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
+		> ok 3 - passing test #3
+		> # passed all 3 test(s)
+		> 1..3
+		EOF
+	)
 "
 
 test_expect_success 'GIT_SKIP_TESTS several tests' "
-	GIT_SKIP_TESTS='git.2 git.5' \
+	(
+		GIT_SKIP_TESTS='git.2 git.5' && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-several \
-		'GIT_SKIP_TESTS several tests' <<-\\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success \"passing test #\$i\" 'true'
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test git-skip-tests-several <<-\\EOF
-	> ok 1 - passing test #1
-	> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
-	> ok 3 - passing test #3
-	> ok 4 - passing test #4
-	> ok 5 # skip passing test #5 (GIT_SKIP_TESTS)
-	> ok 6 - passing test #6
-	> # passed all 6 test(s)
-	> 1..6
-	EOF
+			'GIT_SKIP_TESTS several tests' <<-\\EOF &&
+		for i in 1 2 3 4 5 6
+		do
+			test_expect_success \"passing test #\$i\" 'true'
+		done
+		test_done
+		EOF
+		check_sub_test_lib_test git-skip-tests-several <<-\\EOF
+		> ok 1 - passing test #1
+		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
+		> ok 3 - passing test #3
+		> ok 4 - passing test #4
+		> ok 5 # skip passing test #5 (GIT_SKIP_TESTS)
+		> ok 6 - passing test #6
+		> # passed all 6 test(s)
+		> 1..6
+		EOF
+	)
 "
 
 test_expect_success 'GIT_SKIP_TESTS sh pattern' "
-	GIT_SKIP_TESTS='git.[2-5]' \
+	(
+		GIT_SKIP_TESTS='git.[2-5]' && export GIT_SKIP_TESTS &&
 		run_sub_test_lib_test git-skip-tests-sh-pattern \
-		'GIT_SKIP_TESTS sh pattern' <<-\\EOF &&
-	for i in 1 2 3 4 5 6
-	do
-		test_expect_success \"passing test #\$i\" 'true'
-	done
-	test_done
-	EOF
-	check_sub_test_lib_test git-skip-tests-sh-pattern <<-\\EOF
-	> ok 1 - passing test #1
-	> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
-	> ok 3 # skip passing test #3 (GIT_SKIP_TESTS)
-	> ok 4 # skip passing test #4 (GIT_SKIP_TESTS)
-	> ok 5 # skip passing test #5 (GIT_SKIP_TESTS)
-	> ok 6 - passing test #6
-	> # passed all 6 test(s)
-	> 1..6
-	EOF
+			'GIT_SKIP_TESTS sh pattern' <<-\\EOF &&
+		for i in 1 2 3 4 5 6
+		do
+			test_expect_success \"passing test #\$i\" 'true'
+		done
+		test_done
+		EOF
+		check_sub_test_lib_test git-skip-tests-sh-pattern <<-\\EOF
+		> ok 1 - passing test #1
+		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
+		> ok 3 # skip passing test #3 (GIT_SKIP_TESTS)
+		> ok 4 # skip passing test #4 (GIT_SKIP_TESTS)
+		> ok 5 # skip passing test #5 (GIT_SKIP_TESTS)
+		> ok 6 - passing test #6
+		> # passed all 6 test(s)
+		> 1..6
+		EOF
+	)
 "
 
 test_expect_success '--run basic' "
-- 
1.9.0
