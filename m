From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] write_sha1_file_prepare: fix buffer overrun with extra-long object type
Date: Tue, 05 May 2015 10:30:09 -0700
Message-ID: <xmqqvbg7dja6.fsf@gitster.dls.corp.google.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
	<1430775451-31130-1-git-send-email-gitster@pobox.com>
	<1430775451-31130-3-git-send-email-gitster@pobox.com>
	<CAPig+cS3f2XggxqbvX6Z2Da24QKLOg915Bf-bTVa+4oVzfhA1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 05 19:30:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypgfp-0007y9-Dw
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 19:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762010AbbEERaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 13:30:16 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762007AbbEERaM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 13:30:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A4F74EA77;
	Tue,  5 May 2015 13:30:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dzNy31G2rAX6CXfbX1H556uP+2A=; b=kYBjmd
	WEyoN5a+wLMnsf8nncOQMz/pEsF/3vCp8c4JgbKfbLdxGr71lWfhjbk1ad9s8Lkd
	SHkI4/2Cmo4pA4udxvO78ZExo8C4cCUMY90lZfbT8Z4To0jOXXHhCtobjJxHffDl
	QLlxUIPbq8kYbdpfJZSO6frklkb3BO/RBqTDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RkUFHwFq1CyrOnNm/MmADI+4RP5XJc6G
	4gN2/gOMo3SekkVivec1ubj/39juf8OUTmFIh7O1tFF3Jq7N9Gd5tkroZ+zoZGvk
	o1Qzz0mG1ZtjRHm+EE7cU4cum4oIv8KC5fanKw59lypgYab58tAfqkpxtIidLUOb
	h7xjWZiiRvI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 927BE4EA76;
	Tue,  5 May 2015 13:30:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F3514EA72;
	Tue,  5 May 2015 13:30:10 -0400 (EDT)
In-Reply-To: <CAPig+cS3f2XggxqbvX6Z2Da24QKLOg915Bf-bTVa+4oVzfhA1A@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 4 May 2015 20:13:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 61BCDF18-F34C-11E4-8F7A-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268400>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, May 4, 2015 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> From: Eric Sunshine <sunshine@sunshineco.com>
>
> Thanks for re-rerolling this series. Considering that the only bits
> left from me are the diagnosis and the (mostly intact) commit message,
> perhaps the authorship should be changed, or at the very least a big
> "Helped-by: Junio" added? Anyhow, a few minor comments below...

I am a bit too lazy to take the ownership, so I decided only to take
the blame ;-)

Here is a replacement; all the other patches stay the same.

-- >8 --
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 4 May 2015 03:25:15 -0400
Subject: [PATCH] hash-object --literally: fix buffer overrun with extra-long object type

"hash-object" learned in 5ba9a93 (hash-object: add --literally
option, 2014-09-11) to allow crafting a corrupt/broken object of
unknown type.

When the user-provided type is particularly long, however, it can
overflow the relatively small stack-based character array handed to
write_sha1_file_prepare() by hash_sha1_file() and write_sha1_file(),
leading to stack corruption (and crash).  Introduce a custom helper
to allow arbitrarily long typenames just for "hash-object --literally".

[jc: Eric's original used a strbuf in the more common codepaths, and
I rewrote it to avoid penalizing the non-literally code. Bugs are mine]

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c |  4 +---
 cache.h               |  1 +
 sha1_file.c           | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 6158363..17e8bfdc 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -22,10 +22,8 @@ static int hash_literally(unsigned char *sha1, int fd, const char *type, unsigne
 
 	if (strbuf_read(&buf, fd, 4096) < 0)
 		ret = -1;
-	else if (flags & HASH_WRITE_OBJECT)
-		ret = write_sha1_file(buf.buf, buf.len, type, sha1);
 	else
-		ret = hash_sha1_file(buf.buf, buf.len, type, sha1);
+		ret = hash_sha1_file_literally(buf.buf, buf.len, type, sha1, flags);
 	strbuf_release(&buf);
 	return ret;
 }
diff --git a/cache.h b/cache.h
index dfa1a56..e037cad 100644
--- a/cache.h
+++ b/cache.h
@@ -888,6 +888,7 @@ static inline const unsigned char *lookup_replace_object_extended(const unsigned
 extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_noatime(const char *name);
diff --git a/sha1_file.c b/sha1_file.c
index c08c0cb..dc940e6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2962,6 +2962,27 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }
 
+int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type,
+			     unsigned char *sha1, unsigned flags)
+{
+	char *header;
+	int hdrlen, status = 0;
+
+	/* type string, SP, %lu of the length plus NUL must fit this */
+	header = xmalloc(strlen(type) + 32);
+	write_sha1_file_prepare(buf, len, type, sha1, header, &hdrlen);
+
+	if (!(flags & HASH_WRITE_OBJECT))
+		goto cleanup;
+	if (has_sha1_file(sha1))
+		goto cleanup;
+	status = write_loose_object(sha1, header, hdrlen, buf, len, 0);
+
+cleanup:
+	free(header);
+	return status;
+}
+
 int force_object_loose(const unsigned char *sha1, time_t mtime)
 {
 	void *buf;
-- 
2.4.0-311-gf1d9b8d
