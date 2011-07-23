From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH] tests: print failed test numbers at the end of the test
 run
Date: Sat, 23 Jul 2011 21:16:02 +0200
Message-ID: <4E2B1DF2.4000003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 21:16:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkhgS-0005mX-N5
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 21:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab1GWTQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 15:16:07 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39484 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab1GWTQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 15:16:05 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id 38ADC19444E72;
	Sat, 23 Jul 2011 21:16:03 +0200 (CEST)
Received: from [93.246.62.195] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QkhgB-000662-00; Sat, 23 Jul 2011 21:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/5ul5NEntDekMn6O4X6ZzW8kOgzKcop5TLv9Hp
	lRbEMKd8VkGJyHKHOBTcFS0q2VxZ4SA54MhaVEvPm3LVxG5Vp8
	LD1XMhOrbrPqf1b2smaQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177702>

On modern multi-core processors "make test" is often run in multiple jobs.
If one of them fails the test run does stop, but the concurrently running
tests finish their run. Finding out what test is broken involves a lot of
scrolling. That gets even worse when the -i option is used.

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

Maybe I'm missing something completely obvious, but I always have a hard
time finding out which test scripts did fail in a test run with -j30.

 t/aggregate-results.sh |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
index d206b7c..b8e929a 100755
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
+				testnum=$(echo $file | cut -b 14-18)
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
1.7.6.346.g750efc
