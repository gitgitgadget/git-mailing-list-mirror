From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/3] fast-import: extract object preparation function
Date: Fri, 12 Aug 2011 16:32:48 +0600
Message-ID: <1313145170-24471-2-git-send-email-divanorama@gmail.com>
References: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 12:32:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrp2b-0007lB-Vn
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 12:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314Ab1HLKce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 06:32:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42662 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1HLKcc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 06:32:32 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so1552656bke.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vA9CmY4jHu47vWRZUTEKLAZ1lyy4hrhT4xeUmpMDCwI=;
        b=XHMDWVNTyyMzdt9MdomvmoIJ+cimySvf2nBEn3mwLLRzUzPauRD/Fw+QO6oXQs28t6
         mdv50f/a86XeIegtXmesLgM/Mm501I0bUDuCpOYGfeeRWWZbArtM4VsVoVOq2NCCzGfq
         3+klraVcmxg6f9GeKBV2hb5TlcUhMkm1MZumo=
Received: by 10.205.82.197 with SMTP id ad5mr273293bkc.238.1313145151823;
        Fri, 12 Aug 2011 03:32:31 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id i14sm763298bkd.6.2011.08.12.03.32.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 03:32:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179224>

We're constructing raw objects and compute their sha1's in fast-import
just before saving them.

Extract header and sha1 computations so that we can get sha1 without
actually saving the object.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7cc2262..d0f8580 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1006,6 +1006,30 @@ static void cycle_packfile(void)
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
@@ -1018,15 +1042,9 @@ static int store_object(
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
