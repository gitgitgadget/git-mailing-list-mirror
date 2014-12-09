From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] attr.c: split path processing code out of collect_all_attrs()
Date: Tue,  9 Dec 2014 20:53:23 +0700
Message-ID: <1418133205-18213-3-git-send-email-pclouds@gmail.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 14:54:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyLEZ-0001bS-R5
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 14:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050AbaLINxl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 08:53:41 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36568 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757040AbaLINxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 08:53:41 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so588887pde.29
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 05:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rZIhSGaI82/IpSE1iHrgh43XdKmwaql2967AguOzMxM=;
        b=oOTSYRiHxeNrCBTSJbcDWizPQDNm3rfMVmpIFFdDsQp/V7++1k+GKxVsaZkmro8+fF
         kkiMLA3WpnvciGPipA7t3zNeufgq/vdis9Ajth3WH4MR971V8IXYG2HiZ23TN8j3LSUH
         ba29Wx9pHpZ4urHqDqk84T5aRL1YW+LRr1iuAHbFiGjf5528bokxBTJ4dWbepAWSFxQc
         dUdw+5DmJbm2tjbo7eB/UvzvaKhs3hntFp19at5vkDbqEnTzz0QZBdhLfQSXJ9SVakwO
         skgAQV3XIFs4rN/sBqrnN2E9mMMzF8Z7kbNf2f4axMD3uHIOcKtN/L9nPW1jgObg+lEM
         Gr7A==
X-Received: by 10.70.50.102 with SMTP id b6mr31453283pdo.38.1418133220827;
        Tue, 09 Dec 2014 05:53:40 -0800 (PST)
Received: from lanh ([115.73.216.238])
        by mx.google.com with ESMTPSA id ty7sm1650671pac.1.2014.12.09.05.53.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Dec 2014 05:53:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 09 Dec 2014 20:53:37 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261123>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 583d36a..def09c7 100644
--- a/attr.c
+++ b/attr.c
@@ -705,14 +705,9 @@ static int macroexpand_one(int attr_nr, int rem)
 	return rem;
 }
=20
-/*
- * Collect all attributes for path into the array pointed to by
- * check_all_attr.
- */
-static void collect_all_attrs(const char *path)
+static int split_path(const char *path, int *dirlen_p, int *basename_o=
ffset_p)
 {
-	struct attr_stack *stk;
-	int i, pathlen, rem, dirlen;
+	int pathlen, dirlen;
 	const char *cp, *last_slash =3D NULL;
 	int basename_offset;
=20
@@ -728,7 +723,22 @@ static void collect_all_attrs(const char *path)
 		basename_offset =3D 0;
 		dirlen =3D 0;
 	}
+	*dirlen_p =3D dirlen;
+	*basename_offset_p =3D basename_offset;
+	return pathlen;
+}
+
+/*
+ * Collect all attributes for path into the array pointed to by
+ * check_all_attr.
+ */
+static void collect_all_attrs(const char *path)
+{
+	struct attr_stack *stk;
+	int i, pathlen, rem, dirlen;
+	int basename_offset;
=20
+	pathlen =3D split_path(path, &dirlen, &basename_offset);
 	prepare_attr_stack(path, dirlen);
 	for (i =3D 0; i < git_attr_nr; i++)
 		check_all_attr[i].value =3D ATTR__UNKNOWN;
--=20
2.2.0.84.ge9c7a8a
