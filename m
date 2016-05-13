From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 ter] index-helper: use watchman to avoid refreshing index with lstat()
Date: Fri, 13 May 2016 17:16:22 -0400
Message-ID: <1463174182-20200-1-git-send-email-dturner@twopensource.com>
References: <5736366D.6080706@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, ramsay@ramsayjones.plus.com
X-From: git-owner@vger.kernel.org Fri May 13 23:16:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1KS3-000542-4a
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 23:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbcEMVQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 17:16:36 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34895 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbcEMVQf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 17:16:35 -0400
Received: by mail-io0-f174.google.com with SMTP id d62so148283067iof.2
        for <git@vger.kernel.org>; Fri, 13 May 2016 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0rZqw2Q4U3/lYrikqi5BsBMO5GELF2T/0v72EW58xmk=;
        b=t9d586wAM84c4KhYW0j8jnjyPXRMOKipv7dxWYQx3VqtJ3RtYtHBgeo1ksDp0faBnP
         tdakucsbNXMot5gNGv/BYcPIA7/KxbqK/pUUMza56Hwl2WSwFB5CZdctE3H2XkEUPBv3
         PL1SyJ3d/C7KN5pbXNdXt3BmS2V2DvM7Io9fHOtaVVWISYqivngklHmn73Fz88wQ65bJ
         EvZ54BSQGVhsYah1Uv7SOc5gLmp4G0Vc7w4pWtRyHwlLqeZtYyJTIcYKH82MFb/Irboc
         dGeta5wq1t7QW5pjcPSM8Q+yYxMniNVnmxCoPSvTgUcPGuOEOjECIGPcy+3N3B4tW3So
         CGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rZqw2Q4U3/lYrikqi5BsBMO5GELF2T/0v72EW58xmk=;
        b=LwYU46EPnSCuzVBI6/UxMnqa93B6Dk1kAq1QcL8ooMBtslb3Uln+48Zjj+c/Z+XCqM
         4OLELHUvaK7EM9yzLrzYqrre/dOBcZ1CMZ+6gNhbfUkkH05p8mT6zde3X7pQV9mWb+kW
         /qYS2lJCR/6gqer4hqd2XpynanLk/fOMJAFFR+316TIMGtkK/zI82uU9r/+7l+Omm5gh
         kFZK7a1j63F3BLOlZ6QYlIqDT7MFyGiakqMZquLnP/YwElf7KCmzhQNCrmJioTDGyarP
         dU7FPlYN3icpQJBK9TQRbX3fiw3o/uIkKFwx56pXy0yTlNr7+Cee8LL3kFO0Oal0wpk8
         huKw==
X-Gm-Message-State: AOPr4FXLJX3om8LWTzL37/Nf7PmyovInkCn/L8Rjss2UE/8dPXSxQJ+41zHLWnofBqlHpQ==
X-Received: by 10.107.41.210 with SMTP id p201mr14533828iop.106.1463174194247;
        Fri, 13 May 2016 14:16:34 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id x128sm6620667iod.37.2016.05.13.14.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 May 2016 14:16:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <5736366D.6080706@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294585>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Watchman is hidden behind index-helper. Before git tries to read the
index from shm, it notifies index-helper through the socket and waits
for index-helper to prepare a file for sharing memory (with
MAP_SHARED). index-helper then contacts watchman, updates 'WAMA'
extension and put it in a separate file and wakes git up with a reply
to git's socket.

Git uses this extension to not lstat unchanged entries. Git only
trusts the 'WAMA' extension when it's received from the separate file,
not from disk. Unmarked entries are "clean". Marked entries are dirty
from watchman point of view. If it finds out some entries are
'watchman-dirty', but are really unchanged (e.g. the file was changed,
then reverted back), then Git will clear the marking in 'WAMA' before
writing it down.

Hiding watchman behind index-helper means you need both daemons. You
can't run watchman alone. Not so good. But on the other hand, 'git'
binary is not linked to watchman/json libraries, which is good for
packaging. Core git package will run fine without watchman-related
packages. If they need watchman, they can install git-index-helper and
dependencies.

This also lets us trust anything in the untracked cache that we haven't
marked invalid, saving those stat() calls.

Another reason for tying watchman to index-helper is, when used with
untracked cache, we need to keep track of $GIT_WORK_TREE file
listing. That kind of list can be kept in index-helper.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---

Right, let's try this one instead.

The actual segfault that Ramsay points out will not happen in ordinary
usage (since we control both client and server), but it's better to be
clean.

---
 Documentation/git-index-helper.txt |   6 +
 cache.h                            |   2 +
 dir.c                              |  23 +++-
 dir.h                              |   3 +
 index-helper.c                     | 107 ++++++++++++++--
 read-cache.c                       | 241 +++++++++++++++++++++++++++++=
+++++---
 6 files changed, 355 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index e144752..cce00cb 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -55,6 +55,12 @@ command. The following commands are used to control =
the daemon:
 	Let the daemon know the index is to be read. It keeps the
 	daemon alive longer, unless `--exit-after=3D0` is used.
=20
+"poke <path>":
+	Like "poke", but replies with "OK".  If the index has the
+	watchman extension, index-helper queries watchman, then
+	prepares a shared memory object with the watchman index
+	extension before replying.
+
 All commands and replies are terminated by a NUL byte.
=20
 In the event of an error, messages may be written to
diff --git a/cache.h b/cache.h
index 452aea2..633e1dd 100644
--- a/cache.h
+++ b/cache.h
@@ -567,6 +567,7 @@ extern int daemonize(int *);
=20
 /* Initialize and use the cache information */
 struct lock_file;
+extern int verify_index(const struct index_state *);
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const struct paths=
pec *pathspec);
 extern int do_read_index(struct index_state *istate, const char *path,
@@ -574,6 +575,7 @@ extern int do_read_index(struct index_state *istate=
, const char *path,
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
+extern void write_watchman_ext(struct strbuf *sb, struct index_state *=
istate);
 #define COMMIT_LOCK		(1 << 0)
 #define CLOSE_LOCK		(1 << 1)
 extern int write_locked_index(struct index_state *, struct lock_file *=
lock, unsigned flags);
diff --git a/dir.c b/dir.c
index 69e0be6..5058b29 100644
--- a/dir.c
+++ b/dir.c
@@ -597,9 +597,9 @@ static void trim_trailing_spaces(char *buf)
  *
  * If "name" has the trailing slash, it'll be excluded in the search.
  */
-static struct untracked_cache_dir *lookup_untracked(struct untracked_c=
ache *uc,
-						    struct untracked_cache_dir *dir,
-						    const char *name, int len)
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *u=
c,
+					     struct untracked_cache_dir *dir,
+					     const char *name, int len)
 {
 	int first, last;
 	struct untracked_cache_dir *d;
@@ -1726,6 +1726,17 @@ static int valid_cached_dir(struct dir_struct *d=
ir,
 	if (!untracked)
 		return 0;
=20
+	if (dir->untracked->use_watchman) {
+		/*
+		 * With watchman, we can trust the untracked cache's
+		 * valid field.
+		 */
+		if (untracked->valid)
+			goto skip_stat;
+		else
+			invalidate_directory(dir->untracked, untracked);
+	}
+
 	if (stat(path->len ? path->buf : ".", &st)) {
 		invalidate_directory(dir->untracked, untracked);
 		memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
@@ -1739,6 +1750,7 @@ static int valid_cached_dir(struct dir_struct *di=
r,
 		return 0;
 	}
=20
+skip_stat:
 	if (untracked->check_only !=3D !!check_only) {
 		invalidate_directory(dir->untracked, untracked);
 		return 0;
@@ -2625,8 +2637,10 @@ static void free_untracked(struct untracked_cach=
e_dir *ucd)
=20
 void free_untracked_cache(struct untracked_cache *uc)
 {
-	if (uc)
+	if (uc) {
 		free_untracked(uc->root);
+		string_list_clear(&uc->invalid_untracked, 0);
+	}
 	free(uc);
 }
=20
@@ -2775,6 +2789,7 @@ struct untracked_cache *read_untracked_extension(=
const void *data, unsigned long
 		return NULL;
=20
 	uc =3D xcalloc(1, sizeof(*uc));
+	string_list_init(&uc->invalid_untracked, 1);
 	strbuf_init(&uc->ident, ident_len);
 	strbuf_add(&uc->ident, ident, ident_len);
 	load_sha1_stat(&uc->ss_info_exclude, &ouc->info_exclude_stat,
diff --git a/dir.h b/dir.h
index 3d540de..8fd3f9e 100644
--- a/dir.h
+++ b/dir.h
@@ -315,4 +315,7 @@ struct untracked_cache *read_untracked_extension(co=
nst void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *u=
c,
+					     struct untracked_cache_dir *dir,
+					     const char *name, int len);
 #endif
diff --git a/index-helper.c b/index-helper.c
index a3a9b00..b9a050a 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -8,15 +8,18 @@
 #include "cache.h"
 #include "unix-socket.h"
 #include "pkt-line.h"
+#include "watchman-support.h"
=20
 struct shm {
 	unsigned char sha1[20];
 	void *shm;
 	size_t size;
+	pid_t pid;
 };
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
+static struct shm shm_watchman;
 static int daemonized, to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
@@ -28,10 +31,21 @@ static void release_index_shm(struct shm *is)
 	is->shm =3D NULL;
 }
=20
+static void release_watchman_shm(struct shm *is)
+{
+	if (!is->shm)
+		return;
+	munmap(is->shm, is->size);
+	unlink(git_path("shm-watchman-%s-%" PRIuMAX,
+			sha1_to_hex(is->sha1), (uintmax_t)is->pid));
+	is->shm =3D NULL;
+}
+
 static void cleanup_shm(void)
 {
 	release_index_shm(&shm_index);
 	release_index_shm(&shm_base_index);
+	release_watchman_shm(&shm_watchman);
 }
=20
 static void cleanup(void)
@@ -166,9 +180,10 @@ static void share_the_index(void)
 	if (the_index.split_index && the_index.split_index->base)
 		share_index(the_index.split_index->base, &shm_base_index);
 	share_index(&the_index, &shm_index);
-	if (to_verify && !verify_shm())
+	if (to_verify && !verify_shm()) {
 		cleanup_shm();
-	discard_index(&the_index);
+		discard_index(&the_index);
+	}
 }
=20
 static void set_socket_blocking_flag(int fd, int make_nonblocking)
@@ -201,6 +216,80 @@ static void refresh(void)
=20
 #ifndef NO_MMAP
=20
+#ifdef USE_WATCHMAN
+static void share_watchman(struct index_state *istate,
+			   struct shm *is, pid_t pid)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	void *shm;
+
+	write_watchman_ext(&sb, istate);
+	if (!shared_mmap_create(sb.len + 20, &shm,
+				git_path("shm-watchman-%s-%" PRIuMAX,
+					 sha1_to_hex(istate->sha1),
+					 (uintmax_t)pid))) {
+		is->size =3D sb.len + 20;
+		is->shm =3D shm;
+		is->pid =3D pid;
+		hashcpy(is->sha1, istate->sha1);
+
+		memcpy(shm, sb.buf, sb.len);
+		hashcpy((unsigned char *)shm + is->size - 20, is->sha1);
+	}
+	strbuf_release(&sb);
+}
+
+
+static void prepare_with_watchman(pid_t pid)
+{
+	/*
+	 * TODO: with the help of watchman, maybe we could detect if
+	 * $GIT_DIR/index is updated.
+	 */
+	if (!verify_index(&the_index))
+		refresh();
+
+	if (check_watchman(&the_index))
+		return;
+
+	share_watchman(&the_index, &shm_watchman, pid);
+}
+
+static void prepare_index(pid_t pid)
+{
+	if (shm_index.shm =3D=3D NULL)
+		refresh();
+	release_watchman_shm(&shm_watchman);
+	if (the_index.last_update)
+		prepare_with_watchman(pid);
+}
+
+#endif
+
+static void reply_to_poke(int client_fd, const char *pid_buf)
+{
+	char *capabilities;
+	struct strbuf sb =3D STRBUF_INIT;
+
+#ifdef USE_WATCHMAN
+	pid_t client_pid =3D strtoull(pid_buf, NULL, 10);
+
+	prepare_index(client_pid);
+#endif
+	capabilities =3D strchr(pid_buf, ' ');
+
+	if (capabilities && !strcmp(capabilities, " watchman"))
+#ifdef USE_WATCHMAN
+		packet_buf_write(&sb, "OK watchman");
+#else
+		packet_buf_write(&sb, "NAK watchman");
+#endif
+	else
+		packet_buf_write(&sb, "OK");
+	if (write_in_full(client_fd, sb.buf, sb.len) !=3D sb.len)
+		warning(_("client write failed"));
+}
+
 static void loop(int fd, int idle_in_seconds)
 {
 	assert(idle_in_seconds < INT_MAX / 1000);
@@ -252,11 +341,15 @@ static void loop(int fd, int idle_in_seconds)
 			buf[bytes_read] =3D 0;
 			if (!strcmp(buf, "refresh")) {
 				refresh();
-			} else if (!strcmp(buf, "poke")) {
-				/*
-				 * Just a poke to keep us
-				 * alive, nothing to do.
-				 */
+			} else if (starts_with(buf, "poke")) {
+				if (buf[4] =3D=3D ' ') {
+					reply_to_poke(client_fd, buf + 5);
+				} else {
+					/*
+					 * Just a poke to keep us
+					 * alive, nothing to do.
+					 */
+				}
 			} else {
 				warning("BUG: Bogus command %s", buf);
 			}
diff --git a/read-cache.c b/read-cache.c
index 1719f5a..8ec4be3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1235,7 +1235,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
 		if (!new) {
 			const char *fmt;
=20
-			if (really && cache_errno =3D=3D EINVAL) {
+			if (really || cache_errno =3D=3D EINVAL) {
 				/* If we are doing --really-refresh that
 				 * means the index is not valid anymore.
 				 */
@@ -1375,11 +1375,75 @@ static int verify_hdr(const struct cache_header=
 *hdr, unsigned long size)
 	return 0;
 }
=20
+static struct untracked_cache_dir *find_untracked_cache_dir(
+	struct untracked_cache *uc, struct untracked_cache_dir *ucd,
+	const char *name)
+{
+	int component_len;
+	const char *end;
+	struct untracked_cache_dir *dir;
+
+	if (!*name)
+		return ucd;
+
+	end =3D strchr(name, '/');
+	if (end)
+		component_len =3D end - name;
+	else
+		component_len =3D strlen(name);
+
+	dir =3D lookup_untracked(uc, ucd, name, component_len);
+	if (dir)
+		return find_untracked_cache_dir(uc, dir, name + component_len + 1);
+
+	return NULL;
+}
+
 static void mark_no_watchman(size_t pos, void *data)
 {
 	struct index_state *istate =3D data;
+	struct cache_entry *ce =3D istate->cache[pos];
+	struct strbuf sb =3D STRBUF_INIT;
+	char *c;
+	struct untracked_cache_dir *dir;
+
 	assert(pos < istate->cache_nr);
-	istate->cache[pos]->ce_flags |=3D CE_WATCHMAN_DIRTY;
+	ce->ce_flags |=3D CE_WATCHMAN_DIRTY;
+
+	if (!istate->untracked || !istate->untracked->root)
+		return;
+
+	strbuf_add(&sb, ce->name, ce_namelen(ce));
+
+	for (c =3D sb.buf + sb.len - 1; c > sb.buf; c--) {
+		if (*c =3D=3D '/') {
+			strbuf_setlen(&sb, c - sb.buf);
+			break;
+		}
+	}
+
+	if (c =3D=3D sb.buf)
+		strbuf_setlen(&sb, 0);
+
+	dir =3D find_untracked_cache_dir(istate->untracked,
+				       istate->untracked->root, sb.buf);
+	if (dir)
+		dir->valid =3D 0;
+
+	strbuf_release(&sb);
+}
+
+static int mark_untracked_invalid(struct string_list_item *item, void =
*uc)
+{
+	struct untracked_cache *untracked =3D uc;
+	struct untracked_cache_dir *dir;
+
+	dir =3D find_untracked_cache_dir(untracked, untracked->root,
+				       item->string);
+	if (dir)
+		dir->valid =3D 0;
+
+	return 0;
 }
=20
 static int read_watchman_ext(struct index_state *istate, const void *d=
ata,
@@ -1409,10 +1473,24 @@ static int read_watchman_ext(struct index_state=
 *istate, const void *data,
 	ewah_each_bit(bitmap, mark_no_watchman, istate);
 	ewah_free(bitmap);
=20
-	/*
-	 * TODO: update the untracked cache from the untracked data in this
-	 * extension.
-	 */
+	if (istate->untracked && istate->untracked->root) {
+		int i;
+		const char *untracked;
+
+		untracked =3D (const char *)data + len + 8 + bitmap_size;
+		for (i =3D 0; i < untracked_nr; ++i) {
+			int len =3D strlen(untracked);
+			string_list_append(&istate->untracked->invalid_untracked,
+					   untracked);
+			untracked +=3D len + 1;
+		}
+
+		for_each_string_list(&istate->untracked->invalid_untracked,
+			 mark_untracked_invalid, istate->untracked);
+
+		if (untracked_nr)
+			istate->cache_changed |=3D WATCHMAN_CHANGED;
+	}
 	return 0;
 }
=20
@@ -1645,29 +1723,88 @@ static void post_read_index_from(struct index_s=
tate *istate)
 	tweak_untracked_cache(istate);
 }
=20
+/* in ms */
+#define WATCHMAN_TIMEOUT 1000
+
+static int poke_and_wait_for_reply(int fd)
+{
+	int ret =3D -1;
+	struct pollfd pollfd;
+	int bytes_read;
+	char reply_buf[4096];
+	const char *requested_capabilities =3D "";
+
+#ifdef USE_WATCHMAN
+	requested_capabilities =3D "watchman";
+#endif
+
+	if (fd < 0)
+		return -1;
+
+	if (packet_write_gently(fd, "poke %d %s", getpid(), requested_capabil=
ities))
+		return -1;
+	if (packet_flush_gently(fd))
+		return -1;
+
+	/* Now wait for a reply */
+	pollfd.fd =3D fd;
+	pollfd.events =3D POLLIN;
+	if (poll(&pollfd, 1, WATCHMAN_TIMEOUT) <=3D 0)
+		/* No reply or error, giving up */
+		goto done_poke;
+
+	bytes_read =3D packet_read(fd, NULL, NULL, reply_buf, sizeof(reply_bu=
f),
+				 PACKET_READ_GENTLE_ON_EOF |
+				 PACKET_READ_CHOMP_NEWLINE);
+
+	if (bytes_read < 0)
+		goto done_poke;
+
+	if (!strcmp(reply_buf, "NAK watchman")
+#ifdef USE_WATCHMAN
+	    || !ends_with(reply_buf, "watchman")
+#endif
+		) {
+		warning("We requested watchman support from index-helper, but "
+			"it doesn't support it. Please use a version of git "
+			"index-helper with watchman support.");
+		goto done_poke;
+	}
+
+	if (!starts_with(reply_buf, "OK"))
+		goto done_poke;
+
+	ret =3D 0;
+done_poke:
+	close(fd);
+	return ret;
+}
+
 static int poke_daemon(struct index_state *istate,
 		       const struct stat *st, int refresh_cache)
 {
 	int fd;
-	int ret =3D 0;
-	const char *socket_path;
+	int ret =3D -1;
=20
 	/* if this is from index-helper, do not poke itself (recursively) */
 	if (istate->to_shm)
 		return 0;
=20
-	socket_path =3D git_path("index-helper.sock");
-	if (!socket_path)
+	fd =3D unix_stream_connect(git_path("index-helper.sock"));
+	if (fd < 0) {
+		warning("Failed to connect to index-helper socket");
+		unlink(git_path("index-helper.sock"));
 		return -1;
-
-	fd =3D unix_stream_connect(socket_path);
+	}
 	sigchain_push(SIGPIPE, SIG_IGN);
+
 	if (refresh_cache) {
 		packet_write_gently(fd, "refresh");
+		packet_flush_gently(fd);
+		ret =3D 0;
 	} else {
-		packet_write_gently(fd, "poke");
+		ret =3D poke_and_wait_for_reply(fd);
 	}
-	packet_flush_gently(fd);
=20
 	close(fd);
 	sigchain_pop(SIGPIPE);
@@ -1737,6 +1874,74 @@ fail:
 	return -1;
 }
=20
+static void refresh_by_watchman(struct index_state *istate)
+{
+	void *shm =3D NULL;
+	int length;
+	int i;
+	struct stat st;
+	int fd =3D -1;
+	const char *path =3D git_path("shm-watchman-%s-%"PRIuMAX,
+				    sha1_to_hex(istate->sha1),
+				    (uintmax_t)getpid());
+
+	fd =3D open(path, O_RDONLY);
+	if (fd < 0)
+		return;
+
+	/*
+	 * This watchman data is just for us -- no need to keep it
+	 * around once we've got it open.
+	 */
+	unlink(path);
+
+	if (fstat(fd, &st) < 0)
+		goto done;
+
+	length =3D st.st_size;
+	shm =3D mmap(NULL, length, PROT_READ, MAP_SHARED, fd, 0);
+
+	if (shm =3D=3D MAP_FAILED)
+		goto done;
+
+	close(fd);
+	fd =3D -1;
+
+	if (length <=3D 20 ||
+	    hashcmp(istate->sha1, (unsigned char *)shm + length - 20) ||
+	    /*
+	     * No need to clear CE_WATCHMAN_DIRTY set by 'WAMA' on
+	     * disk. Watchman can only set more, not clear any, so
+	     * this is OR mask.
+	     */
+	    read_watchman_ext(istate, shm, length - 20))
+		goto done;
+
+	/*
+	 * Now that we've marked the invalid entries in the
+	 * untracked-cache itself, we can erase them from the list of
+	 * entries to be processed and mark the untracked cache for
+	 * watchman usage.
+	 */
+	if (istate->untracked) {
+		string_list_clear(&istate->untracked->invalid_untracked, 0);
+		istate->untracked->use_watchman =3D 1;
+	}
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce =3D istate->cache[i];
+		if (ce_stage(ce) || (ce->ce_flags & CE_WATCHMAN_DIRTY))
+			continue;
+		ce_mark_uptodate(ce);
+	}
+done:
+	if (shm)
+		munmap(shm, length);
+
+	if (fd >=3D 0)
+		close(fd);
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int mu=
st_exist)
 {
@@ -1856,7 +2061,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	split_index =3D istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
 		post_read_index_from(istate);
-		return ret;
+		goto done;
 	}
=20
 	if (split_index->base)
@@ -1877,6 +2082,10 @@ int read_index_from(struct index_state *istate, =
const char *path)
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
 	post_read_index_from(istate);
+
+done:
+	if (ret > 0 && istate->from_shm && istate->last_update)
+		refresh_by_watchman(istate);
 	return ret;
 }
=20
@@ -2178,7 +2387,7 @@ out:
 	return 0;
 }
=20
-static int verify_index(const struct index_state *istate)
+int verify_index(const struct index_state *istate)
 {
 	return verify_index_from(istate, get_index_file());
 }
--=20
2.4.2.767.g62658d5-twtrsrc
