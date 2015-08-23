From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] dir.c: make last_exclude_matching_from_list() run til the end
Date: Sun, 23 Aug 2015 19:50:13 +0700
Message-ID: <1440334214-32131-2-git-send-email-pclouds@gmail.com>
References: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 14:51:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTUjr-0007MZ-Bm
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 14:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbbHWMu6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 08:50:58 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36677 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbbHWMup (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 08:50:45 -0400
Received: by pdbmi9 with SMTP id mi9so42911309pdb.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ttjoz9czH4hUh1iVBrnUVhahJ95fggYSGEZvU6ycdVg=;
        b=XCPpggj37a01cBNvSThp1NlsXgUAdL4Oc7tNg0Wo4PTLGL/BLhOpLtbGYM/n2k3Xx9
         nx+Sg9Ae07dxXo18V+k2gOmek1XLMCFrFhdXYupSuibsEqCnPOLMHAObw+mJHCukurHl
         KkIrRRSOYyW+zcj6iOL9YX2fHIAnGJu28enOJ7U54IbaRmaXAdIRv2kQClIg/w2GncoX
         XpxFec+B7BOs0oNyOZUzbN5KwisEvr6qovUJwex6SqE7laiG3I0aArHd3NcsHoWX3ZYQ
         Sp43W+mXemELTs625ltaKhRKDm8pq/zIFJ4iptegg4FmoVBjRI1wKTV0yaIZmxgFigKT
         VDdg==
X-Received: by 10.70.95.138 with SMTP id dk10mr32863560pdb.57.1440334244802;
        Sun, 23 Aug 2015 05:50:44 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id pu7sm13895815pdb.94.2015.08.23.05.50.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2015 05:50:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 23 Aug 2015 19:50:43 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276406>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index c00c7e2..3a7630a 100644
--- a/dir.c
+++ b/dir.c
@@ -901,6 +901,7 @@ static struct exclude *last_exclude_matching_from_l=
ist(const char *pathname,
 						       int *dtype,
 						       struct exclude_list *el)
 {
+	struct exclude *exc =3D NULL; /* undecided */
 	int i;
=20
 	if (!el->nr)
@@ -922,18 +923,22 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 			if (match_basename(basename,
 					   pathlen - (basename - pathname),
 					   exclude, prefix, x->patternlen,
-					   x->flags))
-				return x;
+					   x->flags)) {
+				exc =3D x;
+				break;
+			}
 			continue;
 		}
=20
 		assert(x->baselen =3D=3D 0 || x->base[x->baselen - 1] =3D=3D '/');
 		if (match_pathname(pathname, pathlen,
 				   x->base, x->baselen ? x->baselen - 1 : 0,
-				   exclude, prefix, x->patternlen, x->flags))
-			return x;
+				   exclude, prefix, x->patternlen, x->flags)) {
+			exc =3D x;
+			break;
+		}
 	}
-	return NULL; /* undecided */
+	return exc;
 }
=20
 /*
--=20
2.3.0.rc1.137.g477eb31
