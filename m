Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE0E1F744
	for <e@80x24.org>; Thu, 30 Jun 2016 09:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbcF3JKg (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:10:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:38264 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751203AbcF3JK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:10:28 -0400
Received: (qmail 31618 invoked by uid 102); 30 Jun 2016 09:09:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:09:21 -0400
Received: (qmail 6657 invoked by uid 107); 30 Jun 2016 09:09:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:09:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 05:09:16 -0400
Date:	Thu, 30 Jun 2016 05:09:16 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/5] archive-tar: write extended headers for file sizes >=
 8GB
Message-ID: <20160630090916.GC17463@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160630090614.GA16725@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The ustar format has a fixed-length field for the size of
each file entry which is supposed to contain up to 11 bytes
of octal-formatted data plus a NUL or space terminator.

These means that the largest size we can represent is
077777777777, or 1 byte short of 8GB. The correct solution
for a larger file, according to POSIX.1-2001, is to add an
extended pax header, similar to how we handle long
filenames. This patch does that, and writes zero for the
size field in the ustar header (the last bit is not
mentioned by POSIX, but it matches how GNU tar behaves with
--format=pax).

This should be a strict improvement over the current
behavior, which is to die in xsnprintf with a "BUG".
However, there's some interesting history here.

Prior to f2f0267 (archive-tar: use xsnprintf for trivial
formatting, 2015-09-24), we silently overflowed the "size"
field. The extra bytes ended up in the "mtime" field of the
header, which was then immediately written itself,
overwriting our extra bytes. What that means depends on how
many bytes we wrote.

If the size was 64GB or greater, then we actually overflowed
digits into the mtime field, meaning our value was
effectively right-shifted by those lost octal digits. And
this patch is again a strict improvement over that.

But if the size was between 8GB and 64GB, then our 12-byte
field held all of the actual digits, and only our NUL
terminator overflowed. According to POSIX, there should be a
NUL or space at the end of the field. However, GNU tar seems
to be lenient here, and will correctly parse a size up 64GB
(minus one) from the field. So sizes in this range might
have just worked, depending on the implementation reading
the tarfile.

This patch is mostly still an improvement there, as the 8GB
limit is specifically mentioned in POSIX as the correct
limit. But it's possible that it could be a regression
(versus the pre-f2f0267 state) if all of the following are
true:

  1. You have a file between 8GB and 64GB.

  2. Your tar implementation _doesn't_ know about pax
     extended headers.

  3. Your tar implementation _does_ parse 12-byte sizes from
     the ustar header without a delimiter.

It's probably not worth worrying about such an obscure set
of conditions, but I'm documenting it here just in case.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c       | 31 +++++++++++++++++++++++++++++--
 t/t5000-tar-tree.sh |  4 ++--
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index cb99df2..57a1540 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -18,6 +18,13 @@ static int tar_umask = 002;
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args);
 
+/*
+ * This is the max value that a ustar size header can specify, as it is fixed
+ * at 11 octal digits. POSIX specifies that we switch to extended headers at
+ * this size.
+ */
+#define USTAR_MAX_SIZE 077777777777UL
+
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
 {
@@ -137,6 +144,20 @@ static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
 	strbuf_addch(sb, '\n');
 }
 
+/*
+ * Like strbuf_append_ext_header, but for numeric values.
+ */
+static void strbuf_append_ext_header_uint(struct strbuf *sb,
+					  const char *keyword,
+					  uintmax_t value)
+{
+	char buf[40]; /* big enough for 2^128 in decimal, plus NUL */
+	int len;
+
+	len = xsnprintf(buf, sizeof(buf), "%"PRIuMAX, value);
+	strbuf_append_ext_header(sb, keyword, buf, len);
+}
+
 static unsigned int ustar_header_chksum(const struct ustar_header *header)
 {
 	const unsigned char *p = (const unsigned char *)header;
@@ -208,7 +229,7 @@ static int write_tar_entry(struct archiver_args *args,
 	struct ustar_header header;
 	struct strbuf ext_header = STRBUF_INIT;
 	unsigned int old_mode = mode;
-	unsigned long size;
+	unsigned long size, size_in_header;
 	void *buffer;
 	int err = 0;
 
@@ -267,7 +288,13 @@ static int write_tar_entry(struct archiver_args *args,
 			memcpy(header.linkname, buffer, size);
 	}
 
-	prepare_header(args, &header, mode, size);
+	size_in_header = size;
+	if (S_ISREG(mode) && size > USTAR_MAX_SIZE) {
+		size_in_header = 0;
+		strbuf_append_ext_header_uint(&ext_header, "size", size);
+	}
+
+	prepare_header(args, &header, mode, size_in_header);
 
 	if (ext_header.len > 0) {
 		err = write_extended_header(args, sha1, ext_header.buf,
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 950bdd3..93c2d34 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -360,7 +360,7 @@ test_expect_success 'set up repository with huge blob' '
 
 # We expect git to die with SIGPIPE here (otherwise we
 # would generate the whole 64GB).
-test_expect_failure 'generate tar with huge size' '
+test_expect_success 'generate tar with huge size' '
 	{
 		git archive HEAD
 		echo $? >exit-code
@@ -369,7 +369,7 @@ test_expect_failure 'generate tar with huge size' '
 	test_cmp expect exit-code
 '
 
-test_expect_failure TAR_HUGE 'system tar can read our huge size' '
+test_expect_success TAR_HUGE 'system tar can read our huge size' '
 	echo 68719476737 >expect &&
 	tar_info huge.tar | cut -d" " -f1 >actual &&
 	test_cmp expect actual
-- 
2.9.0.317.g65b4e7c

