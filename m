Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBFB81FEB3
	for <e@80x24.org>; Wed, 11 Jan 2017 11:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937470AbdAKLLB (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 06:11:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:37922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933927AbdAKLLA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 06:11:00 -0500
Received: (qmail 24098 invoked by uid 109); 11 Jan 2017 11:10:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 11:10:59 +0000
Received: (qmail 20892 invoked by uid 111); 11 Jan 2017 11:11:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 06:11:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2017 06:10:55 -0500
Date:   Wed, 11 Jan 2017 06:10:55 -0500
From:   Jeff King <peff@peff.net>
To:     "A. Wilcox" <awilfox@adelielinux.org>
Cc:     git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] t7810: avoid assumption about invalid regex syntax
Message-ID: <20170111111055.j3hgijpaabvy6kyg@sigill.intra.peff.net>
References: <20170111100400.vhd5ytarqpujigbn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170111100400.vhd5ytarqpujigbn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few of the tests want to check that "git grep -P -E" will
override -P with -E, and vice versa. To do so, we use a
regex with "\x{..}", which is valid in PCRE but not defined
by POSIX (for basic or extended regular expressions).

However, POSIX declares quite a lot of syntax, including
"\x", as "undefined". That leaves implementations free to
extend the standard if they choose. At least one, musl libc,
implements "\x" in the same way as PCRE.  Our tests check
that "-E" complains about "\x", which fails with musl.

We can fix this by finding some construct which behaves
reliably on both PCRE and POSIX, but differently in each
system.

One such construct is the use of backslash inside brackets.
In PCRE, "[\d]" interprets "\d" as it would outside the
brackets, matching a digit. Whereas in POSIX, the backslash
must be treated literally, and we match either it or a
literal "d".  Moreover, implementations are not free to
change this according to POSIX, so we should be able to rely
on it.

Signed-off-by: Jeff King <peff@peff.net>
---
I've tested this with glibc, but I wasn't able to do so with musl. The
two complications are:

  1. Recent versions of git won't build with musl's regex at all,
     because it doesn't support the non-standard REG_STARTEND that we
     rely on since b7d36ffca (regex: use regexec_buf(), 2016-09-21).

     So if applied on an older git, this patch should help, but newer
     versions need NO_REGEX (to use the fallback glibc regex code)
     either way, which would also make the problem go away.

     Still, I think it's the right thing to do, since we are relying on
     something that POSIX clearly leaves up to the implementation. It
     may also help on other systems, or if musl ends up supporting
     REG_STARTEND in the future.

  2. I tried to cherry-pick to v2.7.x and test it with musl. Debian
     ships with a "musl-gcc" wrapper, but it doesn't work out of the
     box. Both zlib and pcre are compiled against glibc, so I'd have to
     rebuild those, too. At which point I gave up and decided to just
     let you test it on your musl-based system. :)

 t/t7810-grep.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index de2405ccb..19f0108f8 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -39,6 +39,10 @@ test_expect_success setup '
 		echo "a+bc"
 		echo "abc"
 	} >ab &&
+	{
+		echo d &&
+		echo 0
+	} >d0 &&
 	echo vvv >v &&
 	echo ww w >w &&
 	echo x x xx x >x &&
@@ -1105,36 +1109,36 @@ test_expect_success 'grep pattern with grep.patternType=fixed, =basic, =extended
 '
 
 test_expect_success 'grep -G -F -P -E pattern' '
-	>empty &&
-	test_must_fail git grep -G -F -P -E "a\x{2b}b\x{2a}c" ab >actual &&
-	test_cmp empty actual
+	echo "d0:d" >expected &&
+	git grep -G -F -P -E "[\d]" d0 >actual &&
+	test_cmp expected actual
 '
 
 test_expect_success 'grep pattern with grep.patternType=fixed, =basic, =perl, =extended' '
-	>empty &&
-	test_must_fail git \
+	echo "d0:d" >expected &&
+	git \
 		-c grep.patterntype=fixed \
 		-c grep.patterntype=basic \
 		-c grep.patterntype=perl \
 		-c grep.patterntype=extended \
-		grep "a\x{2b}b\x{2a}c" ab >actual &&
-	test_cmp empty actual
+		grep "[\d]" d0 >actual &&
+	test_cmp expected actual
 '
 
 test_expect_success LIBPCRE 'grep -G -F -E -P pattern' '
-	echo "ab:a+b*c" >expected &&
-	git grep -G -F -E -P "a\x{2b}b\x{2a}c" ab >actual &&
+	echo "d0:0" >expected &&
+	git grep -G -F -E -P "[\d]" d0 >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success LIBPCRE 'grep pattern with grep.patternType=fixed, =basic, =extended, =perl' '
-	echo "ab:a+b*c" >expected &&
+	echo "d0:0" >expected &&
 	git \
 		-c grep.patterntype=fixed \
 		-c grep.patterntype=basic \
 		-c grep.patterntype=extended \
 		-c grep.patterntype=perl \
-		grep "a\x{2b}b\x{2a}c" ab >actual &&
+		grep "[\d]" d0 >actual &&
 	test_cmp expected actual
 '
 
-- 
2.11.0.627.gfa6151259
