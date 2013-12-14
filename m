From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 18/21] refs: adjust reflog path for repos/<id>/HEAD
Date: Sat, 14 Dec 2013 17:55:04 +0700
Message-ID: <1387018507-21999-19-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Dec 14 11:53:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrmqL-0001Ni-HO
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623Ab3LNKxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:53:04 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:65204 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab3LNKxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:53:03 -0500
Received: by mail-pa0-f50.google.com with SMTP id kl14so1059501pab.37
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eTJPp4HEBL60WTvriJPb2DS12j0h530apa+HA+OpO4Q=;
        b=tRcVqqzmTKoNXREf58Y40WbEXKNtwhTDBU92Zzcmd7IZ2qNBNxFn++Vjy8qvVoDU7n
         INod0VqLx0HovHxRMoTRWDtAWsiel6mmVFujQRp1093zPcT0j1Eo+m74c+7QdqA7Cqz5
         LvJM11XFy2CNkloZm2VZ/WSmUCWIeULKsE3ZshyWSgxXKa0n9Ox2AX/veA6rO1bo3ybv
         wKfxMvC2/ndvj2UG7rUSWrxP9u4eFR4EWxNFHPHogkcHN4KFtohz4gfr4Vm5wRIpZEGp
         kks3Z9i+yQ8A/q28xoRun6YOTsJm09V8e+fZr5jGnTXmIJz/IxHsWb4lueNbV455IjCB
         lV3A==
X-Received: by 10.68.66.1 with SMTP id b1mr8760283pbt.43.1387018382347;
        Sat, 14 Dec 2013 02:53:02 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id ki1sm11450136pbd.1.2013.12.14.02.52.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:53:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:57:55 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239300>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 refs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 5e5a382..3691ef5 100644
--- a/refs.c
+++ b/refs.c
@@ -2676,13 +2676,24 @@ static int copy_msg(char *buf, const char *msg)
 int log_ref_setup(const char *refname, char *logfile, int bufsize)
 {
 	int logfd, oflags =3D O_APPEND | O_WRONLY;
+	const char *p =3D NULL;
=20
-	git_snpath(logfile, bufsize, "logs/%s", refname);
+	/*
+	 * reflog of repos/XXX/HEAD is repos/XXX/logs/HEAD, not
+	 * refs/repos/XXX/HEAD
+	 */
+	if (!strncmp(refname, "repos/", 6) &&
+	    (p =3D strchr(refname + 6, '/')) !=3D 0)
+		git_snpath(logfile, bufsize, "%.*s/logs/%s",
+			   (int)(p - refname), refname, p + 1);
+	else
+		git_snpath(logfile, bufsize, "logs/%s", refname);
 	if (log_all_ref_updates &&
 	    (!prefixcmp(refname, "refs/heads/") ||
 	     !prefixcmp(refname, "refs/remotes/") ||
 	     !prefixcmp(refname, "refs/notes/") ||
-	     !strcmp(refname, "HEAD"))) {
+	     !strcmp(refname, "HEAD") ||
+	     (p && !strcmp(p + 1, "HEAD")))) {
 		if (safe_create_leading_directories(logfile) < 0)
 			return error("unable to create directory for %s",
 				     logfile);
--=20
1.8.5.1.77.g42c48fa
