From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 7/9] clean: replace match_pathspec() with dir_path_match()
Date: Fri, 24 Jan 2014 20:40:34 +0700
Message-ID: <1390570836-20394-8-git-send-email-pclouds@gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pawel.sikora@agmk.net,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 14:35:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6gvK-0005FL-TU
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 14:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbaAXNfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 08:35:50 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:51617 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaAXNft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 08:35:49 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so3279882pab.35
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 05:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=92rdqpvHJgi6b/uCFBfZwCnufJ1AAO+JtVj+FeyM+Gw=;
        b=uVUJMJuJJwTWrvyeaMEkegrHYE1D8w3qKIdrz1VDy9BHB4boBreWQc+n6xnKj3ykjM
         5c/Jx9p3It9dYzfF+RUUB6bxpbS7lIFZNW2lVtJ3neEvyh7HNTtDFVZHvB0AS94bGHV3
         1XdlV4pJX+iQ4LEXC25upXUmxPcqutq/+v5jiCi1KXYaUtUKc7O+YOQu2128cAqjaENH
         iZ2hAj7qGgXYwGGGeSfOGj+osP7C6fk8lbHzP7ZiIdHr/1DGgdl+Taqiv8CNnfOZFBaj
         ibyRIRiwrKkcGp4eD9XQpMYxTXfb5EOmBWupUFoail379GEF1jHqzEz4RFOzdspiQwAO
         OH5Q==
X-Received: by 10.66.221.103 with SMTP id qd7mr14469419pac.44.1390570549118;
        Fri, 24 Jan 2014 05:35:49 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id nu10sm3352346pbb.16.2014.01.24.05.35.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 05:35:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:41:23 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241006>

This instance was left out when many match_pathspec() call sites that
take input from dir_entry were converted to dir_path_match() because
it passed a path with the trailing slash stripped out to match_pathspec=
()
while the others did not. Stripping for all call sites back then would
be a regression because match_pathspec() did not know how to match
pathspec foo/ against _directory_ foo (the stripped version of path
"foo/").

match_pathspec() knows how to do it now. And dir_path_match() strips
the trailing slash also. Use the new function, because the stripping
code is removed in the next patch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 4c9680a..5adb52d 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -961,8 +961,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 			die_errno("Cannot lstat '%s'", ent->name);
=20
 		if (pathspec.nr)
-			matches =3D match_pathspec(&pathspec, ent->name,
-						 len, 0, NULL, 0);
+			matches =3D dir_path_match(ent, &pathspec, 0, NULL);
=20
 		if (S_ISDIR(st.st_mode)) {
 			if (remove_directories || (matches =3D=3D MATCHED_EXACTLY)) {
--=20
1.8.5.2.240.g8478abd
