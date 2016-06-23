Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A7B1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 23:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbcFWXbU (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 19:31:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:59455 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287AbcFWXbU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 19:31:20 -0400
Received: (qmail 12739 invoked by uid 102); 23 Jun 2016 23:31:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 19:31:19 -0400
Received: (qmail 16056 invoked by uid 107); 23 Jun 2016 23:31:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 19:31:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 19:31:15 -0400
Date:	Thu, 23 Jun 2016 19:31:15 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 1/4] t5000: test tar files that overflow ustar headers
Message-ID: <20160623233114.GA5605@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232041.GA3668@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623232041.GA3668@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 07:20:44PM -0400, Jeff King wrote:

> I'm still not excited about the 64MB write, just because it's awfully
> heavyweight for such a trivial test. It runs pretty fast on my RAM disk,
> but maybe not on other people's system.
> 
> I considered but didn't explore two other options:
> 
>   1. I couldn't convince zlib to write a smaller file (this is done with
>      core.compression=9). But I'm not sure if that's inherent to the
>      on-disk format, or simply the maximum size of a deflate block.
> 
>      So it's possible that one could hand-roll zlib data that says "I'm
>      64GB" but is only a few bytes long.
> 
>   2. We don't ever want to see the whole 64GB, of course; we want to
>      stream it out and only care about the header (as an aside, this
>      makes a wonderful test that we are hitting the streaming code path,
>      as it's unlikely to work without it :) ).
> 
>      So another option would be to include a truncated file that claims
>      to be 64GB, and has only the first 256kb or something worth of data
>      (which should deflate down to almost nothing).
> 
>      git-fsck wouldn't work, of course, but we don't need to run it.
>      Other bits of git might complain, but our plan is for git to get
>      SIGPIPE before hitting that point anyway.
> 
>      So that seems pretty easy, but it is potentially flaky.

Writing that convinced me that (2) is actually quite a sane way to go.
The patch is below, which seems to work.

I arbitrarily picked the first 2048 bytes of the loose object. That's
1/32768 of the original. If we assume the compression ratio is stable
through the file (and it should be; the file is all zeroes), that should
generate 2MB of data should we need it (way more than we feed to our
"head -c" invocation).

This patch is on top of the whole series just to illustrate it. Doing it
for real will involve squashing it into the first patch (and adjusting
the commit message), and then handling the minor rebase conflicts. I'll
hold off on a re-roll until I get any comments on v3.

-Peff

---
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 07e0bdc..e542938 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -339,19 +339,12 @@ test_lazy_prereq TAR_HUGE '
 	test_cmp expect actual
 '
 
-# Likewise, we need bunzip for the 64GB git object.
-test_lazy_prereq BUNZIP '
-	bunzip2 --version
-'
-
-test_expect_success BUNZIP 'set up repository with huge blob' '
+test_expect_success 'set up repository with huge blob' '
 	obj_d=19 &&
 	obj_f=f9c8273ec45a8938e6999cb59b3ff66739902a &&
 	obj=${obj_d}${obj_f} &&
 	mkdir -p .git/objects/$obj_d &&
-	bunzip2 -c \
-		<"$TEST_DIRECTORY"/t5000/$obj.bz2 \
-		>.git/objects/$obj_d/$obj_f &&
+	cp "$TEST_DIRECTORY"/t5000/$obj .git/objects/$obj_d/$obj_f &&
 	rm -f .git/index &&
 	git update-index --add --cacheinfo 100644,$obj,huge &&
 	git commit -m huge
@@ -359,7 +352,7 @@ test_expect_success BUNZIP 'set up repository with huge blob' '
 
 # We expect git to die with SIGPIPE here (otherwise we
 # would generate the whole 64GB).
-test_expect_success BUNZIP 'generate tar with huge size' '
+test_expect_success 'generate tar with huge size' '
 	{
 		git archive HEAD
 		echo $? >exit-code
@@ -368,7 +361,7 @@ test_expect_success BUNZIP 'generate tar with huge size' '
 	test_cmp expect exit-code
 '
 
-test_expect_success BUNZIP,TAR_HUGE 'system tar can read our huge size' '
+test_expect_success TAR_HUGE 'system tar can read our huge size' '
 	echo 68719476737 >expect &&
 	tar_info huge.tar | cut -d" " -f1 >actual &&
 	test_cmp expect actual
diff --git a/t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a b/t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a
new file mode 100644
index 0000000000000000000000000000000000000000..5cbe9ec312bfd7b7e0398ca281e9d42848743704
GIT binary patch
literal 2048
zcmb=p_2!@<FM|RPgTa!7MhCMEn`g89mv_5$t@dj2a|><dbTfugFd71*Aut*OqaiRF
L0;3@?%t8PFWtt9Z

literal 0
HcmV?d00001

diff --git a/t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a.bz2 b/t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a.bz2
deleted file mode 100644
index 9619fd3c5f6f345a40aba1b91807bb4d937fc51c..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 578
zcmV-I0=@l0T4*^jL0KkKS$mI#Bmk}@egE{{00qbxVL(9uNQgj6FakgbL{P{8umA%P
z1cU%-zyaKJ3Zno3&;S`U000^T007Vc88iR@8UZy`L7)Mk0iXZ?8a+UzR8!JvwH}iK
zXvkv}!$8#Dpwk&jhdD}y=}Ly#N{6=5N`@-9@zf#~Y}ml6A5xVKIEqv?6sUZ+ic~-0
z3bD}&yn;flel6M|SGh`t%>^nMd9)O$Wu&Noa%<D9r9(fbH_W9&qsPxi@k)lGl@5I+
zDj0prR6BE&sCksAbrh&!tffP{F-nI-prpRlLJ+$#Qc)DvQlXBLp@B+<1u7d*3ZhIX
zg<RA^t&a>SgnP<VG8CwK>ira`Ve7_Hm1V`0kgE@zR6?%0tYir&brh(3dz7ebDNy(^
zL0KkKS?}&rK>-rd{r~jXFbzl$fdD`NU<g16aRNX9Kv2K{umFG%1O@;pzyY`b3;;A}
zXu>jRG-;qPzyn5xj3Xw4Mw$Zz)lx%14F-mTL6atf)Gz?ip`!@NpwXs)%#?y?q!Xf$
zP8vZs=>+{8*(#7u93>!3K5|fsT$F-(VMr#rK{}}f`lJ&zAez-6nY%u7(h0VZPg+4e
zX$0a(CY`i`W~3AAPBemQq!ZGRP7dlpJ?RA1nvhKtf@|4GCaOU@$`MOSl~R?f3Ia)6
zDFpYV6Llb)sRYUuLMe6QNGF9Ln9>Q3G=gtZ37;(>om7H;BohijH-{QkNGI(epUDKq
QkWcY<BvXY60gn}ckTCG&H~;_u

