From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] archive-tar: write extended headers for far-future mtime
Date: Thu, 16 Jun 2016 00:37:58 -0400
Message-ID: <20160616043758.GB18323@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 06:38:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDP49-0001sW-QX
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jun 2016 06:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbcFPEiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2016 00:38:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:55437 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750898AbcFPEiB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 00:38:01 -0400
Received: (qmail 30061 invoked by uid 102); 16 Jun 2016 04:38:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 00:38:00 -0400
Received: (qmail 12148 invoked by uid 107); 16 Jun 2016 04:38:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 00:38:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 00:37:58 -0400
Content-Disposition: inline
In-Reply-To: <20160616043523.GA13615@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297411>

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
index 7340b64..749722f 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -185,6 +185,14 @@ static inline unsigned long ustar_size(uintmax_t size)
 		return 0;
 }
 
+static inline unsigned long ustar_mtime(time_t mtime)
+{
+	if (mtime < 077777777777)
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
 
 	if (ustar_size(size) != size)
 		strbuf_append_ext_header_uint(&ext_header, "size", size);
+	if (ustar_mtime(args->time) != args->time)
+		strbuf_append_ext_header_uint(&ext_header, "mtime", args->time);
 
 	prepare_header(args, &header, mode, size);
 
-- 
2.9.0.150.g8bd4cf6
