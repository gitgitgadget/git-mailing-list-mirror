From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 19/46] rm: convert to use parse_pathspec
Date: Sun, 14 Jul 2013 15:35:42 +0700
Message-ID: <1373790969-13000-20-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:38:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHou-0002De-Fo
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab3GNIiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:38:12 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:40843 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:38:11 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so9816508pdj.31
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9Y+YMTKQ6PY7bZBzF2kDAYaehzbdc8YOOXbvUqZO1Bc=;
        b=YNGF84IG/sCd3sZsvrvgDIupgkWjymK0VaWb6bnnFmqA8oHzBKvNfTgrj9a4pyubUI
         BxgScbH8LW21PEZg6zrhU28r1moH09c4a2Qz/C2ADdjj5IbICnKFkg0jnCMEYdDJYkzX
         Lw4GOdqxGfg5KN+daKFzm5z7gDmpo9d5anQsq6bLMAl/PSJqnx5BdmBNdURCihbbzbPy
         nywFcyVTR6BvrVvm+5NCTYdtfnsG1+iMdkM0IfCEQYdmrqxaHz4BirRpRGP0N8V2DGgk
         oNY2bkZ0pih6OKPnx1MfeFnQWTZusUloW++G9xA7PcWA+F1+OmuozGKJ0pxThBkP6IkO
         cmQQ==
X-Received: by 10.68.171.162 with SMTP id av2mr48610221pbc.104.1373791090405;
        Sun, 14 Jul 2013 01:38:10 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id wr9sm54578502pbc.7.2013.07.14.01.38.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:38:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:38:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230331>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 06025a2..ee0ae4c 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -11,6 +11,7 @@
 #include "parse-options.h"
 #include "string-list.h"
 #include "submodule.h"
+#include "pathspec.h"
=20
 static const char * const builtin_rm_usage[] =3D {
 	N_("git rm [options] [--] <file>..."),
@@ -279,7 +280,7 @@ static struct option builtin_rm_options[] =3D {
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	const char **pathspec;
+	struct pathspec pathspec;
 	char *seen;
=20
 	git_config(git_default_config, NULL);
@@ -312,31 +313,30 @@ int cmd_rm(int argc, const char **argv, const cha=
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
@@ -344,7 +344,7 @@ int cmd_rm(int argc, const char **argv, const char =
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
