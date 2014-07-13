From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 17/31] setup.c: convert check_repository_format_gently to use strbuf
Date: Sun, 13 Jul 2014 11:50:54 +0700
Message-ID: <1405227068-25506-18-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:54:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BoC-0000aK-Ct
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbaGMEyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:54:41 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42500 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbaGMEyj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:54:39 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so3606872pac.33
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vwkmXzt7/pH6ytHE7n3iKvzR8neAex12ACTCTernrr4=;
        b=rIoerSX9a+E+lH64ZgJff1dkQDQSZwUc5fxAD9JQfJbjEXXYphbJLYsT2mozVYlag8
         bqBiVshBD4M/6CC6ZNP9CKQPrxrJSkynQi4MceUoy7jGQvsatA3PrxKeiyhsdh4IYaz8
         RDIMr2lO6BbhhgE1jChNDYrl1mZwnW68nuadd1wlZ4DPR7QydByXk4u6bGeTZV+XZBkO
         1PVQw3FhUvYOtpVhwM6Iulx7+sfjhfFriROWzrhZkiQEPI0//ui3bzWQAHR6YcP/fU2d
         Ce8A0YmbVCntsQlkoiGKRoMSMZT/2gmEC1iKD4wCk1tVr3EfSxpRrjxpjZtQL3kiuoYC
         kUvA==
X-Received: by 10.68.139.137 with SMTP id qy9mr8753252pbb.11.1405227279513;
        Sat, 12 Jul 2014 21:54:39 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id av2sm6760239pbc.16.2014.07.12.21.54.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:54:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:54:39 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253420>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 176d505..a17389f 100644
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
1.9.1.346.ga2b5940
