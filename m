From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 8/9] wildmatch: advance faster in <asterisk> + <literal> patterns
Date: Fri, 28 Dec 2012 11:10:53 +0700
Message-ID: <1356667854-8686-9-git-send-email-pclouds@gmail.com>
References: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 05:12:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToRJ2-00017p-Dj
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 05:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab2L1EMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Dec 2012 23:12:05 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:53054 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab2L1EME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 23:12:04 -0500
Received: by mail-pb0-f41.google.com with SMTP id xa7so5715206pbc.0
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 20:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=TfPKhF6t3vlZQCRxCOFoW11D0zJWqED5+2Yv9Rb50vg=;
        b=UItaNrKV7c8vcxOfRZTP6CesCvw5Xn3WVr6DpVb7UXRDmLISuLBMPOjujDGqpnw09Y
         tDIAjKA4buEVDTaW7olcnRNFfgVVu6umviHBcHUaNSLn++14NqI+k9T/k4nYZ0scQ6CR
         FK7ugYwosmrzc8WJCC6ihCZQKOPr+EQbi+QWGL/Y58fpVkkpR7J5m/BF4vi0s9bgZ/8a
         2AWKV11M1HHwZelWwq2VB/iO8nRBv6/Dy6d8fiRca+ZnEI7e9OERFpVgRlffDT7Uj6+j
         wcpkdvZ/VoN4gfHstpxof/3xJmdSfqftATct7O/LqTOrjLL0eqBLsqkQrDLwRdPlzBWr
         x8zA==
X-Received: by 10.66.81.198 with SMTP id c6mr95425704pay.50.1356667923848;
        Thu, 27 Dec 2012 20:12:03 -0800 (PST)
Received: from lanh ([115.74.54.149])
        by mx.google.com with ESMTPS id oj1sm18929686pbb.19.2012.12.27.20.12.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2012 20:12:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 28 Dec 2012 11:12:04 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212231>

compat, '*/*/*' on linux-2.6.git file list 2000 times, before:
wildmatch 7s 985049us
fnmatch   2s 735541us or 34.26% faster

and after:
wildmatch 4s 492549us
fnmatch   0s 888263us or 19.77% slower

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3070-wildmatch.sh |  6 ++++++
 wildmatch.c          | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 4cdb13b..dcbc8bc 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -207,6 +207,9 @@ match 0 x foo '*/*/*'
 match 0 x foo/bar '*/*/*'
 match 1 x foo/bba/arr '*/*/*'
 match 0 x foo/bb/aa/rr '*/*/*'
+match 1 x abcXdefXghi '*X*i'
+match 0 x ab/cXd/efXg/hi '*X*i'
+match 1 x ab/cXd/efXg/hi '*/*X*/*/*i'
=20
 pathmatch 1 foo foo
 pathmatch 0 foo fo
@@ -226,5 +229,8 @@ pathmatch 0 foo '*/*/*'
 pathmatch 0 foo/bar '*/*/*'
 pathmatch 1 foo/bba/arr '*/*/*'
 pathmatch 1 foo/bb/aa/rr '*/*/*'
+pathmatch 1 abcXdefXghi '*X*i'
+pathmatch 1 ab/cXd/efXg/hi '*/*X*/*/*i'
+pathmatch 1 ab/cXd/efXg/hi '*Xg*i'
=20
 test_done
diff --git a/wildmatch.c b/wildmatch.c
index f6d45d5..40eda08 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -132,6 +132,27 @@ static int dowild(const uchar *p, const uchar *tex=
t, unsigned int flags)
 			while (1) {
 				if (t_ch =3D=3D '\0')
 					break;
+				/*
+				 * Try to advance faster when an asterisk is
+				 * followed by a literal. We know in this case
+				 * that the the string before the literal
+				 * must belong to "*".
+				 */
+				if (!is_glob_special(*p)) {
+					p_ch =3D *p;
+					if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
+						p_ch =3D tolower(p_ch);
+					while ((t_ch =3D *text) !=3D '\0' &&
+					       (!(flags & WM_PATHNAME) || t_ch !=3D '/')) {
+						if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
+							t_ch =3D tolower(t_ch);
+						if (t_ch =3D=3D p_ch)
+							break;
+						text++;
+					}
+					if (t_ch !=3D p_ch)
+						return WM_NOMATCH;
+				}
 				if ((matched =3D dowild(p, text, flags)) !=3D WM_NOMATCH) {
 					if (!match_slash || matched !=3D WM_ABORT_TO_STARSTAR)
 						return matched;
--=20
1.8.0.rc2.23.g1fb49df
