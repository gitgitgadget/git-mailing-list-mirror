From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] zlib: wrap inflateInit2 used to accept only for gzip
 format
Date: Fri, 10 Jun 2011 13:15:45 -0700
Message-ID: <1307736948-16956-4-git-send-email-gitster@pobox.com>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 22:16:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV87o-00068o-DF
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119Ab1FJUQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:16:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758111Ab1FJUP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:15:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E12584253
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=mdkJ
	cIgrztKplfPvSwvgVCIEEGk=; b=ZhIQCcoo/zqqBZd1YWA3T8fJV4UTvSA0IGnn
	Qr7dpHdDASaUYxG7ENeiDJzyaerAhPju8kkzjdhAi8D5FGF+BvIG0qAYnCqEeVWy
	LqGqKyYxJb71+vd4vUqf6Q0dUnvpED5zJFeDGgeapFdYrZOxHuluFbFXqvNfLdX7
	XXo1phc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HyWRdu
	imxKVYyQ8+L8xERdZwfDMyH27umx8ai6DRQ7fz/LIIFqttG2tgh3bO1vNSG6RPW/
	Wah3Em1JSSsRbVMUTSM4RXzJlt+Zd2PgZk+IOvdJbCZknehh4KLSNFXGWu5WaqXq
	k7i3ozpenVX2fh3mvO/VCSbRRhiu+luvaGmF8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C40664252
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 226E04251 for
 <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc1.118.ge175b4a
In-Reply-To: <1307736948-16956-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C09E076C-939E-11E0-A88D-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175623>

http-backend.c uses inflateInit2() to tell the library that it wants to
accept only gzip format. Wrap it in a helper function so that readers do
not have to wonder what the magic numbers 15 and 16 are for.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h        |    1 +
 http-backend.c |    5 +----
 zlib.c         |   15 +++++++++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index ce73e1f..50f09d0 100644
--- a/cache.h
+++ b/cache.h
@@ -21,6 +21,7 @@
 #endif
 
 void git_inflate_init(z_streamp strm);
+void git_inflate_init_gzip_only(z_streamp strm);
 void git_inflate_end(z_streamp strm);
 int git_inflate(z_streamp strm, int flush);
 
diff --git a/http-backend.c b/http-backend.c
index c74cb03..ab5015d 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -275,12 +275,9 @@ static void inflate_request(const char *prog_name, int out)
 	unsigned char in_buf[8192];
 	unsigned char out_buf[8192];
 	unsigned long cnt = 0;
-	int ret;
 
 	memset(&stream, 0, sizeof(stream));
-	ret = inflateInit2(&stream, (15 + 16));
-	if (ret != Z_OK)
-		die("cannot start zlib inflater, zlib err %d", ret);
+	git_inflate_init_gzip_only(&stream);
 
 	while (1) {
 		ssize_t n = xread(0, in_buf, sizeof(in_buf));
diff --git a/zlib.c b/zlib.c
index be9d7e9..b613cbd 100644
--- a/zlib.c
+++ b/zlib.c
@@ -32,6 +32,21 @@ void git_inflate_init(z_streamp strm)
 	    strm->msg ? strm->msg : "no message");
 }
 
+void git_inflate_init_gzip_only(z_streamp strm)
+{
+	/*
+	 * Use default 15 bits, +16 is to accept only gzip and to
+	 * yield Z_DATA_ERROR when fed zlib format.
+	 */
+	const int windowBits = 15 + 16;
+	int status = inflateInit2(strm, windowBits);
+
+	if (status == Z_OK)
+		return;
+	die("inflateInit2: %s (%s)", zerr_to_string(status),
+	    strm->msg ? strm->msg : "no message");
+}
+
 void git_inflate_end(z_streamp strm)
 {
 	int status = inflateEnd(strm);
-- 
1.7.6.rc1.118.ge175b4a
