Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6EE1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 16:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbcFUQRN (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 12:17:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:57957 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751922AbcFUQRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 12:17:12 -0400
Received: (qmail 25741 invoked by uid 102); 21 Jun 2016 16:17:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 12:17:08 -0400
Received: (qmail 26115 invoked by uid 107); 21 Jun 2016 16:17:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 12:17:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 12:17:06 -0400
Date:	Tue, 21 Jun 2016 12:17:06 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 2/2] archive-tar: write extended headers for far-future
 mtime
Message-ID: <20160621161706.GB17826@sigill.intra.peff.net>
References: <20160621161604.GA17638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160621161604.GA17638@sigill.intra.peff.net>
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
it only affected things far in the future, it wasn't worth
dealing with. But note that my calculations claiming
thousands of years were off there; because our xsnprintf
produces a NUL byte, we only have until the year 2242 to
fix this.

Given that this is just around the corner (geologically
speaking), and because the fix for "size" makes doing this
on top trivial, let's just make it work.

Note that we don't (and never did) handle negative
timestamps (i.e., before 1970). This would probably not be
too hard to support in the same way, but since git does not
support negative timestamps at all, I didn't bother here.

Unlike the last patch for "size", this one is easy to test
efficiently (the magic date is octal 01000000000001):

  $ echo content >file
  $ git add file
  $ GIT_COMMITTER_DATE='@68719476737 +0000' \
    git commit -q -m 'tempori parendum'
  $ git archive HEAD | tar tvf -
  -rw-rw-r-- root/root         8 4147-08-20 03:32 file

With the current tip of master, this dies in xsnprintf (and
prior to f2f0267, it overflowed into the checksum field, and
the resulting tarfile claimed to be from the year 2242).

However, I decided not to include this in the test suite,
because I suspect it will create portability headaches,
including:

  1. The exact format of the system tar's "t" output.

  2. System tars that cannot handle pax headers.

  3. System tars tha cannot handle dates that far in the
     future.

  4. If we replace "tar t" with "tar x", then filesystems
     that cannot handle dates that far in the future.

In other words, we do not really have a reliable tar reader
for these corner cases, so the best we could do is a
byte-for-byte comparison of the output.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index a9caf13..ed562d4 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -185,6 +185,14 @@ static inline unsigned long ustar_size(uintmax_t size)
 		return 0;
 }
 
+static inline unsigned long ustar_mtime(time_t mtime)
+{
+	if (mtime <= 077777777777UL)
+		return mtime;
+	else
+		return 0;
+}
+
 static void prepare_header(struct archiver_args *args,
 			   struct ustar_header *header,
 			   unsigned int mode, unsigned long size)
@@ -192,7 +200,8 @@ static void prepare_header(struct archiver_args *args,
 	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
 	xsnprintf(header->size, sizeof(header->size), "%011lo",
 		  S_ISREG(mode) ? ustar_size(size) : 0);
-	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
+	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo",
+		  ustar_mtime(args->time));
 
 	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
 	xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
@@ -292,6 +301,8 @@ static int write_tar_entry(struct archiver_args *args,
 
 	if (S_ISREG(mode) && ustar_size(size) != size)
 		strbuf_append_ext_header_uint(&ext_header, "size", size);
+	if (ustar_mtime(args->time) != args->time)
+		strbuf_append_ext_header_uint(&ext_header, "mtime", args->time);
 
 	prepare_header(args, &header, mode, size);
 
-- 
2.9.0.204.g1499a7b
