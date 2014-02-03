From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/26] read-cache: save trailing sha-1
Date: Mon,  3 Feb 2014 11:28:57 +0700
Message-ID: <1391401754-15347-10-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:30:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABAn-00017N-Bm
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbaBCEaK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:30:10 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:61503 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaBCEaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:30:09 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so6579575pbc.16
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PHwVjtrr+GCh3PT7RE5IE7D4bTsrE0aqNSkfdsDQJLk=;
        b=t/jePeVqBxIxyn0TgqJdD6gV3vpE/Y5NOgYSw8tWibxtjWvOihIJ/1n3i5QtArk/CQ
         Z8qwz9FFj/XSaVRu6ayKJsBn9E4a8TyllGWUcAjJyKxa0RWIn+4K3r/izM0yck6sFEaZ
         f/lUznlMUBESX52YD+7DFFjBEOzrcMoIfgqbi1XQ+SDJ1vgnHhijOUqIFn/wdStjF+Ke
         XvViNBgtRZxrWymx8yY3UPAQEHzNhEyT4D16WwxTUqPt46nPYpwDg2Zba9k2ItkGrT9H
         ybCWJgDtNjn9VBtmXIWsdOvyz5W++6h+nupbyje+ISGcaXCaqFcRIoKRGTrfSiOaLgV+
         Dl6g==
X-Received: by 10.66.154.75 with SMTP id vm11mr35369581pab.124.1391401808792;
        Sun, 02 Feb 2014 20:30:08 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id qq5sm51410252pbb.24.2014.02.02.20.30.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:30:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:30:06 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241404>

This will be used as signature to know if the index has changed.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      | 1 +
 read-cache.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 7a836b1..f14d535 100644
--- a/cache.h
+++ b/cache.h
@@ -279,6 +279,7 @@ struct index_state {
 		 initialized : 1;
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
+	unsigned char sha1[20];
 };
=20
 extern struct index_state the_index;
diff --git a/read-cache.c b/read-cache.c
index 33dd676..3b6daf1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1269,10 +1269,11 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
=20
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(struct cache_header *hdr,
+		      unsigned long size,
+		      unsigned char *sha1)
 {
 	git_SHA_CTX c;
-	unsigned char sha1[20];
 	int hdr_version;
=20
 	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
@@ -1461,7 +1462,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	close(fd);
=20
 	hdr =3D mmap;
-	if (verify_hdr(hdr, mmap_size) < 0)
+	if (verify_hdr(hdr, mmap_size, istate->sha1) < 0)
 		goto unmap;
=20
 	istate->version =3D ntohl(hdr->hdr_version);
--=20
1.8.5.2.240.g8478abd
