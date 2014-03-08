From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 17/28] setup.c: convert check_repository_format_gently to use strbuf
Date: Sat,  8 Mar 2014 09:48:09 +0700
Message-ID: <1394246900-31535-18-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:49:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7KY-0005ec-OR
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbaCHCti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:49:38 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38077 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaCHCti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:49:38 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so4787471pde.24
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bop9+jlnGufAD+pgQH37bA0ZMYsYl86ro7p3INd0zjg=;
        b=g8n65Z9E/mXbOjymwxjONbponwh0hKFdsmqlCOsIHXYucSwOVz/T8wBMOhyFFO5qeJ
         4v8CEABitEcsYmMApw8B72srOb5E17x8Wuai2RzpgNZoeuZIiX2QxATCnTwynfaFjSNV
         HMKEAVfCh4fYxlJhG7mO/9mpPLIGU3iqiWxCAJc/KLjRCAwfewNgkyjy7VbtSbxiZRiQ
         UJS95xGj6hvI/JeIILaeUzt5Uts8WlPsLZZ8NI4cT9Hu19Pr6JGZvPOPM+YO3tLBhtrH
         yMLJITjj8bANQZUB0D/RyErXWvSTnPL3CbZOvKW7FmiqQEtsFm9t11Pfj9xPy8r6p5K2
         cu5w==
X-Received: by 10.68.180.66 with SMTP id dm2mr25743255pbc.143.1394246977553;
        Fri, 07 Mar 2014 18:49:37 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id ei4sm42705218pbb.42.2014.03.07.18.49.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:49:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:50:10 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243658>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 7e5b334..5085ab1 100644
--- a/setup.c
+++ b/setup.c
@@ -288,7 +288,9 @@ void setup_work_tree(void)
=20
 static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
 {
-	char repo_config[PATH_MAX+1];
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *repo_config;
+	int ret =3D 0;
=20
 	/*
 	 * git_config() can't be used here because it calls git_pathdup()
@@ -299,7 +301,8 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	snprintf(repo_config, PATH_MAX, "%s/config", gitdir);
+	strbuf_addf(&sb, "%s/config", gitdir);
+	repo_config =3D sb.buf;
 	git_config_early(check_repository_format_version, NULL, repo_config);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
@@ -309,9 +312,10 @@ static int check_repository_format_gently(const ch=
ar *gitdir, int *nongit_ok)
 			GIT_REPO_VERSION, repository_format_version);
 		warning("Please upgrade Git");
 		*nongit_ok =3D -1;
-		return -1;
+		ret =3D -1;
 	}
-	return 0;
+	strbuf_release(&sb);
+	return ret;
 }
=20
 /*
--=20
1.9.0.40.gaa8c3ea
