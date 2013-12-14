From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/21] environment.c: support super .git file specified by $GIT_DIR
Date: Sat, 14 Dec 2013 17:54:58 +0700
Message-ID: <1387018507-21999-13-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmpg-000199-27
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab3LNKwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:52:24 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:50028 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:52:23 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so3482793pdi.19
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W+KXOuShoK5XyWVjG3cPQbtz4eIRSPE2uALSHV92FII=;
        b=JvWmYeIS3c5Aw1PZZxcnW/7Hk9VF3cvZ2A7LKnfliHeZc2FbCsu31ERExTbNkrpVKu
         00aNvVBhIxa8/ifuaaG2bzLKxE/rLDmF0bgRaDUsyb3yHUILTdmx1aXQ7iNfP8rfIwYW
         nfDgU6VO9V+kVoHjmgbnrS0Q7A3GJ5LvBCc8rv5ueM1ZBicgJl46S6DKh1oeMZmR/wAV
         yw3rTg369mKiYF8fQVxGtkY3dmRtbjf8NGOuNC5ExFSy9UXaNrB1G6+nQIlV6CAwPIlV
         xBsWORUI5ntr3JJWtdsC9p02KTlTMNbN3tIBaOwLPmp1gu/pMvXDRP2lFurWq58PkNzF
         gVTw==
X-Received: by 10.68.106.98 with SMTP id gt2mr8771478pbb.61.1387018343161;
        Sat, 14 Dec 2013 02:52:23 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id nw11sm15338099pab.13.2013.12.14.02.52.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:52:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:57:16 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239294>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 environment.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index d5ae7a3..cbfa879 100644
--- a/environment.c
+++ b/environment.c
@@ -125,13 +125,17 @@ static char *expand_namespace(const char *raw_nam=
espace)
 static void setup_git_env(void)
 {
 	const char *gitfile;
+	char *super;
=20
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
-	gitfile =3D read_gitfile(git_dir);
+	gitfile =3D read_gitfile_super(git_dir, &super);
 	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
-	git_super_dir =3D getenv(GIT_SUPER_DIR_ENVIRONMENT);
+	if (super)
+		git_super_dir =3D xstrdup(super);
+	else
+		git_super_dir =3D getenv(GIT_SUPER_DIR_ENVIRONMENT);
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
 		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
--=20
1.8.5.1.77.g42c48fa
