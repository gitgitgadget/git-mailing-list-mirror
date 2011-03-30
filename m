From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC svn-fe] tests: introduce helper to fill a pipe in the
 background
Date: Wed, 30 Mar 2011 03:16:43 -0500
Message-ID: <20110330081643.GD2793@elie>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
 <20110330001653.GA1161@sigill.intra.peff.net>
 <20110330002921.GC14578@elie>
 <20110330033017.GA18157@sigill.intra.peff.net>
 <20110330035733.GA2793@elie>
 <20110330041339.GA26281@sigill.intra.peff.net>
 <4D92D3A8.3090301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, David Barr <david.barr@cordelta.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 10:16:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4qaH-00005X-Ai
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 10:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab1C3IQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 04:16:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43381 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab1C3IQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 04:16:49 -0400
Received: by iwn34 with SMTP id 34so999252iwn.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=04+pVDC1DmnkjS8FAX996/JPBxyTUKkEZAhkagk3i5o=;
        b=gLAVsj7uZ9ayis8PAxPKVcICOwbmu7hT0W71M7hj2VFtw/nwPb8GLsFZq+aW8TE2/w
         DmHnD/wSFBZ2UIdxSBc0jU28aD5nIQOBX0wUVd7thcMenAI7CTD5MOB14LhWzCN868Cs
         brqF2YypPXKa8t0jVSaxu7PkyDuY2/JFPz5uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iKWrb/khF5okT53gOBv9+wAliZ5xKFcyUky3cxh6MiHR4cfZL+UwOg2zBLtR2p9Ols
         pYD55E/8VL71x4q9hI03FmW39ctTmsdLVA0sbi9dsmc6FUf1F1/yiJ56Gz6tRkH0UOxK
         yuWHGap/21gdtT6bJU3IRmlF5GPLjeyzkWqMo=
Received: by 10.43.60.71 with SMTP id wr7mr858129icb.148.1301473008566;
        Wed, 30 Mar 2011 01:16:48 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.sbcglobal.net [68.255.107.98])
        by mx.google.com with ESMTPS id s1sm4211218iba.41.2011.03.30.01.16.46
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 01:16:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D92D3A8.3090301@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170363>

The fill_input function generates a fifo and runs a command to write
to it and wait.  The intended use is to check that specialized
programs can find the end of their input without reading too much or
relying on EOF or SIGPIPE.  For example:

	fill_input "echo hi" &&
	head -1 input

will succeed, while

	fill_input "echo hi" &&
	head -2 input

will hang.

It works by running the indicated commands followed by
"exec sleep 100" in a background process; the process ID is later
passed to "kill" to avoid leaving behind random processes.

Several tests already did something like that but this adds some
improvements:

  1. Wrap the "kill" in a test_when_finished, since we want
     to clean up the process whether the test succeeds or not.

  2. Mark the kill as OK to fail.  These tests are not about
     whether the input generating function dies due to SIGPIPE
     or the system is slow enough for the timer to expire early
     but about what happens on the downstream end.

  3. Mark the relevant tests with the EXECKEEPSPID prerequisite.

Based-on-patch-by: Jeff King <peff@peff.net>
Improved-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Johannes Sixt wrote:

> Note that tests that depend on ( exec ... ) & kill $! must be marked with
> the EXECKEEPSPID prerequisite.

Hmm, that's a shame, since the point of writing t0081 was to make sure
some assumptions the line-buffer lib makes are valid on Windows.  So I
suspect a better thing to do would be to remove t0081 --- the
line-buffer lib is simple, everyday use exercises it pretty well
already, and I can't imagine this script catching a bug.

 t/t0081-line-buffer.sh |   61 ++++++++++++++++++++++--------------------------
 1 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 5067d1e..fb09ff1 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -14,6 +14,25 @@ correctly.
 
 test -n "$GIT_REMOTE_SVN_TEST_BIG_FILES" && test_set_prereq EXPENSIVE
 
+fill_input () {
+	if
+		! test_declared_prereq PIPE ||
+		! test_declared_prereq EXECKEEPSPID
+	then
+		echo >&4 "fill_input requires PIPE,EXECKEEPSPID prerequisites"
+		return 127
+	fi &&
+	rm -f input &&
+	mkfifo input &&
+	{
+		(
+			eval "$*" &&
+			exec sleep 100
+		) >input &
+	} &&
+	test_when_finished "kill $!"
+}
+
 generate_tens_of_lines () {
 	tens=$1 &&
 	line=$2 &&
@@ -35,28 +54,15 @@ long_read_test () {
 	line=abcdefghi &&
 	echo "$line" >expect &&
 
-	if ! test_declared_prereq PIPE
-	then
-		echo >&4 "long_read_test: need to declare PIPE prerequisite"
-		return 127
-	fi &&
 	tens_of_lines=$(($1 / 100 + 1)) &&
 	lines=$(($tens_of_lines * 10)) &&
 	readsize=$((($lines - 1) * 10 + 3)) &&
 	copysize=7 &&
-	rm -f input &&
-	mkfifo input &&
-	{
-		(
-			generate_tens_of_lines $tens_of_lines "$line" &&
-			exec sleep 100
-		) >input &
-	} &&
+	fill_input "generate_tens_of_lines $tens_of_lines $line" &&
 	test-line-buffer input <<-EOF >output &&
 	binary $readsize
 	copy $copysize
 	EOF
-	kill $! &&
 	test_line_count = $lines output &&
 	tail -n 1 <output >actual &&
 	test_cmp expect actual
@@ -79,18 +85,13 @@ test_expect_success 'hello world' '
 	test_cmp expect actual
 '
 
-test_expect_success PIPE '0-length read, no input available' '
+test_expect_success PIPE,EXECKEEPSPID '0-length read, no input available' '
 	printf ">" >expect &&
-	rm -f input &&
-	mkfifo input &&
-	{
-		sleep 100 >input &
-	} &&
+	fill_input : &&
 	test-line-buffer input <<-\EOF >actual &&
 	binary 0
 	copy 0
 	EOF
-	kill $! &&
 	test_cmp expect actual
 '
 
@@ -104,26 +105,20 @@ test_expect_success '0-length read, send along greeting' '
 	test_cmp expect actual
 '
 
-test_expect_success PIPE '1-byte read, no input available' '
+test_expect_success PIPE,EXECKEEPSPID '1-byte read, no input available' '
 	printf ">%s" ab >expect &&
-	rm -f input &&
-	mkfifo input &&
-	{
-		(
-			printf "%s" a &&
-			printf "%s" b &&
-			exec sleep 100
-		) >input &
-	} &&
+	fill_input "
+		printf a &&
+		printf b
+	" &&
 	test-line-buffer input <<-\EOF >actual &&
 	binary 1
 	copy 1
 	EOF
-	kill $! &&
 	test_cmp expect actual
 '
 
-test_expect_success PIPE 'long read (around 8192 bytes)' '
+test_expect_success PIPE,EXECKEEPSPID 'long read (around 8192 bytes)' '
 	long_read_test 8192
 '
 
-- 
1.7.4.2
