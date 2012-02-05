From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] read-cache: reduce malloc/free during writing index
Date: Sun,  5 Feb 2012 15:30:04 +0700
Message-ID: <1328430605-4566-3-git-send-email-pclouds@gmail.com>
References: <1328430605-4566-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 09:31:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtxVR-0002Pw-0S
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 09:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab2BEIbV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 03:31:21 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36557 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2BEIbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 03:31:04 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so4091382pbd.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 00:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UbNdOql9zEDyFir1GX3Jf1NLjpuv2rqTHGmLhEX+HmI=;
        b=n8scZLCf++98x/W9R4lQ4FrbaywVnuA014yWZZibG4GVfNZgNVCeTqhM/wJL5hSs4u
         mUBAfjuiOtfJOu3q/FmC9vHDpmdUVVi07c6RL3ilokAzC+CS+PL93GOjuqOKFEa48Z8m
         t7BdKwpt0rDEgQqUqY0dxejhx9MiTX8gNfUqk=
Received: by 10.68.227.71 with SMTP id ry7mr6899186pbc.114.1328430664383;
        Sun, 05 Feb 2012 00:31:04 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.57.120])
        by mx.google.com with ESMTPS id p9sm28945648pbb.9.2012.02.05.00.31.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 00:31:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 05 Feb 2012 15:30:22 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328430605-4566-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189934>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2dbf923..7b9a989 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1521,12 +1521,19 @@ static void ce_smudge_racily_clean_entry(struct=
 cache_entry *ce)
 	}
 }
=20
-static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *=
ce)
+static int ce_prepare_ondisk_entry(struct cache_entry *ce,
+				    void **ondisk_p, int *ondisk_size)
 {
 	int size =3D ondisk_ce_size(ce);
-	struct ondisk_cache_entry *ondisk =3D xcalloc(1, size);
+	struct ondisk_cache_entry *ondisk;
 	char *name;
-	int result;
+
+	if (size <=3D *ondisk_size)
+		ondisk =3D *ondisk_p;
+	else {
+		ondisk =3D *ondisk_p =3D xrealloc(*ondisk_p, size);
+		*ondisk_size =3D size;
+	}
=20
 	ondisk->ctime.sec =3D htonl(ce->ce_ctime.sec);
 	ondisk->mtime.sec =3D htonl(ce->ce_mtime.sec);
@@ -1549,10 +1556,7 @@ static int ce_write_entry(git_SHA_CTX *c, int fd=
, struct cache_entry *ce)
 	else
 		name =3D ondisk->name;
 	memcpy(name, ce->name, ce_namelen(ce));
-
-	result =3D ce_write(c, fd, ondisk, size);
-	free(ondisk);
-	return result;
+	return size;
 }
=20
 static int has_racy_timestamp(struct index_state *istate)
@@ -1588,6 +1592,8 @@ int write_index(struct index_state *istate, int n=
ewfd)
 	struct cache_entry **cache =3D istate->cache;
 	int entries =3D istate->cache_nr;
 	struct stat st;
+	void *ce_ondisk =3D NULL;
+	int ce_ondisk_size =3D 0;
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -1612,13 +1618,17 @@ int write_index(struct index_state *istate, int=
 newfd)
=20
 	for (i =3D 0; i < entries; i++) {
 		struct cache_entry *ce =3D cache[i];
+		int size;
+
 		if (ce->ce_flags & CE_REMOVE)
 			continue;
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
-		if (ce_write_entry(&c, newfd, ce) < 0)
+		size =3D ce_prepare_ondisk_entry(ce, &ce_ondisk, &ce_ondisk_size);
+		if (ce_write(&c, newfd, ce_ondisk, size) < 0)
 			return -1;
 	}
+	free(ce_ondisk);
=20
 	/* Write extension data here */
 	if (istate->cache_tree) {
--=20
1.7.8.36.g69ee2
