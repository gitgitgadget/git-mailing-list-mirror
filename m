From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Portability: returning void
Date: Tue, 29 Mar 2011 19:29:21 -0500
Message-ID: <20110330002921.GC14578@elie>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
 <20110330001653.GA1161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:29:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4jHw-00073M-Kx
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 02:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab1C3A32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 20:29:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41255 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1C3A31 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 20:29:27 -0400
Received: by gwaa18 with SMTP id a18so315494gwa.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+G27qUPWv8vXZV2iYO8lsWSA3AMwZpSEXvOu52QqBAM=;
        b=MdPffo0J/m/2EASxuMgbkBJ3JP/mbk/T3wW5LBOYEbinVPU4xLQystIR/t6on37qzd
         9Sd+PQSMFpf1cCfRzKzP3luRmaOzqUhks2AIUcbTC26t+hWBy7OZg5A5qKJgVYjN80j+
         h3RqIWkfpSjKXCXmtI6dJnyTYGIaOxDRXRm8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n09jHa2xC+1WS+1aKijfxwEaCvbanBu4MgNGbVCBI5KojtoOTUprjEaUH6DbUDMxFZ
         b6h7oKshFQs5nVa2aJpNtyWocA0pmms9W2s70O9tK+NaWERUYB1engRB/4i2LQsW64Oc
         OIxFQC8W3YD+wWO4GafsyO9B/lsBoXfu9nFnM=
Received: by 10.236.79.136 with SMTP id i8mr570198yhe.392.1301444966772;
        Tue, 29 Mar 2011 17:29:26 -0700 (PDT)
Received: from elie (adsl-68-255-111-103.dsl.chcgil.sbcglobal.net [68.255.111.103])
        by mx.google.com with ESMTPS id p3sm2745995yhp.89.2011.03.29.17.29.24
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 17:29:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110330001653.GA1161@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170343>

(-cc: Michael, to stop spamming a kind bug reporter :))
Jeff King wrote:
> On Tue, Mar 29, 2011 at 06:49:55PM -0500, Jonathan Nieder wrote:

>> | 19424 18:31:25 <... nanosleep resumed> NULL) = 0
>> | 19424 18:31:25 close(1)                 = 0
>> | 19424 18:31:25 close(2)                 = 0
>> | 19424 18:31:25 exit_group(0)            = ?
>> | 19422 18:31:25 <... wait4 resumed> 0x7fff65d1ee6c, 0, NULL) = ? ERESTARTSYS (To be restarted)
>> | 19422 18:31:25 --- SIGTERM (Terminated) @ 0 (0) ---
>> 
>> The first sleep wakes up and dies.  The corresponding subshell
>> wakes up, reaps the child, and finally accepts SIGTERM.
>
> Hrm. That's different than what happens on my system. On my system, the
> bash process is _already_ dead during the whole procedure, and it is
> just the stray sleeps that keep prove waiting.
>
> Maybe different bash versions? Mine is 4.1.5(1) (from debian unstable,
> bash_4.1-3).

$ dpkg-query -W perl bash
bash	4.1-3
perl	5.10.1-18

Same version here, but I had modified the test a little.  *tries the
stock version again*  Same behavior still.  FWIW I am using the patch
below[1] and invoking the tests as

	strace -f -o trace.out prove --exec=bash -v t0081-line-buffer.sh :: -v -i

> Did you try my 5>/dev/null patch? With it, I get no hang at all.

Haven't tried it yet but will try.

I really don't like that as a long-term solution.  Yes, it gets prove
to stop hanging, but meanwhile we have no control over the child
processes we have spawned.  I'd rather just drop the tests.
---
diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 1dbe1c9..054bffa 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -49,13 +49,14 @@ long_read_test () {
 	{
 		{
 			generate_tens_of_lines $tens_of_lines "$line" &&
-			sleep 100
+			sleep 15
 		} >input &
 	} &&
 	test-line-buffer input <<-EOF >output &&
 	binary $readsize
 	copy $copysize
 	EOF
+	pstree -p $! &&
 	kill $! &&
 	test_line_count = $lines output &&
 	tail -n 1 <output >actual &&
@@ -84,12 +85,13 @@ test_expect_success PIPE '0-length read, no input available' '
 	rm -f input &&
 	mkfifo input &&
 	{
-		sleep 100 >input &
+		sleep 15 >input &
 	} &&
 	test-line-buffer input <<-\EOF >actual &&
 	binary 0
 	copy 0
 	EOF
+	pstree -p $! &&
 	kill $! &&
 	test_cmp expect actual
 '
@@ -112,13 +114,14 @@ test_expect_success PIPE '1-byte read, no input available' '
 		{
 			printf "%s" a &&
 			printf "%s" b &&
-			sleep 100
+			sleep 15
 		} >input &
 	} &&
 	test-line-buffer input <<-\EOF >actual &&
 	binary 1
 	copy 1
 	EOF
+	pstree -p $! &&
 	kill $! &&
 	test_cmp expect actual
 '
-- 
