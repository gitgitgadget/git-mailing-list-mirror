From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/6] match_pathname: avoid calling strncmp if baselen is 0
Date: Sun, 10 Mar 2013 13:14:25 +0700
Message-ID: <1362896070-17456-2-git-send-email-pclouds@gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 07:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEZXX-00019T-8H
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 07:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112Ab3CJGOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 01:14:50 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:49001 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab3CJGOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 01:14:46 -0500
Received: by mail-pb0-f45.google.com with SMTP id ro8so2629435pbb.32
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 22:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NdfivxHV4pOuhjjpTeWxYl9UvkgyMl1+uFqeeT6FzLo=;
        b=j1zh+rfxpzC8veUbqwkaZmnuIEFzW/l2sWSQpMdZiA7waqP5CbnMtj9Qb+bxEo3r+c
         FZYa049FPlvOApxC6g7zYC480LhD3GB5xsznoeap/4Yv0yBLqQUQEDSdsYu0X6t0o0ke
         MHpKhzsPdKOiZDGPWBHTXuUHVEuVizFfdW42U/JYVrZSnMgHlk5CguL/iWFXea0aK4dl
         8/6PbN0Ry3L6jdHiPfET//CoyZmOPSY8wfBkMdEupTM+dC1zMJ+Lx8m9njTwA08n4dDT
         fJo+37k5koupXO/CZhTLa6n1VTVQRI4vaYRcecNwr5lOKi39dIjXU5s9FZGwR7EncIY6
         cbfw==
X-Received: by 10.68.204.234 with SMTP id lb10mr17372261pbc.64.1362896085636;
        Sat, 09 Mar 2013 22:14:45 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id ol7sm13855269pbb.14.2013.03.09.22.14.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 22:14:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Mar 2013 13:14:38 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217781>

This reduces "git status" user time by a little bit. This is the
sorted results of 10 consecutive runs of "git ls-files
--exclude-standard -o" on webkit.git, compiled with gcc -O2:

        before      after
user    0m0.607s    0m0.554s
user    0m0.613s    0m0.564s
user    0m0.613s    0m0.571s
user    0m0.621s    0m0.576s
user    0m0.621s    0m0.578s
user    0m0.622s    0m0.579s
user    0m0.624s    0m0.583s
user    0m0.626s    0m0.584s
user    0m0.628s    0m0.586s
user    0m0.638s    0m0.592s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 57394e4..b3cd66c 100644
--- a/dir.c
+++ b/dir.c
@@ -662,8 +662,8 @@ int match_pathname(const char *pathname, int pathle=
n,
 	 * may not end with a trailing slash though.
 	 */
 	if (pathlen < baselen + 1 ||
-	    (baselen && pathname[baselen] !=3D '/') ||
-	    strncmp_icase(pathname, base, baselen))
+	    (baselen && (pathname[baselen] !=3D '/' ||
+			 strncmp_icase(pathname, base, baselen))))
 		return 0;
=20
 	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
--=20
1.8.1.2.536.gf441e6d
