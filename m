From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/5] make_absolute_path(): Do not append redundant slash
Date: Sun, 14 Feb 2010 22:44:41 +0700
Message-ID: <1266162285-10955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 16:47:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgghC-0000Ms-GA
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 16:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab0BNPr2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 10:47:28 -0500
Received: from mail-pz0-f197.google.com ([209.85.222.197]:59816 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab0BNPr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 10:47:27 -0500
Received: by pzk35 with SMTP id 35so549598pzk.33
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 07:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=k6hGVOqnfkHb1smC7kF5WI98VYzeyrc6nXLXmXut5AA=;
        b=vhMHSAIS3ttKttIx+smkizcSIZDVeN3hocTlvjX2JC5SU8Zrzi20qCYVpv/9i9byCP
         SqwGK0Muhf8l5sa7qNr3gLntuNdqxQhipzDeWQSvYLxZQU6Stym0LCOpCoTlx1AJl43i
         RgtjjanGuWI6SV0inqVpzXJoEoaThA1pRdm5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=GKra7fCHoyXNcwuJoFeUh9Efk7trl1r2Y5sovoIhH9DpyIKwHxJTuGoy0QJ7x3xBCI
         aBVpROQ37zy5cmqF3ewUfKNPvOeGNmv1VHUnKTSs08VQEkEXOHkKJghVZz3Ryz/raD0X
         LBB97j6QuINszKiPz/bk3YK/8YFlHArqbuyHU=
Received: by 10.142.248.4 with SMTP id v4mr2706053wfh.258.1266162446800;
        Sun, 14 Feb 2010 07:47:26 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.243.56])
        by mx.google.com with ESMTPS id 21sm396807pzk.3.2010.02.14.07.47.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 07:47:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Feb 2010 22:44:46 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139911>

When concatenating two paths, if the first one already have '/', do
not put another '/' in between the two paths.

Usually this is not the case as getcwd() won't return '/foo/bar/',
except when you are standing at root, then it will return '/'.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 abspath.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/abspath.c b/abspath.c
index b88122c..c91a29c 100644
--- a/abspath.c
+++ b/abspath.c
@@ -54,8 +54,9 @@ const char *make_absolute_path(const char *path)
 			if (len + strlen(last_elem) + 2 > PATH_MAX)
 				die ("Too long path name: '%s/%s'",
 						buf, last_elem);
-			buf[len] =3D '/';
-			strcpy(buf + len + 1, last_elem);
+			if (len && buf[len-1] !=3D '/')
+				buf[len++] =3D '/';
+			strcpy(buf + len, last_elem);
 			free(last_elem);
 			last_elem =3D NULL;
 		}
--=20
1.7.0.195.g637a2
