Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874662018A
	for <e@80x24.org>; Thu, 30 Jun 2016 09:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbcF3JPo (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:15:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:38290 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751810AbcF3JPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:15:42 -0400
Received: (qmail 31596 invoked by uid 102); 30 Jun 2016 09:09:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:09:02 -0400
Received: (qmail 6651 invoked by uid 107); 30 Jun 2016 09:09:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:09:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 05:08:57 -0400
Date:	Thu, 30 Jun 2016 05:08:57 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
Message-ID: <20160630090857.GB17463@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160630090614.GA16725@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The ustar format only has room for 11 (or 12, depending on
some implementations) octal digits for the size and mtime of
each file. For values larger than this, we have to add pax
extended headers to specify the real data, and git does not
yet know how to do so.

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
again, I pre-generated that loose object, and then took only
the first 2k of it. That should be enough to generate 2MB of
data before hitting an inflate error, which is plenty for us
to generate the tar header (and then die of SIGPIPE while
streaming the rest out).

The tests are split so that we test as much as we can even
with an uncooperative system tar. This actually catches the
current breakage (which is that we die("BUG") trying to
write the ustar header) on every system, and then on systems
where we can, we go farther and actually verify the result.

Helped-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5000-tar-tree.sh                              |  74 +++++++++++++++++++++++
 t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a | Bin 0 -> 2048 bytes
 t/t5000/huge-and-future.tar                      | Bin 0 -> 2048 bytes
 3 files changed, 74 insertions(+)
 create mode 100644 t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a
 create mode 100644 t/t5000/huge-and-future.tar

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 4b68bba..950bdd3 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -319,4 +319,78 @@ test_expect_success 'catch non-matching pathspec' '
 	test_must_fail git archive -v HEAD -- "*.abc" >/dev/null
 '
 
+# Pull the size and date of each entry in a tarfile using the system tar.
+#
+# We'll pull out only the year from the date; that avoids any question of
+# timezones impacting the result (as long as we keep our test times away from a
+# year boundary; our reference times are all in August).
+#
+# The output of tar_info is expected to be "<size> <year>", both in decimal. It
+# ignores the return value of tar. We have to do this, because some of our test
+# input is only partial (the real data is 64GB in some cases).
+tar_info () {
+	"$TAR" tvf "$1" |
+	awk '{
+		split($4, date, "-")
+		print $3 " " date[1]
+	}'
+}
+
+# See if our system tar can handle a tar file with huge sizes and dates far in
+# the future, and that we can actually parse its output.
+#
+# The reference file was generated by GNU tar, and the magic time and size are
+# both octal 01000000000001, which overflows normal ustar fields.
+test_lazy_prereq TAR_HUGE '
+	echo "68719476737 4147" >expect &&
+	tar_info "$TEST_DIRECTORY"/t5000/huge-and-future.tar >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'set up repository with huge blob' '
+	obj_d=19 &&
+	obj_f=f9c8273ec45a8938e6999cb59b3ff66739902a &&
+	obj=${obj_d}${obj_f} &&
+	mkdir -p .git/objects/$obj_d &&
+	cp "$TEST_DIRECTORY"/t5000/$obj .git/objects/$obj_d/$obj_f &&
+	rm -f .git/index &&
+	git update-index --add --cacheinfo 100644,$obj,huge &&
+	git commit -m huge
+'
+
+# We expect git to die with SIGPIPE here (otherwise we
+# would generate the whole 64GB).
+test_expect_failure 'generate tar with huge size' '
+	{
+		git archive HEAD
+		echo $? >exit-code
+	} | test_copy_bytes 4096 >huge.tar &&
+	echo 141 >expect &&
+	test_cmp expect exit-code
+'
+
+test_expect_failure TAR_HUGE 'system tar can read our huge size' '
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
+test_expect_failure TAR_HUGE 'system tar can read our future mtime' '
+	echo 4147 >expect &&
+	tar_info future.tar | cut -d" " -f2 >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a b/t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a
new file mode 100644
index 0000000000000000000000000000000000000000..5cbe9ec312bfd7b7e0398ca281e9d42848743704
GIT binary patch
literal 2048
zcmb=p_2!@<FM|RPgTa!7MhCMEn`g89mv_5$t@dj2a|><dbTfugFd71*Aut*OqaiRF
L0;3@?%t8PFWtt9Z

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
2.9.0.317.g65b4e7c

