From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/34] setup.c: convert check_repository_format_gently to use strbuf
Date: Sun, 30 Nov 2014 15:24:42 +0700
Message-ID: <1417335899-27307-18-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:28:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzrs-0008JT-BE
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbaK3I21 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:28:27 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:54540 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbaK3I20 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:28:26 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so9044843pdi.3
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=336fN+fEk+b7du5woWoDdJt37deqwZb6Dq0Z4QV2sww=;
        b=iMjC76GNDM/xJxIqv0hkepMqKKSyg91jZSPYvV6J2gncBUaFNWNEFUt0X0TWCtPeBZ
         qFc6EFOec3TRFsw3o59i5P5zBEfo1zzYyGxx5sp3cWC70OdJ7qtuc95c/CaTyPCJ9XTN
         yFAh0PaQKH8SLrY5XS5Ta1eoJQUWkZQ9fAvAkKlpx61sZnegRr7j1swVYovGS8Y4IWIF
         RfEWWQrI13dOpmg1K3gt8UmeaKN3cZg1Okkeh1OHOZ5O2Bz6jdyjKkr62SSbNS2chse2
         3x1MUfzErzeVyVzJHtoWffCTc33WC4bsKyffBVkaL1m2p8Qwf0lRV5tlq5P6tSGZhDeU
         RZzA==
X-Received: by 10.68.211.104 with SMTP id nb8mr36210570pbc.29.1417336105545;
        Sun, 30 Nov 2014 00:28:25 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id t9sm14229200pbs.75.2014.11.30.00.28.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:28:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:28:23 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260404>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
