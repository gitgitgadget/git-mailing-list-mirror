From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Wed, 19 Dec 2007 16:21:30 -0800
Message-ID: <7vy7bqrzat.fsf@gitster.siamese.dyndns.org>
References: <20071215155150.GA24810@coredump.intra.peff.net>
	<7vprx7n90t.fsf@gitster.siamese.dyndns.org>
	<20071215200202.GA3334@sigill.intra.peff.net>
	<20071216070614.GA5072@sigill.intra.peff.net>
	<7v8x3ul927.fsf@gitster.siamese.dyndns.org>
	<7v7ijejq6j.fsf@gitster.siamese.dyndns.org>
	<20071216212104.GA32307@coredump.intra.peff.net>
	<7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org>
	<20071219141845.GA2146@hashpling.org>
	<20071219142715.GB14187@coredump.intra.peff.net>
	<20071219143712.GA3483@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 01:22:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J59B3-0006BI-7z
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 01:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbXLTAVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 19:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbXLTAVx
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 19:21:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbXLTAVw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 19:21:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B7A08A7F;
	Wed, 19 Dec 2007 19:21:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BAD3C8A7D;
	Wed, 19 Dec 2007 19:21:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68962>

Charles Bailey <charles@hashpling.org> writes:

> On Wed, Dec 19, 2007 at 09:27:15AM -0500, Jeff King wrote:
> ...
>> Somebody beat you to it. :) Can you confirm that the fix in
>> 
>>   <1198007158-27576-1-git-send-email-win@wincent.com>
>> 
>> works for you?
>
> Ooh, the excitement, I've never had the opportunity to "git am"
> before.

Well, if Wincent had sent the patch as plain text without MIME
quoted-printable, you did not have to even have the excitement of
running "git am", but a simple "git apply" would have sufficed.

    ...
    How about the following? This swaps in perl in place of sed, which we c=
    an
    hopefully rely upon to work across platforms.

    Cheers,
    Wincent

    -------- 8< --------
    =46ix tests for broken sed on Leopard

    The newly-added common-tail-optimization test fails on Leopard because
    the broken sed implementation bails with a spurious "unterminated
    substitute pattern" error because of the length of one of the
    arguments.

Just for future reference, I do not mind avoiding "top-post" style patch
using "-- >8 --" cut markers, but do not have three or more dashes in
the cut marker.  "mailinfo" will split the message at that line and the
portion intended as the proposed commit log message will be taken as
part of garbage in front of the patch.  Using "-- >8 --" (two dashes,
space, scissors, ...) keeps both the front matter and the log text
together so that "am -i" or "commit --amend" can work on both parts.


By the way, how does this rewrite look?

-- >8 --
t4024: fix test script to use simpler sed pattern

The earlier test stripped away expected number of 'z' but the output
would have been very hard to read once somebody broke the common tail
optimization.  Instead, count the number of 'z' and show it, to help
diagnosing the problem better in the future.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 t/t4024-diff-optimize-common.sh |  158 ++++++++++++++++++++++++++++++---------
 1 files changed, 123 insertions(+), 35 deletions(-)

diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index 20fe87b..3c66102 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -10,58 +10,146 @@ z="$z$z$z$z$z$z$z$z" ;# 512
 z="$z$z$z$z" ;# 2048
 z2047=$(expr "$z" : '.\(.*\)') ; #2047
 
-test_expect_success setup '
-
-	echo "a$z2047" >file-a &&
-	echo "b" >file-b &&
-	echo "$z2047" >>file-b &&
-	echo "c$z2047" | tr -d "\012" >file-c &&
-	echo "d" >file-d &&
-	echo "$z2047" | tr -d "\012" >>file-d &&
+x=zzzzzzzzzz			;# 10
+y="$x$x$x$x$x$x$x$x$x$x"	;# 100
+z="$y$y$y$y$y$y$y$y$y$y"	;# 1000
+z1000=$z
+z100=$y
+z10=$x
 
-	git add file-a file-b file-c file-d &&
+zs() {
+	count="$1"
+	while test "$count" -ge 1000
+	do
+		count=$(($count - 1000))
+		printf "%s" $z1000
+	done
+	while test "$count" -ge 100
+	do
+		count=$(($count - 100))
+		printf "%s" $z100
+	done
+	while test "$count" -ge 10
+	do
+		count=$(($count - 10))
+		printf "%s" $z10
+	done
+	while test "$count" -ge 1
+	do
+		count=$(($count - 1))
+		printf "z"
+	done
+}
 
-	echo "A$z2047" >file-a &&
-	echo "B" >file-b &&
-	echo "$z2047" >>file-b &&
-	echo "C$z2047" | tr -d "\012" >file-c &&
-	echo "D" >file-d &&
-	echo "$z2047" | tr -d "\012" >>file-d
-
-'
+zc () {
+	sed -e "/^index/d" \
+		-e "s/$z1000/Q/g" \
+		-e "s/QQQQQQQQQ/Z9000/g" \
+		-e "s/QQQQQQQQ/Z8000/g" \
+		-e "s/QQQQQQQ/Z7000/g" \
+		-e "s/QQQQQQ/Z6000/g" \
+		-e "s/QQQQQ/Z5000/g" \
+		-e "s/QQQQ/Z4000/g" \
+		-e "s/QQQ/Z3000/g" \
+		-e "s/QQ/Z2000/g" \
+		-e "s/Q/Z1000/g" \
+		-e "s/$z100/Q/g" \
+		-e "s/QQQQQQQQQ/Z900/g" \
+		-e "s/QQQQQQQQ/Z800/g" \
+		-e "s/QQQQQQQ/Z700/g" \
+		-e "s/QQQQQQ/Z600/g" \
+		-e "s/QQQQQ/Z500/g" \
+		-e "s/QQQQ/Z400/g" \
+		-e "s/QQQ/Z300/g" \
+		-e "s/QQ/Z200/g" \
+		-e "s/Q/Z100/g" \
+		-e "s/000Z//g" \
+		-e "s/$z10/Q/g" \
+		-e "s/QQQQQQQQQ/Z90/g" \
+		-e "s/QQQQQQQQ/Z80/g" \
+		-e "s/QQQQQQQ/Z70/g" \
+		-e "s/QQQQQQ/Z60/g" \
+		-e "s/QQQQQ/Z50/g" \
+		-e "s/QQQQ/Z40/g" \
+		-e "s/QQQ/Z30/g" \
+		-e "s/QQ/Z20/g" \
+		-e "s/Q/Z10/g" \
+		-e "s/00Z//g" \
+		-e "s/z/Q/g" \
+		-e "s/QQQQQQQQQ/Z9/g" \
+		-e "s/QQQQQQQQ/Z8/g" \
+		-e "s/QQQQQQQ/Z7/g" \
+		-e "s/QQQQQQ/Z6/g" \
+		-e "s/QQQQQ/Z5/g" \
+		-e "s/QQQQ/Z4/g" \
+		-e "s/QQQ/Z3/g" \
+		-e "s/QQ/Z2/g" \
+		-e "s/Q/Z1/g" \
+		-e "s/0Z//g" \
+	;
+}
 
-cat >expect <<\EOF
-diff --git a/file-a b/file-a
---- a/file-a
-+++ b/file-a
+expect_pattern () {
+	cnt="$1"
+	cat <<EOF
+diff --git a/file-a$cnt b/file-a$cnt
+--- a/file-a$cnt
++++ b/file-a$cnt
 @@ -1 +1 @@
--aZ
-+AZ
-diff --git a/file-b b/file-b
---- a/file-b
-+++ b/file-b
+-Z${cnt}a
++Z${cnt}A
+diff --git a/file-b$cnt b/file-b$cnt
+--- a/file-b$cnt
++++ b/file-b$cnt
 @@ -1 +1 @@
 -b
 +B
-diff --git a/file-c b/file-c
---- a/file-c
-+++ b/file-c
+diff --git a/file-c$cnt b/file-c$cnt
+--- a/file-c$cnt
++++ b/file-c$cnt
 @@ -1 +1 @@
--cZ
+-cZ$cnt
 \ No newline at end of file
-+CZ
++CZ$cnt
 \ No newline at end of file
-diff --git a/file-d b/file-d
---- a/file-d
-+++ b/file-d
+diff --git a/file-d$cnt b/file-d$cnt
+--- a/file-d$cnt
++++ b/file-d$cnt
 @@ -1 +1 @@
 -d
 +D
 EOF
+}
+
+sample='1023 1024 1025 2047 4095'
+
+test_expect_success setup '
+
+	for n in $sample
+	do
+		( zs $n ; echo a ) >file-a$n &&
+		( echo b; zs $n; echo ) >file-b$n &&
+		( printf c; zs $n ) >file-c$n &&
+		( echo d; zs $n ) >file-d$n &&
+
+		git add file-a$n file-b$n file-c$n file-d$n &&
+
+		( zs $n ; echo A ) >file-a$n &&
+		( echo B; zs $n; echo ) >file-b$n &&
+		( printf C; zs $n ) >file-c$n &&
+		( echo D; zs $n ) >file-d$n &&
+
+		expect_pattern $n || break
+
+	done >expect
+'
 
 test_expect_success 'diff -U0' '
 
-	git diff -U0 | sed -e "/^index/d" -e "s/$z2047/Z/g" >actual &&
+	for n in $sample
+	do
+		git diff -U0 file-?$n
+	done | zc >actual &&
 	diff -u expect actual
 
 '
