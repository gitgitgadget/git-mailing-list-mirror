From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Portability: returning void
Date: Tue, 29 Mar 2011 22:57:33 -0500
Message-ID: <20110330035733.GA2793@elie>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie>
 <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie>
 <20110330001653.GA1161@sigill.intra.peff.net>
 <20110330002921.GC14578@elie>
 <20110330033017.GA18157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 05:58:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4mYI-0005qu-MO
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 05:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab1C3D6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 23:58:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49359 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab1C3D6W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 23:58:22 -0400
Received: by yxs7 with SMTP id 7so369519yxs.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+5p5BpmAtFYDxIHWTpODzj16hVpK4967r+vGuN82W1M=;
        b=A6h0OyFB0AlGTL/2QYkep6o+RFzrtxCiAzNJLS504K3pfPe5lFNGZA7rG2Loq2HRNA
         YM98vQNm/zs6o1yFftcKBwk8njRhY7n2xCLstvSxv1w0wIcMHJuDZuuH/k66iz3Hobfk
         4gprN38DdhYkD2gD9dJqtIHosI5qfIyXAQpo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EXQ1LuE+JOn4MuGPIqpdhNnNz6mbdZYLMbBNvlr5OfCtKWaN+T+JWWaTcGXAEELxtM
         dQi6tyGMpR2ttAZyydQCR62CFoAyaJ5rD6fUB1rdl/+l0cGwNj7gX/OXPQuwOI5yRvYZ
         qLSjpXDu1cV4Z1VMZEVF6y7r8mUBHT9LDwcwA=
Received: by 10.150.11.5 with SMTP id 5mr1041115ybk.29.1301457500107;
        Tue, 29 Mar 2011 20:58:20 -0700 (PDT)
Received: from elie ([68.255.111.103])
        by mx.google.com with ESMTPS id q29sm5720391yba.2.2011.03.29.20.58.18
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 20:58:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110330033017.GA18157@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170352>

Jeff King wrote:

> While we're at it, let's make the "kill" process a little
> more robust. Specifically:
>
>   1. Wrap the "kill" in a test_when_finished, since we want
>      to clean up the process whether the test succeeds or not.
>
>   2. The "kill" is part of our && chain for test success. It
>      probably won't fail, but it can if the process has
>      expired before we manage to kill it. So let's mark it
>      as OK to fail.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Actually, my (2) above is unlikely to trigger, since the test would have
> to hang for 100 seconds first, which probably means it is failing
> anyway. But I did run across it when I screwed up my fix.

That is actually how the tests distinguish between success and
failure.  Any idea about a better way?

I was in the process of writing a commit message for the same "exec"
trick, but I'm glad you got to it first. ;-)

> Also, is it just me, or does it seem weird that test_when_finished
> blocks failing can produce test failure? I would think you would be able
> to put any old cleanup crap into them and not care whether it worked or
> not.

I'm generally happy that it catches mistakes in cleanup code, but I
could easily be convinced to change it anyway.

> --- a/t/t0081-line-buffer.sh
> +++ b/t/t0081-line-buffer.sh
> @@ -47,16 +47,16 @@ long_read_test () {
[...]
> +		) >input &
>  	} &&
> +	test_when_finished "kill $! || true" &&

The $! gets expanded when this is executed, so later background
processes won't interfere.  Good.

Maybe it would be good to factor out a helper to make future
improvements a little easier, like so:

-- 8< --
Subject: t0081: introduce helper to fill a pipe in the background

The fill_input function generates a fifo and runs a command to write
to it and wait a while.  The intended use is to test programs that
need to be able to cope with input of limited length without relying
on EOF or SIGPIPE to detect its end.

For example:

	fill_input "echo hi" &&
	head -1 input

will succeed, while

	fill_input "echo hi" &&
	head -2 input

will hang waiting for more input.

It works by running the indicated commands followed by
"exec sleep 100" in a background process and registering a clean-up
command to kill it and check if it was killed by SIGPIPE (good) or
ran to completion (bad).  This patch adds a definition for this
function and updates existing tests that used that trick to use it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The commit message assumes test_when_finished "kill $!", while the
patch uses "kill $! || :"; one of the two would need to be fixed
before applying this.

 t/t0081-line-buffer.sh |   51 +++++++++++++++++++----------------------------
 1 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 416ccc1..218da98 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -14,6 +14,21 @@ correctly.
 
 test -n "$GIT_REMOTE_SVN_TEST_BIG_FILES" && test_set_prereq EXPENSIVE
 
+fill_input () {
+	if ! test_declared_prereq PIPE
+	then
+		echo >&4 "fill_input: need to declare PIPE prerequisite"
+		return 127
+	fi &&
+	rm -f input &&
+	mkfifo input &&
+	(
+		eval "$*" &&
+		exec sleep 100
+	) >input &
+	test_when_finished "kill $! || true"
+}
+
 generate_tens_of_lines () {
 	tens=$1 &&
 	line=$2 &&
@@ -35,24 +50,11 @@ long_read_test () {
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
-	test_when_finished "kill $! || true" &&
+	fill_input "generate_tens_of_lines $tens_of_lines $line" &&
 	test-line-buffer input <<-EOF >output &&
 	binary $readsize
 	copy $copysize
@@ -81,12 +83,7 @@ test_expect_success 'hello world' '
 
 test_expect_success PIPE '0-length read, no input available' '
 	printf ">" >expect &&
-	rm -f input &&
-	mkfifo input &&
-	{
-		sleep 100 >input &
-	} &&
-	test_when_finished "kill $! || true" &&
+	fill_input : &&
 	test-line-buffer input <<-\EOF >actual &&
 	binary 0
 	copy 0
@@ -106,16 +103,10 @@ test_expect_success '0-length read, send along greeting' '
 
 test_expect_success PIPE '1-byte read, no input available' '
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
-	test_when_finished "kill $! || true" &&
+	fill_input "
+		printf a &&
+		printf b
+	" &&
 	test-line-buffer input <<-\EOF >actual &&
 	binary 1
 	copy 1
-- 
1.7.4.2
