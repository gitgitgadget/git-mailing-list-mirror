From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/4] count-objects: report garbage files in pack directory too
Date: Tue, 12 Feb 2013 16:27:56 +0700
Message-ID: <1360661277-17273-4-git-send-email-pclouds@gmail.com>
References: <1360661277-17273-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 10:28:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5C9l-0002DN-KW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 10:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027Ab3BLJ1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 04:27:37 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:41237 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012Ab3BLJ1c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 04:27:32 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so3587797pad.28
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 01:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=mt33K9TPfMDcYv9SULU5ZH8ROlorlvNy2r35GTtmEGM=;
        b=UbBI6mbWq3OEzV3zXuQepYoaM9DcBRRykhRcMtJW2dZLHgym5V7mNV8Q6vqh+Xe/9J
         Xk+2HvnxGMGkqmBsC/pJp6hA4n7dP2PEtHIFE7PQRAQlA6v1edu038uCUv+cM387y5F7
         lFFe/rwbuQ+azA9X0ONarbXOaLsiJyRjMjXcymnYVLWi3EAfdE38sN7c5VV5Esf9GCGE
         1RGVDPlv3UVHnkqLesCIFrd7oSmaKFHtiNQ43RjjO91mZDX8978IJvFRKun2H78vg9Cq
         S+aU7V0jJlw/f5r55bcogER1b1nZOtzOFXDLqZjHdB8YNiETgg/vYskgbeMvzEbMGhc6
         fGkQ==
X-Received: by 10.66.79.202 with SMTP id l10mr50169754pax.36.1360661251581;
        Tue, 12 Feb 2013 01:27:31 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id e6sm73514880paw.16.2013.02.12.01.27.27
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 01:27:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Feb 2013 16:28:18 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1360661277-17273-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216125>

prepare_packed_git_one() is modified to allow count-objects to hook a
report function to so we don't need to duplicate the pack searching
logic in count-objects.c. When report_pack_garbage is NULL, the
overhead is insignificant.

The garbage is reported with warning() instead of error() in packed
garbage case because it's not an error to have garbage. Loose garbage
is still reported as errors and will be converted to warnings later.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-count-objects.txt |  4 +-
 builtin/count-objects.c             | 22 +++++++++-
 cache.h                             |  3 ++
 sha1_file.c                         | 83 +++++++++++++++++++++++++++++=
+++++++-
 4 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-co=
unt-objects.txt
index e816823..1611d7c 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -33,8 +33,8 @@ size-pack: disk space consumed by the packs, in KiB
 prune-packable: the number of loose objects that are also present in
 the packs. These objects could be pruned using `git prune-packed`.
 +
-garbage: the number of files in loose object database that are not
-valid loose objects
+garbage: the number of files in object database that are not valid
+loose objects nor valid packs
=20
 GIT
 ---
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 9afaa88..639c9a5 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -9,6 +9,24 @@
 #include "builtin.h"
 #include "parse-options.h"
=20
+static unsigned long garbage;
+
+static void real_report_garbage(const char *desc,
+				const char *path, int len,
+				const char *name)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	if (len && name)
+		strbuf_addf(&sb, "%.*s/%s", len, path, name);
+	else if (!len && name)
+		strbuf_addf(&sb, "%s%s", path, name);
+	else
+		strbuf_addf(&sb, "%s", path);
+	warning("%s: %s", desc, sb.buf);
+	garbage++;
+	strbuf_release(&sb);
+}
+
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
 			  off_t *loose_size,
@@ -76,7 +94,7 @@ int cmd_count_objects(int argc, const char **argv, co=
nst char *prefix)
 	const char *objdir =3D get_object_directory();
 	int len =3D strlen(objdir);
 	char *path =3D xmalloc(len + 50);
-	unsigned long loose =3D 0, packed =3D 0, packed_loose =3D 0, garbage =
=3D 0;
+	unsigned long loose =3D 0, packed =3D 0, packed_loose =3D 0;
 	off_t loose_size =3D 0;
 	struct option opts[] =3D {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -87,6 +105,8 @@ int cmd_count_objects(int argc, const char **argv, c=
onst char *prefix)
 	/* we do not take arguments other than flags for now */
 	if (argc)
 		usage_with_options(count_objects_usage, opts);
+	if (verbose)
+		report_garbage =3D real_report_garbage;
 	memcpy(path, objdir, len);
 	if (len && objdir[len-1] !=3D '/')
 		path[len++] =3D '/';
diff --git a/cache.h b/cache.h
index 7339f21..e486499 100644
--- a/cache.h
+++ b/cache.h
@@ -1051,6 +1051,9 @@ extern const char *parse_feature_value(const char=
 *feature_list, const char *fea
=20
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const =
char *idx_path);
=20
+/* A hook for count-objects to report invalid files in pack directory =
*/
+extern void (*report_garbage)(const char *desc, const char *path, int =
len, const char *name);
+
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
 extern void install_packed_git(struct packed_git *pack);
diff --git a/sha1_file.c b/sha1_file.c
index 8d7da1d..290e348 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -21,6 +21,7 @@
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
 #include "streaming.h"
+#include "dir.h"
=20
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -1000,6 +1001,52 @@ void install_packed_git(struct packed_git *pack)
 	packed_git =3D pack;
 }
=20
+void (*report_garbage)(const char *desc, const char *path,
+		       int len, const char *name);
+
+static void report_pack_garbage(struct string_list *list)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct packed_git *p;
+	int i;
+
+	if (!report_garbage)
+		return;
+
+	sort_string_list(list);
+
+	for (p =3D packed_git; p; p =3D p->next) {
+		struct string_list_item *item;
+		if (!p->pack_local)
+			continue;
+		strbuf_reset(&sb);
+		strbuf_add(&sb, p->pack_name,
+			   strlen(p->pack_name) - 5); /* ".pack" */
+		item =3D string_list_lookup(list, sb.buf);
+		if (!item)
+			continue;
+		/*
+		 * string_list_lookup does not guarantee to return the
+		 * first matched string if it's duplicated.
+		 */
+		while (item - list->items &&
+		       !strcmp(item[-1].string, item->string))
+			item--;
+		while (item - list->items < list->nr &&
+		       !strcmp(item->string, sb.buf)) {
+			item->util =3D NULL; /* non-garbage mark */
+			item++;
+		}
+	}
+	for (i =3D 0; i < list->nr; i++) {
+		struct string_list_item *item =3D list->items + i;
+		if (!item->util)
+			continue;
+		report_garbage("garbage found", item->string, 0, item->util);
+	}
+	strbuf_release(&sb);
+}
+
 static void prepare_packed_git_one(char *objdir, int local)
 {
 	/* Ensure that this buffer is large enough so that we can
@@ -1009,6 +1056,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 	int len;
 	DIR *dir;
 	struct dirent *de;
+	struct string_list garbage =3D STRING_LIST_INIT_DUP;
=20
 	sprintf(path, "%s/pack", objdir);
 	len =3D strlen(path);
@@ -1024,7 +1072,14 @@ static void prepare_packed_git_one(char *objdir,=
 int local)
 		int namelen =3D strlen(de->d_name);
 		struct packed_git *p;
=20
-		if (len + namelen + 1 > sizeof(path))
+		if (len + namelen + 1 > sizeof(path)) {
+			if (report_garbage)
+				report_garbage("path too long",
+					       path, len - 1, de->d_name);
+			continue;
+		}
+
+		if (is_dot_or_dotdot(de->d_name))
 			continue;
=20
 		strcpy(path + len, de->d_name);
@@ -1045,9 +1100,33 @@ static void prepare_packed_git_one(char *objdir,=
 int local)
 			if (!p)
 				continue;
 			install_packed_git(p);
-		}
+		} else if (!report_garbage) {
+			/*
+			 * the rest of this if-chain requires
+			 * report_garbage !=3D NULL. Stop the chain if
+			 * report_garbage is NULL.
+			 */
+			;
+		} else if (has_extension(de->d_name, ".pack")) {
+			struct string_list_item *item;
+			int n =3D strlen(path) - 5;
+			item =3D string_list_append_nodup(&garbage,
+							 xstrndup(path, n));
+			item->util =3D ".pack";
+			continue;
+		} else if (has_extension(de->d_name, ".idx")) {
+			struct string_list_item *item;
+			int n =3D strlen(path) - 4;
+			item =3D string_list_append_nodup(&garbage,
+							xstrndup(path, n));
+			item->util =3D ".idx";
+			continue;
+		} else
+			report_garbage("garbage found", path, 0, NULL);
 	}
 	closedir(dir);
+	report_pack_garbage(&garbage);
+	string_list_clear(&garbage, 0);
 }
=20
 static int sort_pack(const void *a_, const void *b_)
--=20
1.8.1.2.536.gf441e6d
