From: Jeff King <peff@peff.net>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Sat, 29 Dec 2012 04:05:58 -0500
Message-ID: <20121229090558.GA31291@sigill.intra.peff.net>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net>
 <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net>
 <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 10:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TosN8-0006tg-Ib
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 10:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab2L2JGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 04:06:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38673 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab2L2JGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 04:06:03 -0500
Received: (qmail 28015 invoked by uid 107); 29 Dec 2012 09:07:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 04:07:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 04:05:58 -0500
Content-Disposition: inline
In-Reply-To: <20121229052747.GA14928@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212300>

On Sat, Dec 29, 2012 at 12:27:47AM -0500, Jeff King wrote:

> > I think I tried the partial decompression for commit header and it did
> > not help much (or I misremember it, not so sure).
> 
> I'll see if I can dig up the reference, as it was something I was going
> to look at next.

I tried the simple patch below, but it actually made things slower!  I'm
assuming it is because the streaming setup is not micro-optimized very
well. A custom read_sha1_until_blank_line() could probably do better.

diff --git a/commit.c b/commit.c
index e8eb0ae..efd6c06 100644
--- a/commit.c
+++ b/commit.c
@@ -8,6 +8,7 @@
 #include "notes.h"
 #include "gpg-interface.h"
 #include "mergesort.h"
+#include "streaming.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -306,6 +307,39 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	return 0;
 }
 
+static void *read_commit_header(const unsigned char *sha1,
+				enum object_type *type,
+				unsigned long *size)
+{
+	static const int chunk_size = 256;
+	struct strbuf buf = STRBUF_INIT;
+	struct git_istream *st;
+
+	st = open_istream(sha1, type, size, NULL);
+	if (!st)
+		return NULL;
+	while (1) {
+		size_t start = buf.len;
+		ssize_t readlen;
+
+		strbuf_grow(&buf, chunk_size);
+		readlen = read_istream(st, buf.buf + start, chunk_size);
+		buf.buf[start + readlen + 1] = '\0';
+		buf.len += readlen;
+
+		if (readlen < 0) {
+			close_istream(st);
+			strbuf_release(&buf);
+			return NULL;
+		}
+		if (!readlen || strstr(buf.buf + start, "\n\n"))
+			break;
+	}
+
+	close_istream(st);
+	return strbuf_detach(&buf, size);
+}
+
 int parse_commit(struct commit *item)
 {
 	enum object_type type;
@@ -317,7 +351,11 @@ int parse_commit(struct commit *item)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.sha1, &type, &size);
+
+	if (!save_commit_buffer)
+		buffer = read_commit_header(item->object.sha1, &type, &size);
+	else
+		buffer = read_sha1_file(item->object.sha1, &type, &size);
 	if (!buffer)
 		return error("Could not read %s",
 			     sha1_to_hex(item->object.sha1));
