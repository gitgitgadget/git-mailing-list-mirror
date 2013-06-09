From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/45] rm: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:52 +0700
Message-ID: <1370759178-1709-20-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ5e-0000aQ-7s
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab3FIG0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:26:54 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:46810 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3FIG0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:26:53 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so797251pdj.22
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oSmFiBU52Q2p9T5LzNW5Oqp7Ov66RVXMIHpNaIxE2QY=;
        b=IctIm2c34tnLHuPMvsKDTXNoLRrM6BElSnXHfqfSbtmBRtoy1Ip1KJoZlTrBdXcd/V
         ecDdAn1Jevi1DV1SUzkRJyoP54YU8+hRDor1+pAwnat7MBzLshiiocXKnV9/GQ33pBtd
         V9BwyKPRMn1wXc9S3jcJul0q9mfiklF/37oBzl3NKrbZiSG1iOQkIl/E2m6RJX2zg1UJ
         blLitbGgMJoN+aC9qxMevA/G+FwfWxQ2bov5eA3QkBZBIGOyXVV6d9RSEMkjFcwA+9Kt
         BMVLyI5hDHsqkY9/uAMzQXnHq2cCFsBpGKG5Jn2bo9v3QvSlQjLAaX0IzYk10BH0qEuH
         fB6A==
X-Received: by 10.68.137.227 with SMTP id ql3mr5170436pbb.39.1370759213321;
        Sat, 08 Jun 2013 23:26:53 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id qh4sm10251100pac.8.2013.06.08.23.26.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:26:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:28:24 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226911>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 7b91d52..0b38de3 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -10,6 +10,7 @@
 #include "tree-walk.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "pathspec.h"
=20
 static const char * const builtin_rm_usage[] =3D {
 	N_("git rm [options] [--] <file>..."),
@@ -216,7 +217,7 @@ static struct option builtin_rm_options[] =3D {
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	const char **pathspec;
+	struct pathspec pathspec;
 	char *seen;
=20
 	git_config(git_default_config, NULL);
@@ -249,31 +250,30 @@ int cmd_rm(int argc, const char **argv, const cha=
r *prefix)
 		}
 	}
=20
-	pathspec =3D get_pathspec(prefix, argv);
-	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
+	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
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
@@ -281,7 +281,7 @@ int cmd_rm(int argc, const char **argv, const char =
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
1.8.2.83.gc99314b
