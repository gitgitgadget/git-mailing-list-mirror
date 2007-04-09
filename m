From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 04/10] compute a CRC32 for each object as stored in a pack
Date: Mon, 09 Apr 2007 01:06:31 -0400
Message-ID: <11760951993409-git-send-email-nico@cam.org>
References: <11760951973172-git-send-email-nico@cam.org>
 <11760951973319-git-send-email-nico@cam.org>
 <11760951993458-git-send-email-nico@cam.org>
 <11760951993225-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 07:07:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ham5v-00038I-9J
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 07:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbXDIFGx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 01:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbXDIFGx
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 01:06:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64601 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbXDIFGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 01:06:42 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG700EK9SV173A3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 01:06:40 -0400 (EDT)
In-reply-to: <11760951993225-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.1.31.ge421f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44029>

The most important optimization for performance when repacking is the
ability to reuse data from a previous pack as is and bypass any delta
or even SHA1 computation by simply copying the raw data from one pack
to another directly.

The problem with  this is that any data corruption within a copied object
would go unnoticed and the new (repacked) pack would be self-consistent
with its own checksum despite containing a corrupted object.  This is a
real issue that already happened at least once in the past.

In some attempt to prevent this, we validate the copied data by inflating
it and making sure no error is signaled by zlib.  But this is still not
perfect as a significant portion of a pack content is made of object
headers and references to delta base objects which are not deflated and
therefore not validated when repacking actually making the pack data reuse
still not as safe as it could be.

Of course a full SHA1 validation could be performed, but that implies
full data inflating and delta replaying which is extremely costly, which
cost the data reuse optimization was designed to avoid in the first place.

So the best solution to this is simply to store a CRC32 of the raw pack
data for each object in the pack index.  This way any object in a pack can
be validated before being copied as is in another pack, including header
and any other non deflated data.

Why CRC32 instead of a faster checksum like Adler32?  Quoting Wikipedia:

   Jonathan Stone discovered in 2001 that Adler-32 has a weakness for very
   short messages. He wrote "Briefly, the problem is that, for very short
   packets, Adler32 is guaranteed to give poor coverage of the available
   bits. Don't take my word for it, ask Mark Adler. :-)" The problem is
   that sum A does not wrap for short messages. The maximum value of A for
   a 128-byte message is 32640, which is below the value 65521 used by the
   modulo operation. An extended explanation can be found in RFC 3309,
   which mandates the use of CRC32 instead of Adler-32 for SCTP, the
   Stream Control Transmission Protocol.

In the context of a GIT pack, we have lots of small objects, especially
deltas, which are likely to be quite small and in a size range for which
Adler32 is dimed not to be sufficient.  Another advantage of CRC32 is the
possibility for recovery from certain types of small corruptions like
single bit errors which are the most probable type of corruptions.

OK what this patch does is to compute the CRC32 of each object written to
a pack within pack-objects.  It is not written to the index yet and it is
obviously not validated when reusing pack data yet either.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    6 ++++++
 csum-file.c            |   14 ++++++++++++++
 csum-file.h            |    4 ++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d0be879..03e36f0 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -44,6 +44,7 @@ struct object_entry {
 				 * be used as the base objectto delta huge
 				 * objects against.
 				 */
+	uint32_t crc32;		/* crc of raw pack data for this object */
 };
 
 /*
@@ -381,6 +382,9 @@ static unsigned long write_object(struct sha1file *f,
 	enum object_type obj_type;
 	int to_reuse = 0;
 
+	if (!pack_to_stdout)
+		crc32_begin(f);
+
 	obj_type = entry->type;
 	if (! entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
@@ -496,6 +500,8 @@ static unsigned long write_object(struct sha1file *f,
 	if (entry->delta)
 		written_delta++;
 	written++;
+	if (!pack_to_stdout)
+		entry->crc32 = crc32_end(f);
 	return hdrlen + datalen;
 }
 
diff --git a/csum-file.c b/csum-file.c
index b7174c6..7c806ad 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -49,6 +49,8 @@ int sha1close(struct sha1file *f, unsigned char *result, int update)
 
 int sha1write(struct sha1file *f, void *buf, unsigned int count)
 {
+	if (f->do_crc)
+		f->crc32 = crc32(f->crc32, buf, count);
 	while (count) {
 		unsigned offset = f->offset;
 		unsigned left = sizeof(f->buffer) - offset;
@@ -91,6 +93,7 @@ struct sha1file *sha1create(const char *fmt, ...)
 	f->fd = fd;
 	f->error = 0;
 	f->offset = 0;
+	f->do_crc = 0;
 	SHA1_Init(&f->ctx);
 	return f;
 }
@@ -111,6 +114,7 @@ struct sha1file *sha1fd(int fd, const char *name)
 	f->fd = fd;
 	f->error = 0;
 	f->offset = 0;
+	f->do_crc = 0;
 	SHA1_Init(&f->ctx);
 	return f;
 }
@@ -143,4 +147,14 @@ int sha1write_compressed(struct sha1file *f, void *in, unsigned int size)
 	return size;
 }
 
+void crc32_begin(struct sha1file *f)
+{
+	f->crc32 = crc32(0, Z_NULL, 0);
+	f->do_crc = 1;
+}
 
+uint32_t crc32_end(struct sha1file *f)
+{
+	f->do_crc = 0;
+	return f->crc32;
+}
diff --git a/csum-file.h b/csum-file.h
index 3ad1a99..7e13391 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -7,6 +7,8 @@ struct sha1file {
 	unsigned int offset, namelen;
 	SHA_CTX ctx;
 	char name[PATH_MAX];
+	int do_crc;
+	uint32_t crc32;
 	unsigned char buffer[8192];
 };
 
@@ -15,5 +17,7 @@ extern struct sha1file *sha1create(const char *fmt, ...) __attribute__((format (
 extern int sha1close(struct sha1file *, unsigned char *, int);
 extern int sha1write(struct sha1file *, void *, unsigned int);
 extern int sha1write_compressed(struct sha1file *, void *, unsigned int);
+extern void crc32_begin(struct sha1file *);
+extern uint32_t crc32_end(struct sha1file *);
 
 #endif
-- 
1.5.1.696.g6d352-dirty
