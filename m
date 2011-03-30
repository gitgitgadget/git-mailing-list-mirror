From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Portability: returning void
Date: Wed, 30 Mar 2011 03:41:48 -0500
Message-ID: <20110330084148.GE2793@elie>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
 <20110330001653.GA1161@sigill.intra.peff.net>
 <20110330002921.GC14578@elie>
 <20110330033017.GA18157@sigill.intra.peff.net>
 <20110330035733.GA2793@elie>
 <20110330041339.GA26281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 10:42:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4qyX-0002i5-2c
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 10:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab1C3Il4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 04:41:56 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43944 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab1C3Ilx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 04:41:53 -0400
Received: by iyb14 with SMTP id 14so1004776iyb.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EJ7I4E76ZgW9oj3lqUFVpSC4sT4CBCCioXPKTy70Yao=;
        b=qBBBi4I+JAsrOZQpayoe9op6YGe+15qyxnelWsot0d0CExPwlBE7FftmwNrbz19aRw
         cqTkUiiO6OVSeJQPzYEsMeKFJ5MSPPey9q8DaVsuXvso+qdv8bKgMSCEfJpsuQcKeGjw
         J5ejtbRwCfRJ0Qi+DlGj4ZPTjXoyUg3GO3uKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PPQ6hKAdVshte4DwSEPo+EBwH3C+Lmd5+GBWTBVoPjimyOkp6j22kCx6rjso1yLovP
         o8uKXp3Li1UVv1/55rNs3r8jn6NaQj6NGi//AdIH/8vgTHa12moa6hmSf3D41R1nCNIY
         vTJrotcpnFN5P66ANDdfRbf2UqvM12/WPOD5I=
Received: by 10.231.186.85 with SMTP id cr21mr76523ibb.164.1301474512979;
        Wed, 30 Mar 2011 01:41:52 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.sbcglobal.net [68.255.107.98])
        by mx.google.com with ESMTPS id c1sm4233493ibe.66.2011.03.30.01.41.50
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 01:41:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110330041339.GA26281@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170365>

Jeff King wrote:

> Ah. I was trying not to look too hard at how the tests actually work, so
> I completely missed that. Yes, if the "kill" is part of the actual test,
> then it should stay in the test.

Heh, what was the person writing that test thinking?  Allowing the
kill to fail would be better --- some future test might have the
generate_lots_of_text part dying of SIGPIPE, which would make later
attempts to kill it fail.  Totally cryptic.

What are these tests make to check, anyway?

 - "0-length read, no input available" makes some sense.  It's checking
   that the platform fread can handle requests to read nothing (or that
   line-buffer works around it if some esoteric platform cannot).

 - "1-byte read, no input available" makes less sense.  I just can't
   see any reason for it to fail.  And it "tests" two functions at
   once, for crazy historical reasons.

 - "long read" checks that we can read something around the pipe size
   and not get totally confused.  I can imagine it failing but it
   wouldn't be git's fault.  It also doesn't seem like a useful test.

I don't think any of them is worth the fuss.  So how about this?

-- 8< --
Subject: Revert "t0081 (line-buffer): add buffering tests"

This (morally) reverts commit d280f68313eecb8b3838c70641a246382d5e5343,
which added some tests that are a pain to maintain and are not likely
to find bugs in git.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0081-line-buffer.sh |  106 +-----------------------------------------------
 1 files changed, 2 insertions(+), 104 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 5067d1e..bd83ed3 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -2,74 +2,14 @@
 
 test_description="Test the svn importer's input handling routines.
 
-These tests exercise the line_buffer library, but their real purpose
-is to check the assumptions that library makes of the platform's input
-routines.  Processes engaged in bi-directional communication would
-hang if fread or fgets is too greedy.
+These tests provide some simple checks that the line_buffer API
+behaves as advertised.
 
 While at it, check that input of newlines and null bytes are handled
 correctly.
 "
 . ./test-lib.sh
 
-test -n "$GIT_REMOTE_SVN_TEST_BIG_FILES" && test_set_prereq EXPENSIVE
-
-generate_tens_of_lines () {
-	tens=$1 &&
-	line=$2 &&
-
-	i=0 &&
-	while test $i -lt "$tens"
-	do
-		for j in a b c d e f g h i j
-		do
-			echo "$line"
-		done &&
-		: $((i = $i + 1)) ||
-		return
-	done
-}
-
-long_read_test () {
-	: each line is 10 bytes, including newline &&
-	line=abcdefghi &&
-	echo "$line" >expect &&
-
-	if ! test_declared_prereq PIPE
-	then
-		echo >&4 "long_read_test: need to declare PIPE prerequisite"
-		return 127
-	fi &&
-	tens_of_lines=$(($1 / 100 + 1)) &&
-	lines=$(($tens_of_lines * 10)) &&
-	readsize=$((($lines - 1) * 10 + 3)) &&
-	copysize=7 &&
-	rm -f input &&
-	mkfifo input &&
-	{
-		(
-			generate_tens_of_lines $tens_of_lines "$line" &&
-			exec sleep 100
-		) >input &
-	} &&
-	test-line-buffer input <<-EOF >output &&
-	binary $readsize
-	copy $copysize
-	EOF
-	kill $! &&
-	test_line_count = $lines output &&
-	tail -n 1 <output >actual &&
-	test_cmp expect actual
-}
-
-test_expect_success 'setup: have pipes?' '
-      rm -f frob &&
-      if mkfifo frob
-      then
-		test_set_prereq PIPE
-      fi
-'
-
 test_expect_success 'hello world' '
 	echo ">HELLO" >expect &&
 	test-line-buffer <<-\EOF >actual &&
@@ -79,21 +19,6 @@ test_expect_success 'hello world' '
 	test_cmp expect actual
 '
 
-test_expect_success PIPE '0-length read, no input available' '
-	printf ">" >expect &&
-	rm -f input &&
-	mkfifo input &&
-	{
-		sleep 100 >input &
-	} &&
-	test-line-buffer input <<-\EOF >actual &&
-	binary 0
-	copy 0
-	EOF
-	kill $! &&
-	test_cmp expect actual
-'
-
 test_expect_success '0-length read, send along greeting' '
 	echo ">HELLO" >expect &&
 	test-line-buffer <<-\EOF >actual &&
@@ -104,33 +29,6 @@ test_expect_success '0-length read, send along greeting' '
 	test_cmp expect actual
 '
 
-test_expect_success PIPE '1-byte read, no input available' '
-	printf ">%s" ab >expect &&
-	rm -f input &&
-	mkfifo input &&
-	{
-		(
-			printf "%s" a &&
-			printf "%s" b &&
-			exec sleep 100
-		) >input &
-	} &&
-	test-line-buffer input <<-\EOF >actual &&
-	binary 1
-	copy 1
-	EOF
-	kill $! &&
-	test_cmp expect actual
-'
-
-test_expect_success PIPE 'long read (around 8192 bytes)' '
-	long_read_test 8192
-'
-
-test_expect_success PIPE,EXPENSIVE 'longer read (around 65536 bytes)' '
-	long_read_test 65536
-'
-
 test_expect_success 'read from file descriptor' '
 	rm -f input &&
 	echo hello >expect &&
-- 
1.7.4.2.660.g270d4b.dirty
