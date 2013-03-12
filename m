From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/13] exclude: avoid calling prep_exclude on entries of the same directory
Date: Tue, 12 Mar 2013 20:04:54 +0700
Message-ID: <1363093500-16796-8-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOuc-0007k4-79
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451Ab3CLNGK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:06:10 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:54085 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3CLNGI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:06:08 -0400
Received: by mail-pb0-f42.google.com with SMTP id xb4so4971419pbc.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Z4tGVaTOh8mo7Ziz06w3axsQt/b7GygUFdXhK9er7T4=;
        b=nv2KHsPb8a5ZquoSOG5CEVH5L5aQbT58wiJnlKrNZpc7UR62MkLs6gUcix+Nmb2cWf
         XhavEou0AjWP7GPod0QVgv5DVeeht+gwAIvtDGrBjRzT6T+0/Drj7ObHPAiD9xkgbLwv
         rxyxCxNXLz5rKKLeQmgEWGL5nTQgWa/l/3Hb//U42SMwX7cXiEB93g0NRslaTepk6srr
         z8trhLsBJMT4MAyB1yXggKHeYupE4sY0UrB37GaXT9jmDcnFOeW2t6hTytjlYFOMa+zc
         3+hjmSMtsYZsPz7LvtqqyOCqtwr7bvAb0ggfhZbEidmfQgGn4JWXMml3wCGNQoRcABpI
         yVuQ==
X-Received: by 10.68.237.100 with SMTP id vb4mr37491062pbc.202.1363093568280;
        Tue, 12 Mar 2013 06:06:08 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id eg1sm24986579pbb.33.2013.03.12.06.06.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:06:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:05:57 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217956>

prep_exclude is only necessary when we enter or leave a directory. Now
it's called for every entry in a directory. With this patch, the
number of prep_exclude calls in webkit.git goes from 188k down to
11k. This patch does not make exclude any faster, but it prepares for
making prep_exclude heavier in terms of computation, where a large
number of calls may have bigger impacts.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 10 +++++++++-
 dir.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 58739f3..f8f7a7e 100644
--- a/dir.c
+++ b/dir.c
@@ -804,7 +804,10 @@ static struct exclude *last_exclude_matching(struc=
t dir_struct *dir,
 	basename =3D (basename) ? basename+1 : pathname;
=20
 	START_CLOCK();
-	prep_exclude(dir, pathname, basename-pathname);
+	if (!dir->exclude_prepared) {
+		prep_exclude(dir, pathname, basename-pathname);
+		dir->exclude_prepared =3D 1;
+	}
 	STOP_CLOCK(tv_prep_exclude);
=20
 	START_CLOCK();
@@ -894,6 +897,7 @@ struct exclude *last_exclude_matching_path(struct p=
ath_exclude_check *check,
=20
 		if (ch =3D=3D '/') {
 			int dt =3D DT_DIR;
+			check->dir->exclude_prepared =3D 0;
 			exclude =3D last_exclude_matching(check->dir,
 							path->buf, path->len,
 							&dt);
@@ -908,6 +912,7 @@ struct exclude *last_exclude_matching_path(struct p=
ath_exclude_check *check,
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
=20
+	check->dir->exclude_prepared =3D 0;
 	return last_exclude_matching(check->dir, name, namelen, dtype);
 }
=20
@@ -1394,6 +1399,7 @@ static int read_directory_recursive(struct dir_st=
ruct *dir,
 	if (!fdir)
 		goto out;
=20
+	dir->exclude_prepared =3D 0;
 	while ((de =3D readdir(fdir)) !=3D NULL) {
 		switch (treat_path(dir, de, &path, baselen, simplify)) {
 		case path_recurse:
@@ -1415,6 +1421,7 @@ static int read_directory_recursive(struct dir_st=
ruct *dir,
 	}
 	closedir(fdir);
  out:
+	dir->exclude_prepared =3D 0;
 	strbuf_release(&path);
=20
 	return contents;
@@ -1486,6 +1493,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 			break;
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
+		dir->exclude_prepared =3D 0;
 		if (treat_one_path(dir, &sb, simplify,
 				   DT_DIR, NULL) =3D=3D path_ignored)
 			break; /* do not recurse into it */
diff --git a/dir.h b/dir.h
index 560ade4..0748407 100644
--- a/dir.h
+++ b/dir.h
@@ -86,6 +86,7 @@ struct dir_struct {
=20
 	/* Exclude info */
 	const char *exclude_per_dir;
+	int exclude_prepared;
=20
 	/*
 	 * We maintain three groups of exclude pattern lists:
--=20
1.8.1.2.536.gf441e6d
