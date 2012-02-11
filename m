From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] pack-refs: remove all empty dirs under .git/{refs,logs/refs}
Date: Sat, 11 Feb 2012 18:08:04 +0700
Message-ID: <1328958484-4202-1-git-send-email-pclouds@gmail.com>
References: <1328946907-31650-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 12:02:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwAio-0007nD-A6
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 12:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab2BKLBy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 06:01:54 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64780 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab2BKLBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 06:01:53 -0500
Received: by daed14 with SMTP id d14so3060035dae.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 03:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TRiwTuLkDcN4ODJGGC/YuCIHWwrKUADqbddsDy8vTNk=;
        b=NHdUROgyKzKlI9IgWqylL8GUvFQBC19SdijAhNl6Dm2g+x8alELGvVtYONNKU3phMu
         V8hxOVos7cQaYU1txmDkA6K45FX+9qYmy8PxKdd32P6E6TEyl0+w3uArlDyD6pWrw3R5
         JvMJskCFE/Eq31l+LP851BAVHC4y5+UF7YR5U=
Received: by 10.68.199.38 with SMTP id jh6mr25484725pbc.77.1328958112796;
        Sat, 11 Feb 2012 03:01:52 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id r10sm21219918pbs.12.2012.02.11.03.01.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 03:01:51 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 11 Feb 2012 18:08:05 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328946907-31650-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190509>

"git pack-refs" tries to remove directory that becomes empty but it
does not try to do so hard enough. Only empty directories created
because a ref is packed are considered.

This patch introduces a global switch, which instructs ref machinery
to collect all empty directories (or ones containing only empty
directories) in removable order. "git pack-refs" uses this information
to clean $GIT_DIR/refs and $GIT_DIR/logs/refs.

Some directories are kept by this patch even if they are empty: refs,
refs/heads and refs/tags. The first one is one of git repository
signature. The rest is created by init-db, one may expect them to alway=
s
be there.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v3, no second look at $GIT_DIR/refs and also clean
 $GIT_DIR/logs/refs. Not really fond of the global switch, but it does
 not look very intrusive to refs.c

 builtin/pack-refs.c  |    2 ++
 pack-refs.c          |   10 ++++++++++
 refs.c               |   35 +++++++++++++++++++++++++++++++----
 refs.h               |    4 ++++
 t/t3210-pack-refs.sh |   10 ++++++++++
 5 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 39a9d89..044ae8f 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "pack-refs.h"
+#include "refs.h"
=20
 static char const * const pack_refs_usage[] =3D {
 	"git pack-refs [options]",
@@ -15,6 +16,7 @@ int cmd_pack_refs(int argc, const char **argv, const =
char *prefix)
 		OPT_BIT(0, "prune", &flags, "prune loose refs (default)", PACK_REFS_=
PRUNE),
 		OPT_END(),
 	};
+	save_empty_ref_directories =3D 1;
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 	return pack_refs(flags);
diff --git a/pack-refs.c b/pack-refs.c
index f09a054..76d3408 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "tag.h"
 #include "pack-refs.h"
+#include "string-list.h"
=20
 struct ref_to_prune {
 	struct ref_to_prune *next;
@@ -105,10 +106,19 @@ static void prune_ref(struct ref_to_prune *r)
=20
 static void prune_refs(struct ref_to_prune *r)
 {
+	struct string_list *list =3D get_empty_ref_directories();;
+	int i;
+
 	while (r) {
 		prune_ref(r);
 		r =3D r->next;
 	}
+
+	for (i =3D 0; i < list->nr; i++) {
+		const char *s =3D list->items[i].string;
+		rmdir(git_path("%s", s));
+		rmdir(git_path("logs/%s", s));
+	}
 }
=20
 static struct lock_file packed;
diff --git a/refs.c b/refs.c
index b8843bb..7e9a250 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "tag.h"
 #include "dir.h"
+#include "string-list.h"
=20
 /* ISSYMREF=3D0x01, ISPACKED=3D0x02 and ISBROKEN=3D0x04 are public int=
erfaces */
 #define REF_KNOWS_PEELED 0x10
@@ -29,6 +30,8 @@ struct ref_array {
 	struct ref_entry **refs;
 };
=20
+int save_empty_ref_directories;
+
 /*
  * Parse one line from a packed-refs file.  Write the SHA1 to sha1.
  * Return a pointer to the refname within the line (null-terminated),
@@ -177,6 +180,7 @@ static struct ref_cache {
 	char did_packed;
 	struct ref_array loose;
 	struct ref_array packed;
+	struct string_list empty_dirs;
 	/* The submodule name, or "" for the main repo. */
 	char name[FLEX_ARRAY];
 } *ref_cache;
@@ -326,7 +330,7 @@ void add_packed_ref(const char *refname, const unsi=
gned char *sha1)
 }
=20
 static void get_ref_dir(struct ref_cache *refs, const char *base,
-			struct ref_array *array)
+			struct ref_array *array, int *would_be_empty)
 {
 	DIR *dir;
 	const char *path;
@@ -343,6 +347,7 @@ static void get_ref_dir(struct ref_cache *refs, con=
st char *base,
 		struct dirent *de;
 		int baselen =3D strlen(base);
 		char *refname =3D xmalloc(baselen + 257);
+		int nr =3D 0;
=20
 		memcpy(refname, base, baselen);
 		if (baselen && base[baselen-1] !=3D '/')
@@ -355,8 +360,13 @@ static void get_ref_dir(struct ref_cache *refs, co=
nst char *base,
 			int namelen;
 			const char *refdir;
=20
-			if (de->d_name[0] =3D=3D '.')
+			if (de->d_name[0] =3D=3D '.') {
+				if (strcmp(de->d_name, "..") &&
+				    strcmp(de->d_name, "."))
+					nr++;
 				continue;
+			}
+			nr++;
 			namelen =3D strlen(de->d_name);
 			if (namelen > 255)
 				continue;
@@ -369,7 +379,10 @@ static void get_ref_dir(struct ref_cache *refs, co=
nst char *base,
 			if (stat(refdir, &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				get_ref_dir(refs, refname, array);
+				int empty =3D 0;
+				get_ref_dir(refs, refname, array, &empty);
+				if (empty)
+					nr--;
 				continue;
 			}
 			if (*refs->name) {
@@ -387,6 +400,15 @@ static void get_ref_dir(struct ref_cache *refs, co=
nst char *base,
 		}
 		free(refname);
 		closedir(dir);
+		if (save_empty_ref_directories &&
+		    nr =3D=3D 0 &&
+		    strcmp(base, "refs") &&
+		    strcmp(base, "refs/heads") &&
+		    strcmp(base, "refs/tags")) {
+			string_list_append(&refs->empty_dirs, xstrdup(base));
+			if (would_be_empty)
+				*would_be_empty =3D 1;
+		}
 	}
 }
=20
@@ -427,12 +449,17 @@ void warn_dangling_symref(FILE *fp, const char *m=
sg_fmt, const char *refname)
 static struct ref_array *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
-		get_ref_dir(refs, "refs", &refs->loose);
+		get_ref_dir(refs, "refs", &refs->loose, NULL);
 		refs->did_loose =3D 1;
 	}
 	return &refs->loose;
 }
=20
+struct string_list *get_empty_ref_directories()
+{
+	return &get_ref_cache(NULL)->empty_dirs;
+}
+
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 #define MAXREFLEN (1024)
diff --git a/refs.h b/refs.h
index 00ba1e2..21a2a00 100644
--- a/refs.h
+++ b/refs.h
@@ -14,6 +14,10 @@ struct ref_lock {
 #define REF_ISPACKED 0x02
 #define REF_ISBROKEN 0x04
=20
+struct string_list;
+extern int save_empty_ref_directories;
+extern struct string_list *get_empty_ref_directories();
+
 /*
  * Calls the specified function for each ref file until it returns non=
zero,
  * and returns the value
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index cd04361..40fcd54 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -66,6 +66,16 @@ test_expect_success 'see if git pack-refs --prune re=
moves empty dirs' '
      ! test -e .git/refs/heads/r
 '
=20
+test_expect_success 'pack-refs --prune removes all empty dirs in refs =
and logs' '
+     mkdir -p .git/refs/empty/outside/heads &&
+     mkdir -p .git/refs/heads/empty/dir/ectory &&
+     mkdir -p .git/logs/refs/heads/empty/dir/ectory &&
+     git pack-refs --all --prune &&
+     ! test -e .git/refs/empty &&
+     ! test -e .git/refs/heads/empty &&
+     ! test -e .git/logs/refs/heads/empty
+'
+
 test_expect_success \
     'git branch g should work when git branch g/h has been deleted' \
     'git branch g/h &&
--=20
1.7.8.36.g69ee2
