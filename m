From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/46] commit: convert to use parse_pathspec
Date: Sun, 14 Jul 2013 15:35:38 +0700
Message-ID: <1373790969-13000-16-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:37:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHoW-0001wr-6l
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab3GNIhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:37:48 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:55752 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIhr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:37:47 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so10247124pad.4
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fq4D4mWvk2KQ/aug3nx/DvgHpU0hE1KCzZe5dQo+99M=;
        b=AyzLrDxM19cFrs2Nve/QeM0naytpB9p/ReHyPczU9SwTp2aaG6bFdPmaQKGzXPq6HC
         KZ48940KE7NU7EszCvfjBOOsXbVnxvSb6FtOZk2cIV5iqlV1OJYzUbdG375qrnN2JguM
         DQBiU3MTnCop8IGbi95RMTe7iy+SfgEofTuySi/4IcnaMikQyFnjdUk3aPrbo9Ey9SWL
         bWCpggRm9dKM1cpf4kjT0WTSraqqUT6msD/+cli4PffLJz9fgYACHaXcnBAnwJPp0z/t
         CUhBxHk0MVY75W5gkDkcTLGTR+nZVjnsamOkbsEoxQQ8NyYkFf2LdlXRpkzgdAuZ0KMv
         2rrg==
X-Received: by 10.69.15.33 with SMTP id fl1mr37248077pbd.189.1373791067219;
        Sun, 14 Jul 2013 01:37:47 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id py6sm54540170pbb.33.2013.07.14.01.37.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:37:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:37:59 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230327>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 790e5ab..530f0ed 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -284,17 +284,17 @@ static char *prepare_index(int argc, const char *=
*argv, const char *prefix,
 {
 	int fd;
 	struct string_list partial;
-	const char **pathspec =3D NULL;
+	struct pathspec pathspec;
 	char *old_index_env =3D NULL;
 	int refresh_flags =3D REFRESH_QUIET;
=20
 	if (is_status)
 		refresh_flags |=3D REFRESH_UNMERGED;
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_FULL,
+		       prefix, argv);
=20
-	if (*argv)
-		pathspec =3D get_pathspec(prefix, argv);
-
-	if (read_cache_preload(pathspec) < 0)
+	if (read_cache_preload(pathspec.raw) < 0)
 		die(_("index file corrupt"));
=20
 	if (interactive) {
@@ -336,9 +336,9 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 	 * (A) if all goes well, commit the real index;
 	 * (B) on failure, rollback the real index.
 	 */
-	if (all || (also && pathspec && *pathspec)) {
+	if (all || (also && pathspec.nr)) {
 		fd =3D hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
+		add_files_to_cache(also ? prefix : NULL, pathspec.raw, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_cache(fd, active_cache, active_nr) ||
@@ -357,7 +357,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 	 * and create commit from the_index.
 	 * We still need to refresh the index here.
 	 */
-	if (!only && (!pathspec || !*pathspec)) {
+	if (!only && !pathspec.nr) {
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
@@ -402,7 +402,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
=20
 	memset(&partial, 0, sizeof(partial));
 	partial.strdup_strings =3D 1;
-	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, paths=
pec))
+	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, paths=
pec.raw))
 		exit(1);
=20
 	discard_cache();
--=20
1.8.2.83.gc99314b
