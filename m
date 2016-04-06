From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 09/16] index-helper: use watchman to avoid refreshing index with lstat()
Date: Wed,  6 Apr 2016 18:11:55 -0400
Message-ID: <1459980722-4836-10-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:13:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvhN-0004xc-06
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbcDFWNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 18:13:01 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34191 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbcDFWMq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:46 -0400
Received: by mail-qk0-f174.google.com with SMTP id r184so23605706qkc.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZa9hQikN9zv6msDBBMi92KG1f2Qj1QUX0tsEaQkQf4=;
        b=OI7o+bsIaNRRw6PgOQwx1txbPmU1qdhiH46Hu/MgXZZSnSakxeeHEPtEbH8e2MlOf4
         e6hZk0hBkDdSVOLcssOg2yvSucCt5DpMTws5/429qb0TxvNFDz1v2GN4i3xB7wn+MDG3
         Md3Aut5ftkEHS8pQ0j7ruhgwzCoJy0XEueodIhF7D9LfERq2uo84ZDHBqzGl4qRHTB9L
         Iy02saBf38HkOdtFXDfTS31WwL2igG68y6Kkj08HBOfI3qwTZy5ywsbXY3u0GU1dp/ue
         kXXnxdW209fxAtO1xNTPD4JN0Kycz7FJpAhaw8Yhs/mQJcscIMNxuT68Rr6nNGsoeEnP
         0mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZa9hQikN9zv6msDBBMi92KG1f2Qj1QUX0tsEaQkQf4=;
        b=LIP5gWTq7WX54PxAQCrhtc2Z26SmfxuLEx7tCCt1tQzkhSXNUoTS6ulmqodix6HIwc
         0fgRdcUTjE1HLiwfp6QBvZw6yJw04uRARBEXtdJpjdkbmG71+1HBEPnLbMjRvDNN2Lfj
         NoK26ufnHmYzdu6I1yNE4mtUzsHThSlVBeE/gCIM+H5nGhQZrlO01eEksZZumt5gq3Ol
         tdpP2PsvYeGkNo6zai0KzM0NvyeRWLnyBb5vTLVrFh/fUty31SSZFiBTkq4ujzZcAMIy
         Ka/Z3tEGgvWv535bLYB5x9ylBr4L55YkV5QlGiCsXK3tQ4yqvgRBFY13Qfj93m6ffehD
         +F1w==
X-Gm-Message-State: AD7BkJKM4zZ8Twufq3jrMSa2sW1vyyDtwjtWKjC9FVVgbnMriLSynuboh22NYgXMKzRbzg==
X-Received: by 10.55.72.86 with SMTP id v83mr50185143qka.72.1459980765261;
        Wed, 06 Apr 2016 15:12:45 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290884>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Watchman is hidden behind index-helper. Before git tries to read the
index from shm, it notifies index-helper through the socket and
waits for index-helper to prepare shm. index-helper then contacts
watchman, updates 'WAMA' extension and put it in a separate shm and
wakes git up with a reply to git's socket.

Git uses this extension to not lstat unchanged entries. Git only
trusts the 'WAMA' extension when it's received from the separate shm,
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
 cache.h                            |   8 ++
 dir.c                              |  23 +++-
 dir.h                              |   3 +
 index-helper.c                     | 102 ++++++++++++++---
 read-cache.c                       | 218 +++++++++++++++++++++++++++++=
++++----
 6 files changed, 319 insertions(+), 41 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index bb344cf..9d1ad0e 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -51,6 +51,12 @@ following commands are used to control the daemon:
 	Let the daemon know the index is to be read. It keeps the
 	daemon alive longer, unless `--exit-after=3D0` is used.
=20
+"poke <path>":
+	Like "poke", but replies with "OK".  If watchman is
+	configured, index-helper queries watchman, then prepares a
+	shared memory object with the watchman index extension before
+	replying.
+
 All commands and replies are terminated by a 0 byte.
=20
 GIT
diff --git a/cache.h b/cache.h
index 37f211b..e43a6e1 100644
--- a/cache.h
+++ b/cache.h
@@ -558,6 +558,7 @@ extern int daemonize(int *);
=20
 /* Initialize and use the cache information */
 struct lock_file;
+extern int verify_index(const struct index_state *);
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const struct paths=
pec *pathspec);
 extern int do_read_index(struct index_state *istate, const char *path,
@@ -565,6 +566,7 @@ extern int do_read_index(struct index_state *istate=
, const char *path,
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
+extern void write_watchman_ext(struct strbuf *sb, struct index_state* =
istate);
 #define COMMIT_LOCK		(1 << 0)
 #define CLOSE_LOCK		(1 << 1)
 extern int write_locked_index(struct index_state *, struct lock_file *=
lock, unsigned flags);
@@ -1839,4 +1841,10 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
=20
+/*
+ * Open a socket to the git index-helper. Return the fd of that
+ * socket, or -1 on error.
+ */
+int connect_to_index_helper(void);
+
 #endif /* CACHE_H */
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
index 10f29f5..f993ae6 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -6,15 +6,18 @@
 #include "split-index.h"
 #include "shm.h"
 #include "lockfile.h"
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
@@ -26,10 +29,21 @@ static void release_index_shm(struct shm *is)
 	is->shm =3D NULL;
 }
=20
+static void release_watchman_shm(struct shm *is)
+{
+	if (!is->shm)
+		return;
+	munmap(is->shm, is->size);
+	git_shm_unlink("git-watchman-%s-%" PRIuMAX,
+		       sha1_to_hex(is->sha1), (uintmax_t)is->pid);
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
@@ -127,18 +141,10 @@ static void share_the_index(void)
 	if (the_index.split_index && the_index.split_index->base)
 		share_index(the_index.split_index->base, &shm_base_index);
 	share_index(&the_index, &shm_index);
-	if (to_verify && !verify_shm())
+	if (to_verify && !verify_shm()) {
 		cleanup_shm();
-	discard_index(&the_index);
-}
-
-static void refresh(void)
-{
-	the_index.keep_mmap =3D 1;
-	the_index.to_shm    =3D 1;
-	if (read_cache() < 0)
-		die(_("could not read index"));
-	share_the_index();
+		discard_index(&the_index);
+	}
 }
=20
 static void set_socket_nonblocking(int fd)
@@ -156,6 +162,61 @@ static void set_socket_nonblocking(int fd)
=20
 #ifdef HAVE_SHM
=20
+#ifdef USE_WATCHMAN
+static void share_watchman(struct index_state *istate,
+			   struct shm *is, pid_t pid)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	void *shm;
+
+	write_watchman_ext(&sb, istate);
+	if (git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, sb.len + 20,
+			&shm, PROT_READ | PROT_WRITE, MAP_SHARED,
+			"git-watchman-%s-%" PRIuMAX,
+			sha1_to_hex(istate->sha1), (uintmax_t)pid) =3D=3D sb.len + 20) {
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
+	if (check_watchman(&the_index))
+		return;
+
+	share_watchman(&the_index, &shm_watchman, pid);
+}
+
+static void prepare_index(pid_t pid)
+{
+	release_watchman_shm(&shm_watchman);
+	if (the_index.last_update)
+		prepare_with_watchman(pid);
+}
+
+#endif
+
+static void refresh(void)
+{
+	discard_index(&the_index);
+	the_index.keep_mmap =3D 1;
+	the_index.to_shm    =3D 1;
+	if (read_cache() < 0)
+		die(_("could not read index"));
+	share_the_index();
+}
+
 static void loop(int fd, int idle_in_seconds)
 {
 	struct timeval timeout;
@@ -201,11 +262,20 @@ static void loop(int fd, int idle_in_seconds)
 		if (strbuf_getwholeline_fd(&command, client_fd, '\0') =3D=3D 0) {
 			if (!strcmp(command.buf, "refresh")) {
 				refresh();
-			} else if (!strcmp(command.buf, "poke")) {
-				/*
-				 * Just a poke to keep us
-				 * alive, nothing to do.
-				 */
+			} else if (starts_with(command.buf, "poke")) {
+				if (command.buf[4] =3D=3D ' ') {
+#ifdef USE_WATCHMAN
+					int client_pid =3D strtoull(command.buf + 5, NULL, 10);
+					prepare_index(client_pid);
+#endif
+					if (write_in_full(client_fd, "OK", 3) !=3D 3)
+						warning(_("client write failed"));
+				} else {
+					/*
+					 * Just a poke to keep us
+					 * alive, nothing to do.
+					 */
+				}
 			} else {
 				warning("BUG: Bogus command %s", command.buf);
 			}
diff --git a/read-cache.c b/read-cache.c
index 59d892e..b6e9244 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1233,7 +1233,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
 		if (!new) {
 			const char *fmt;
=20
-			if (really && cache_errno =3D=3D EINVAL) {
+			if (really || cache_errno =3D=3D EINVAL) {
 				/* If we are doing --really-refresh that
 				 * means the index is not valid anymore.
 				 */
@@ -1373,11 +1373,76 @@ static int verify_hdr(const struct cache_header=
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
+	if (c =3D=3D sb.buf) {
+		strbuf_setlen(&sb, 0);
+	}
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
@@ -1407,10 +1472,24 @@ static int read_watchman_ext(struct index_state=
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
+		untracked =3D data + len + 8 + bitmap_size;
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
@@ -1643,16 +1722,10 @@ static void post_read_index_from(struct index_s=
tate *istate)
 	tweak_untracked_cache(istate);
 }
=20
-static int poke_daemon(struct index_state *istate,
-		       const struct stat *st, int refresh_cache)
+int connect_to_index_helper(void)
 {
-	int fd;
-	int ret =3D 0;
 	struct sockaddr_un address =3D {0};
-
-	/* if this is from index-helper, do not poke itself (recursively) */
-	if (istate->to_shm)
-		return 0;
+	int fd;
=20
 	if (readlink(git_path("index-helper.path"), address.sun_path,
 		     UNIX_PATH_MAX) < 0)
@@ -1663,16 +1736,71 @@ static int poke_daemon(struct index_state *ista=
te,
 		return -1;
=20
 	address.sun_family =3D AF_UNIX;
-	if (connect(fd, (struct sockaddr *) &address, sizeof(address))) {
-		warning("Failed to connect to socket %s", address.sun_path);
-		close(fd);
+	if (!connect(fd, (struct sockaddr *) &address, sizeof(address)))
+		return fd;
+
+
+	warning("Failed to connect to socket %s", address.sun_path);
+	close(fd);
+	return -1;
+}
+
+static int poke_and_wait_for_reply(int fd)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	struct strbuf reply =3D STRBUF_INIT;
+	int ret =3D -1;
+	fd_set fds;
+	struct timeval timeout;
+
+	timeout.tv_usec =3D 0;
+	timeout.tv_sec =3D 1;
+
+	if (fd < 0)
 		return -1;
-	}
+
+	strbuf_addf(&buf, "poke %d", getpid());
+	if (write_in_full(fd, buf.buf, buf.len + 1) !=3D buf.len + 1)
+		goto done_poke;
+
+	/* Now wait for a reply */
+	FD_ZERO(&fds);
+	FD_SET(fd, &fds);
+	if (select(fd + 1, &fds, NULL, NULL, &timeout) =3D=3D 0)
+		/* No reply, giving up */
+		goto done_poke;
+
+	if (strbuf_getwholeline_fd(&reply, fd, 0))
+		goto done_poke;
+
+	if (!starts_with(reply.buf, "OK"))
+		goto done_poke;
+
+	ret =3D 0;
+done_poke:
+	close(fd);
+	strbuf_release(&buf);
+	strbuf_release(&reply);
+
+	return ret;
+}
+
+static int poke_daemon(struct index_state *istate,
+		       const struct stat *st, int refresh_cache)
+{
+	int fd;
+	int ret =3D -1;
+
+	/* if this is from index-helper, do not poke itself (recursively) */
+	if (istate->to_shm)
+		return 0;
+
+	fd =3D connect_to_index_helper();
=20
 	if (refresh_cache) {
 		ret =3D write_in_full(fd, "refresh", 8) !=3D 8;
 	} else {
-		ret =3D write_in_full(fd, "poke", 5) !=3D 5;
+		ret =3D poke_and_wait_for_reply(fd);
 	}
=20
 	close(fd);
@@ -1728,6 +1856,50 @@ static int try_shm(struct index_state *istate)
 	return 0;
 }
=20
+static void refresh_by_watchman(struct index_state *istate)
+{
+	void *shm =3D NULL;
+	int length;
+	int i;
+
+	length =3D git_shm_map(O_RDONLY, 0700, -1, &shm,
+			     PROT_READ, MAP_SHARED,
+			     "git-watchman-%s-%" PRIuMAX,
+			     sha1_to_hex(istate->sha1),
+			     (uintmax_t)getpid());
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
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int mu=
st_exist)
 {
@@ -1847,7 +2019,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	split_index =3D istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
 		post_read_index_from(istate);
-		return ret;
+		goto done;
 	}
=20
 	if (split_index->base)
@@ -1868,6 +2040,10 @@ int read_index_from(struct index_state *istate, =
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
@@ -2169,7 +2345,7 @@ out:
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
