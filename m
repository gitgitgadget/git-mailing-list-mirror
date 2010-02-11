From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] make_absolute_path(): Do not append redundant slash
Date: Thu, 11 Feb 2010 21:43:19 +0700
Message-ID: <1265899403-15904-2-git-send-email-pclouds@gmail.com>
References: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 15:54:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaQn-0003qn-5H
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab0BKOyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:54:07 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:53462 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab0BKOyG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:54:06 -0500
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2010 09:54:06 EST
Received: by yxe34 with SMTP id 34so1205993yxe.16
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 06:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=auct6cIJI/eVJEiviaH8wSv15YlCVOwtJWX20Ct3Nsk=;
        b=TKYkdslQFPOspxHBSCy+Z/xh0zGh823IRxU4YRjcTcQYSEz+Y/9Cxyc+bzkhCRwpfw
         o3C1r4WqjhrMrUHf90OttGl9ixgHWflaxJ/tlZN0wkzewJKH4br68Og4eY9QI+b9oRjc
         NQXVnGwe989wTFyRPrbc9isM/5ez5R+wunxog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FhJmOlnZZWDdvqbcIc9UjG1yfb+bS6muwf6sfYNJeCJSpn1XZVTgkM5wQBTzxQAlYq
         kDfO84gUTX9Hjs4L6v8pgqsZ7a8h3VcwUMBjaqivMwxTiW/4d4UUBbKR2elgPRZDf68Z
         xuoQFucnPRr2ZBfXZjyyDFi42atNCX3ABb+uM=
Received: by 10.101.105.30 with SMTP id h30mr2570772anm.225.1265899572998;
        Thu, 11 Feb 2010 06:46:12 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.243.56])
        by mx.google.com with ESMTPS id 8sm924804ywg.19.2010.02.11.06.46.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 06:46:11 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Feb 2010 21:43:31 +0700
X-Mailer: git-send-email 1.7.0.rc2.182.g3adef
In-Reply-To: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139597>

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
1.7.0.rc2.182.g3adef
