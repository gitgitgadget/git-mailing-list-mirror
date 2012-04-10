From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] sha1_file: stuff various pack reading variables into a struct
Date: Tue, 10 Apr 2012 21:39:28 +0700
Message-ID: <1334068771-32725-3-git-send-email-pclouds@gmail.com>
References: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 16:43:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHcHb-0007BL-0a
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 16:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758914Ab2DJOmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 10:42:53 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:40136 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab2DJOmw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 10:42:52 -0400
Received: by dake40 with SMTP id e40so6734273dak.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=a+S5O8S4a+ipU356ENDeuAd8fE8YZWPL657QHusTG9s=;
        b=0ptWJ4OtlMyPW/aWKbcUqDj3rj1hF1ojBIGr9n8lWGX3klCaCP2P8agNUowx8B5yBt
         bCkH3jaFC4JBRjWCRj/n84NqoqHsQSly6m2Wih1TPlgom9e1qEvyCz8sibWinIiJ4KWw
         1NuDs2HUGrinK0ZdBXNqblVTxQsJv2EyDzE6B7CUU30UCcdajcv0BW0FUwN5xnlB0S1D
         6/LlU5sFnq6PJIxTnZVeWT4aYvPypFYbHicQHv/dSrcyOpBLsIAUADWpZoF+a0FBq+yM
         /XYyxFMDFiL5bew8C3fOyoliXeKWSKga78DKuasaIHttecZoRnQUk+4xvxbfW8Q0YBeF
         HmVw==
Received: by 10.68.234.167 with SMTP id uf7mr28907333pbc.138.1334068971932;
        Tue, 10 Apr 2012 07:42:51 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.33.136])
        by mx.google.com with ESMTPS id n8sm58862pba.20.2012.04.10.07.42.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 07:42:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Apr 2012 21:39:51 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195087>

This requires any threads (including the main one) to call
init_pack_context() first. All pack data is per thread.

Original patch is written by Thomas Rast <trast@student.ethz.ch>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |    1 +
 git.c       |    1 +
 sha1_file.c |  251 +++++++++++++++++++++++++++++++++++----------------=
--------
 3 files changed, 152 insertions(+), 101 deletions(-)

diff --git a/cache.h b/cache.h
index 26d14b4..868ef48 100644
--- a/cache.h
+++ b/cache.h
@@ -997,6 +997,7 @@ struct packed_git {
=20
 extern struct packed_git *get_packed_git(void);
 extern void set_packed_git(struct packed_git *);
+extern void init_pack_context(void);
=20
 struct pack_entry {
 	off_t offset;
diff --git a/git.c b/git.c
index 3805616..7eee270 100644
--- a/git.c
+++ b/git.c
@@ -533,6 +533,7 @@ int main(int argc, const char **argv)
 	const char *cmd;
=20
 	startup_info =3D &git_startup_info;
+	init_pack_context();
=20
 	cmd =3D git_extract_argv0_path(argv[0]);
 	if (!cmd)
diff --git a/sha1_file.c b/sha1_file.c
index 4fd4e2c..170c0b1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -33,16 +33,79 @@ static inline uintmax_t sz_fmt(size_t s) { return s=
; }
=20
 const unsigned char null_sha1[20];
=20
-static struct packed_git *packed_git_;
+#define MAX_DELTA_CACHE (256)
+
+struct delta_base_cache_lru_list {
+	struct delta_base_cache_lru_list *prev;
+	struct delta_base_cache_lru_list *next;
+};
+
+struct delta_base_cache_entry {
+	struct delta_base_cache_lru_list lru;
+	void *data;
+	struct packed_git *p;
+	off_t base_offset;
+	unsigned long size;
+	enum object_type type;
+};
+
+struct pack_context {
+	size_t delta_base_cached;
+	struct delta_base_cache_entry *delta_base_cache;
+	struct delta_base_cache_lru_list *delta_base_cache_lru;
+	struct packed_git *last_found_pack;
+
+	unsigned int pack_used_ctr;
+	unsigned int pack_mmap_calls;
+	unsigned int peak_pack_open_windows;
+	unsigned int pack_open_windows;
+	unsigned int pack_open_fds;
+	unsigned int pack_max_fds;
+	size_t peak_pack_mapped;
+	size_t pack_mapped;
+	struct packed_git *packed_git;
+	int prepare_packed_git_run_once;
+
+	char sha1_file_name_buf[PATH_MAX];
+	char *sha1_pack_name, *sha1_pack_base;
+	char *sha1_pack_index_name, *sha1_pack_index_base;
+};
+
+static pthread_key_t pack_key;
+struct pack_context *get_thread_pack_context(void)
+{
+	return pthread_getspecific(pack_key);
+}
+
 struct packed_git *get_packed_git(void)
 {
-	return packed_git_;
+	return get_thread_pack_context()->packed_git;
 }
 void set_packed_git(struct packed_git *p)
 {
-	packed_git_ =3D p;
+	get_thread_pack_context()->packed_git =3D p;
 }
=20
+void init_pack_context(void)
+{
+	static int initialized =3D 0;
+	struct pack_context *ctx =3D xmalloc(sizeof(struct pack_context));
+
+	if (!initialized) {
+		pthread_key_create(&pack_key, NULL);
+		initialized =3D 1;
+	}
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->delta_base_cached =3D 0;
+	ctx->delta_base_cache_lru =3D xmalloc(sizeof(struct delta_base_cache_=
lru_list));
+	ctx->delta_base_cache_lru->prev =3D ctx->delta_base_cache_lru;
+	ctx->delta_base_cache_lru->next =3D ctx->delta_base_cache_lru;
+	ctx->delta_base_cache =3D xcalloc(MAX_DELTA_CACHE, sizeof(struct delt=
a_base_cache_entry));
+	ctx->last_found_pack =3D NULL;
+	ctx->packed_git =3D NULL;
+	pthread_setspecific(pack_key, ctx);
+}
=20
 /*
  * This is meant to hold a *small* number of objects that you would
@@ -65,8 +128,6 @@ static struct cached_object empty_tree =3D {
 	0
 };
=20
-static struct packed_git *last_found_pack;
-
 static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
 {
 	int i;
@@ -177,7 +238,7 @@ static void fill_sha1_path(char *pathbuf, const uns=
igned char *sha1)
  */
 char *sha1_file_name(const unsigned char *sha1)
 {
-	static char buf[PATH_MAX];
+	char *buf =3D get_thread_pack_context()->sha1_file_name_buf;
 	const char *objdir;
 	int len;
=20
@@ -224,16 +285,14 @@ static char *sha1_get_pack_name(const unsigned ch=
ar *sha1,
=20
 char *sha1_pack_name(const unsigned char *sha1)
 {
-	static char *name, *base;
-
-	return sha1_get_pack_name(sha1, &name, &base, "pack");
+	struct pack_context *ctx =3D get_thread_pack_context();
+	return sha1_get_pack_name(sha1, &ctx->sha1_pack_name, &ctx->sha1_pack=
_base, "pack");
 }
=20
 char *sha1_pack_index_name(const unsigned char *sha1)
 {
-	static char *name, *base;
-
-	return sha1_get_pack_name(sha1, &name, &base, "idx");
+	struct pack_context *ctx =3D get_thread_pack_context();
+	return sha1_get_pack_name(sha1, &ctx->sha1_pack_index_name, &ctx->sha=
1_pack_index_base, "idx");
 }
=20
 struct alternate_object_database *alt_odb_list;
@@ -455,18 +514,10 @@ static int has_loose_object(const unsigned char *=
sha1)
 	       has_loose_object_nonlocal(sha1);
 }
=20
-static unsigned int pack_used_ctr;
-static unsigned int pack_mmap_calls;
-static unsigned int peak_pack_open_windows;
-static unsigned int pack_open_windows;
-static unsigned int pack_open_fds;
-static unsigned int pack_max_fds;
-static size_t peak_pack_mapped;
-static size_t pack_mapped;
-struct packed_git *packed_git;
-
-void pack_report(void)
+void pack_report()
 {
+	struct pack_context *ctx =3D get_thread_pack_context();
+
 	fprintf(stderr,
 		"pack_report: getpagesize()            =3D %10" SZ_FMT "\n"
 		"pack_report: core.packedGitWindowSize =3D %10" SZ_FMT "\n"
@@ -480,10 +531,10 @@ void pack_report(void)
 		"pack_report: pack_open_windows        =3D %10u / %10u\n"
 		"pack_report: pack_mapped              =3D "
 			"%10" SZ_FMT " / %10" SZ_FMT "\n",
-		pack_used_ctr,
-		pack_mmap_calls,
-		pack_open_windows, peak_pack_open_windows,
-		sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped));
+		ctx->pack_used_ctr,
+		ctx->pack_mmap_calls,
+		ctx->pack_open_windows, ctx->peak_pack_open_windows,
+		sz_fmt(ctx->pack_mapped), sz_fmt(ctx->peak_pack_mapped));
 }
=20
 static int check_packed_git_idx(const char *path,  struct packed_git *=
p)
@@ -624,6 +675,7 @@ static void scan_windows(struct packed_git *p,
=20
 static int unuse_one_window(struct packed_git *current, int keep_fd)
 {
+	struct pack_context *ctx =3D get_thread_pack_context();
 	struct packed_git *p, *lru_p =3D NULL;
 	struct pack_window *lru_w =3D NULL, *lru_l =3D NULL;
=20
@@ -633,7 +685,7 @@ static int unuse_one_window(struct packed_git *curr=
ent, int keep_fd)
 		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
-		pack_mapped -=3D lru_w->len;
+		ctx->pack_mapped -=3D lru_w->len;
 		if (lru_l)
 			lru_l->next =3D lru_w->next;
 		else {
@@ -641,12 +693,12 @@ static int unuse_one_window(struct packed_git *cu=
rrent, int keep_fd)
 			if (!lru_p->windows && lru_p->pack_fd !=3D -1
 				&& lru_p->pack_fd !=3D keep_fd) {
 				close(lru_p->pack_fd);
-				pack_open_fds--;
+				ctx->pack_open_fds--;
 				lru_p->pack_fd =3D -1;
 			}
 		}
 		free(lru_w);
-		pack_open_windows--;
+		ctx->pack_open_windows--;
 		return 1;
 	}
 	return 0;
@@ -654,8 +706,9 @@ static int unuse_one_window(struct packed_git *curr=
ent, int keep_fd)
=20
 void release_pack_memory(size_t need, int fd)
 {
-	size_t cur =3D pack_mapped;
-	while (need >=3D (cur - pack_mapped) && unuse_one_window(NULL, fd))
+	struct pack_context *ctx =3D get_thread_pack_context();
+	size_t cur =3D ctx->pack_mapped;
+	while (need >=3D (cur - ctx->pack_mapped) && unuse_one_window(NULL, f=
d))
 		; /* nothing */
 }
=20
@@ -676,6 +729,7 @@ void *xmmap(void *start, size_t length,
=20
 void close_pack_windows(struct packed_git *p)
 {
+	struct pack_context *ctx =3D get_thread_pack_context();
 	while (p->windows) {
 		struct pack_window *w =3D p->windows;
=20
@@ -683,8 +737,8 @@ void close_pack_windows(struct packed_git *p)
 			die("pack '%s' still has open windows to it",
 			    p->pack_name);
 		munmap(w->base, w->len);
-		pack_mapped -=3D w->len;
-		pack_open_windows--;
+		ctx->pack_mapped -=3D w->len;
+		ctx->pack_open_windows--;
 		p->windows =3D w->next;
 		free(w);
 	}
@@ -719,7 +773,8 @@ void close_pack_index(struct packed_git *p)
  */
 void free_pack_by_name(const char *pack_name)
 {
-	struct packed_git *p, **pp =3D &packed_git_;
+	struct pack_context *ctx =3D get_thread_pack_context();
+	struct packed_git *p, **pp =3D &ctx->packed_git;
=20
 	while (*pp) {
 		p =3D *pp;
@@ -728,13 +783,13 @@ void free_pack_by_name(const char *pack_name)
 			close_pack_windows(p);
 			if (p->pack_fd !=3D -1) {
 				close(p->pack_fd);
-				pack_open_fds--;
+				ctx->pack_open_fds--;
 			}
 			close_pack_index(p);
 			free(p->bad_object_sha1);
 			*pp =3D p->next;
-			if (last_found_pack =3D=3D p)
-				last_found_pack =3D NULL;
+			if (ctx->last_found_pack =3D=3D p)
+				ctx->last_found_pack =3D NULL;
 			free(p);
 			return;
 		}
@@ -748,6 +803,7 @@ void free_pack_by_name(const char *pack_name)
  */
 static int open_packed_git_1(struct packed_git *p)
 {
+	struct pack_context *ctx =3D get_thread_pack_context();
 	struct stat st;
 	struct pack_header hdr;
 	unsigned char sha1[20];
@@ -757,7 +813,7 @@ static int open_packed_git_1(struct packed_git *p)
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
=20
-	if (!pack_max_fds) {
+	if (!ctx->pack_max_fds) {
 		struct rlimit lim;
 		unsigned int max_fds;
=20
@@ -768,18 +824,18 @@ static int open_packed_git_1(struct packed_git *p=
)
=20
 		/* Save 3 for stdin/stdout/stderr, 22 for work */
 		if (25 < max_fds)
-			pack_max_fds =3D max_fds - 25;
+			ctx->pack_max_fds =3D max_fds - 25;
 		else
-			pack_max_fds =3D 1;
+			ctx->pack_max_fds =3D 1;
 	}
=20
-	while (pack_max_fds <=3D pack_open_fds && unuse_one_window(NULL, -1))
+	while (ctx->pack_max_fds <=3D ctx->pack_open_fds && unuse_one_window(=
NULL, -1))
 		; /* nothing */
=20
 	p->pack_fd =3D git_open_noatime(p->pack_name);
 	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
 		return -1;
-	pack_open_fds++;
+	ctx->pack_open_fds++;
=20
 	/* If we created the struct before we had the pack we lack size. */
 	if (!p->pack_size) {
@@ -827,11 +883,12 @@ static int open_packed_git_1(struct packed_git *p=
)
=20
 static int open_packed_git(struct packed_git *p)
 {
+	struct pack_context *ctx =3D get_thread_pack_context();
 	if (!open_packed_git_1(p))
 		return 0;
 	if (p->pack_fd !=3D -1) {
 		close(p->pack_fd);
-		pack_open_fds--;
+		ctx->pack_open_fds--;
 		p->pack_fd =3D -1;
 	}
 	return -1;
@@ -855,6 +912,7 @@ unsigned char *use_pack(struct packed_git *p,
 		off_t offset,
 		unsigned long *left)
 {
+	struct pack_context *ctx =3D get_thread_pack_context();
 	struct pack_window *win =3D *w_cursor;
=20
 	/* Since packfiles end in a hash of their content and it's
@@ -887,8 +945,8 @@ unsigned char *use_pack(struct packed_git *p,
 			if (len > packed_git_window_size)
 				len =3D packed_git_window_size;
 			win->len =3D (size_t)len;
-			pack_mapped +=3D win->len;
-			while (packed_git_limit < pack_mapped
+			ctx->pack_mapped +=3D win->len;
+			while (packed_git_limit < ctx->pack_mapped
 				&& unuse_one_window(p, p->pack_fd))
 				; /* nothing */
 			win->base =3D xmmap(NULL, win->len,
@@ -901,21 +959,21 @@ unsigned char *use_pack(struct packed_git *p,
 			if (!win->offset && win->len =3D=3D p->pack_size
 				&& !p->do_not_close) {
 				close(p->pack_fd);
-				pack_open_fds--;
+				ctx->pack_open_fds--;
 				p->pack_fd =3D -1;
 			}
-			pack_mmap_calls++;
-			pack_open_windows++;
-			if (pack_mapped > peak_pack_mapped)
-				peak_pack_mapped =3D pack_mapped;
-			if (pack_open_windows > peak_pack_open_windows)
-				peak_pack_open_windows =3D pack_open_windows;
+			ctx->pack_mmap_calls++;
+			ctx->pack_open_windows++;
+			if (ctx->pack_mapped > ctx->peak_pack_mapped)
+				ctx->peak_pack_mapped =3D ctx->pack_mapped;
+			if (ctx->pack_open_windows > ctx->peak_pack_open_windows)
+				ctx->peak_pack_open_windows =3D ctx->pack_open_windows;
 			win->next =3D p->windows;
 			p->windows =3D win;
 		}
 	}
 	if (win !=3D *w_cursor) {
-		win->last_used =3D pack_used_ctr++;
+		win->last_used =3D ctx->pack_used_ctr++;
 		win->inuse_cnt++;
 		*w_cursor =3D win;
 	}
@@ -998,8 +1056,9 @@ struct packed_git *parse_pack_index(unsigned char =
*sha1, const char *idx_path)
=20
 void install_packed_git(struct packed_git *pack)
 {
+	struct pack_context *ctx =3D get_thread_pack_context();
 	if (pack->pack_fd !=3D -1)
-		pack_open_fds++;
+		ctx->pack_open_fds++;
=20
 	pack->next =3D get_packed_git();
 	set_packed_git(pack);
@@ -1108,12 +1167,12 @@ static void rearrange_packed_git(void)
 	free(ary);
 }
=20
-static int prepare_packed_git_run_once =3D 0;
 void prepare_packed_git(void)
 {
 	struct alternate_object_database *alt;
+	struct pack_context *ctx =3D get_thread_pack_context();
=20
-	if (prepare_packed_git_run_once)
+	if (ctx->prepare_packed_git_run_once)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
@@ -1123,13 +1182,14 @@ void prepare_packed_git(void)
 		alt->name[-1] =3D '/';
 	}
 	rearrange_packed_git();
-	prepare_packed_git_run_once =3D 1;
+	ctx->prepare_packed_git_run_once =3D 1;
 }
=20
 void reprepare_packed_git(void)
 {
+	struct pack_context *ctx =3D get_thread_pack_context();
 	discard_revindex();
-	prepare_packed_git_run_once =3D 0;
+	ctx->prepare_packed_git_run_once =3D 0;
 	prepare_packed_git();
 }
=20
@@ -1664,24 +1724,6 @@ static void *unpack_compressed_entry(struct pack=
ed_git *p,
 	return buffer;
 }
=20
-#define MAX_DELTA_CACHE (256)
-
-static size_t delta_base_cached;
-
-static struct delta_base_cache_lru_list {
-	struct delta_base_cache_lru_list *prev;
-	struct delta_base_cache_lru_list *next;
-} delta_base_cache_lru =3D { &delta_base_cache_lru, &delta_base_cache_=
lru };
-
-static struct delta_base_cache_entry {
-	struct delta_base_cache_lru_list lru;
-	void *data;
-	struct packed_git *p;
-	off_t base_offset;
-	unsigned long size;
-	enum object_type type;
-} delta_base_cache[MAX_DELTA_CACHE];
-
 static unsigned long pack_entry_hash(struct packed_git *p, off_t base_=
offset)
 {
 	unsigned long hash;
@@ -1694,7 +1736,8 @@ static unsigned long pack_entry_hash(struct packe=
d_git *p, off_t base_offset)
 static int in_delta_base_cache(struct packed_git *p, off_t base_offset=
)
 {
 	unsigned long hash =3D pack_entry_hash(p, base_offset);
-	struct delta_base_cache_entry *ent =3D delta_base_cache + hash;
+	struct delta_base_cache_entry *ent
+		=3D get_thread_pack_context()->delta_base_cache + hash;
 	return (ent->data && ent->p =3D=3D p && ent->base_offset =3D=3D base_=
offset);
 }
=20
@@ -1703,7 +1746,8 @@ static void *cache_or_unpack_entry(struct packed_=
git *p, off_t base_offset,
 {
 	void *ret;
 	unsigned long hash =3D pack_entry_hash(p, base_offset);
-	struct delta_base_cache_entry *ent =3D delta_base_cache + hash;
+	struct pack_context *ctx =3D get_thread_pack_context();
+	struct delta_base_cache_entry *ent =3D ctx->delta_base_cache + hash;
=20
 	ret =3D ent->data;
 	if (!ret || ent->p !=3D p || ent->base_offset !=3D base_offset)
@@ -1713,7 +1757,7 @@ static void *cache_or_unpack_entry(struct packed_=
git *p, off_t base_offset,
 		ent->data =3D NULL;
 		ent->lru.next->prev =3D ent->lru.prev;
 		ent->lru.prev->next =3D ent->lru.next;
-		delta_base_cached -=3D ent->size;
+		ctx->delta_base_cached -=3D ent->size;
 	} else {
 		ret =3D xmemdupz(ent->data, ent->size);
 	}
@@ -1722,48 +1766,52 @@ static void *cache_or_unpack_entry(struct packe=
d_git *p, off_t base_offset,
 	return ret;
 }
=20
-static inline void release_delta_base_cache(struct delta_base_cache_en=
try *ent)
+static inline void release_delta_base_cache(struct pack_context *ctx,
+					    struct delta_base_cache_entry *ent)
 {
 	if (ent->data) {
 		free(ent->data);
 		ent->data =3D NULL;
 		ent->lru.next->prev =3D ent->lru.prev;
 		ent->lru.prev->next =3D ent->lru.next;
-		delta_base_cached -=3D ent->size;
+		ctx->delta_base_cached -=3D ent->size;
 	}
 }
=20
 void clear_delta_base_cache(void)
 {
 	unsigned long p;
+	struct pack_context *ctx =3D get_thread_pack_context();
+	struct delta_base_cache_entry *delta_base_cache =3D ctx->delta_base_c=
ache;
 	for (p =3D 0; p < MAX_DELTA_CACHE; p++)
-		release_delta_base_cache(&delta_base_cache[p]);
+		release_delta_base_cache(ctx, &delta_base_cache[p]);
 }
=20
 static void add_delta_base_cache(struct packed_git *p, off_t base_offs=
et,
 	void *base, unsigned long base_size, enum object_type type)
 {
 	unsigned long hash =3D pack_entry_hash(p, base_offset);
-	struct delta_base_cache_entry *ent =3D delta_base_cache + hash;
+	struct pack_context *ctx =3D get_thread_pack_context();
+	struct delta_base_cache_entry *ent =3D ctx->delta_base_cache + hash;
 	struct delta_base_cache_lru_list *lru;
=20
-	release_delta_base_cache(ent);
-	delta_base_cached +=3D base_size;
+	release_delta_base_cache(ctx, ent);
+	ctx->delta_base_cached +=3D base_size;
=20
-	for (lru =3D delta_base_cache_lru.next;
-	     delta_base_cached > delta_base_cache_limit
-	     && lru !=3D &delta_base_cache_lru;
+	for (lru =3D ctx->delta_base_cache_lru->next;
+	     ctx->delta_base_cached > delta_base_cache_limit
+	     && lru !=3D ctx->delta_base_cache_lru;
 	     lru =3D lru->next) {
 		struct delta_base_cache_entry *f =3D (void *)lru;
 		if (f->type =3D=3D OBJ_BLOB)
-			release_delta_base_cache(f);
+			release_delta_base_cache(ctx, f);
 	}
-	for (lru =3D delta_base_cache_lru.next;
-	     delta_base_cached > delta_base_cache_limit
-	     && lru !=3D &delta_base_cache_lru;
+	for (lru =3D ctx->delta_base_cache_lru->next;
+	     ctx->delta_base_cached > delta_base_cache_limit
+	     && lru !=3D ctx->delta_base_cache_lru;
 	     lru =3D lru->next) {
 		struct delta_base_cache_entry *f =3D (void *)lru;
-		release_delta_base_cache(f);
+		release_delta_base_cache(ctx, f);
 	}
=20
 	ent->p =3D p;
@@ -1771,10 +1819,10 @@ static void add_delta_base_cache(struct packed_=
git *p, off_t base_offset,
 	ent->type =3D type;
 	ent->data =3D base;
 	ent->size =3D base_size;
-	ent->lru.next =3D &delta_base_cache_lru;
-	ent->lru.prev =3D delta_base_cache_lru.prev;
-	delta_base_cache_lru.prev->next =3D &ent->lru;
-	delta_base_cache_lru.prev =3D &ent->lru;
+	ent->lru.next =3D ctx->delta_base_cache_lru;
+	ent->lru.prev =3D ctx->delta_base_cache_lru->prev;
+	ctx->delta_base_cache_lru->prev->next =3D &ent->lru;
+	ctx->delta_base_cache_lru->prev =3D &ent->lru;
 }
=20
 static void *read_object(const unsigned char *sha1, enum object_type *=
type,
@@ -2066,20 +2114,21 @@ static int fill_pack_entry(const unsigned char =
*sha1,
=20
 static int find_pack_entry(const unsigned char *sha1, struct pack_entr=
y *e)
 {
+	struct pack_context *ctx =3D get_thread_pack_context();
 	struct packed_git *p;
=20
 	prepare_packed_git();
 	if (!get_packed_git())
 		return 0;
=20
-	if (last_found_pack && fill_pack_entry(sha1, e, last_found_pack))
+	if (ctx->last_found_pack && fill_pack_entry(sha1, e, ctx->last_found_=
pack))
 		return 1;
=20
 	for (p =3D get_packed_git(); p; p =3D p->next) {
-		if (p =3D=3D last_found_pack || !fill_pack_entry(sha1, e, p))
+		if (p =3D=3D ctx->last_found_pack || !fill_pack_entry(sha1, e, p))
 			continue;
=20
-		last_found_pack =3D p;
+		ctx->last_found_pack =3D p;
 		return 1;
 	}
 	return 0;
--=20
1.7.8.36.g69ee2
