From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] make_absolute_path(): Do not append redundant slash
Date: Wed, 10 Feb 2010 00:02:27 +0700
Message-ID: <1265734950-15145-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:05:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NetWj-0006xS-TT
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 18:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab0BIRFR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 12:05:17 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53343 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103Ab0BIRFP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 12:05:15 -0500
Received: by vws12 with SMTP id 12so351911vws.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 09:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=bbx1CDSBjPubPCIkKqED3cd0wNHQc4JGXmME30aC2ks=;
        b=Hxx3Z2dWstj93TvqRAU04oESlvvVYSeeNpEYvLlhe2VWYPaGUTNHGrRBydaPacIve2
         epex27eefL/qzN6qkNJ+Gwo3FazEqHvC1t3DERtBtC1FYnx3oXukdDtcSHVjaqQe0NOs
         NnZZlizFwXFzTDTlOpDjtuYmLy4HGp6xfkt+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=rUY/JkJKOjuF6fSIR1L1YH6cwBZb50uDSoowdJuSvCNQmzJ4y72Fwjwx2AJt/huocb
         u15n1B14L1rFlBspBQXsveA9bPFT2j0iC0Nzq7bqytPOnEaIo3lXku2fa/0dD6RWPw74
         bB6VkQhM5M2XzTSf0JBtWkw5uqfq2D4nfZ0wE=
Received: by 10.220.122.78 with SMTP id k14mr750149vcr.106.1265735113691;
        Tue, 09 Feb 2010 09:05:13 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.235.86])
        by mx.google.com with ESMTPS id 37sm2348681vws.7.2010.02.09.09.05.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 09:05:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Feb 2010 00:02:32 +0700
X-Mailer: git-send-email 1.7.0.rc2.182.g3adef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139415>

make_absolute_path("foo") at root returns "//foo". This patch makes it
return "/foo" correctly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .. so that "git init" will show "initialized empty Git in /.git"

 abspath.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/abspath.c b/abspath.c
index b88122c..e72aede 100644
--- a/abspath.c
+++ b/abspath.c
@@ -54,8 +54,9 @@ const char *make_absolute_path(const char *path)
 			if (len + strlen(last_elem) + 2 > PATH_MAX)
 				die ("Too long path name: '%s/%s'",
 						buf, last_elem);
-			buf[len] =3D '/';
-			strcpy(buf + len + 1, last_elem);
+			if (*buf !=3D '/' || buf[1] !=3D '\0')
+				buf[len++] =3D '/';
+			strcpy(buf + len, last_elem);
 			free(last_elem);
 			last_elem =3D NULL;
 		}
--=20
1.7.0.rc2.182.g3adef
