From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 17/32] setup.c: convert check_repository_format_gently to use strbuf
Date: Sun, 28 Sep 2014 08:22:31 +0700
Message-ID: <1411867366-3821-18-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:24:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3Dv-0002UY-6q
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbaI1BYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:24:23 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:49486 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BYW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:24:22 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so1162432pdb.11
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=18SLkkqthfuwGZG8r3EFUxo+OCwY2fsLCqThOcx4/wk=;
        b=Nwho2CcL8jjEDQS/2JNBrrE3FBU93FUgR3AjSBzJ0yW+jQoB/O/exer17w2LADakjG
         IaIaneuNoXn0W7M1pRWYIsqZp/L717YMFTkaLg5oZJEnpniDMx3NBhzTR2aE3cOU18Rg
         RziLWONYZx2clGNmTfVtYcFn3Z+pkeVj6HqyPbc+JN4pUYf03sIeCHlNHjJpD3HDEaYp
         s3Ozz4mNodf9hu4yqGFzPSiJi+WtWPu5dTLLD8USm0ffAMv+O8myTC2mPJ33mf5aTK4V
         gaxSelTJdVEft5KZ73aJr0kvHruRtEp70LPuRwumwzWIubAI1n5inih0eXQ6chw89v1Q
         DCqA==
X-Received: by 10.70.123.42 with SMTP id lx10mr35401625pdb.90.1411867462082;
        Sat, 27 Sep 2014 18:24:22 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id w7sm7519323pbs.4.2014.09.27.18.24.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:24:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:24:25 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257576>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 6c52f75..00a23e6 100644
--- a/setup.c
+++ b/setup.c
@@ -342,7 +342,9 @@ void setup_work_tree(void)
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
@@ -353,7 +355,8 @@ static int check_repository_format_gently(const cha=
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
@@ -363,9 +366,10 @@ static int check_repository_format_gently(const ch=
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
2.1.0.rc0.78.gc0d8480
