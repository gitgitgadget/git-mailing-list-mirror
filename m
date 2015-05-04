From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] write_sha1_file_prepare: fix buffer overrun with extra-long object type
Date: Mon,  4 May 2015 03:25:15 -0400
Message-ID: <1430724315-524-4-git-send-email-sunshine@sunshineco.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 09:26:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpAlM-0005IC-Vq
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 09:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbbEDHZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 03:25:45 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35078 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbEDHZi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 03:25:38 -0400
Received: by iejt8 with SMTP id t8so124089285iej.2
        for <git@vger.kernel.org>; Mon, 04 May 2015 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R82nPnkIopS4828Ti2mHpKdxEc5A02ywRzPSf7NMWYc=;
        b=pWvJGrc6rUdU80G2yqZ/n9MuJgJGjD+ZFjBeL/4spECo/UlGPR0DUWQbbTlIAUbht7
         0NrSqasVAe+HLIMunjVntis5zI6d+psWypcLom2FjtUs5f66UXahPxci7+YySD4QRbN/
         J01iY3MXFRxZ+q4hEeVJ3jAbm/d0uvQ543CpV+paoV4rvv446aIeJzTSQW5IlkM/I2CU
         zYltNCvfaGB2gdIfQAyaQncXmOiAnxIqd2xE5x+t7GiQjtDMOvLQ1cpo6ELuLhvEA/2w
         vcj2+MMvOVwB8n86PWiNmPqWQW3N2r7zfbCustf9r0pZ0WX60DPEQLlmwv9nw00R2wux
         lAog==
X-Received: by 10.42.128.84 with SMTP id l20mr27408551ics.21.1430724337200;
        Mon, 04 May 2015 00:25:37 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id r4sm4707630igw.12.2015.05.04.00.25.36
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 00:25:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.319.g7a04823
In-Reply-To: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268308>

git-hash-object learned --literally in 5ba9a93 (hash-object: add
--literally option, 2014-09-11) which can be used to craft a
corrupt/broken object of unknown type. When the user-provided type is
particularly long, it can overflow the relatively small stack-based
character array handed to write_sha1_file_prepare() by hash_sha1_file()
and write_sha1_file(), leading to stack corruption (and crash).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

The composed 'hdr' is supposed to be NUL-terminated, and code which
accesses 'hdr' expects the NUL to be included as part of its length.
Although strbuf ensures that a NUL byte follows the string content, I
took the precaution of explicitly adding NUL when formulating 'hdr'

    strbuf_addf(hdr, "%s %lu%c", type, len, '\0');

so that callers can just say hdr.len when the length is needed, rather
than having to remember to say hdr.len+1.


I haven't fully convinced myself that this fix is appropriate since it
penalizes _all_ callers of hash_sha1_file() and write_sha1_file() with
an extra heap allocation (via strbuf), even though "hash-object
--literally" is the only mechanism by which an overly-long object type
can arrive.

 sha1_file.c            | 21 ++++++++++-----------
 t/t1007-hash-object.sh |  2 +-
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 88f06ba..6d3fa26 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2795,16 +2795,16 @@ void *read_object_with_reference(const unsigned char *sha1,
 
 static void write_sha1_file_prepare(const void *buf, unsigned long len,
                                     const char *type, unsigned char *sha1,
-                                    char *hdr, int *hdrlen)
+				    struct strbuf *hdr)
 {
 	git_SHA_CTX c;
 
 	/* Generate the header */
-	*hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
+	strbuf_addf(hdr, "%s %lu%c", type, len, '\0');
 
 	/* Sha1.. */
 	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, *hdrlen);
+	git_SHA1_Update(&c, hdr->buf, hdr->len);
 	git_SHA1_Update(&c, buf, len);
 	git_SHA1_Final(sha1, &c);
 }
@@ -2865,9 +2865,8 @@ static int write_buffer(int fd, const void *buf, size_t len)
 int hash_sha1_file(const void *buf, unsigned long len, const char *type,
                    unsigned char *sha1)
 {
-	char hdr[32];
-	int hdrlen;
-	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	struct strbuf hdr = STRBUF_INIT;
+	write_sha1_file_prepare(buf, len, type, sha1, &hdr);
 	return 0;
 }
 
@@ -3005,18 +3004,18 @@ static int freshen_packed_object(const unsigned char *sha1)
 int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
 	unsigned char sha1[20];
-	char hdr[32];
-	int hdrlen;
+	struct strbuf hdr = STRBUF_INIT;
 
-	/* Normally if we have it in the pack then we do not bother writing
+	/*
+	 * Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	write_sha1_file_prepare(buf, len, type, sha1, &hdr);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
 	if (freshen_loose_object(sha1) || freshen_packed_object(sha1))
 		return 0;
-	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
+	return write_loose_object(sha1, hdr.buf, hdr.len, buf, len, 0);
 }
 
 int force_object_loose(const unsigned char *sha1, time_t mtime)
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 0e65577..7c3dcfb 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -206,7 +206,7 @@ test_expect_success '--literally' '
 	echo example | git hash-object -t $t --literally --stdin
 '
 
-test_expect_failure '--literally with extra-long type' '
+test_expect_success '--literally with extra-long type' '
 	t=12345678901234567890123456789012345678901234567890 &&
 	t="$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t" &&
 	echo example | git hash-object -t $t --literally --stdin
-- 
2.4.0.319.g7a04823
