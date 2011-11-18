From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] csum-file: introduce sha1file_checkpoint
Date: Thu, 17 Nov 2011 23:11:55 -0800
Message-ID: <1321600317-30546-2-git-send-email-gitster@pobox.com>
References: <1319846051-462-1-git-send-email-gitster@pobox.com>
 <1321600317-30546-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 08:12:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRIcP-0007eY-NX
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 08:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab1KRHMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 02:12:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab1KRHMB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 02:12:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A4492305
	for <git@vger.kernel.org>; Fri, 18 Nov 2011 02:12:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=s/4f
	dwykAraw4uId1VxNTNxfjnQ=; b=A+G9eZ9HSmVWQ4Wr5YiLBO4Lo9M6Jdp/R0bv
	hm9tETmnLoyX1urHq6N09afCDinIOjLf0/ic9uM1wgagrh7ay+ybuF/l6pTPecRO
	CM6mL9L8BJVU7R4rBpYBraUxRaioLhqqA7/8k2F1XQALFy5cw41OsPrFW8eV0bl1
	yvrBw6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=nNQw+J
	1c75Lg0fseDJxBuG03VKftSRjWAxJNnU1tC4UwqisTXTzvmgqvHPqw4wB8V8uwLP
	GLPitfneDPsSp2GdP+lvtVtlYB/Ragmb5/DeTR3CB2KlOWvG6RYRBdmU77aO/SKz
	CIvy4JP0Rwxtt/Zq8Ypr9edswSSsi+kPGMt1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 296012304
	for <git@vger.kernel.org>; Fri, 18 Nov 2011 02:12:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B2202303 for
 <git@vger.kernel.org>; Fri, 18 Nov 2011 02:12:00 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc3.111.g7d421
In-Reply-To: <1321600317-30546-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9BDBD65E-11B4-11E1-86CA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185641>

It is useful to be able to rewind a check-summed file to a certain
previous state after writing data into it using sha1write() API. The
fast-import command does this after streaming a blob data to the packfile
being generated and then noticing that the same blob has already been
written, and it does this with a private code truncate_pack() that is
commented as "Yes, this is a layering violation".

Introduce two API functions, sha1file_checkpoint(), that allows the caller
to save a state of a sha1file, and then later revert it to the saved state.
Use it to reimplement truncate_pack().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 csum-file.c   |   20 ++++++++++++++++++++
 csum-file.h   |    9 +++++++++
 fast-import.c |   25 ++++++++-----------------
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index fc97d6e..53f5375 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -158,6 +158,26 @@ struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp
 	return f;
 }
 
+void sha1file_checkpoint(struct sha1file *f, struct sha1file_checkpoint *checkpoint)
+{
+	sha1flush(f);
+	checkpoint->offset = f->total;
+	checkpoint->ctx = f->ctx;
+}
+
+int sha1file_truncate(struct sha1file *f, struct sha1file_checkpoint *checkpoint)
+{
+	off_t offset = checkpoint->offset;
+
+	if (ftruncate(f->fd, offset) ||
+	    lseek(f->fd, offset, SEEK_SET) != offset)
+		return -1;
+	f->total = offset;
+	f->ctx = checkpoint->ctx;
+	f->offset = 0; /* sha1flush() was called in checkpoint */
+	return 0;
+}
+
 void crc32_begin(struct sha1file *f)
 {
 	f->crc32 = crc32(0, NULL, 0);
diff --git a/csum-file.h b/csum-file.h
index 6a7967c..3b540bd 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -17,6 +17,15 @@ struct sha1file {
 	unsigned char buffer[8192];
 };
 
+/* Checkpoint */
+struct sha1file_checkpoint {
+	off_t offset;
+	git_SHA_CTX ctx;
+};
+
+extern void sha1file_checkpoint(struct sha1file *, struct sha1file_checkpoint *);
+extern int sha1file_truncate(struct sha1file *, struct sha1file_checkpoint *);
+
 /* sha1close flags */
 #define CSUM_CLOSE	1
 #define CSUM_FSYNC	2
diff --git a/fast-import.c b/fast-import.c
index 8d8ea3c..a8db41b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1143,17 +1143,11 @@ static int store_object(
 	return 0;
 }
 
-static void truncate_pack(off_t to, git_SHA_CTX *ctx)
+static void truncate_pack(struct sha1file_checkpoint *checkpoint)
 {
-	if (ftruncate(pack_data->pack_fd, to)
-	 || lseek(pack_data->pack_fd, to, SEEK_SET) != to)
+	if (sha1file_truncate(pack_file, checkpoint))
 		die_errno("cannot truncate pack to skip duplicate");
-	pack_size = to;
-
-	/* yes this is a layering violation */
-	pack_file->total = to;
-	pack_file->offset = 0;
-	pack_file->ctx = *ctx;
+	pack_size = checkpoint->offset;
 }
 
 static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
@@ -1166,8 +1160,8 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 	unsigned long hdrlen;
 	off_t offset;
 	git_SHA_CTX c;
-	git_SHA_CTX pack_file_ctx;
 	git_zstream s;
+	struct sha1file_checkpoint checkpoint;
 	int status = Z_OK;
 
 	/* Determine if we should auto-checkpoint. */
@@ -1175,11 +1169,8 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 		|| (pack_size + 60 + len) < pack_size)
 		cycle_packfile();
 
-	offset = pack_size;
-
-	/* preserve the pack_file SHA1 ctx in case we have to truncate later */
-	sha1flush(pack_file);
-	pack_file_ctx = pack_file->ctx;
+	sha1file_checkpoint(pack_file, &checkpoint);
+	offset = checkpoint.offset;
 
 	hdrlen = snprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
 	if (out_sz <= hdrlen)
@@ -1245,14 +1236,14 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 
 	if (e->idx.offset) {
 		duplicate_count_by_type[OBJ_BLOB]++;
-		truncate_pack(offset, &pack_file_ctx);
+		truncate_pack(&checkpoint);
 
 	} else if (find_sha1_pack(sha1, packed_git)) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
 		duplicate_count_by_type[OBJ_BLOB]++;
-		truncate_pack(offset, &pack_file_ctx);
+		truncate_pack(&checkpoint);
 
 	} else {
 		e->depth = 0;
-- 
1.7.8.rc3.111.g7d421
