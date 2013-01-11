From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/21] commit: convert to use parse_pathspec
Date: Fri, 11 Jan 2013 18:20:59 +0700
Message-ID: <1357903275-16804-6-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtcgK-0006fJ-Mw
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab3AKLVd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:21:33 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:45123 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab3AKLVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:21:32 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so731606dak.20
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+04Nzh3tnRU7pfwQz3B4PBYyQm447nABCfRsckxAVFY=;
        b=GSaSDTgclRDtk5kvCnMSxhIlsIFPj90Wti4jwXEAbgu+wZV8r84ebb2P2YD8d7hgo7
         RZFP7WR+6jymVM7yGJ02rdPEMfrCoxokl17niY9IVnWK/6+FZM45xsUfCDz9E/3BDcU6
         jSbTHOtcFDw7L3JLtZshEVVpAre9WKCC3qOSUNqXhUeaBichhLyAI1cxjurDOevS62cW
         RXJ/vJHhhm54Vzuhr4ESdavZkqojwt7PVHh4O3JbK2ZOpU48oTVoZu4BrylWeDMuAzV7
         GZr2H3lQ5Ug2ak7brCNTx3gn2JJVczScnAce3lIsIBfBKzOqwBIkHbjAi0QqvTknYbw0
         WAFw==
X-Received: by 10.66.82.198 with SMTP id k6mr206147511pay.53.1357903291806;
        Fri, 11 Jan 2013 03:21:31 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id ho4sm2633665pbc.54.2013.01.11.03.21.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:21:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:21:46 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213197>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 18 +++++++++---------
 cache.h          |  3 +++
 setup.c          |  3 +++
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..444ae1d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -277,17 +277,17 @@ static char *prepare_index(int argc, const char *=
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
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP,
+		       PATHSPEC_EMPTY_MATCH_ALL,
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
@@ -329,9 +329,9 @@ static char *prepare_index(int argc, const char **a=
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
@@ -350,7 +350,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 	 * and create commit from the_index.
 	 * We still need to refresh the index here.
 	 */
-	if (!only && (!pathspec || !*pathspec)) {
+	if (!only && !pathspec.nr) {
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
@@ -395,7 +395,7 @@ static char *prepare_index(int argc, const char **a=
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
diff --git a/cache.h b/cache.h
index e52365d..a3c316f 100644
--- a/cache.h
+++ b/cache.h
@@ -476,6 +476,9 @@ extern int ie_modified(const struct index_state *, =
struct cache_entry *, struct
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP    (1<<0)
=20
+/* Pathspec flags */
+#define PATHSPEC_EMPTY_MATCH_ALL (1<<0) /* No args means match everyth=
ing */
+
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
diff --git a/setup.c b/setup.c
index 6e960b9..a26b6c0 100644
--- a/setup.c
+++ b/setup.c
@@ -280,6 +280,9 @@ void parse_pathspec(struct pathspec *pathspec,
 	if (!entry && !prefix)
 		return;
=20
+	if (!*argv && (flags & PATHSPEC_EMPTY_MATCH_ALL))
+		return;
+
 	/* No arguments with prefix -> prefix pathspec */
 	if (!entry) {
 		static const char *raw[2];
--=20
1.8.0.rc2.23.g1fb49df
