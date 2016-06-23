Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6F911FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 23:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbcFWXVT (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 19:21:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:59432 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751827AbcFWXVS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 19:21:18 -0400
Received: (qmail 12278 invoked by uid 102); 23 Jun 2016 23:21:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 19:21:18 -0400
Received: (qmail 15943 invoked by uid 107); 23 Jun 2016 23:21:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 19:21:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 19:21:13 -0400
Date:	Thu, 23 Jun 2016 19:21:13 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH v3 3/4] archive-tar: write extended headers for far-future
 mtime
Message-ID: <20160623232112.GC3668@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160623231512.GA27683@sigill.intra.peff.net>
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
 archive-tar.c       | 16 +++++++++++++---
 t/t5000-tar-tree.sh |  4 ++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 274bdfa..0bb164c 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -317,7 +317,18 @@ static int write_global_extended_header(struct archiver_args *args)
 	unsigned int mode;
 	int err = 0;
 
-	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
+	if (sha1)
+		strbuf_append_ext_header(&ext_header, "comment",
+					 sha1_to_hex(sha1), 40);
+	if (args->time > 077777777777UL) {
+		strbuf_append_ext_header_uint(&ext_header, "mtime",
+					      args->time);
+		args->time = 077777777777UL;
+	}
+
+	if (!ext_header.len)
+		return 0;
+
 	memset(&header, 0, sizeof(header));
 	*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
 	mode = 0100666;
@@ -402,8 +413,7 @@ static int write_tar_archive(const struct archiver *ar,
 {
 	int err = 0;
 
-	if (args->commit_sha1)
-		err = write_global_extended_header(args);
+	err = write_global_extended_header(args);
 	if (!err)
 		err = write_archive_entries(args, write_tar_entry);
 	if (!err)
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 79dbc88..07e0bdc 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -382,11 +382,11 @@ test_expect_success 'set up repository with far-future commit' '
 		git commit -m "tempori parendum"
 '
 
-test_expect_failure 'generate tar with future mtime' '
+test_expect_success 'generate tar with future mtime' '
 	git archive HEAD >future.tar
 '
 
-test_expect_failure TAR_HUGE 'tar can encode dates far in future' '
+test_expect_success TAR_HUGE 'tar can encode dates far in future' '
 	echo 4147 >expect &&
 	tar_info future.tar | cut -d" " -f2 >actual &&
 	test_cmp expect actual
-- 
2.9.0.217.g096ca68

