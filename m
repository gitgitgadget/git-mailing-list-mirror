From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] rerere: remove duplicated functions
Date: Sat, 14 Feb 2009 23:21:04 +0100
Message-ID: <1234650064-639-1-git-send-email-szeder@ira.uka.de>
References: <alpine.DEB.1.00.0902141944030.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 23:23:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYSua-0005ay-11
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbZBNWVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 17:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbZBNWVK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:21:10 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:60095 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZBNWVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:21:08 -0500
Received: from [127.0.1.1] (p5B130271.dip0.t-ipconnect.de [91.19.2.113])
	by mrelayeu.kundenserver.de (node=mrelayeu0) with ESMTP (Nemesis)
	id 0MKwh2-1LYSsg46m9-0006Lb; Sat, 14 Feb 2009 23:21:06 +0100
X-Mailer: git-send-email 1.6.2.rc0.111.g246ed
In-Reply-To: <alpine.DEB.1.00.0902141944030.10279@pacific.mpi-cbg.de>
X-Provags-ID: V01U2FsdGVkX1+oxjBKiQkNjN7Ll5nh4rOUmuNvB56HNNhK0mz
 XiacYVNxFA9ks/nKlrTj1Z5vdXLKVbLWw/hD0gyCDbOgtodbw3
 P/rdlC/BVd7rW6oMeQJ7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109941>

Both rerere.c and builtin-rerere.c define the static functions
rr_path() and has_resolution() the exact same way.  To eliminate this
code duplication this patch turns the functions in rerere.c
non-static, and makes builtin-rerere.c use them.  Also, since this
puts these two functions into the global namespace, rename them to
rerere_path() and has_rerere_resolution(), respectively, and rename
their "name" parameter to "hex", because it better reflects what that
parameter actually is.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

  On Sat, Feb 14, 2009 at 07:47:36PM +0100, Johannes Schindelin wrote:
  > > +extern const char *rr_path(const char *name, const char *file);
  > > +extern int has_resolution(const char *name);
  >=20
  > You might argue that rr_path() is a unique enough name (although I'=
d
  > rather name it rerere_path() instead), but has_resolution() is not =
a
  > good description of what the function does when it lives in the glo=
bal
  > name space.  has_rerere_resolution() (with "hex" instead of "name",=
 to
  > make it obvious what the parameter actually _is_) should be a much
  > better name.

  You are right;  I was aiming for a minimal change and haven't noticed
  the naming issue.  Renamed both functions and their "name" parameter,
  as you suggested.


 builtin-rerere.c |   25 +++++++------------------
 rerere.c         |   22 +++++++++++-----------
 rerere.h         |    2 ++
 3 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index bd8fc77..020af73 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -13,28 +13,17 @@ static const char git_rerere_usage[] =3D
 static int cutoff_noresolve =3D 15;
 static int cutoff_resolve =3D 60;
=20
-static const char *rr_path(const char *name, const char *file)
-{
-	return git_path("rr-cache/%s/%s", name, file);
-}
-
 static time_t rerere_created_at(const char *name)
 {
 	struct stat st;
-	return stat(rr_path(name, "preimage"), &st) ? (time_t) 0 : st.st_mtim=
e;
-}
-
-static int has_resolution(const char *name)
-{
-	struct stat st;
-	return !stat(rr_path(name, "postimage"), &st);
+	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : st.st_=
mtime;
 }
=20
 static void unlink_rr_item(const char *name)
 {
-	unlink(rr_path(name, "thisimage"));
-	unlink(rr_path(name, "preimage"));
-	unlink(rr_path(name, "postimage"));
+	unlink(rerere_path(name, "thisimage"));
+	unlink(rerere_path(name, "preimage"));
+	unlink(rerere_path(name, "postimage"));
 	rmdir(git_path("rr-cache/%s", name));
 }
=20
@@ -65,7 +54,7 @@ static void garbage_collect(struct string_list *rr)
 		then =3D rerere_created_at(e->d_name);
 		if (!then)
 			continue;
-		cutoff =3D (has_resolution(e->d_name)
+		cutoff =3D (has_rerere_resolution(e->d_name)
 			  ? cutoff_resolve : cutoff_noresolve);
 		if (then < now - cutoff * 86400)
 			string_list_append(e->d_name, &to_remove);
@@ -124,7 +113,7 @@ int cmd_rerere(int argc, const char **argv, const c=
har *prefix)
 	if (!strcmp(argv[1], "clear")) {
 		for (i =3D 0; i < merge_rr.nr; i++) {
 			const char *name =3D (const char *)merge_rr.items[i].util;
-			if (!has_resolution(name))
+			if (!has_rerere_resolution(name))
 				unlink_rr_item(name);
 		}
 		unlink(git_path("rr-cache/MERGE_RR"));
@@ -137,7 +126,7 @@ int cmd_rerere(int argc, const char **argv, const c=
har *prefix)
 		for (i =3D 0; i < merge_rr.nr; i++) {
 			const char *path =3D merge_rr.items[i].string;
 			const char *name =3D (const char *)merge_rr.items[i].util;
-			diff_two(rr_path(name, "preimage"), path, path, path);
+			diff_two(rerere_path(name, "preimage"), path, path, path);
 		}
 	else
 		usage(git_rerere_usage);
diff --git a/rerere.c b/rerere.c
index 3518207..713c6e1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -12,15 +12,15 @@ static int rerere_autoupdate;
=20
 static char *merge_rr_path;
=20
-static const char *rr_path(const char *name, const char *file)
+const char *rerere_path(const char *hex, const char *file)
 {
-	return git_path("rr-cache/%s/%s", name, file);
+	return git_path("rr-cache/%s/%s", hex, file);
 }
=20
-static int has_resolution(const char *name)
+int has_rerere_resolution(const char *hex)
 {
 	struct stat st;
-	return !stat(rr_path(name, "postimage"), &st);
+	return !stat(rerere_path(hex, "postimage"), &st);
 }
=20
 static void read_rr(struct string_list *rr)
@@ -208,12 +208,12 @@ static int merge(const char *name, const char *pa=
th)
 	mmbuffer_t result =3D {NULL, 0};
 	xpparam_t xpp =3D {XDF_NEED_MINIMAL};
=20
-	if (handle_file(path, NULL, rr_path(name, "thisimage")) < 0)
+	if (handle_file(path, NULL, rerere_path(name, "thisimage")) < 0)
 		return 1;
=20
-	if (read_mmfile(&cur, rr_path(name, "thisimage")) ||
-			read_mmfile(&base, rr_path(name, "preimage")) ||
-			read_mmfile(&other, rr_path(name, "postimage")))
+	if (read_mmfile(&cur, rerere_path(name, "thisimage")) ||
+			read_mmfile(&base, rerere_path(name, "preimage")) ||
+			read_mmfile(&other, rerere_path(name, "postimage")))
 		return 1;
 	ret =3D xdl_merge(&base, &cur, "", &other, "",
 			&xpp, XDL_MERGE_ZEALOUS, &result);
@@ -291,7 +291,7 @@ static int do_plain_rerere(struct string_list *rr, =
int fd)
 			string_list_insert(path, rr)->util =3D hex;
 			if (mkdir(git_path("rr-cache/%s", hex), 0755))
 				continue;
-			handle_file(path, NULL, rr_path(hex, "preimage"));
+			handle_file(path, NULL, rerere_path(hex, "preimage"));
 			fprintf(stderr, "Recorded preimage for '%s'\n", path);
 		}
 	}
@@ -307,7 +307,7 @@ static int do_plain_rerere(struct string_list *rr, =
int fd)
 		const char *path =3D rr->items[i].string;
 		const char *name =3D (const char *)rr->items[i].util;
=20
-		if (has_resolution(name)) {
+		if (has_rerere_resolution(name)) {
 			if (!merge(name, path)) {
 				if (rerere_autoupdate)
 					string_list_insert(path, &update);
@@ -326,7 +326,7 @@ static int do_plain_rerere(struct string_list *rr, =
int fd)
 			continue;
=20
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
-		copy_file(rr_path(name, "postimage"), path, 0666);
+		copy_file(rerere_path(name, "postimage"), path, 0666);
 	mark_resolved:
 		rr->items[i].util =3D NULL;
 	}
diff --git a/rerere.h b/rerere.h
index f9b0386..13313f3 100644
--- a/rerere.h
+++ b/rerere.h
@@ -5,5 +5,7 @@
=20
 extern int setup_rerere(struct string_list *);
 extern int rerere(void);
+extern const char *rerere_path(const char *hex, const char *file);
+extern int has_rerere_resolution(const char *hex);
=20
 #endif
--=20
1.6.2.rc0.111.g246ed
