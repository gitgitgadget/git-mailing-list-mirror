From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 13/31] rm: convert to use parse_pathspec
Date: Sun, 13 Jan 2013 19:35:21 +0700
Message-ID: <1358080539-17436-14-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:37:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMof-0006t4-KK
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab3AMMhL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:37:11 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:58816 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab3AMMhK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:37:10 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so1693023pbc.18
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=t0cFFdKMg1VA9R64i7fm5+tDWfrcXNXYByNmFEesrVg=;
        b=vYLqlBAy4DT0n8d1sQFTBPnlFU0f3AZVsad3kr3Zn/XPf0t64UmxRCfufEskMdCiiO
         5A8gOHW0F85pQF3G4gBG5SLqqqoV9mrR0qd0EYkqElCdQXkagvTdLv1vT4YqxMvuW3Wn
         62rtwzgacoI0KxB3ZSjSYgQhWPiWW5Slo6oaj49nzQdjB+lSiUjoEd7EtVc59xbi5VCg
         +ONnVz4d0eyMhjIQqZmls0KR2Qa/US7Hvhv97Q6p+oOYZN30llT0zsFIRlhWsh3KVSMq
         rTt+b18NfOaVP+iw2swDJRMtLr3FqEFbB8mqzqjiuGKHHHzB1lshdYn//mexSj+zo2mG
         rVCQ==
X-Received: by 10.68.216.134 with SMTP id oq6mr244756303pbc.162.1358080629707;
        Sun, 13 Jan 2013 04:37:09 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id mn4sm6294329pbc.12.2013.01.13.04.37.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:37:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:37:24 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213353>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rm.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index dabfcf6..1a2c932 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -216,7 +216,7 @@ static struct option builtin_rm_options[] =3D {
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	const char **pathspec;
+	struct pathspec pathspec;
 	char *seen;
=20
 	git_config(git_default_config, NULL);
@@ -249,31 +249,30 @@ int cmd_rm(int argc, const char **argv, const cha=
r *prefix)
 		}
 	}
=20
-	pathspec =3D get_pathspec(prefix, argv);
-	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
+	refresh_index(&the_index, REFRESH_QUIET, pathspec.raw, NULL, NULL);
=20
 	seen =3D NULL;
-	for (i =3D 0; pathspec[i] ; i++)
-		/* nothing */;
-	seen =3D xcalloc(i, 1);
+	seen =3D xcalloc(pathspec.nr, 1);
=20
 	for (i =3D 0; i < active_nr; i++) {
 		struct cache_entry *ce =3D active_cache[i];
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
+		if (!match_pathspec_depth(&pathspec, ce->name, ce_namelen(ce), 0, se=
en))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
 		list.entry[list.nr].name =3D ce->name;
 		list.entry[list.nr++].is_submodule =3D S_ISGITLINK(ce->ce_mode);
 	}
=20
-	if (pathspec) {
-		const char *match;
+	if (pathspec.nr) {
+		const char *original;
 		int seen_any =3D 0;
-		for (i =3D 0; (match =3D pathspec[i]) !=3D NULL ; i++) {
+		for (i =3D 0; i < pathspec.nr; i++) {
+			original =3D pathspec.items[i].original;
 			if (!seen[i]) {
 				if (!ignore_unmatch) {
 					die(_("pathspec '%s' did not match any files"),
-					    match);
+					    original);
 				}
 			}
 			else {
@@ -281,7 +280,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 			}
 			if (!recursive && seen[i] =3D=3D MATCHED_RECURSIVELY)
 				die(_("not removing '%s' recursively without -r"),
-				    *match ? match : ".");
+				    *original ? original : ".");
 		}
=20
 		if (! seen_any)
--=20
1.8.0.rc2.23.g1fb49df
