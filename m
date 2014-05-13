From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/8] read-cache: skip verifying trailing SHA-1 on cached index
Date: Tue, 13 May 2014 18:15:36 +0700
Message-ID: <1399979737-8577-10-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:16:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAhK-0000jn-Hy
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760994AbaEMLQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:16:33 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:36508 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760209AbaEMLQc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:16:32 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so162461pbb.31
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FHEUNppws3+ClfO77lXkfLqcoqlHHWOxUu2qngtnh68=;
        b=Pq/tnj3VOnfDfA6jVgKvoMmzIdZ406gobb7jvaeYEP87hz7qlEMoDPwwNUyEk4sFtv
         IStKdIdS/+Et99sQxgvyLSmf/SqQkNAR1Ml/lVZLihRk/Cy+ZvzAta01m25jJZWdCjnR
         o0GRS64NZo5r3IXE8GWnGxqzbUyfBZZQwgvJFcFfvgKO52lgoRa1/H5x1yNtyFPQUW5s
         PDdnB2OEwgrHv1djW0QKVk4BLseQZ+jqOheSfAXsx61X+7pLa/tmx23HEbPr6r31jnEI
         gxgXpWutUu+85iIjVeYlP7uSSHdhpafTKp3tYec8Q3OElfEdsZCkCN6KOfTKFVfqawTO
         doqQ==
X-Received: by 10.66.66.135 with SMTP id f7mr63816044pat.22.1399979791820;
        Tue, 13 May 2014 04:16:31 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id qv3sm27688386pbb.87.2014.05.13.04.16.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:16:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:16:37 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248769>

The daemon is responsible for verifying the index before putting it in
the shared memory. No need to redo it again.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4041485..e98521f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1332,6 +1332,8 @@ static int verify_hdr(struct cache_header *hdr, u=
nsigned long size)
 	hdr_version =3D ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
+	if (!size)
+		return 0;
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
 	git_SHA1_Final(sha1, &c);
@@ -1511,7 +1513,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	struct stat st;
 	unsigned long src_offset;
 	struct cache_header *hdr;
-	void *mmap;
+	void *mmap, *old_mmap;
 	size_t mmap_size;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
=20
@@ -1543,9 +1545,10 @@ int do_read_index(struct index_state *istate, co=
nst char *path, int must_exist)
 	}
 	close(fd);
=20
+	old_mmap =3D mmap;
 	mmap =3D try_shm(mmap, &mmap_size);
 	hdr =3D mmap;
-	if (verify_hdr(hdr, mmap_size) < 0)
+	if (verify_hdr(hdr, old_mmap !=3D mmap ? 0 : mmap_size) < 0)
 		goto unmap;
=20
 	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - 20);
--=20
1.9.1.346.ga2b5940
