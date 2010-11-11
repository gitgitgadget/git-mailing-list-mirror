From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] add: do not rely on dtype being NULL behavior
Date: Thu, 11 Nov 2010 20:03:22 +0700
Message-ID: <1289480602-10545-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Thu Nov 11 14:04:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWpg-0002Ez-F5
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 14:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756370Ab0KKNEq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 08:04:46 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47437 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113Ab0KKNEp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 08:04:45 -0500
Received: by pzk28 with SMTP id 28so387732pzk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 05:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=0FTOAjsBozlaf/J0o8R9MwlSqQ4ELsxlJ1yeaWICCwQ=;
        b=p4HVt9oltaGkQW6slDFnUA6HpxdO1dHfWhmgoCxBtvdn76/F1aJUdf3ZfgXN150STq
         9Agcw8V6FgVCSc2Pdu//QiIr6oPsD59itd2sthrGW/d+FCQP/ZpSvE/x0NycDDAnM4Bx
         QgLihtYVNdjvXXDqQG2MtmrhtueqrCEG01pFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=UufGpTIwEwfllMCYSKZ13cDI0SxcH39e1kaEflBNiwWRc/ZXloWz7hHhzq8Sp83qZv
         UpN1WgWDhc1PMQI/G4er5a8Q+Etxp8iHh2HJUzHTC31Yf6v37Kegc/MHNFTGaSKEJCYG
         jdWgGnmBMA1nln0OwQVRzJd5Fp4SmY9JPdPBM=
Received: by 10.142.172.9 with SMTP id u9mr15444wfe.197.1289480685169;
        Thu, 11 Nov 2010 05:04:45 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id w22sm2331016wfd.19.2010.11.11.05.04.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 05:04:44 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Nov 2010 20:03:24 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161245>

Commit c84de70 (excluded_1(): support exclude files in index -
2009-08-20) added support for excluded() where dtype can be NULL. It
was designed specifically for index matching because there was no
other way to extract dtype information from index. It did not support
wildcard matching (for example, "a*/" pattern would fail to match).

The code was probably misread when commit 108da0d (git add: Add the
"--ignore-missing" option for the dry run - 2010-07-10) was made
because DT_UNKNOWN happens to be zero (NULL) too.

Do not pass DT_UNKNOWN/NULL to excluded(), instead pass a pointer to a
variable that contains DT_UNKNOWN. The real dtype will be extracted
from worktree by excluded(), as expected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I do not add tests for the "a*/" failure above because I plan
 to fix it. Expect c84de70 will be reverted "soon" (in my timescale)
 when sparse checkout can pass real dtype.

 builtin/add.c |    3 ++-
 dir.c         |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 56a4e0a..1a4672d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -446,7 +446,8 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 			if (!seen[i] && pathspec[i][0]
 			    && !file_exists(pathspec[i])) {
 				if (ignore_missing) {
-					if (excluded(&dir, pathspec[i], DT_UNKNOWN))
+					int dtype =3D DT_UNKNOWN;
+					if (excluded(&dir, pathspec[i], &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
 					die("pathspec '%s' did not match any files",
diff --git a/dir.c b/dir.c
index b2dfb69..c4bed66 100644
--- a/dir.c
+++ b/dir.c
@@ -359,7 +359,7 @@ int excluded_from_list(const char *pathname,
 			int to_exclude =3D x->to_exclude;
=20
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
-				if (!dtype) {
+				if (dtype !=3D NULL) {
 					if (!prefixcmp(pathname, exclude) &&
 					    pathname[x->patternlen] =3D=3D '/')
 						return to_exclude;
--=20
1.7.3.2.210.g045198
