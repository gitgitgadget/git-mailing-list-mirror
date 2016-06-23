Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB151FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 23:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbcFWXUz (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 19:20:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:59421 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751827AbcFWXUy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 19:20:54 -0400
Received: (qmail 12250 invoked by uid 102); 23 Jun 2016 23:20:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 19:20:49 -0400
Received: (qmail 15903 invoked by uid 107); 23 Jun 2016 23:21:04 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 19:21:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 19:20:45 -0400
Date:	Thu, 23 Jun 2016 19:20:45 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH v3 1/4] t5000: test tar files that overflow ustar headers
Message-ID: <20160623232041.GA3668@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160623231512.GA27683@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The ustar format only has room for 11 (or 12, depending on
some implementations) octal digits for the size and mtime of
each file. After this, we have to add pax extended headers
to specify the real data, and git does not yet know how to
do so.

Before fixing that, let's start off with some test
infrastructure, as designing portable and efficient tests
for this is non-trivial.

We want to use the system tar to check our output (because
what we really care about is interoperability), but we can't
rely on it:

  1. being able to read pax headers

  2. being able to handle huge sizes or mtimes

  3. supporting a "t" format we can parse

So as a prerequisite, we can feed the system tar a reference
tarball to make sure it can handle these features. The
reference tar here was created with:

  dd if=/dev/zero seek=64G bs=1 count=1 of=huge
  touch -d @68719476737 huge
  tar cf - --format=pax |
  head -c 2048

using GNU tar. Note that this is not a complete tarfile, but
it's enough to contain the headers we want to examine.

Likewise, we need to convince git that it has a 64GB blob to
output. Running "git add" on that 64GB file takes many
minutes of CPU, and even compressed, the result is 64MB. So
again, I pre-generated that loose object, and then used
bzip2 on the result, which shrinks it to a few hundred
bytes.  Unfortunately, we do still inflate it to 64MB on
disk briefly while the test is running.

The tests are split so that we test as much as we can even
with an uncooperative system tar. This actually catches the
current breakage (which is that we die("BUG") trying to
write the ustar header) on every system, and then on systems
where we can, we go farther and actually verify the result.

Helped-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Jeff King <peff@peff.net>
---
I'm still not excited about the 64MB write, just because it's awfully
heavyweight for such a trivial test. It runs pretty fast on my RAM disk,
but maybe not on other people's system.

I considered but didn't explore two other options:

  1. I couldn't convince zlib to write a smaller file (this is done with
     core.compression=9). But I'm not sure if that's inherent to the
     on-disk format, or simply the maximum size of a deflate block.

     So it's possible that one could hand-roll zlib data that says "I'm
     64GB" but is only a few bytes long.

  2. We don't ever want to see the whole 64GB, of course; we want to
     stream it out and only care about the header (as an aside, this
     makes a wonderful test that we are hitting the streaming code path,
     as it's unlikely to work without it :) ).

     So another option would be to include a truncated file that claims
     to be 64GB, and has only the first 256kb or something worth of data
     (which should deflate down to almost nothing).

     git-fsck wouldn't work, of course, but we don't need to run it.
     Other bits of git might complain, but our plan is for git to get
     SIGPIPE before hitting that point anyway.

     So that seems pretty easy, but it is potentially flaky.

 t/t5000-tar-tree.sh                                |  73 +++++++++++++++++++++
 .../19f9c8273ec45a8938e6999cb59b3ff66739902a.bz2   | Bin 0 -> 578 bytes
 t/t5000/huge-and-future.tar                        | Bin 0 -> 2048 bytes
 3 files changed, 73 insertions(+)
 create mode 100644 t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a.bz2
 create mode 100644 t/t5000/huge-and-future.tar

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 4b68bba..e7c9271 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -319,4 +319,77 @@ test_expect_success 'catch non-matching pathspec' '
 	test_must_fail git archive -v HEAD -- "*.abc" >/dev/null
 '
 
+# See if our system tar can handle a tar file with huge sizes and dates far in
+# the future, and that we can actually parse its output.
+#
+# The reference file was generated by GNU tar, and the magic time and size are
+# both octal 01000000000001, which overflows normal ustar fields.
+#
+# When parsing, we'll pull out only the year from the date; that
+# avoids any question of timezones impacting the result. The output
+# of tar_info is expected to be "<size> <year>", both in decimal. It ignores
+# the return value of tar. We have to do this, because our reference file is
+# only a partial (the whole thing would be 64GB!).
+tar_info () {
+	"$TAR" tvf "$1" | awk '{print $3 " " $4}' | cut -d- -f1
+}
+test_lazy_prereq TAR_HUGE '
+	echo "68719476737 4147" >expect &&
+	tar_info "$TEST_DIRECTORY"/t5000/huge-and-future.tar >actual &&
+	test_cmp expect actual
+'
+
+# Likewise, we need bunzip for the 64GB git object.
+test_lazy_prereq BUNZIP '
+	bunzip2 --version
+'
+
+test_expect_success BUNZIP 'set up repository with huge blob' '
+	obj_d=19 &&
+	obj_f=f9c8273ec45a8938e6999cb59b3ff66739902a &&
+	obj=${obj_d}${obj_f} &&
+	mkdir -p .git/objects/$obj_d &&
+	bunzip2 -c \
+		<"$TEST_DIRECTORY"/t5000/$obj.bz2 \
+		>.git/objects/$obj_d/$obj_f &&
+	rm -f .git/index &&
+	git update-index --add --cacheinfo 100644,$obj,huge &&
+	git commit -m huge
+'
+
+# We expect git to die with SIGPIPE here (otherwise we
+# would generate the whole 64GB).
+test_expect_failure BUNZIP 'generate tar with huge size' '
+	{
+		git archive HEAD
+		echo $? >exit-code
+	} | head -c 4096 >huge.tar &&
+	echo 141 >expect &&
+	test_cmp expect exit-code
+'
+
+test_expect_failure BUNZIP,TAR_HUGE 'system tar can read our huge size' '
+	echo 68719476737 >expect &&
+	tar_info huge.tar | cut -d" " -f1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'set up repository with far-future commit' '
+	rm -f .git/index &&
+	echo content >file &&
+	git add file &&
+	GIT_COMMITTER_DATE="@68719476737 +0000" \
+		git commit -m "tempori parendum"
+'
+
+test_expect_failure 'generate tar with future mtime' '
+	git archive HEAD >future.tar
+'
+
+test_expect_failure TAR_HUGE 'tar can encode dates far in future' '
+	echo 4147 >expect &&
+	tar_info future.tar | cut -d" " -f2 >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a.bz2 b/t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a.bz2
new file mode 100644
index 0000000000000000000000000000000000000000..9619fd3c5f6f345a40aba1b91807bb4d937fc51c
GIT binary patch
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

literal 0
HcmV?d00001

diff --git a/t/t5000/huge-and-future.tar b/t/t5000/huge-and-future.tar
new file mode 100644
index 0000000000000000000000000000000000000000..63155e185585c7589b0db1d6da199bfa27f517c7
GIT binary patch
literal 2048
zcmeHH%L;=q5X{-H$QS6YCRsi7-eZ3uw6XOd6dxe{`X*^rs7fzVia3{DW=WVGG6|!T
z?v6%ZOjU;{l%nX?UJY9lV4;Lyu3CInz(g<_!2ppkX1rTd#L``D-RR0nTAFX1kAc_4
z!yHsfm<dvpP!J<8o1&bMdO{|^&z|%z2c<+6LM8=4Dk<2wb(>gk^{~&l;zIw<Ka%wM
q@2eX*^nb#uM^s?*|C3Di`M;YypV2;0-{yXeagpKN-s}$iu>((@uRaR^

literal 0
HcmV?d00001

-- 
2.9.0.217.g096ca68

