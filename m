From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] read_index_from: remove bogus errno assignments
Date: Mon,  6 Aug 2012 18:27:09 +0700
Message-ID: <1344252429-7377-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 13:28:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyLU6-00018x-RZ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 13:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985Ab2HFL2Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 07:28:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56016 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab2HFL2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 07:28:23 -0400
Received: by pbbrr13 with SMTP id rr13so2459282pbb.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 04:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=c9LxvkIDkouGJhJukoker5LG837+R4my3pUKulXrU88=;
        b=bzar0u5+P5HrDA+wj/0w9OO8GvQU6i5Re6WwZh/CabUj4Ed+0ad1f3UJO3G0mj6PPX
         clsR3isvyxo/gGgOM/o9YlC6jXCpXAqrtSRzv+jQv4suhF9p6O0QpjZ7X/HwM+Yss59W
         pn7K5BKaJCoZdmPSl7U+7yUb7huaAa1ZQRM2718+0brSRPb+45ss1sJ7DKyAvGGlJYmH
         m8Y9T9tzhOmH/WgUWcIXKmv/7TO9VaXVxFI2h8NvpmsJxEJemV/GiRuapF0eVtDqccfv
         RS+X6WDeyPGRr6xJQUNYoN7ZzvPfB7dox5ctSpGVjsF+0GC/pml32/mhceRZyjlyHILy
         WAuw==
Received: by 10.68.192.40 with SMTP id hd8mr18521081pbc.125.1344252503210;
        Mon, 06 Aug 2012 04:28:23 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.55.147])
        by mx.google.com with ESMTPS id to6sm5372283pbc.12.2012.08.06.04.28.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Aug 2012 04:28:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 06 Aug 2012 18:27:19 +0700
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202962>

These assignments comes from the very first commit e83c516 (Initial
revision of "git", the information manager from hell - 2005-04-07).
Back then we did not die() when errors happened so correct errno was
required.

Since 5d1a5c0 ([PATCH] Better error reporting for "git status" -
2005-10-01), read_index_from() learned to die rather than just return
-1 and these assignments became irrelevant. Remove them.

While at it, move die_errno() next to xmmap() call because it's the
mmap's error code that we care about. Otherwise if close(fd); fails,
it could overwrite mmap's errno.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I saw the last hunk in this patch from 01/16 in Thomas's index v5
 series. But it looks more like an independent change. Thomas moved
 read_index_from code so this patch will cause conflicts with his
 series. It's a good change though, I think.

 read-cache.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2f8159f..76513cd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1414,11 +1414,9 @@ int read_index_from(struct index_state *istate, =
const char *path)
 	size_t mmap_size;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
=20
-	errno =3D EBUSY;
 	if (istate->initialized)
 		return istate->cache_nr;
=20
-	errno =3D ENOENT;
 	istate->timestamp.sec =3D 0;
 	istate->timestamp.nsec =3D 0;
 	fd =3D open(path, O_RDONLY);
@@ -1431,15 +1429,14 @@ int read_index_from(struct index_state *istate,=
 const char *path)
 	if (fstat(fd, &st))
 		die_errno("cannot stat the open index");
=20
-	errno =3D EINVAL;
 	mmap_size =3D xsize_t(st.st_size);
 	if (mmap_size < sizeof(struct cache_header) + 20)
 		die("index file smaller than expected");
=20
 	mmap =3D xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, =
fd, 0);
-	close(fd);
 	if (mmap =3D=3D MAP_FAILED)
 		die_errno("unable to map index file");
+	close(fd);
=20
 	hdr =3D mmap;
 	if (verify_hdr(hdr, mmap_size) < 0)
@@ -1495,7 +1492,6 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
=20
 unmap:
 	munmap(mmap, mmap_size);
-	errno =3D EINVAL;
 	die("index file corrupt");
 }
=20
--=20
1.7.8
