From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/12] index-pack: do not allocate buffer for unpacking deltas in the first pass
Date: Sat,  7 Sep 2013 17:43:10 +0700
Message-ID: <1378550599-25365-4-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:40:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFwn-0002df-QD
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab3IGKky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:40:54 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:56229 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3IGKkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:40:53 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so4239917pbb.34
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JxPRMBP1KrikM78y4jZi7A3mCc4Ii08xHnPyDrHgsOE=;
        b=a1wP4m65KsC+kYvV/yuv1QfNRTkdY75YhBvIaeIUE4vDLu/bBvYFoknbQ99HSdkUzB
         xEWeWFdnvLY/TIuq4MKP//wpmvtsQJY7RJrISOQ6sMcK3f/Db3PeUCI+rIoto82UPJ3X
         zQKL6ui4EMhBwpdkMYdGwa1ow7wOahxCrDmhfezrSaYgjGg3JtR3Huu05sPJ5BjKC9Ts
         GQc86LT9pQIulS0+rY+8Na1jzS30T3xoa7Rj0KQ8PKxlKZDek3QmTMo5QsjJ6Wc41TFM
         hhxVYM4abY5Ms+3CJn+ekIujrs49CVhxfUA+dS8zUgUcKWH0Q+enQFO86+HR/lIjXgS5
         9wNg==
X-Received: by 10.68.113.130 with SMTP id iy2mr761015pbb.171.1378550452757;
        Sat, 07 Sep 2013 03:40:52 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id fa4sm3930806pab.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:40:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:44:00 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234121>

We do need deltas until the second pass. Allocating a buffer for it
then freeing later is wasteful is unnecessary. Make it use fixed_buf
(aka large blob code path).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5b1395d..a47cc34 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -446,7 +446,8 @@ static void *unpack_entry_data(unsigned long offset=
, unsigned long size,
 		git_SHA1_Update(&c, hdr, hdrlen);
 	} else
 		sha1 =3D NULL;
-	if (type =3D=3D OBJ_BLOB && size > big_file_threshold)
+	if (is_delta_type(type) ||
+	     (type =3D=3D OBJ_BLOB && size > big_file_threshold))
 		buf =3D fixed_buf;
 	else
 		buf =3D xmalloc(size);
--=20
1.8.2.83.gc99314b
