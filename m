From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/8] mv: move index search code out
Date: Sun, 10 Aug 2014 09:29:33 +0700
Message-ID: <1407637776-19794-6-git-send-email-pclouds@gmail.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 04:30:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGItk-0003p0-MJ
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 04:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbaHJCaJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2014 22:30:09 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:44917 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaHJCaI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 22:30:08 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so8994248pdb.27
        for <git@vger.kernel.org>; Sat, 09 Aug 2014 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zyfJO/i8FcEe5HxcM781g+ON1bFm1set1OdSptu1w1Q=;
        b=fn8lBWJFAVrBunfF6+ZHUwIxof9R43mK9/Sq6dZJJV8jfAMaOeY+fqt+Yh+t580fco
         nwVK2KG1TfpImVyg+/DUOsqGpYRPcYpeOkvzDV9uMgV03VKgWuWVyZxfNhQqIEByPnj/
         W7mswbSzwcclza0qon66of3lREaGKQdtXXyqMWT1DlRJgKrn8GSUOCMmgV4YG5ug3yt6
         Kgj5Mmi19AAK6mk8c4fugJEAbziatbg33TjKBgo99ju2MyQgpmbWiNeT0Qvc/bM35PYW
         njZxG4w3g5rS0yosY9lBVDHslkwjyAQvNbPUMlY0bVwBBftUR6YUr+up3mDrEg0j2Qex
         VCow==
X-Received: by 10.70.134.39 with SMTP id ph7mr33467994pdb.32.1407637808050;
        Sat, 09 Aug 2014 19:30:08 -0700 (PDT)
Received: from lanh ([115.73.228.225])
        by mx.google.com with ESMTPSA id mn2sm7218525pbc.64.2014.08.09.19.30.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2014 19:30:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Aug 2014 09:30:11 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255081>

"Huh?" is removed from die() message.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 0732355..dcfcb11 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -78,6 +78,29 @@ static void prepare_move_submodule(const char *src, =
int first,
 	strbuf_release(&submodule_dotgit);
 }
=20
+static int index_range_of_same_dir(const char *src, int length,
+				   int *first_p, int *last_p)
+{
+	const char *src_w_slash =3D add_slash(src);
+	int first, last, len_w_slash =3D length + 1;
+
+	first =3D cache_name_pos(src_w_slash, len_w_slash);
+	if (first >=3D 0)
+		die(_("%.*s is in index"), len_w_slash, src_w_slash);
+
+	first =3D -1 - first;
+	for (last =3D first; last < active_nr; last++) {
+		const char *path =3D active_cache[last]->name;
+		if (strncmp(path, src_w_slash, len_w_slash))
+			break;
+	}
+	if (src_w_slash !=3D src)
+		free((char *)src_w_slash);
+	*first_p =3D first;
+	*last_p =3D last;
+	return last - first;
+}
+
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, gitmodules_modified =3D 0;
@@ -153,25 +176,10 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 				prepare_move_submodule(src, first,
 						       submodule_gitfile + i);
 			else {
-				const char *src_w_slash =3D add_slash(src);
-				int last, len_w_slash =3D length + 1;
+				int last;
=20
 				modes[i] =3D WORKING_DIRECTORY;
-
-				first =3D cache_name_pos(src_w_slash, len_w_slash);
-				if (first >=3D 0)
-					die (_("Huh? %.*s is in index?"),
-							len_w_slash, src_w_slash);
-
-				first =3D -1 - first;
-				for (last =3D first; last < active_nr; last++) {
-					const char *path =3D active_cache[last]->name;
-					if (strncmp(path, src_w_slash, len_w_slash))
-						break;
-				}
-				if (src_w_slash !=3D src)
-					free((char *)src_w_slash);
-
+				index_range_of_same_dir(src, length, &first, &last);
 				if (last - first < 1)
 					bad =3D _("source directory is empty");
 				else {
--=20
2.1.0.rc0.78.gc0d8480
