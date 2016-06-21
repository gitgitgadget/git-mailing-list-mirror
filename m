Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01401FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 16:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbcFUQQ6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 12:16:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:57952 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751790AbcFUQQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 12:16:57 -0400
Received: (qmail 25725 invoked by uid 102); 21 Jun 2016 16:16:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 12:16:57 -0400
Received: (qmail 26097 invoked by uid 107); 21 Jun 2016 16:17:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 12:17:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 12:16:54 -0400
Date:	Tue, 21 Jun 2016 12:16:54 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 1/2] archive-tar: write extended headers for file sizes >=
 8GB
Message-ID: <20160621161654.GA17826@sigill.intra.peff.net>
References: <20160621161604.GA17638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160621161604.GA17638@sigill.intra.peff.net>
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
digits into the mtime field, meaning our value was was
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

There's no test included here. I did confirm that this works
(using GNU tar) with:

  $ dd if=/dev/zero seek=64G bs=1 count=1 of=huge
  $ git add huge
  $ git commit -q -m foo
  $ git archive HEAD | head -c 10000 | tar tvf - 2>/dev/null
  -rw-rw-r-- root/root 68719476737 2016-06-15 21:07 huge

Pre-f2f0267, this would yield a bogus size of 8GB, and
post-f2f0267, git-archive simply dies.

Unfortunately, it's quite an expensive test to run. For one
thing, unless your filesystem supports files with holes, it
takes 64GB of disk space (you might think piping straight to
`hash-object --stdin` would be better, but it's not; that
tries to buffer all 64GB in RAM!). Furthermore, hashing and
compressing the object takes several minutes of CPU time.

We could ship just the resulting compressed object data as a
loose object, but even that takes 64MB. So sadly, this code
path remains untested in the test suite.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index cb99df2..a9caf13 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -137,6 +137,20 @@ static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
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
@@ -163,12 +177,21 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 	return i;
 }
 
+static inline unsigned long ustar_size(uintmax_t size)
+{
+	if (size <= 077777777777UL)
+		return size;
+	else
+		return 0;
+}
+
 static void prepare_header(struct archiver_args *args,
 			   struct ustar_header *header,
 			   unsigned int mode, unsigned long size)
 {
 	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
-	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? size : 0);
+	xsnprintf(header->size, sizeof(header->size), "%011lo",
+		  S_ISREG(mode) ? ustar_size(size) : 0);
 	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
 
 	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
@@ -267,6 +290,9 @@ static int write_tar_entry(struct archiver_args *args,
 			memcpy(header.linkname, buffer, size);
 	}
 
+	if (S_ISREG(mode) && ustar_size(size) != size)
+		strbuf_append_ext_header_uint(&ext_header, "size", size);
+
 	prepare_header(args, &header, mode, size);
 
 	if (ext_header.len > 0) {
-- 
2.9.0.204.g1499a7b

