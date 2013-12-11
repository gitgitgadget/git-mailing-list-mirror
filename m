From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/POC 4/7] setup.c: add split-repo support to is_git_directory()
Date: Wed, 11 Dec 2013 21:15:30 +0700
Message-ID: <1386771333-32574-5-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 15:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqkVQ-0007hn-MS
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 15:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970Ab3LKOLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Dec 2013 09:11:11 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:46987 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3LKOLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 09:11:10 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so9996636pbb.23
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 06:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BYlgeOkJ4yz0rQDzFA+3LqmEAwEY+BffmGCnlT11NTY=;
        b=LZIl7ezWGRGwVnKm+13XxO5fwzZx/OfKjGmiGLIQMCwvPS9l8la8hPoRolcoWqFuBa
         YF067erXFGl8j5ctnSYP0Xn+5BLWGzMirVLPbQUUsCPN717eATI9TwSNgTJiQVmbHbQy
         lXQ7UJzSW0DFAbCpaXff0y6BBJkU5+QSz2TovHu7BJdZ8jQeNdoYryORhdAAf2NyooFf
         LE3+b/0AqQcOpVd69nuiaJ8Faa16Sg6iVbVl68Gt2BOu2ZUGNZU0JREK/IJDg9vGlKJt
         GoPWLbxdceJXLOZGbGUrsfgI5r7K49LgM5/sgbBpedKwrv9n3k5TomLCQQr2XwOHvMd1
         oWhw==
X-Received: by 10.66.139.100 with SMTP id qx4mr1776935pab.141.1386771069944;
        Wed, 11 Dec 2013 06:11:09 -0800 (PST)
Received: from lanh ([115.73.201.231])
        by mx.google.com with ESMTPSA id oa3sm32947042pbb.15.2013.12.11.06.11.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 06:11:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 11 Dec 2013 21:15:59 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239198>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/setup.c b/setup.c
index 84362a6..43f56fb 100644
--- a/setup.c
+++ b/setup.c
@@ -182,28 +182,31 @@ void verify_non_filename(const char *prefix, cons=
t char *arg)
  *    a proper "ref:", or a regular file HEAD that has a properly
  *    formatted sha1 object name.
  */
-int is_git_directory(const char *suspect)
+static int is_git_directory_super(const char *suspect, const char *sup=
er)
 {
 	char path[PATH_MAX];
 	size_t len =3D strlen(suspect);
+	size_t super_len =3D strlen(super);
=20
-	if (PATH_MAX <=3D len + strlen("/objects"))
+	if (PATH_MAX <=3D super_len + strlen("/objects"))
 		die("Too long path: %.*s", 60, suspect);
-	strcpy(path, suspect);
+	strcpy(path, super);
 	if (getenv(DB_ENVIRONMENT)) {
 		if (access(getenv(DB_ENVIRONMENT), X_OK))
 			return 0;
 	}
 	else {
-		strcpy(path + len, "/objects");
+		strcpy(path + super_len, "/objects");
 		if (access(path, X_OK))
 			return 0;
 	}
=20
-	strcpy(path + len, "/refs");
+	strcpy(path + super_len, "/refs");
 	if (access(path, X_OK))
 		return 0;
=20
+	if (super !=3D suspect)
+		strcpy(path, suspect);
 	strcpy(path + len, "/HEAD");
 	if (validate_headref(path))
 		return 0;
@@ -211,6 +214,12 @@ int is_git_directory(const char *suspect)
 	return 1;
 }
=20
+int is_git_directory(const char *suspect)
+{
+	return is_git_directory_super(suspect, suspect);
+}
+
+
 int is_inside_git_dir(void)
 {
 	if (inside_git_dir < 0)
--=20
1.8.5.1.77.g42c48fa
