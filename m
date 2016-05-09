From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 10/19] index-helper: use watchman to avoid refreshing index with lstat()
Date: Mon,  9 May 2016 16:48:40 -0400
Message-ID: <1462826929-7567-11-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:51:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7n-0004LM-Nm
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbcEIUtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 16:49:49 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34254 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbcEIUtS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:18 -0400
Received: by mail-qg0-f48.google.com with SMTP id 90so95695525qgz.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASVQ5uluJoObXnkzyxVBhPNaPV1Q1SABwh3OoyYvXQc=;
        b=KJm+RrD8hI6u0m6JAmGqFvbnklc9kTZRmKLqzi8XtvlXZAiY4B4ykgKrNoN++v4Eez
         vTM3HATytQiIFCesPXrb98SCCd4ZZoyaIQDBCuU5UvhkFcvNTB52yIrqKnpomzP45PiW
         oKmkExJEpmjowSWK0zn+spnGTA6huwwWL8th6PfDAhX2pj28wqOgGVBu5+pr0z2StF+L
         NcC37y7mmk7Lkd6mm8BaIde2YDfnmO7Wuoj7hTAAgjnHXPYpd4o5HNKaxCyyKOs5rCAv
         Im5oxqH20R2bn/PSZkdV+fWmc9bPkMI1bOlIomgcJDmgQ82CEnAJmqay9TOJE+bL+MGe
         PgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASVQ5uluJoObXnkzyxVBhPNaPV1Q1SABwh3OoyYvXQc=;
        b=DHjGkp0d25iJrKVMipEexiHLwciVb00DEtxuUMxPDYxVwo0aNlpL1lhGSQhdfyKksf
         7qNo3d8ebFhCZhhen7p+hE1lfAWK7CZsPg7tDrXb6EdAADq4EeZqbH81sATbFtGWlEgM
         2zxEBGMYB1UnRqICYSBJxW8tenrwP00kyiG4Aef4MCNXE9gj7DtPByc+mxB0ZPDGx975
         TiSYx/Tf3reW9Rt7q5niS9W8SVK9r2jgXDPelDDNrG7q+RsB9BuamJb5pWGRIwAczXhA
         ht6Qy0jh/wcWYWD54j16eTkqVyaKbK+4auHy1AYz+vo7rYUXf0cSw2Mg98oBpaqqyQbQ
         WbjQ==
X-Gm-Message-State: AOPr4FXFXoZfigHEtm0dI1Hv3bcB9p/6UD8gWwmcBSCOMUtaXCdOUYIUff5FnDxJk4lBSw==
X-Received: by 10.140.151.206 with SMTP id 197mr40020035qhx.4.1462826957115;
        Mon, 09 May 2016 13:49:17 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:15 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294060>

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

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |   6 +
 cache.h                            |   2 +
 dir.c                              |  23 +++-
 dir.h                              |   3 +
 index-helper.c                     | 107 ++++++++++++++--
 read-cache.c                       | 243 +++++++++++++++++++++++++++++=
+++++---
 6 files changed, 357 insertions(+), 27 deletions(-)

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
index 7df7a97..71c4f48 100644
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
 static void log_warning(const char *warning, ...)
@@ -51,10 +54,21 @@ static void release_index_shm(struct shm *is)
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
@@ -189,9 +203,10 @@ static void share_the_index(void)
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
@@ -224,6 +239,80 @@ static void refresh(void)
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
+	if (!strcmp(capabilities, " watchman"))
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
@@ -275,11 +364,15 @@ static void loop(int fd, int idle_in_seconds)
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
 				log_warning("BUG: Bogus command %s", buf);
 			}
diff --git a/read-cache.c b/read-cache.c
index 9399a81..b4ed18e 100644
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
@@ -1645,29 +1723,90 @@ static void post_read_index_from(struct index_s=
tate *istate)
 	tweak_untracked_cache(istate);
 }
=20
+/* in ms */
+#define WATCHMAN_TIMEOUT 1000
+
+static int poke_and_wait_for_reply(int fd)
+{
+	struct strbuf buf =3D STRBUF_INIT;
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
+	strbuf_addf(&buf, "poke %d %s", getpid(), requested_capabilities);
+	packet_write(fd, buf.buf, buf.len);
+	packet_flush(fd);
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
+	strbuf_release(&buf);
+
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
 		packet_write(fd, "refresh");
+		packet_flush(fd);
+		ret =3D 0;
 	} else {
-		packet_write(fd, "poke");
+		ret =3D poke_and_wait_for_reply(fd);
 	}
-	packet_flush(fd);
=20
 	close(fd);
 	sigchain_pop(SIGPIPE);
@@ -1737,6 +1876,74 @@ fail:
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
@@ -1856,7 +2063,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	split_index =3D istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
 		post_read_index_from(istate);
-		return ret;
+		goto done;
 	}
=20
 	if (split_index->base)
@@ -1877,6 +2084,10 @@ int read_index_from(struct index_state *istate, =
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
@@ -2178,7 +2389,7 @@ out:
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
