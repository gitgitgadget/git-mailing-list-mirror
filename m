From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] write_sha1_file_prepare: fix buffer overrun with extra-long object type
Date: Mon, 04 May 2015 10:58:35 -0700
Message-ID: <xmqq4mnsteb8.fsf@gitster.dls.corp.google.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
	<1430724315-524-4-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 04 19:58:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpKdg-0006sX-SN
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 19:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbbEDR6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 13:58:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751485AbbEDR6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 13:58:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA3B84CF74;
	Mon,  4 May 2015 13:58:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=pevTruzpLWwUh1D+yAoLXgj5AGQ=; b=L/eK7GIbVj6sH87BvTVE
	JfauaYRcT5j38dCQZ+t0foBFwA8fRkDnysd91DwiOGZ7zkKq53jeEjYeTFEHAYIR
	eZ4kIh31vFwe3mz5L7aXvIa/8mfHHWi9HpqZGsplMU86lXsCkwfyrvZ+EB7K19t7
	6kP4Gk92eb3Y4Ux9AGTG+ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Q37CgPLpMfSrf5E5HOB08bQzkcozT91KVQ+UOZ1g2PxZKR
	lJieQo7BfMskh9wvD1EX0f+T66cIIOkJtwM4JwsQgCpvyXKyL+30G+McCWGzGMW+
	G+UVL3hWCpx6XZrvPvWpbwRmicIHIbtAHFIX+ku+0Ilmw/uMI+zkH/Y6oyHuQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C22EB4CF73;
	Mon,  4 May 2015 13:58:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13B184CF6D;
	Mon,  4 May 2015 13:58:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 303053F0-F287-11E4-B676-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268337>

Eric Sunshine <sunshine@sunshineco.com> writes:

> git-hash-object learned --literally in 5ba9a93 (hash-object: add
> --literally option, 2014-09-11) which can be used to craft a
> corrupt/broken object of unknown type. When the user-provided type is
> particularly long, it can overflow the relatively small stack-based
> character array handed to write_sha1_file_prepare() by hash_sha1_file()
> and write_sha1_file(), leading to stack corruption (and crash).
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

Thanks.

> ---
>
> The composed 'hdr' is supposed to be NUL-terminated, and code which
> accesses 'hdr' expects the NUL to be included as part of its length.
> Although strbuf ensures that a NUL byte follows the string content, I
> took the precaution of explicitly adding NUL when formulating 'hdr'
>
>     strbuf_addf(hdr, "%s %lu%c", type, len, '\0');
>
> so that callers can just say hdr.len when the length is needed, rather
> than having to remember to say hdr.len+1.

That is unnecessary and may turn out to be more confusing than it is
worth in the long run; though I do not think it matters too much.

> I haven't fully convinced myself that this fix is appropriate since it
> penalizes _all_ callers of hash_sha1_file() and write_sha1_file() with
> an extra heap allocation (via strbuf), even though "hash-object
> --literally" is the only mechanism by which an overly-long object type
> can arrive.

I am moderately unhappy about fixing it this way for the exact
reason you stated aboe.

write_sha1_file_prepare() can stay the same as before, and we can
use a variant of hash_sha1_file() only when doing the --literally
thing to use a special allocation.  Perhaps like this?

The patch was done on top of yours; it reverts the change to
write_sha1_file_prepare() and its callers, and instead adds a
separate helper.  We may want to restructure the latter half of
write_sha1_file() that does the freshen-or-write into a helper
function to share more logic, though.

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 207b90c..ef383e1 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -22,10 +22,8 @@ static int hash_literally(unsigned char *sha1, int fd, const char *type, unsigne
 
 	if (strbuf_read(&buf, fd, 4096) < 0)
 		ret = -1;
-	else if (flags & HASH_WRITE_OBJECT)
-		ret = write_sha1_file(buf.buf, buf.len, type, sha1);
 	else
-		ret = hash_sha1_file(buf.buf, buf.len, type, sha1);
+		ret = hash_sha1_file_literally(&buf, type, sha1, flags);
 	strbuf_release(&buf);
 	return ret;
 }
diff --git a/cache.h b/cache.h
index 3d3244b..a37423e 100644
--- a/cache.h
+++ b/cache.h
@@ -874,6 +874,7 @@ static inline const unsigned char *lookup_replace_object_extended(const unsigned
 extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int hash_sha1_file_literally(struct strbuf *buf, const char *type, unsigned char *return_sha1, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_noatime(const char *name);
diff --git a/sha1_file.c b/sha1_file.c
index 6d3fa26..c8ab069 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2795,16 +2795,16 @@ void *read_object_with_reference(const unsigned char *sha1,
 
 static void write_sha1_file_prepare(const void *buf, unsigned long len,
                                     const char *type, unsigned char *sha1,
-				    struct strbuf *hdr)
+				    char *hdr, int *hdrlen)
 {
 	git_SHA_CTX c;
 
 	/* Generate the header */
-	strbuf_addf(hdr, "%s %lu%c", type, len, '\0');
+	*hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
 
 	/* Sha1.. */
 	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr->buf, hdr->len);
+	git_SHA1_Update(&c, hdr, *hdrlen);
 	git_SHA1_Update(&c, buf, len);
 	git_SHA1_Final(sha1, &c);
 }
@@ -2865,8 +2865,9 @@ static int write_buffer(int fd, const void *buf, size_t len)
 int hash_sha1_file(const void *buf, unsigned long len, const char *type,
                    unsigned char *sha1)
 {
-	struct strbuf hdr = STRBUF_INIT;
-	write_sha1_file_prepare(buf, len, type, sha1, &hdr);
+	char hdr[32];
+	int hdrlen;
+	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	return 0;
 }
 
@@ -3004,18 +3005,43 @@ static int freshen_packed_object(const unsigned char *sha1)
 int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
 	unsigned char sha1[20];
-	struct strbuf hdr = STRBUF_INIT;
+	char hdr[32];
+	int hdrlen;
 
-	/*
-	 * Normally if we have it in the pack then we do not bother writing
+	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_sha1_file_prepare(buf, len, type, sha1, &hdr);
+	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
 	if (freshen_loose_object(sha1) || freshen_packed_object(sha1))
 		return 0;
-	return write_loose_object(sha1, hdr.buf, hdr.len, buf, len, 0);
+	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
+}
+
+int hash_sha1_file_literally(struct strbuf *buf, const char *type,
+			     unsigned char *sha1, unsigned flags)
+{
+	struct strbuf header = STRBUF_INIT;
+	int hdrlen, status = 0;
+
+	/* type string, SP, %lu of the length plus NUL must fit this */
+	strbuf_grow(&header, strlen(type) + 20);
+
+	write_sha1_file_prepare(buf->buf, buf->len, type, sha1,
+				header.buf, &hdrlen);
+
+	if (!(flags & HASH_WRITE_OBJECT))
+		goto cleanup;
+
+	if (freshen_loose_object(sha1) || freshen_packed_object(sha1))
+		goto cleanup;
+	status = write_loose_object(sha1, header.buf, hdrlen,
+				    buf->buf, buf->len, 0);
+
+cleanup:
+	strbuf_release(&header);
+	return status;
 }
 
 int force_object_loose(const unsigned char *sha1, time_t mtime)
