From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] Remove global pointer "packed_git" in favor or set/get function pair
Date: Tue, 10 Apr 2012 21:39:27 +0700
Message-ID: <1334068771-32725-2-git-send-email-pclouds@gmail.com>
References: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 16:42:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHcHR-00074e-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 16:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758924Ab2DJOmn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 10:42:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52722 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758824Ab2DJOmn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 10:42:43 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so45834pbc.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OKc8K0rzuJ2fTgOg6ifTSjgvyyf+BFh0QQsEav+M5k8=;
        b=dIObcmXKKXFtTJ0sHPaZVqcX0Ap3xt2M0si9Ss5VuC3URMtPTgiXYCCZF106WOTTyO
         IUIu7DC8C7OQUCVYNed7+3/U8Ewjz7kyibUIidTzMIjap/uqt6U/NVLwZbf+cmLkUl0q
         1at/r/waHTQcsMwM7YMa0blxzUGkFFmznJDGBf2sH3KGFr0NLOBfbi0XC4v0cE5jo2I+
         vH+dShIF+pWgflPX8QuAgPJh2P1PtA4QVUTfez7ryCc8B1b4JfJNMoKrCFmyUi4I3ytz
         T7wopRMalAK4SXmmPYO9KP8Wq9obJsGvBgwNed6FjqaAAapreDNrQn1FI+HaeR2jVP8C
         zrSw==
Received: by 10.68.194.67 with SMTP id hu3mr13161434pbc.111.1334068962728;
        Tue, 10 Apr 2012 07:42:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.33.136])
        by mx.google.com with ESMTPS id z7sm44737pbk.63.2012.04.10.07.42.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 07:42:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Apr 2012 21:39:42 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195086>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/count-objects.c  |    4 ++--
 builtin/fsck.c           |    4 ++--
 builtin/gc.c             |    2 +-
 builtin/pack-objects.c   |   10 +++++-----
 builtin/pack-redundant.c |    4 ++--
 cache.h                  |    7 +++++--
 pack-revindex.c          |    4 ++--
 server-info.c            |    4 ++--
 sha1_file.c              |   33 ++++++++++++++++++++++-----------
 sha1_name.c              |    2 +-
 10 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index c37cb98..dc217db 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -104,9 +104,9 @@ int cmd_count_objects(int argc, const char **argv, =
const char *prefix)
 		struct packed_git *p;
 		unsigned long num_pack =3D 0;
 		off_t size_pack =3D 0;
-		if (!packed_git)
+		if (!get_packed_git())
 			prepare_packed_git();
-		for (p =3D packed_git; p; p =3D p->next) {
+		for (p =3D get_packed_git(); p; p =3D p->next) {
 			if (!p->pack_local)
 				continue;
 			if (open_pack_index(p))
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 67eb553..9dbe6d8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -669,7 +669,7 @@ int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
 		prepare_packed_git();
=20
 		if (show_progress) {
-			for (p =3D packed_git; p; p =3D p->next) {
+			for (p =3D get_packed_git(); p; p =3D p->next) {
 				if (open_pack_index(p))
 					continue;
 				total +=3D p->num_objects;
@@ -677,7 +677,7 @@ int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
=20
 			progress =3D start_progress("Checking objects", total);
 		}
-		for (p =3D packed_git; p; p =3D p->next) {
+		for (p =3D get_packed_git(); p; p =3D p->next) {
 			/* verify gives error messages itself */
 			if (verify_pack(p, fsck_obj_buffer,
 					progress, count))
diff --git a/builtin/gc.c b/builtin/gc.c
index 271376d..3007650 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -130,7 +130,7 @@ static int too_many_packs(void)
 		return 0;
=20
 	prepare_packed_git();
-	for (cnt =3D 0, p =3D packed_git; p; p =3D p->next) {
+	for (cnt =3D 0, p =3D get_packed_git(); p; p =3D p->next) {
 		if (!p->pack_local)
 			continue;
 		if (p->pack_keep)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7b07c09..2f242c4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -840,7 +840,7 @@ static int add_object_entry(const unsigned char *sh=
a1, enum object_type type,
 	if (!exclude && local && has_loose_object_nonlocal(sha1))
 		return 0;
=20
-	for (p =3D packed_git; p; p =3D p->next) {
+	for (p =3D get_packed_git(); p; p =3D p->next) {
 		off_t offset =3D find_pack_entry_one(sha1, p);
 		if (offset) {
 			if (!found_pack) {
@@ -2183,7 +2183,7 @@ static void add_objects_in_unpacked_packs(struct =
rev_info *revs)
=20
 	memset(&in_pack, 0, sizeof(in_pack));
=20
-	for (p =3D packed_git; p; p =3D p->next) {
+	for (p =3D get_packed_git(); p; p =3D p->next) {
 		const unsigned char *sha1;
 		struct object *o;
=20
@@ -2221,7 +2221,7 @@ static int has_sha1_pack_kept_or_nonlocal(const u=
nsigned char *sha1)
 	static struct packed_git *last_found =3D (void *)1;
 	struct packed_git *p;
=20
-	p =3D (last_found !=3D (void *)1) ? last_found : packed_git;
+	p =3D (last_found !=3D (void *)1) ? last_found : get_packed_git();
=20
 	while (p) {
 		if ((!p->pack_local || p->pack_keep) &&
@@ -2230,7 +2230,7 @@ static int has_sha1_pack_kept_or_nonlocal(const u=
nsigned char *sha1)
 			return 1;
 		}
 		if (p =3D=3D last_found)
-			p =3D packed_git;
+			p =3D get_packed_git();
 		else
 			p =3D p->next;
 		if (p =3D=3D last_found)
@@ -2245,7 +2245,7 @@ static void loosen_unused_packed_objects(struct r=
ev_info *revs)
 	uint32_t i;
 	const unsigned char *sha1;
=20
-	for (p =3D packed_git; p; p =3D p->next) {
+	for (p =3D get_packed_git(); p; p =3D p->next) {
 		if (!p->pack_local || p->pack_keep)
 			continue;
=20
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index f5c6afc..8fece6a 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -569,7 +569,7 @@ static struct pack_list * add_pack(struct packed_gi=
t *p)
=20
 static struct pack_list * add_pack_file(const char *filename)
 {
-	struct packed_git *p =3D packed_git;
+	struct packed_git *p =3D get_packed_git();
=20
 	if (strlen(filename) < 40)
 		die("Bad pack filename: %s", filename);
@@ -584,7 +584,7 @@ static struct pack_list * add_pack_file(const char =
*filename)
=20
 static void load_all(void)
 {
-	struct packed_git *p =3D packed_git;
+	struct packed_git *p =3D get_packed_git();
=20
 	while (p) {
 		add_pack(p);
diff --git a/cache.h b/cache.h
index e5e1aa4..26d14b4 100644
--- a/cache.h
+++ b/cache.h
@@ -975,7 +975,7 @@ struct pack_window {
 	unsigned int inuse_cnt;
 };
=20
-extern struct packed_git {
+struct packed_git {
 	struct packed_git *next;
 	struct pack_window *windows;
 	off_t pack_size;
@@ -993,7 +993,10 @@ extern struct packed_git {
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
-} *packed_git;
+};
+
+extern struct packed_git *get_packed_git(void);
+extern void set_packed_git(struct packed_git *);
=20
 struct pack_entry {
 	off_t offset;
diff --git a/pack-revindex.c b/pack-revindex.c
index 77a0465..636d35d 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -45,13 +45,13 @@ static void init_pack_revindex(void)
 	int num;
 	struct packed_git *p;
=20
-	for (num =3D 0, p =3D packed_git; p; p =3D p->next)
+	for (num =3D 0, p =3D get_packed_git(); p; p =3D p->next)
 		num++;
 	if (!num)
 		return;
 	pack_revindex_hashsz =3D num * 11;
 	pack_revindex =3D xcalloc(sizeof(*pack_revindex), pack_revindex_hashs=
z);
-	for (p =3D packed_git; p; p =3D p->next) {
+	for (p =3D get_packed_git(); p; p =3D p->next) {
 		num =3D pack_revindex_ix(p);
 		num =3D - 1 - num;
 		pack_revindex[num].p =3D p;
diff --git a/server-info.c b/server-info.c
index 9ec744e..b7951ca 100644
--- a/server-info.c
+++ b/server-info.c
@@ -161,7 +161,7 @@ static void init_pack_info(const char *infofile, in=
t force)
 	objdirlen =3D strlen(objdir);
=20
 	prepare_packed_git();
-	for (p =3D packed_git; p; p =3D p->next) {
+	for (p =3D get_packed_git(); p; p =3D p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
@@ -171,7 +171,7 @@ static void init_pack_info(const char *infofile, in=
t force)
 	}
 	num_pack =3D i;
 	info =3D xcalloc(num_pack, sizeof(struct pack_info *));
-	for (i =3D 0, p =3D packed_git; p; p =3D p->next) {
+	for (i =3D 0, p =3D get_packed_git(); p; p =3D p->next) {
 		if (!p->pack_local)
 			continue;
 		info[i] =3D xcalloc(1, sizeof(struct pack_info));
diff --git a/sha1_file.c b/sha1_file.c
index 4f06a0e..4fd4e2c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -33,6 +33,17 @@ static inline uintmax_t sz_fmt(size_t s) { return s;=
 }
=20
 const unsigned char null_sha1[20];
=20
+static struct packed_git *packed_git_;
+struct packed_git *get_packed_git(void)
+{
+	return packed_git_;
+}
+void set_packed_git(struct packed_git *p)
+{
+	packed_git_ =3D p;
+}
+
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
@@ -618,7 +629,7 @@ static int unuse_one_window(struct packed_git *curr=
ent, int keep_fd)
=20
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p =3D packed_git; p; p =3D p->next)
+	for (p =3D get_packed_git(); p; p =3D p->next)
 		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -708,7 +719,7 @@ void close_pack_index(struct packed_git *p)
  */
 void free_pack_by_name(const char *pack_name)
 {
-	struct packed_git *p, **pp =3D &packed_git;
+	struct packed_git *p, **pp =3D &packed_git_;
=20
 	while (*pp) {
 		p =3D *pp;
@@ -990,8 +1001,8 @@ void install_packed_git(struct packed_git *pack)
 	if (pack->pack_fd !=3D -1)
 		pack_open_fds++;
=20
-	pack->next =3D packed_git;
-	packed_git =3D pack;
+	pack->next =3D get_packed_git();
+	set_packed_git(pack);
 }
=20
 static void prepare_packed_git_one(char *objdir, int local)
@@ -1026,7 +1037,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
=20
 		/* Don't reopen a pack we already have. */
 		strcpy(path + len, de->d_name);
-		for (p =3D packed_git; p; p =3D p->next) {
+		for (p =3D get_packed_git(); p; p =3D p->next) {
 			if (!memcmp(path, p->pack_name, len + namelen - 4))
 				break;
 		}
@@ -1076,14 +1087,14 @@ static void rearrange_packed_git(void)
 	struct packed_git **ary, *p;
 	int i, n;
=20
-	for (n =3D 0, p =3D packed_git; p; p =3D p->next)
+	for (n =3D 0, p =3D get_packed_git(); p; p =3D p->next)
 		n++;
 	if (n < 2)
 		return;
=20
 	/* prepare an array of packed_git for easier sorting */
 	ary =3D xcalloc(n, sizeof(struct packed_git *));
-	for (n =3D 0, p =3D packed_git; p; p =3D p->next)
+	for (n =3D 0, p =3D get_packed_git(); p; p =3D p->next)
 		ary[n++] =3D p;
=20
 	qsort(ary, n, sizeof(struct packed_git *), sort_pack);
@@ -1092,7 +1103,7 @@ static void rearrange_packed_git(void)
 	for (i =3D 0; i < n - 1; i++)
 		ary[i]->next =3D ary[i + 1];
 	ary[n - 1]->next =3D NULL;
-	packed_git =3D ary[0];
+	set_packed_git(ary[0]);
=20
 	free(ary);
 }
@@ -1139,7 +1150,7 @@ static const struct packed_git *has_packed_and_ba=
d(const unsigned char *sha1)
 	struct packed_git *p;
 	unsigned i;
=20
-	for (p =3D packed_git; p; p =3D p->next)
+	for (p =3D get_packed_git(); p; p =3D p->next)
 		for (i =3D 0; i < p->num_bad_objects; i++)
 			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
 				return p;
@@ -2058,13 +2069,13 @@ static int find_pack_entry(const unsigned char =
*sha1, struct pack_entry *e)
 	struct packed_git *p;
=20
 	prepare_packed_git();
-	if (!packed_git)
+	if (!get_packed_git())
 		return 0;
=20
 	if (last_found_pack && fill_pack_entry(sha1, e, last_found_pack))
 		return 1;
=20
-	for (p =3D packed_git; p; p =3D p->next) {
+	for (p =3D get_packed_git(); p; p =3D p->next) {
 		if (p =3D=3D last_found_pack || !fill_pack_entry(sha1, e, p))
 			continue;
=20
diff --git a/sha1_name.c b/sha1_name.c
index 03ffc2c..756b226 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -78,7 +78,7 @@ static int find_short_packed_object(int len, const un=
signed char *match, unsigne
 	int found =3D 0;
=20
 	prepare_packed_git();
-	for (p =3D packed_git; p && found < 2; p =3D p->next) {
+	for (p =3D get_packed_git(); p && found < 2; p =3D p->next) {
 		uint32_t num, last;
 		uint32_t first =3D 0;
 		open_pack_index(p);
--=20
1.7.8.36.g69ee2
