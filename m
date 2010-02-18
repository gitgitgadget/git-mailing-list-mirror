From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Teach "git add" and friends to be paranoid
Date: Wed, 17 Feb 2010 17:16:23 -0800
Message-ID: <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 02:17:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhv1a-0003IE-O0
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 02:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502Ab0BRBRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 20:17:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab0BRBRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 20:17:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B56129A3B2;
	Wed, 17 Feb 2010 20:17:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IlpiU79+u+YZL2aUi5J+j0fqy1Y=; b=tJNBHo
	fG1/pJS6k+PXpB/QFoGnaC4cw7Yp++t6RTqzEpdZa6WSUSQdtH/NP88oluMQsX/4
	HnfdrFMwxVP5xyLY2DYNMAx8XQo2/VarSraTyF3PhGjUWeLZ1xSbqUCBMW4Rs/jE
	pDcnwNIMOtUDvl15bXFbGXBaO/CI2+iLdHXjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OG2rtbwwj94kM+iBK/sBR+qbTZwB0VG0
	738JO2jafDdYsgR8qm4+7fV/R/K5kr9uOduGR9Edp9bx/BZ5YuLTceXA5IaAd2zi
	0P/q1ChK+EQbkK4TLe5GoDasoTrBr9I9che6ggQVOWLAlTFuVKGpxVAzY6me4NN2
	fkXhxWfLNXw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 524249A3B0;
	Wed, 17 Feb 2010 20:17:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AEE39A397; Wed, 17 Feb
 2010 20:16:46 -0500 (EST)
In-Reply-To: <20100214011812.GA2175@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Sun\, 14 Feb 2010 04\:18\:12 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56FCEEAE-1C2B-11DF-8C25-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140277>

When creating a loose object, we normally mmap(2) the entire file, and
hash and then compress to write it out in two separate steps for
efficiency.

This is perfectly good for the intended use of git---nobody is supposed to
be insane enough to expect that it won't break anything to muck with the
contents of a file after telling git to index it and before getting the
control back from git.

But the nature of breakage caused by such an abuse is rather bad.  We will
end up with loose object files, whose names do not match what are stored
and recovered when uncompressed.

This teaches the index_mem() codepath to be paranoid and hash and compress
the data after reading it in core.  The contents hashed may not match the
contents of the file in an insane use case, but at least this way the
result will be internally consistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 657825e..d8a7722 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2278,7 +2278,8 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 }
 
 static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
-			      void *buf, unsigned long len, time_t mtime)
+			      void *buf, unsigned long len, time_t mtime,
+			      int paranoid)
 {
 	int fd, ret;
 	size_t size;
@@ -2286,6 +2287,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	z_stream stream;
 	char *filename;
 	static char tmpfile[PATH_MAX];
+	git_SHA_CTX ctx;
 
 	filename = sha1_file_name(sha1);
 	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
@@ -2312,12 +2314,41 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	stream.next_in = (unsigned char *)hdr;
 	stream.avail_in = hdrlen;
 	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
+		; /* nothing */
 
 	/* Then the data itself.. */
-	stream.next_in = buf;
-	stream.avail_in = len;
-	ret = deflate(&stream, Z_FINISH);
+	if (paranoid) {
+		unsigned char stablebuf[262144];
+		char *bufptr = buf;
+		unsigned long remainder = len;
+
+		git_SHA1_Init(&ctx);
+		git_SHA1_Update(&ctx, hdr, hdrlen);
+
+		ret = Z_OK;
+		while (remainder) {
+			unsigned long chunklen = remainder;
+
+			if (sizeof(stablebuf) <= chunklen)
+				chunklen = sizeof(stablebuf);
+			memcpy(stablebuf, bufptr, chunklen);
+			git_SHA1_Update(&ctx, stablebuf, chunklen);
+			stream.next_in = stablebuf;
+			stream.avail_in = chunklen;
+			do {
+				ret = deflate(&stream, Z_NO_FLUSH);
+			} while (ret == Z_OK);
+			bufptr += chunklen;
+			remainder -= chunklen;
+		}
+		if (ret != Z_STREAM_END)
+			ret = deflate(&stream, Z_FINISH);
+	} else {
+		stream.next_in = buf;
+		stream.avail_in = len;
+		ret = deflate(&stream, Z_FINISH);
+	}
+
 	if (ret != Z_STREAM_END)
 		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
 
@@ -2327,6 +2358,12 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	size = stream.total_out;
 
+	if (paranoid) {
+		unsigned char paranoid_sha1[20];
+		git_SHA1_Final(paranoid_sha1, &ctx);
+		if (hashcmp(paranoid_sha1, sha1))
+			die("hashed file is volatile");
+	}
 	if (write_buffer(fd, compressed, size) < 0)
 		die("unable to write sha1 file");
 	close_sha1_file(fd);
@@ -2344,7 +2381,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	return move_temp_to_file(tmpfile, filename);
 }
 
-int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+static int write_sha1_file_paranoid(void *buf, unsigned long len, const char *type, unsigned char *returnsha1, int paranoid)
 {
 	unsigned char sha1[20];
 	char hdr[32];
@@ -2358,7 +2395,12 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 		hashcpy(returnsha1, sha1);
 	if (has_sha1_file(sha1))
 		return 0;
-	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
+	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0, paranoid);
+}
+
+int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
+{
+	return write_sha1_file_paranoid(buf, len, type, returnsha1, 0);
 }
 
 int force_object_loose(const unsigned char *sha1, time_t mtime)
@@ -2376,7 +2418,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
-	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
+	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime, 0);
 	free(buf);
 
 	return ret;
@@ -2405,10 +2447,15 @@ int has_sha1_file(const unsigned char *sha1)
 	return has_loose_object(sha1);
 }
 
+#define INDEX_MEM_WRITE_OBJECT  01
+#define INDEX_MEM_PARANOID      02
+
 static int index_mem(unsigned char *sha1, void *buf, size_t size,
-		     int write_object, enum object_type type, const char *path)
+		     enum object_type type, const char *path, int flag)
 {
 	int ret, re_allocated = 0;
+	int write_object = flag & INDEX_MEM_WRITE_OBJECT;
+	int paranoid = flag & INDEX_MEM_PARANOID;
 
 	if (!type)
 		type = OBJ_BLOB;
@@ -2426,9 +2473,11 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	}
 
 	if (write_object)
-		ret = write_sha1_file(buf, size, typename(type), sha1);
+		ret = write_sha1_file_paranoid(buf, size, typename(type),
+					       sha1, paranoid);
 	else
 		ret = hash_sha1_file(buf, size, typename(type), sha1);
+
 	if (re_allocated)
 		free(buf);
 	return ret;
@@ -2437,23 +2486,25 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	     enum object_type type, const char *path)
 {
-	int ret;
+	int ret, flag;
 	size_t size = xsize_t(st->st_size);
 
+	flag = write_object ? INDEX_MEM_WRITE_OBJECT : 0;
 	if (!S_ISREG(st->st_mode)) {
 		struct strbuf sbuf = STRBUF_INIT;
 		if (strbuf_read(&sbuf, fd, 4096) >= 0)
-			ret = index_mem(sha1, sbuf.buf, sbuf.len, write_object,
-					type, path);
+			ret = index_mem(sha1, sbuf.buf, sbuf.len,
+					type, path, flag);
 		else
 			ret = -1;
 		strbuf_release(&sbuf);
 	} else if (size) {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret = index_mem(sha1, buf, size, write_object, type, path);
+		flag |= INDEX_MEM_PARANOID;
+		ret = index_mem(sha1, buf, size, type, path, flag);
 		munmap(buf, size);
 	} else
-		ret = index_mem(sha1, NULL, size, write_object, type, path);
+		ret = index_mem(sha1, NULL, size, type, path, flag);
 	close(fd);
 	return ret;
 }
-- 
1.7.0.81.g58679
