From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] read-cache: save trailing sha-1
Date: Sun, 12 Jan 2014 18:03:37 +0700
Message-ID: <1389524622-6702-2-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 12 11:58:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2Ikk-0006hX-Iu
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 11:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaALK6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jan 2014 05:58:44 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:53861 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaALK6d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 05:58:33 -0500
Received: by mail-pb0-f43.google.com with SMTP id rq2so6191037pbb.30
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 02:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Erxi95RFeM+BWmBpwSRTKsZGNewqJLrJsFngpzTDitM=;
        b=Eu28GdDY/96WSQah43mqyd47ugWixRcldE20z/gIAw6l0G+279u5C7y9qqEoJL0jNz
         3YPQJ4Bur8reTW/UxQJeRKiC6erTSOQS4LhWEDe+3A1RxRCrrJ6yIKeNEp7T1iVIasmt
         SRH8nNaSR8Og6zo0TzDBYlOBjAx9xAlkdipE8z2DRZEBKlboKY9HSMTYtOWtCxRKaB3q
         AeO4B5OpRieyqgSwsk0gMPOcBmm2HSrPM+g7Pra7FhmjcAmh6gV3sTh8CTtxv5Ks2lDA
         Q6WF663DWKFA0BHHnTz4fnnGel52JfYY2dwC9ZkQZ2UbscTbK2K7qlotiue317RIWuCr
         UMyA==
X-Received: by 10.68.129.99 with SMTP id nv3mr23230080pbb.40.1389524312755;
        Sun, 12 Jan 2014 02:58:32 -0800 (PST)
Received: from lanh ([115.73.194.184])
        by mx.google.com with ESMTPSA id i10sm38648327pat.11.2014.01.12.02.58.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 Jan 2014 02:58:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 12 Jan 2014 18:03:49 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240340>

This will be used as signature to know if the index has changed.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      | 1 +
 read-cache.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index ce377e1..7f7f306 100644
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
