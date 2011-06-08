From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] sha1_file.c: zlib can only process 4GB at a time
Date: Wed, 08 Jun 2011 12:03:35 -0700
Message-ID: <7v1uz42liw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 21:03:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUO2d-0006PK-2O
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 21:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab1FHTDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 15:03:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab1FHTDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 15:03:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 21BDB5BBD;
	Wed,  8 Jun 2011 15:05:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	l7eRRqBihVZI5iN81CX5YZrIoo=; b=xv455RuD54Wa41yONy8AFJEjv30tjTfwo
	wfI1a/CovIkdJwmQr1YY33s6woy5EaVc3cxfXpBbUhHIxQLNC4M/qu/pcR7CHMMU
	diXfFjFzO1A63IpL3bTl1SJtye+NpX+m7FYzakvDQWcJZvo2ny4GYbtXgZqkh4n1
	V7dlBTjKa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=LxF
	8TiqZtyfKZGSNlEEOPPuLc8tGDp7vqVUxBDSB61b2ag2JwaXxtFKCcJ9RnOaa9p0
	kGtAQ3KH+5G7Mdc+N6u0l1VCxKDKypHkr7+WkeAfXwmjowHtUlHHM7a4hUJxKdd7
	jie4O3m4kdM35+98CqLXyf1JxjMbHOkbv4eAPGAI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F0E05BBC;
	Wed,  8 Jun 2011 15:05:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2BBEE5BBB; Wed,  8 Jun 2011
 15:05:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 524F0DD0-9202-11E0-8313-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175445>

The size of objects we read from the repository and data we try to put
into the repository are represented in "unsigned long", so that on larger
architectures we can handle objects that weigh more than 4GB.

But the interface defined in zlib.h to communicate with inflate/deflate
limits avail_in (how many bytes of input are we calling zlib with) and
avail_out (how many bytes of output from zlib are we ready to accept)
fields effectively to 4GB by defining their type to be uInt.

In many places in our code, we allocate a large buffer (e.g. mmap'ing a
large loose object file) and tell zlib its size by assigning the size to
avail_in field of the stream, but that will truncate the high octets of
the real size.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * There are a lot more places than just this call site, but I wanted to
   send this out to get a quick sanity check by other people if the
   approach of fixing these issues is sane.

   Of course, we should be using streaming for more codepath, but that is
   totally a separate issue. We would want our code to work correctly when
   streaming is not used and your machine is beefy enough with zetabytes
   of ram, and that is the topic of this patch.

 cache.h     |   11 +++++++++++
 sha1_file.c |   11 +++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index e11cf6a..b917ae5 100644
--- a/cache.h
+++ b/cache.h
@@ -24,6 +24,17 @@ void git_inflate_init(z_streamp strm);
 void git_inflate_end(z_streamp strm);
 int git_inflate(z_streamp strm, int flush);
 
+/*
+ * avail_in and avail_out are counted in uInt, which typically limits
+ * the size of the buffer we can use to 4GB when interacting with zlib
+ * in a single call to inflate/deflate.
+ */
+#define ZLIB_BUF_MAX ((1UL << ((sizeof(uInt) * 8))) - 1)
+static inline uInt zlib_buf_cap(unsigned long len)
+{
+	return (ZLIB_BUF_MAX < len ? ZLIB_BUF_MAX : len);
+}
+
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
diff --git a/sha1_file.c b/sha1_file.c
index 064a330..51236ab 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2429,6 +2429,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	unsigned char parano_sha1[20];
 	char *filename;
 	static char tmpfile[PATH_MAX];
+	unsigned long bytes_to_deflate;
 
 	filename = sha1_file_name(sha1);
 	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
@@ -2454,14 +2455,20 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_SHA1_Update(&c, hdr, hdrlen);
 
 	/* Then the data itself.. */
+	bytes_to_deflate = len;
 	stream.next_in = (void *)buf;
-	stream.avail_in = len;
+	stream.avail_in = zlib_buf_cap(bytes_to_deflate);
 	do {
 		unsigned char *in0 = stream.next_in;
+		size_t consumed;
+
 		ret = deflate(&stream, Z_FINISH);
-		git_SHA1_Update(&c, in0, stream.next_in - in0);
+		consumed = stream.next_in - in0;
+		git_SHA1_Update(&c, in0, consumed);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die("unable to write sha1 file");
+		bytes_to_deflate -= consumed;
+		stream.avail_in = zlib_buf_cap(bytes_to_deflate);
 		stream.next_out = compressed;
 		stream.avail_out = sizeof(compressed);
 	} while (ret == Z_OK);
