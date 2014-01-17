From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 01/14] read-cache: save trailing sha-1
Date: Fri, 17 Jan 2014 16:47:27 +0700
Message-ID: <1389952060-12297-2-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:48:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W462E-0001ya-2A
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbaAQJsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:48:13 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:47378 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaAQJsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:48:10 -0500
Received: by mail-pd0-f181.google.com with SMTP id y10so243200pdj.26
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iuyWT2Rb5/yO2zUkcQnt2jTmE+qIrSkFj0cQo9p3ePg=;
        b=aTdhhyLDzaFkrgT7MHmBkfxLZnNsI+L7bPyCCYjU/Se6o+nZv19fauiZtRunm40o/J
         Fgo2SkCJl/QV8jdofqApvsIE2HTAY6lbEUSIrFpi6VbJP8b/dcsZxJdA81OAtMWi02Gz
         Z9ebOqh6CldIrajdIDAjcIP9hdYhTu18gz8DSLAF/D15UueODnrGkeSe0JDLAKxHSDfM
         +Dhsg1ShaT0vOkeXNPVYY7/aaywNVOl5avkuai+dfI0EtNyILwCPHTAJlnFtOLlSjHkN
         R70goBkfhcVC5IIO2s3/G4dnqBySBzzxEVeGRFZyajeRf8mma55W2PLXsirIFX2cn+o/
         qXCQ==
X-Received: by 10.68.171.193 with SMTP id aw1mr947779pbc.117.1389952090165;
        Fri, 17 Jan 2014 01:48:10 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id gg10sm21299387pbc.46.2014.01.17.01.48.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:48:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:48:04 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240582>

This will be used as signature to know if the index has changed.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      | 1 +
 read-cache.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 323481c..a09d622 100644
--- a/cache.h
+++ b/cache.h
@@ -279,6 +279,7 @@ struct index_state {
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
+	unsigned char sha1[20];
 };
=20
 extern struct index_state the_index;
diff --git a/read-cache.c b/read-cache.c
index 3f735f3..fe1d153 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1273,10 +1273,11 @@ struct ondisk_cache_entry_extended {
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
@@ -1465,7 +1466,7 @@ int read_index_from(struct index_state *istate, c=
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
1.8.5.1.208.g05b12ea
