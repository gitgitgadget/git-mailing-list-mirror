From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/21] rm: convert to use parse_pathspec
Date: Sun,  6 Jan 2013 13:20:57 +0700
Message-ID: <1357453268-12543-11-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:22:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjcn-0008HZ-CQ
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab3AFGWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:22:05 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:58212 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab3AFGWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:22:04 -0500
Received: by mail-pb0-f48.google.com with SMTP id rq13so10042866pbb.7
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=GyPwmuJm8RvcwodBfXG2RZhQzKoi5y3gL50u4faIHEg=;
        b=XeEErGmpSkSmIEdhk6FiwPX9/iOhIPvtL+NLhXSySNOnuZQpK0xyFqKEnrUhGlK6Zz
         xgdxiKOmnCxNFdESNjqwhhS8C+G7jTKQwn6dub3Fzfr9H37GttJ/V921HicsudnIHwe7
         +ESC1uetIepqIPSY9VVQ7UkZonTJVa+H4tIKPSfaBV078eqZV1DSaFx4wF49+O7FBtim
         Yq0oX446WmAtLt1MFVKzN/XfGzq9MB1QMX8xVT8kZkENi7KsvDmO4arx8ZkZ+RhX0jUx
         me4mEecSQ9VRFUveOIJawIq+IeH3CWFoH6aam73OY//5kGTmsbTMHJSjYYFp/FhczCEe
         5DKQ==
X-Received: by 10.68.143.100 with SMTP id sd4mr167401712pbb.107.1357453322492;
        Sat, 05 Jan 2013 22:22:02 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id nf9sm35295886pbc.17.2013.01.05.22.21.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:22:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:22:11 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212764>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index dabfcf6..d719d95 100644
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
@@ -249,27 +249,25 @@ int cmd_rm(int argc, const char **argv, const cha=
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
+	if (pathspec.nr) {
 		const char *match;
 		int seen_any =3D 0;
-		for (i =3D 0; (match =3D pathspec[i]) !=3D NULL ; i++) {
+		for (i =3D 0; (match =3D pathspec.raw[i]) !=3D NULL ; i++) {
 			if (!seen[i]) {
 				if (!ignore_unmatch) {
 					die(_("pathspec '%s' did not match any files"),
--=20
1.8.0.rc2.23.g1fb49df
