From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/8] wildmatch: make a special case for "*/" with FNM_PATHNAME
Date: Sat, 22 Dec 2012 14:57:07 +0700
Message-ID: <1356163028-29967-8-git-send-email-pclouds@gmail.com>
References: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 08:58:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmJyO-0000C1-Ov
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 08:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab2LVH6C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2012 02:58:02 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:41619 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2LVH6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 02:58:01 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so3143411pbc.31
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 23:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ms3lNAJbovZu/GNQTjcCbZ0BvdY4pwISuC8ICD8HW3Y=;
        b=LKS3jmSEKvTQm3jyk/NoZ2bnMrvpM2/kDNefbytu7LsuBHqMdpdmB5ozo0kuaR/Ga4
         18f1pWqymo8ghqzuW6V7zEuHhOdrZgLhpFW1VoMnHlOdtWqWZTSgzfM6CN4esOqBd2nk
         WAVN+qoU0oXYMp0WxPQ8w7YhPqshc5RyJroV8G6zW5jZU9tzb5bwkjtoRwH05Ijo1X0B
         3aPSNKV9osJxD4rFJHkpJgqVcDJnnsLCOM6+/D2gZZBVg5IzMd43v6z3+DaklV3mGEJ5
         u6Ud2+nRWU790Jo/Kz5V1JPS0JI2Dh3dhMG5xhxFLIihPQ06TqiCRaUgtJGNY/HJ2aUZ
         KaOQ==
X-Received: by 10.68.212.106 with SMTP id nj10mr47106140pbc.101.1356163080689;
        Fri, 21 Dec 2012 23:58:00 -0800 (PST)
Received: from lanh ([115.74.46.73])
        by mx.google.com with ESMTPS id gv9sm8431110pbc.21.2012.12.21.23.57.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 23:58:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Dec 2012 14:57:56 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212033>

Normally we need recursion for "*". In this case we know that it
matches everything until "/" so we can skip the recursion.

glibc, '*/*/*' on linux-2.6.git file list 2000 times
before:
wildmatch 8s 74513us
fnmatch   1s 97042us or 13.59% faster
after:
wildmatch 3s 521862us
fnmatch   3s 488616us or 99.06% slower

Same test with compat/fnmatch:
wildmatch 8s 110763us
fnmatch   2s 980845us or 36.75% faster
wildmatch 3s 522156us
fnmatch   1s 544487us or 43.85% slower

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/wildmatch.c b/wildmatch.c
index 4fe1d65..3794c4d 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -116,6 +116,18 @@ static int dowild(const uchar *p, const uchar *tex=
t, unsigned int flags)
 						return WM_NOMATCH;
 				}
 				return WM_MATCH;
+			} else if (*p =3D=3D '/' && (flags & WM_PATHNAME) && !special) {
+				/*
+				 * an asterisk followed by a slash
+				 * with WM_PATHNAME matches the next
+				 * directory
+				 */
+				const char *slash =3D strchr((char*)text, '/');
+				if (!slash)
+					return WM_NOMATCH;
+				text =3D (const uchar*)slash;
+				/* the slash is consumed by the top-level for loop */
+				break;
 			}
 			while (1) {
 				if (t_ch =3D=3D '\0')
--=20
1.8.0.rc2.23.g1fb49df
