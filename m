From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] write_sha1_file_prepare: fix buffer overrun with extra-long object type
Date: Mon,  4 May 2015 14:37:29 -0700
Message-ID: <1430775451-31130-3-git-send-email-gitster@pobox.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
 <1430775451-31130-1-git-send-email-gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 23:37:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpO3n-0001N2-GT
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 23:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbbEDVhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 17:37:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752125AbbEDVhg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 17:37:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E72B4FA1E;
	Mon,  4 May 2015 17:37:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AeP/
	9Oe8+CCkoHBN3D/V/FKVWeE=; b=GdLtHTuge+aCstQveL8WdXhaSBwuErFSQ/1P
	s8+HxxF7oMpmSqPcu5WZNCmBj9o2aFeV5xUi8EsmIHQ+mggDkyqOCIx6ttIM1sdr
	Bo1Wr6fbFZyqQANKZMXtT5tpoISafUljYO5FrVyPzvWPstcoITvJa9CyVFnB+hrg
	g4hepmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	E9j3edes7CCf4FhRaiOTZPbOsrnMzjx4yY2VHaXtYjxlWW7BuICJA8BIl4mgYIkI
	zmj5qmpgVB8+O29n5QGPC8rrW4zAxn5IX+SoSJHjhXV7zdJQ0qcqG3FogRVft+yJ
	JA8A/wtVRrX0UGcS2eDL5IDsFBlb/4WN5XzfZ1yJUvk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 375674FA1D;
	Mon,  4 May 2015 17:37:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA7654FA1A;
	Mon,  4 May 2015 17:37:35 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-307-g8f38e3e
In-Reply-To: <1430775451-31130-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C76A2D90-F2A5-11E4-9BCE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268360>

From: Eric Sunshine <sunshine@sunshineco.com>

git-hash-object learned --literally in 5ba9a93 (hash-object: add
--literally option, 2014-09-11) which can be used to craft a
corrupt/broken object of unknown type.

When the user-provided type is particularly long, however, it can
overflow the relatively small stack-based character array handed to
write_sha1_file_prepare() by hash_sha1_file() and write_sha1_file(),
leading to stack corruption (and crash).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Tweaked and backported directly on top of 5ba9a93b (hash-object:
   add --literally option, 2014-09-11) which is v2.2.0-rc0~88^2

 builtin/hash-object.c |  4 +---
 cache.h               |  1 +
 sha1_file.c           | 27 ++++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 6158363..887a8ea 100644
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
index dfa1a56..2da7740 100644
--- a/cache.h
+++ b/cache.h
@@ -888,6 +888,7 @@ static inline const unsigned char *lookup_replace_object_extended(const unsigned
 extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int hash_sha1_file_literally(struct strbuf *buf, const char *type, unsigned char *return_sha1, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_noatime(const char *name);
diff --git a/sha1_file.c b/sha1_file.c
index c08c0cb..0fe3f29 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2962,6 +2962,31 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }
 
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
+	if (has_sha1_file(sha1))
+		goto cleanup;
+	status = write_loose_object(sha1, header.buf, hdrlen,
+				    buf->buf, buf->len, 0);
+
+cleanup:
+	strbuf_release(&header);
+	return status;
+}
+
 int force_object_loose(const unsigned char *sha1, time_t mtime)
 {
 	void *buf;
-- 
2.4.0-302-g6743426
