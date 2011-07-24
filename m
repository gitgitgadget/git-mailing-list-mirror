From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] tests: print failed test numbers at the end of the test
 run
Date: Sun, 24 Jul 2011 15:35:54 +0200
Message-ID: <4E2C1FBA.3010606@web.de>
References: <4E2B1DF2.4000003@web.de> <7vmxg4w2fm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 15:41:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkyvn-00034g-4F
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 15:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab1GXNgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 09:36:00 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:49337 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1GXNf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 09:35:59 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 658AE19449430;
	Sun, 24 Jul 2011 15:35:57 +0200 (CEST)
Received: from [93.246.40.48] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qkyqb-00080T-00; Sun, 24 Jul 2011 15:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7vmxg4w2fm.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18JrvmLFAY0W20bTraT3Rd6a2SspwKAr8lXf2t5
	DTy2KPx6w3wsy6/LvSetb+WI/pcF5GSF2zq0YGzzjYxHUehOWe
	7FRiXt5OaB7AQDZj1eOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177747>

On modern multi-core processors "make test" is often run in multiple jobs.
If one of them fails the test run does stop, but the concurrently running
tests finish their run. It is rather easy to find out which test failed by
doing a "ls -d t/trash*". But that only works when you don't use the "-i"
option to "make test" because you want to get an overview of all failing
tests. In that case all thrash directories are deleted end and the
information which tests failed is lost.

If one or more tests failed, print a list of them before the test summary:

failed test(s): t1000 t6500

fixed   0
success 7638
failed  3
broken  49
total   7723

This makes it possible to just run the test suite with -i and collect all
failed test scripts at the end for further examination.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 24.07.2011 09:41, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Maybe I'm missing something completely obvious, but I always have a hard
>> time finding out which test scripts did fail in a test run with -j30.
> 
> I run "ls -d t/trash*" for that ;-)

Yup. But that won't work when you use "-i" to continue to run all tests
even when some fail, as all trash directories get deleted in the end. Or
did I manage to overlook an option which stops that? ;-)

I rephrased the commit message to make it clear my patch only changes the
behavior when "-i" is used and one or more tests fail, as the code in
question isn't executed otherwise.

>> +			if test $value != 0; then
>> +				testnum=$(echo $file | cut -b 14-18)
>> +				failed_tests="$failed_tests $testnum"
>> +			fi
> 
> Somehow "cut" here feels dirty, as it hardcodes a mysterious offset that
> cannot be guessed without knowing what string it is cutting from by
> looking at t/Makefile.
> 
> 	testnum=$(expr "$file" : 'test-results/\(t[0-9]*\)-')

Thanks, this version is using that expression.


 t/aggregate-results.sh |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
index d206b7c..60465fa 100755
--- a/t/aggregate-results.sh
+++ b/t/aggregate-results.sh
@@ -1,5 +1,6 @@
 #!/bin/sh

+failed_tests=
 fixed=0
 success=0
 failed=0
@@ -18,7 +19,12 @@ do
 		success)
 			success=$(($success + $value)) ;;
 		failed)
-			failed=$(($failed + $value)) ;;
+			failed=$(($failed + $value))
+			if test $value != 0; then
+				testnum=$(expr "$file" : 'test-results/\(t[0-9]*\)-')
+				failed_tests="$failed_tests $testnum"
+			fi
+			;;
 		broken)
 			broken=$(($broken + $value)) ;;
 		total)
@@ -27,6 +33,10 @@ do
 	done <"$file"
 done

+if [ -n "$failed_tests" ]; then
+	printf "\nfailed test(s):$failed_tests\n\n"
+fi
+
 printf "%-8s%d\n" fixed $fixed
 printf "%-8s%d\n" success $success
 printf "%-8s%d\n" failed $failed
-- 
1.7.6.346.g940def.dirty
