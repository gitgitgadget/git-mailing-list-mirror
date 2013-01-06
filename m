From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/21] clean: convert to use parse_pathspec
Date: Sun,  6 Jan 2013 13:20:52 +0700
Message-ID: <1357453268-12543-6-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:22:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrjcI-0007mW-4A
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab3AFGVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:21:34 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:44734 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab3AFGVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:21:33 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so10007988pad.38
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KyrAgOU1VovZjMHabjC9DWTlOrbp2GLiSTbi9A6INmU=;
        b=OnDUPlP3z21KrYsorAWYLWdMXt0yyzxYUUnDb4UnL/O0E4Qzjdxflqzfps8rf2Vdz0
         0RYZFfcSE/WXVBrApTz4gGz5vpGhutHaSoGRFkfJQ8uvoeeedtIzkmecomX+0EftlC+Z
         Hm37OVcGtQF2vqknd5f9oXb7SZwku+dB4oKI7axq5vyYF6+FgqQ6VHb037+0uQGwHMSm
         rA3sRemsxOJXhBcSMYLPudGHr91dCwavg+pWBOwgOf1BXnx7yNz9gO6PLGmUgalrtIE1
         kwTTBiajvghJtcs/f/JKP7Y5vjnEdCIRPHuJmpvBcRDA+GNHloW08K3jBHp91m1obbOu
         B/RA==
X-Received: by 10.68.143.41 with SMTP id sb9mr177103035pbb.50.1357453292820;
        Sat, 05 Jan 2013 22:21:32 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id vs3sm35283153pbc.61.2013.01.05.22.21.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:21:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:21:40 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212759>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 69c1cda..788ad8c 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -42,7 +42,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 	int rm_flags =3D REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory =3D STRBUF_INIT;
 	struct dir_struct dir;
-	static const char **pathspec;
+	struct pathspec pathspec;
 	struct strbuf buf =3D STRBUF_INIT;
 	struct string_list exclude_list =3D STRING_LIST_INIT_NODUP;
 	const char *qname;
@@ -101,12 +101,12 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
 		add_exclude(exclude_list.items[i].string, "", 0,
 			    &dir.exclude_list[EXC_CMDL]);
=20
-	pathspec =3D get_pathspec(prefix, argv);
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
=20
-	fill_directory(&dir, pathspec);
+	fill_directory(&dir, pathspec.raw);
=20
-	if (pathspec)
-		seen =3D xmalloc(argc > 0 ? argc : 1);
+	if (pathspec.nr)
+		seen =3D xmalloc(pathspec.nr);
=20
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
@@ -141,10 +141,10 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
 		if (lstat(ent->name, &st))
 			continue;
=20
-		if (pathspec) {
-			memset(seen, 0, argc > 0 ? argc : 1);
-			matches =3D match_pathspec(pathspec, ent->name, len,
-						 0, seen);
+		if (pathspec.nr) {
+			memset(seen, 0, pathspec.nr);
+			matches =3D match_pathspec_depth(&pathspec, ent->name, len,
+						       0, seen);
 		}
=20
 		if (S_ISDIR(st.st_mode)) {
@@ -169,7 +169,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 			}
 			strbuf_reset(&directory);
 		} else {
-			if (pathspec && !matches)
+			if (pathspec.nr && !matches)
 				continue;
 			qname =3D quote_path_relative(ent->name, -1, &buf, prefix);
 			if (show_only) {
--=20
1.8.0.rc2.23.g1fb49df
