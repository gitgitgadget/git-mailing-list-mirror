Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D871F744
	for <e@80x24.org>; Thu, 30 Jun 2016 09:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbcF3JKe (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:10:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:38266 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751383AbcF3JK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:10:28 -0400
Received: (qmail 31630 invoked by uid 102); 30 Jun 2016 09:09:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:09:25 -0400
Received: (qmail 6663 invoked by uid 107); 30 Jun 2016 09:09:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:09:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 05:09:20 -0400
Date:	Thu, 30 Jun 2016 05:09:20 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 4/5] archive-tar: write extended headers for far-future
 mtime
Message-ID: <20160630090920.GD17463@sigill.intra.peff.net>
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

The ustar format represents timestamps as seconds since the
epoch, but only has room to store 11 octal digits.  To
express anything larger, we need to use an extended header.
This is exactly the same case we fixed for the size field in
the previous commit, and the solution here follows the same
pattern.

This is even mentioned as an issue in f2f0267 (archive-tar:
use xsnprintf for trivial formatting, 2015-09-24), but since
it only affected things far in the future, it wasn't deemed
worth dealing with. But note that my calculations claiming
thousands of years were off there; because our xsnprintf
produces a NUL byte, we only have until the year 2242 to fix
this.

Given that this is just around the corner (geologically
speaking, anyway), and because it's easy to fix, let's just
make it work. Unlike the previous fix for "size", where we
had to write an individual extended header for each file, we
can write one global header (since we have only one mtime
for the whole archive).

There's a slight bit of trickiness there. We may already be
writing a global header with a "comment" field for the
commit sha1. So we need to write our new field into the same
header. To do this, we push the decision of whether to write
such a header down into write_global_extended_header(),
which will now assemble the header as it sees fit, and will
return early if we have nothing to write (in practice, we'll
only have a large mtime if it comes from a commit, but this
makes it also work if you set your system clock ahead such
that time() returns a huge value).

Note that we don't (and never did) handle negative
timestamps (i.e., before 1970). This would probably not be
too hard to support in the same way, but since git does not
support negative timestamps at all, I didn't bother here.

After writing the extended header, we munge the timestamp in
the ustar headers to the maximum-allowable size. This is
wrong, but it's the least-wrong thing we can provide to a
tar implementation that doesn't understand pax headers (it's
also what GNU tar does).

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c       | 19 ++++++++++++++++---
 t/t5000-tar-tree.sh |  4 ++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 57a1540..d671bc3 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -22,8 +22,11 @@ static int write_tar_filter_archive(const struct archiver *ar,
  * This is the max value that a ustar size header can specify, as it is fixed
  * at 11 octal digits. POSIX specifies that we switch to extended headers at
  * this size.
+ *
+ * Likewise for the mtime (which happens to use a buffer of the same size).
  */
 #define USTAR_MAX_SIZE 077777777777UL
+#define USTAR_MAX_MTIME 077777777777UL
 
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
@@ -324,7 +327,18 @@ static int write_global_extended_header(struct archiver_args *args)
 	unsigned int mode;
 	int err = 0;
 
-	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
+	if (sha1)
+		strbuf_append_ext_header(&ext_header, "comment",
+					 sha1_to_hex(sha1), 40);
+	if (args->time > USTAR_MAX_MTIME) {
+		strbuf_append_ext_header_uint(&ext_header, "mtime",
+					      args->time);
+		args->time = USTAR_MAX_MTIME;
+	}
+
+	if (!ext_header.len)
+		return 0;
+
 	memset(&header, 0, sizeof(header));
 	*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
 	mode = 0100666;
@@ -409,8 +423,7 @@ static int write_tar_archive(const struct archiver *ar,
 {
 	int err = 0;
 
-	if (args->commit_sha1)
-		err = write_global_extended_header(args);
+	err = write_global_extended_header(args);
 	if (!err)
 		err = write_archive_entries(args, write_tar_entry);
 	if (!err)
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 93c2d34..96d208d 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -383,11 +383,11 @@ test_expect_success 'set up repository with far-future commit' '
 		git commit -m "tempori parendum"
 '
 
-test_expect_failure 'generate tar with future mtime' '
+test_expect_success 'generate tar with future mtime' '
 	git archive HEAD >future.tar
 '
 
-test_expect_failure TAR_HUGE 'system tar can read our future mtime' '
+test_expect_success TAR_HUGE 'system tar can read our future mtime' '
 	echo 4147 >expect &&
 	tar_info future.tar | cut -d" " -f2 >actual &&
 	test_cmp expect actual
-- 
2.9.0.317.g65b4e7c

