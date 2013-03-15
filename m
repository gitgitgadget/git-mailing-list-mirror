From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 20/45] rm: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 13:06:35 +0700
Message-ID: <1363327620-29017-21-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:26:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO6H-0005kB-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab3COG0S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:26:18 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:52987 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab3COG0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:26:18 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so2890542iak.10
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=kNBufkmHSj59G1ZCBBuHHTRphjdktfKZNj6lQPr9/5I=;
        b=LGspldU2EV80YJx4CKd4kVp98rInJ5i2RQRwSVWO8FSKn15G3A/IfeqC1G4eZDqTrr
         /ued0fmg7Ihk5L/x2Y9GvjRq15K4/OopDy9jYn2Ed8kVaeZB7nMybzjHNhs3qGMF5p2X
         gJPveXp/BsDBsSBVIFzZapXpsafkA8/pMuj9rt/Ud7u7zhZFYHsJt0I168TJoM3itTnH
         smJs2Ts83I4zQbE5iIcgRZNsj3k4qejngftlHxOKO1hwM6mHZY1wX0MVR/Ne9BwPPVCb
         aB7FsOi9wghVQNVMrm5hICg0j2mhFpkKpHZ36XakshiTxUlVLcTUYAPf8Ju4kBwJ0XFR
         0XZg==
X-Received: by 10.50.170.36 with SMTP id aj4mr382293igc.4.1363328777675;
        Thu, 14 Mar 2013 23:26:17 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ih1sm624709igc.3.2013.03.14.23.26.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:26:17 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:09:19 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218207>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index dabfcf6..eb1b745 100644
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
1.8.0.rc0.19.g7bbb31d
