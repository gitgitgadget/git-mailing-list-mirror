From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Thu, 17 Jul 2014 19:45:43 +0700
Message-ID: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 14:46:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7l4x-0003yg-NP
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 14:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbaGQMq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 08:46:28 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41076 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbaGQMq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 08:46:27 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so3306461pab.2
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 05:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ZZ4m+8Ve+prZmKGY5TALIz93GZPPW8yF7eVJYt7pwzk=;
        b=wBDJKpRLMRdwTvQ/NRBRLuu93eG4UQ0UoZdQiTs3JJaUN6Bzy5DsZ14ZE+CmX/LRKI
         TZECsOItX2UPqACqclKYMOArBd8I5Tg+eXIjpOsR528wkv/m2CzjI+1TXOOI0efsAzXN
         NOFTTCTiXLKO5Lbj3MYVIvx5yjOo+L93eJCnFPQHeOVgIz/v3kDkS2qlvihjRCYmFz3o
         0HGnNPgieS90phCl+9kF7+gyax00OktfBBxEuPWa4iiGVt+uxvAw38enVzQUxLLZcTjY
         9QSklDhqTBR9U9Z76YMs0lS91mXeM7EtVdPy2QIyllgD2g6bN37oWALnxozkRkF+eSs/
         sIKg==
X-Received: by 10.66.241.39 with SMTP id wf7mr5428159pac.58.1405601180554;
        Thu, 17 Jul 2014 05:46:20 -0700 (PDT)
Received: from lanh ([115.73.251.38])
        by mx.google.com with ESMTPSA id tf10sm2449891pbc.70.2014.07.17.05.46.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 05:46:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 17 Jul 2014 19:46:14 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253734>

This array 'cwd' is used to store the result from getcwd() and chdir()
back. PATH_MAX is the right constant for the job. On systems with
longer PATH_MAX (eg. 4096 on Linux), hard coding 1024 fails stuff,
e.g. "git init". Make it static too to reduce stack usage.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 abspath.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/abspath.c b/abspath.c
index ca33558..c0c868f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -41,7 +41,7 @@ static const char *real_path_internal(const char *pat=
h, int die_on_error)
 	 * here so that we can chdir() back to it at the end of the
 	 * function:
 	 */
-	char cwd[1024] =3D "";
+	static char cwd[PATH_MAX];
=20
 	int buf_index =3D 1;
=20
@@ -49,6 +49,8 @@ static const char *real_path_internal(const char *pat=
h, int die_on_error)
 	char *last_elem =3D NULL;
 	struct stat st;
=20
+	*cwd =3D '\0';
+
 	/* We've already done it */
 	if (path =3D=3D buf || path =3D=3D next_buf)
 		return path;
--=20
1.9.1.346.ga2b5940
