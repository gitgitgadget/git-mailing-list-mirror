From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] count-objects: report garbage files in pack directory too
Date: Fri,  8 Feb 2013 10:48:26 +0700
Message-ID: <1360295307-5469-3-git-send-email-pclouds@gmail.com>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1360295307-5469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 04:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3ezq-0001WQ-3d
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 04:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759700Ab3BHDvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2013 22:51:06 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:59175 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759295Ab3BHDvF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 22:51:05 -0500
Received: by mail-da0-f48.google.com with SMTP id v40so1563754dad.21
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 19:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2JpN1xr/rosmOIwBFIjIwv/xB9z0AZ7/jfPZSiApqQU=;
        b=Sb1OaciB4KtgBNY9A/K5XGeF/iIeUSCXI8QYoX8/qmlMwapFchiQKgWXns1oY4iq0p
         4hgIgsrp9LRMtLBFhzb610ysSpaZqeB/vWo1XeA7IkQk2XxOtI0kWCHP6+2h9SHKNtpO
         zF3ZTvmtV4I8HX9Dpf3D+MGYTfIt0g1/dJk9JBUpQc+Vhevi97Yd/lHT77YApMBTaV8i
         TcGETLsi6F8T58Loh3f19tDQJDi2xPXSWjVS3TntuPqXP2oDbmse5qOfKuiTISzKkNyE
         H5SSS7ZMA80CLgGro5d/w6AT+qAElefKV0bOqLI+BdaSdYmpM1Nll71tlny6KTE1pTTq
         E2JQ==
X-Received: by 10.66.80.70 with SMTP id p6mr12801965pax.23.1360295463109;
        Thu, 07 Feb 2013 19:51:03 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id e6sm50876070paw.16.2013.02.07.19.50.59
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 19:51:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 08 Feb 2013 10:50:56 +0700
X-Mailer: git-send-email 1.8.1.2.495.g3fdf5d5.dirty
In-Reply-To: <1360295307-5469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215746>

prepare_packed_git_one() is modified to allow count-objects to hook a
report function to so we don't need to duplicate the pack searching
logic in count-objects.c. When report_pack_garbage is NULL, the
overhead is insignificant.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-count-objects.txt |  4 +-
 builtin/count-objects.c             | 18 ++++++++-
 sha1_file.c                         | 81 +++++++++++++++++++++++++++++=
++++++--
 3 files changed, 97 insertions(+), 6 deletions(-)

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
index 9afaa88..118b2ae 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -9,6 +9,20 @@
 #include "builtin.h"
 #include "parse-options.h"
=20
+static unsigned long garbage;
+
+extern void (*report_pack_garbage)(const char *path, int len, const ch=
ar *name);
+static void real_report_pack_garbage(const char *path, int len, const =
char *name)
+{
+	if (len && name)
+		error("garbage found: %.*s/%s", len, path, name);
+	else if (!len && name)
+		error("garbage found: %s%s", path, name);
+	else
+		error("garbage found: %s", path);
+	garbage++;
+}
+
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
 			  off_t *loose_size,
@@ -76,7 +90,7 @@ int cmd_count_objects(int argc, const char **argv, co=
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
@@ -87,6 +101,8 @@ int cmd_count_objects(int argc, const char **argv, c=
onst char *prefix)
 	/* we do not take arguments other than flags for now */
 	if (argc)
 		usage_with_options(count_objects_usage, opts);
+	if (verbose)
+		report_pack_garbage =3D real_report_pack_garbage;
 	memcpy(path, objdir, len);
 	if (len && objdir[len-1] !=3D '/')
 		path[len++] =3D '/';
diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..cc6ef03 100644
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
@@ -1000,6 +1001,54 @@ void install_packed_git(struct packed_git *pack)
 	packed_git =3D pack;
 }
=20
+/* A hook for count-objects to report invalid files in pack directory =
*/
+void (*report_pack_garbage)(const char *path, int len, const char *nam=
e);
+
+static const char *known_pack_extensions[] =3D { ".pack", ".keep", NUL=
L };
+
+static void report_garbage(struct string_list *list)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct packed_git *p;
+	int i;
+
+	if (!report_pack_garbage)
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
+			   strlen(p->pack_name) - strlen(".pack"));
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
+		report_pack_garbage(item->string, 0, item->util);
+	}
+	strbuf_release(&sb);
+}
+
 static void prepare_packed_git_one(char *objdir, int local)
 {
 	/* Ensure that this buffer is large enough so that we can
@@ -1009,6 +1058,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 	int len;
 	DIR *dir;
 	struct dirent *de;
+	struct string_list garbage =3D STRING_LIST_INIT_DUP;
=20
 	sprintf(path, "%s/pack", objdir);
 	len =3D strlen(path);
@@ -1024,14 +1074,37 @@ static void prepare_packed_git_one(char *objdir=
, int local)
 		int namelen =3D strlen(de->d_name);
 		struct packed_git *p;
=20
-		if (!has_extension(de->d_name, ".idx"))
+		if (len + namelen + 1 > sizeof(path)) {
+			if (report_pack_garbage)
+				report_pack_garbage(path, len - 1, de->d_name);
 			continue;
+		}
+
+		strcpy(path + len, de->d_name);
=20
-		if (len + namelen + 1 > sizeof(path))
+		if (!has_extension(de->d_name, ".idx")) {
+			struct string_list_item *item;
+			int i, n;
+			if (!report_pack_garbage)
+				continue;
+			if (is_dot_or_dotdot(de->d_name))
+				continue;
+			for (i =3D 0; known_pack_extensions[i]; i++)
+				if (has_extension(de->d_name,
+						  known_pack_extensions[i]))
+					break;
+			if (!known_pack_extensions[i]) {
+				report_pack_garbage(path, 0, NULL);
+				continue;
+			}
+			n =3D strlen(path) - strlen(known_pack_extensions[i]);
+			item =3D string_list_append_nodup(&garbage,
+							xstrndup(path, n));
+			item->util =3D (void*)known_pack_extensions[i];
 			continue;
+		}
=20
 		/* Don't reopen a pack we already have. */
-		strcpy(path + len, de->d_name);
 		for (p =3D packed_git; p; p =3D p->next) {
 			if (!memcmp(path, p->pack_name, len + namelen - 4))
 				break;
@@ -1047,6 +1120,8 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 		install_packed_git(p);
 	}
 	closedir(dir);
+	report_garbage(&garbage);
+	string_list_clear(&garbage, 0);
 }
=20
 static int sort_pack(const void *a_, const void *b_)
--=20
1.8.1.2.495.g3fdf5d5.dirty
