From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/21] rm: convert to use parse_pathspec
Date: Fri, 11 Jan 2013 18:21:03 +0700
Message-ID: <1357903275-16804-10-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttcgh-00072l-P8
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab3AKLV4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:21:56 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:53596 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab3AKLVz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:21:55 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so902242pbb.11
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=GyPwmuJm8RvcwodBfXG2RZhQzKoi5y3gL50u4faIHEg=;
        b=CRuRPnaaU/PIZPw3h4Rkd3RyQkM7RFC5teC4+PHGgGHdo3CqFCJPsf0S4tpvvoP4Px
         i+AsU8MyiH37ye45Gd0HqRYDnbIxmr5KTgbitIFxgspyKIR3BEodWmQOOEE4GyjKxqW3
         uvQE8OxKTFfUAvvT7GN75VCIXcyh5I7hNzJqrmDsrc7o2HwjWbtP2vqSFOnqIqn7W0wL
         Uh4eEwGFK9GcTCSl/IltumibWhIYK6XlS+4OjHeIAB22pWSbXnJXY1unWV7BvZrTd1sP
         iz5WNnpvL/Xk9Z7rR3LL44MTEjbOjQ1YqKfaU7XFDN2UHOwu2X7qW6Asnlj7iAJxHrrv
         0LDg==
X-Received: by 10.66.81.68 with SMTP id y4mr206255541pax.66.1357903314992;
        Fri, 11 Jan 2013 03:21:54 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id a4sm2939853pax.25.2013.01.11.03.21.52
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:21:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:22:09 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213201>


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
