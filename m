From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/21] commit: convert to use parse_pathspec
Date: Sun,  6 Jan 2013 13:20:53 +0700
Message-ID: <1357453268-12543-7-git-send-email-pclouds@gmail.com>
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
	id 1TrjcO-0007nA-2u
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab3AFGVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:21:41 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58219 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab3AFGVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:21:39 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so10162467pad.7
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=3lOA7wqdTJ4x4svtTBs3uEDkigVyI7pJxUFiXrh6A64=;
        b=Vyj5+NrlajKRsFQYkO9Ml5xC269z1yH/icCQssU+o6+ZGVx6qREAcTI2W5C0sAsyIS
         f+b6SW6ZcSXvIIUgcmv7hB2yzJeWXRNlyNaUjhWTxHDE+z/wlY6ifQNe8MY57du9J2T/
         fxxTaq5UkQ8WkSMZUSbbXNCShQFekcE1mrn1nrjm3WcF8bNeOIgaAsUDRJUS3i9Ra8wV
         v0L726a6D5l6rHZ7dnRWxMwWDNjkI6GMbX7nD8v/mH9jtbdiGjzZF2XvTVXVe/tE83Y4
         k+p2bC06A+brFhVH9lKA+V4kseuWlUQknI85skidAdwDTJ+96eSkmYwB2Qh0z0v9ZeLK
         e6Bw==
X-Received: by 10.68.241.65 with SMTP id wg1mr178680692pbc.141.1357453298626;
        Sat, 05 Jan 2013 22:21:38 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id a4sm36318521pax.25.2013.01.05.22.21.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:21:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:21:48 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212760>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..8410617 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -277,17 +277,18 @@ static char *prepare_index(int argc, const char *=
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
-
 	if (*argv)
-		pathspec =3D get_pathspec(prefix, argv);
+		parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
+	else
+		memset(&pathspec, 0, sizeof(pathspec));
=20
-	if (read_cache_preload(pathspec) < 0)
+	if (read_cache_preload(pathspec.raw) < 0)
 		die(_("index file corrupt"));
=20
 	if (interactive) {
@@ -329,9 +330,9 @@ static char *prepare_index(int argc, const char **a=
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
@@ -350,7 +351,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 	 * and create commit from the_index.
 	 * We still need to refresh the index here.
 	 */
-	if (!only && (!pathspec || !*pathspec)) {
+	if (!only && !pathspec.nr) {
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
@@ -395,7 +396,7 @@ static char *prepare_index(int argc, const char **a=
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
1.8.0.rc2.23.g1fb49df
