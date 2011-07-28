From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/WIP 1/7] fast-import: extract object preparation function
Date: Thu, 28 Jul 2011 10:46:04 +0600
Message-ID: <1311828370-30477-2-git-send-email-divanorama@gmail.com>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 06:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIRW-0004RA-2K
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab1G1En2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:43:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36852 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab1G1EnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:43:25 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so881708fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 21:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=t2q0vLQPZfIdDiAdDqPI1FIHZQMtBq+3Z9aNFKYpIV8=;
        b=UX7yaGCg9J8oEhiFgcNPQQWcyPMLCzZuACgRkWE/4DMug8xMPvWEYuJ/Gd0zl2Jxm8
         8X+Gzm8YweqdGz1xCCPYodbDfOlbIxWe/vo/mVC814eSOicD9Xi9uogNwgiYMwht61N1
         njJXGR/9nFc0aUxz0sUUfp9AhLiwnE0pXeDus=
Received: by 10.204.168.129 with SMTP id u1mr175958bky.89.1311828203875;
        Wed, 27 Jul 2011 21:43:23 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id r24sm146189bkr.26.2011.07.27.21.43.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 21:43:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178008>

We're constructing raw objects and compute their sha1's in fast-import
just before saving them.

Extract header and sha1 computations so that we can get sha1 without
actually saving the object.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 9e8d186..05cc55e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1005,6 +1005,30 @@ static void cycle_packfile(void)
 	start_packfile();
 }
 
+static void prepare_object_hash(
+	enum object_type type,
+	struct strbuf *dat,
+	unsigned char *hdr_out,
+	unsigned long *hdrlen_out,
+	unsigned char *sha1_out
+)
+{
+	unsigned char hdr_[96];
+	unsigned char *hdr = hdr_out ? hdr_out : hdr_;
+	unsigned long hdrlen;
+	git_SHA_CTX c;
+
+	hdrlen = sprintf((char *)hdr,"%s %lu", typename(type),
+		(unsigned long)dat->len) + 1;
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, hdr, hdrlen);
+	git_SHA1_Update(&c, dat->buf, dat->len);
+	git_SHA1_Final(sha1_out, &c);
+
+	if (hdrlen_out)
+		*hdrlen_out = hdrlen;
+}
+
 static int store_object(
 	enum object_type type,
 	struct strbuf *dat,
@@ -1017,15 +1041,9 @@ static int store_object(
 	unsigned char hdr[96];
 	unsigned char sha1[20];
 	unsigned long hdrlen, deltalen;
-	git_SHA_CTX c;
 	git_zstream s;
 
-	hdrlen = sprintf((char *)hdr,"%s %lu", typename(type),
-		(unsigned long)dat->len) + 1;
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, hdrlen);
-	git_SHA1_Update(&c, dat->buf, dat->len);
-	git_SHA1_Final(sha1, &c);
+	prepare_object_hash(type, dat, hdr, &hdrlen, sha1);
 	if (sha1out)
 		hashcpy(sha1out, sha1);
 
-- 
1.7.3.4
