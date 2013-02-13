From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 3/4] count-objects: report garbage files in pack directory too
Date: Wed, 13 Feb 2013 16:13:18 +0700
Message-ID: <1360746799-3668-4-git-send-email-pclouds@gmail.com>
References: <7va9r9igze.fsf@alter.siamese.dyndns.org>
 <1360746799-3668-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 10:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5YPA-0004wj-IE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 10:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306Ab3BMJND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2013 04:13:03 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61067 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab3BMJNA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 04:13:00 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so600392pab.5
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 01:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=J6PUzxAlw+9/k9fl2J0hohSyNe/9lMqSQemDaoILhd8=;
        b=ijBLCOsAMTd1aH7hJke1xGTye6lHxPxwljpn3hU2lEKt+PShCWRSTkPkmqH3TSlkeK
         RXK0238fZOZstZvCAMe6KEobt67SBm6uF/d6OxZ60aMXk5l3LQCpwIQBIuXiaDZbH1KW
         FqQhTa4ApDe82z6I/Y24h6ufcrEwFYbN70VTgQch/jAMv/UGH0JS1z5ZyJSuXbWhhw6N
         Rnj/BAOl8JkFE9rKUe7Gca/gRGaYCcK+NkwquHs9ffJ/Bvo/jsqsj3/uZRaBWlSOI5VG
         GvAyNJuLaA4usH7XwV3HNZVKoHlhKSEiqnA+JK471mBLQ3SGQg5kU5kviYe1frOb6XuF
         VO8A==
X-Received: by 10.66.74.197 with SMTP id w5mr61780376pav.60.1360746779798;
        Wed, 13 Feb 2013 01:12:59 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id d1sm81951623pav.6.2013.02.13.01.12.56
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 01:12:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Feb 2013 16:13:40 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1360746799-3668-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216242>

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
 builtin/count-objects.c             | 12 +++++-
 cache.h                             |  3 ++
 sha1_file.c                         | 77 +++++++++++++++++++++++++++++=
+++++++-
 t/t5304-prune.sh                    | 26 +++++++++++++
 5 files changed, 118 insertions(+), 4 deletions(-)

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
index 9afaa88..1706c8b 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -9,6 +9,14 @@
 #include "builtin.h"
 #include "parse-options.h"
=20
+static unsigned long garbage;
+
+static void real_report_garbage(const char *desc, const char *path)
+{
+	warning("%s: %s", desc, path);
+	garbage++;
+}
+
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
 			  off_t *loose_size,
@@ -76,7 +84,7 @@ int cmd_count_objects(int argc, const char **argv, co=
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
@@ -87,6 +95,8 @@ int cmd_count_objects(int argc, const char **argv, co=
nst char *prefix)
 	/* we do not take arguments other than flags for now */
 	if (argc)
 		usage_with_options(count_objects_usage, opts);
+	if (verbose)
+		report_garbage =3D real_report_garbage;
 	memcpy(path, objdir, len);
 	if (len && objdir[len-1] !=3D '/')
 		path[len++] =3D '/';
diff --git a/cache.h b/cache.h
index 7339f21..73de68c 100644
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
+extern void (*report_garbage)(const char *desc, const char *path);
+
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
 extern void install_packed_git(struct packed_git *pack);
diff --git a/sha1_file.c b/sha1_file.c
index 239bee7..5bedf78 100644
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
@@ -1000,6 +1001,57 @@ void install_packed_git(struct packed_git *pack)
 	packed_git =3D pack;
 }
=20
+void (*report_garbage)(const char *desc, const char *path);
+
+static void report_helper(const struct string_list *list,
+			  int seen_bits, int first, int last)
+{
+	const char *msg;
+	switch (seen_bits) {
+	case 0: msg =3D "no corresponding .idx nor .pack"; break;
+	case 1: msg =3D "no corresponding .idx"; break;
+	case 2: msg =3D "no corresponding .pack"; break;
+	default:
+		return;
+	}
+	for (; first <=3D last; first++)
+		report_garbage(msg, list->items[first].string);
+}
+
+static void report_pack_garbage(struct string_list *list)
+{
+	int i, baselen =3D -1, first =3D 0, seen_bits =3D 0;
+
+	if (!report_garbage)
+		return;
+
+	sort_string_list(list);
+
+	for (i =3D 0; i < list->nr; i++) {
+		const char *path =3D list->items[i].string;
+		if (baselen !=3D -1 &&
+		    strncmp(path, list->items[first].string, baselen)) {
+			report_helper(list, seen_bits, first, i - 1);
+			baselen =3D -1;
+			seen_bits =3D 0;
+		}
+		if (baselen =3D=3D -1) {
+			const char *dot =3D strrchr(path, '.');
+			if (!dot) {
+				report_garbage("garbage found", path);
+				continue;
+			}
+			baselen =3D dot - path + 1;
+			first =3D i;
+		}
+		if (!strcmp(path + baselen, "pack"))
+			seen_bits |=3D 1;
+		else if (!strcmp(path + baselen, "idx"))
+			seen_bits |=3D 2;
+	}
+	report_helper(list, seen_bits, first, list->nr - 1);
+}
+
 static void prepare_packed_git_one(char *objdir, int local)
 {
 	/* Ensure that this buffer is large enough so that we can
@@ -1009,6 +1061,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 	int len;
 	DIR *dir;
 	struct dirent *de;
+	struct string_list garbage =3D STRING_LIST_INIT_DUP;
=20
 	sprintf(path, "%s/pack", objdir);
 	len =3D strlen(path);
@@ -1024,7 +1077,17 @@ static void prepare_packed_git_one(char *objdir,=
 int local)
 		int namelen =3D strlen(de->d_name);
 		struct packed_git *p;
=20
-		if (len + namelen + 1 > sizeof(path))
+		if (len + namelen + 1 > sizeof(path)) {
+			if (report_garbage) {
+				struct strbuf sb =3D STRBUF_INIT;
+				strbuf_addf(&sb, "%.*s/%s", len - 1, path, de->d_name);
+				report_garbage("path too long", sb.buf);
+				strbuf_release(&sb);
+			}
+			continue;
+		}
+
+		if (is_dot_or_dotdot(de->d_name))
 			continue;
=20
 		strcpy(path + len, de->d_name);
@@ -1043,8 +1106,20 @@ static void prepare_packed_git_one(char *objdir,=
 int local)
 			    (p =3D add_packed_git(path, len + namelen, local)) !=3D NULL)
 				install_packed_git(p);
 		}
+
+		if (!report_garbage)
+			continue;
+
+		if (has_extension(de->d_name, ".idx") ||
+		    has_extension(de->d_name, ".pack") ||
+		    has_extension(de->d_name, ".keep"))
+			string_list_append(&garbage, path);
+		else
+			report_garbage("garbage found", path);
 	}
 	closedir(dir);
+	report_pack_garbage(&garbage);
+	string_list_clear(&garbage, 0);
 }
=20
 static int sort_pack(const void *a_, const void *b_)
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index d645328..e4bb3a1 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -195,4 +195,30 @@ test_expect_success 'gc: prune old objects after l=
ocal clone' '
 	)
 '
=20
+test_expect_success 'garbage report in count-objects -v' '
+	: >.git/objects/pack/foo &&
+	: >.git/objects/pack/foo.bar &&
+	: >.git/objects/pack/foo.keep &&
+	: >.git/objects/pack/foo.pack &&
+	: >.git/objects/pack/fake.bar &&
+	: >.git/objects/pack/fake.keep &&
+	: >.git/objects/pack/fake.pack &&
+	: >.git/objects/pack/fake.idx &&
+	: >.git/objects/pack/fake2.keep &&
+	: >.git/objects/pack/fake3.idx &&
+	git count-objects -v 2>stderr &&
+	grep "index file .git/objects/pack/fake.idx is too small" stderr &&
+	grep "^warning:" stderr | sort >actual &&
+	cat >expected <<\EOF &&
+warning: garbage found: .git/objects/pack/fake.bar
+warning: garbage found: .git/objects/pack/foo
+warning: garbage found: .git/objects/pack/foo.bar
+warning: no corresponding .idx nor .pack: .git/objects/pack/fake2.keep
+warning: no corresponding .idx: .git/objects/pack/foo.keep
+warning: no corresponding .idx: .git/objects/pack/foo.pack
+warning: no corresponding .pack: .git/objects/pack/fake3.idx
+EOF
+	test_cmp expected actual
+'
+
 test_done
--=20
1.8.1.2.536.gf441e6d
