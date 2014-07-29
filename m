From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] utf8.c: fix strbuf_utf8_replace copying the last NUL to dst string
Date: Tue, 29 Jul 2014 20:10:29 +0700
Message-ID: <1406639429-28748-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7As-00043g-FV
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbaG2NKe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:10:34 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34169 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaG2NKd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:10:33 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so11617898pdb.19
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=pS9he6ETwZvk1IYlLrELSwbmgVEW7SLW7UD8OIrb/EY=;
        b=mrRCia8jq+nxgnS/CcIru/G2v8cb6OBzQt6rSNxiR7uxCv0jIVpEYqLXGvPZ/dyAei
         l7fwiEuqvQQ9O4DN3BxD+db0x+KGgA1V+OHW5dLTeBtNgtrpsW3y3S3ymiFXfp7ZjQV/
         pmYw8qdxUBcIoYYFhdnsSgypKtz9ysD3sem/Lh3E9oLnlfK7FtVv/zW+Mrr5WhQ4hv3P
         3fdx7BYEqk6TUB3ciN+scPBBw880ii66lZoMJ+tyLHMqqoIltda+c/LOs7Nu9DX3DHih
         4xGLY5x8rk3fYouYzqkWQE3BVutSw34VYBuU0b78FVkfsdCqAV5bNv9Fre5sLNXhCHlc
         SbXA==
X-Received: by 10.70.88.105 with SMTP id bf9mr2081869pdb.54.1406639433512;
        Tue, 29 Jul 2014 06:10:33 -0700 (PDT)
Received: from lanh ([115.73.243.195])
        by mx.google.com with ESMTPSA id w7sm28895587pdo.90.2014.07.29.06.10.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2014 06:10:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jul 2014 20:10:35 +0700
X-Mailer: git-send-email 2.1.0.rc0.66.gb9187ad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254430>

When utf8_width(&src) is called with *src =3D=3D NULL (because the
source string ends with an ansi sequence), it returns 0 and steps
'src' by one. This stepping makes strbuf_utf8_replace add NUL to the
destination string at the end of the loop. Check and break the loop
early.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 utf8.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/utf8.c b/utf8.c
index b30790d..cd090a1 100644
--- a/utf8.c
+++ b/utf8.c
@@ -381,6 +381,8 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int=
 pos, int width,
 			src +=3D n;
 			dst +=3D n;
 		}
+		if (src >=3D end)
+			break;
=20
 		old =3D src;
 		n =3D utf8_width((const char**)&src, NULL);
--=20
2.1.0.rc0.66.gb9187ad
