From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] read-cache: factor out cache entries reading code
Date: Sun,  5 Feb 2012 15:30:03 +0700
Message-ID: <1328430605-4566-2-git-send-email-pclouds@gmail.com>
References: <1328430605-4566-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 09:31:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtxVS-0002Pw-Kr
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 09:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab2BEIbT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 03:31:19 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36557 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2BEIa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 03:30:56 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so4091382pbd.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 00:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aGFG9IxXlxY+Czr09o5bookp+4ywzvpmDZtDyr6DGao=;
        b=iv1YTHrb7vxB5SL2YlHf2/noHFkEN2EII6f17iR10WU5bRjoTlw4jYna64c56c0PPB
         /g7GXRFE2vmQGhDnWnXDGPhkqynoLCBOLOxSkBNo3LGhim8utSxFAmpiJCcGJVf0vkce
         EQYHdzgvzdvNbBFHqasLF6Yive09UTmDFlw1c=
Received: by 10.68.219.232 with SMTP id pr8mr35427759pbc.12.1328430656547;
        Sun, 05 Feb 2012 00:30:56 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.57.120])
        by mx.google.com with ESMTPS id kx17sm28965671pbb.19.2012.02.05.00.30.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 00:30:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 05 Feb 2012 15:30:14 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328430605-4566-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189935>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a51bba1..2dbf923 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1273,10 +1273,28 @@ static struct cache_entry *create_from_disk(str=
uct ondisk_cache_entry *ondisk)
 	return ce;
 }
=20
+static int read_cache_entries(struct index_state *istate,
+			      const char *mmap, unsigned long src_offset)
+{
+	const char *buf =3D mmap + src_offset;
+	int i;
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		struct ondisk_cache_entry *disk_ce;
+		struct cache_entry *ce;
+
+		disk_ce =3D (struct ondisk_cache_entry *)buf;
+		ce =3D create_from_disk(disk_ce);
+		set_index_entry(istate, i, ce);
+		buf +=3D ondisk_ce_size(ce);
+	}
+	return buf - mmap;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
-	int fd, i;
+	int fd;
 	struct stat st;
 	unsigned long src_offset;
 	struct cache_header *hdr;
@@ -1319,17 +1337,7 @@ int read_index_from(struct index_state *istate, =
const char *path)
 	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(struct cache_en=
try *));
 	istate->initialized =3D 1;
=20
-	src_offset =3D sizeof(*hdr);
-	for (i =3D 0; i < istate->cache_nr; i++) {
-		struct ondisk_cache_entry *disk_ce;
-		struct cache_entry *ce;
-
-		disk_ce =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset)=
;
-		ce =3D create_from_disk(disk_ce);
-		set_index_entry(istate, i, ce);
-
-		src_offset +=3D ondisk_ce_size(ce);
-	}
+	src_offset =3D read_cache_entries(istate, mmap, sizeof(*hdr));
 	istate->timestamp.sec =3D st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
=20
--=20
1.7.8.36.g69ee2
