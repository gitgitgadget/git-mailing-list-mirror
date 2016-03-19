From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 10/17] index-helper: use watchman to avoid refreshing index with lstat()
Date: Fri, 18 Mar 2016 21:04:43 -0400
Message-ID: <1458349490-1704-11-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:08:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5NQ-0000we-HR
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053AbcCSBIV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 21:08:21 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35423 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbcCSBIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:08:19 -0400
Received: by mail-qg0-f44.google.com with SMTP id y89so115399996qge.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EG1lQqXl3xLvN79nD7czgalJSqlMWwLQFGPanse1RDE=;
        b=UIV0/XPUDJSDbv38U72M7+N3OBoJ7HP11vOe2RNF3jxhD/NObkaCDKB4u/X1o069SX
         bfC4jn1d2eT7C3R2EUq17XDkLLbTH0jxlc5Nk4nrIV34OMEsWEucRTQC5ghpfpFBfFPG
         zCaV0ofrT6LGLe9FaRr9KeGBUNYOWwCY/sm/47ho/EEmcuL/6ztoIp8geMsOnbLcHD+n
         7xuxecpI6all3Uw99dmOHQW5z8L1ACK24VH5BVfku8QuBWAtvom95e0H0xJrPIOJDFZj
         YKuYoW692MmJ+DIXmaLhZKUym57+fXml8U3mN0pKhW6LsVVIIZtCYiSs0sGBVeYrZPKw
         NlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EG1lQqXl3xLvN79nD7czgalJSqlMWwLQFGPanse1RDE=;
        b=U4l7NMiC6gSh6/Dga7iSrz4jZ5me/k8vzG697kqy1rOyEu28zIBQsOgDHH1Pu1tl+7
         Tf4LK+ZPQy/l5xiQP1T9OJGty+z8Ck/I4Ez44yFCd3ivuQZi4bKets/nVlkLVBD8Q6PC
         9sapLZ5WtVDrGviZxalrY4shmeRu451Eoo5f5eGtd5phU+GftujErISnj6hG1DKHLH/f
         K9FxX9jIKvgheqFQaHXo6HinIyog4ZJnL2bCxpCA2Uj5avmteFIByKdIr4AghCrlhCuq
         LVLrAp0SBhwpQlnTgCvSrJFsr5EVJX3eAP5REnX3am8bf08ibXkvocD/Yg0j41B3ZVZC
         vWbg==
X-Gm-Message-State: AD7BkJKZLsJ6Ex2BweMtfTBNFHIZFiCukvYhRa9ISaq/VzR8jF7WbTLMHLbVD1b2XqldBA==
X-Received: by 10.140.146.143 with SMTP id 137mr27549566qhs.15.1458349698299;
        Fri, 18 Mar 2016 18:08:18 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.08.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:08:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289277>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Watchman is hidden behind index-helper. Before git tries to read the
index from shm, it notifies index-helper through the named pipe and
waits for index-helper to prepare shm. index-helper then contacts
watchman, updates 'WAMA' extension and put it in a separate shm and
wakes git up with a write to git's named pipe.

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

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> =
gmail.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |   6 ++
 cache.h                            |   2 +
 dir.c                              |  12 ++++
 index-helper.c                     | 128 +++++++++++++++++++++++++++++=
+---
 read-cache.c                       | 141 +++++++++++++++++++++++++++++=
++++++--
 5 files changed, 275 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index b858a8d..7a8042e 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -51,6 +51,12 @@ the daemon:
 	Let the daemon know the index is to be read. It keeps the
 	daemon alive longer, unless `--exit-after=3D0` is used.
=20
+"poke <path>":
+	Like "poke", but replies with "OK" by opening the named pipe
+	at <path> and writing the string.  If watchman is configured,
+	index-helper queries watchman, then prepares a shared memory
+	object with the watchman index extension before replying.
+
 All commands and replies are terminated by a 0 byte.
=20
 GIT
diff --git a/cache.h b/cache.h
index 95715fd..9fa339a 100644
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
 #define REFRESH_DAEMON		(1 << 2)
diff --git a/dir.c b/dir.c
index 9b659e6..5058b29 100644
--- a/dir.c
+++ b/dir.c
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
diff --git a/index-helper.c b/index-helper.c
index a854ed8..445a0ac 100644
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
@@ -124,13 +138,62 @@ static void share_the_index(void)
 	if (the_index.split_index && the_index.split_index->base)
 		share_index(the_index.split_index->base, &shm_base_index);
 	share_index(&the_index, &shm_index);
-	if (to_verify && !verify_shm())
+	if (to_verify && !verify_shm()) {
 		cleanup_shm();
-	discard_index(&the_index);
+		discard_index(&the_index);
+	}
+}
+
+#ifdef HAVE_SHM
+
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
 }
=20
-static void refresh(void)
+
+static void prepare_with_watchman(pid_t pid)
 {
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
+static void refresh()
+{
+	discard_index(&the_index);
 	the_index.keep_mmap =3D 1;
 	the_index.to_shm    =3D 1;
 	if (read_cache() < 0)
@@ -138,7 +201,50 @@ static void refresh(void)
 	share_the_index();
 }
=20
-#ifdef HAVE_SHM
+static int send_response(const char *client_pipe_path, const char *res=
ponse)
+{
+	int fd;
+	int len;
+
+	fd =3D open(client_pipe_path, O_WRONLY | O_NONBLOCK);
+	if (fd < 0)
+		return -1;
+
+	len =3D strlen(response) + 1;
+	assert(len < PIPE_BUF);
+	if (write_in_full(fd, response, len) !=3D len) {
+		close(fd);
+		return -1;
+	}
+
+	close(fd);
+	return 0;
+}
+
+static uintmax_t get_trailing_digits(const char *path)
+{
+	const char *start =3D strrchr(path, '/');
+	if (!start)
+		return 0;
+	while (*start && !isdigit(*start)) start ++;
+	if (!*start)
+		return 0;
+	return strtoull(start, NULL, 10);
+}
+
+static void reply(const char *path)
+{
+	uintmax_t pid;
+	/*
+	 * Parse caller pid out of provided path.  It'll be some
+	 * digits on the end.
+	 */
+	pid =3D (pid_t)get_trailing_digits(path);
+#ifdef USE_WATCHMAN
+	prepare_index(pid);
+#endif
+	send_response(path, "OK");
+}
=20
 static void loop(int fd, int idle_in_seconds)
 {
@@ -171,11 +277,15 @@ static void loop(int fd, int idle_in_seconds)
 			if (strbuf_getwholeline_fd(&command, fd, '\0') =3D=3D 0) {
 				if (!strcmp(command.buf, "refresh")) {
 					refresh();
-				} else if (!strcmp(command.buf, "poke")) {
-					  /*
-					   * Just a poke to keep us
-					   * alive, nothing to do.
-					   */
+				} else if (starts_with(command.buf, "poke")) {
+					if (command.buf[4] =3D=3D ' ')
+						reply(command.buf + 5);
+					else
+						/*
+						 * Just a poke to keep us
+						 * alive, nothing to do.
+						 */
+						;
 				} else {
 					warning("BUG: Bogus command %s", command.buf);
 				}
diff --git a/read-cache.c b/read-cache.c
index b4bd15c..8e886d1 100644
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
@@ -1722,11 +1722,94 @@ static void post_read_index_from(struct index_s=
tate *istate)
 	tweak_untracked_cache(istate);
 }
=20
+static int poke_and_wait_for_reply(int fd)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	struct strbuf reply =3D STRBUF_INIT;
+	int pid =3D getpid();
+	int read_fd =3D -1;
+	int ret =3D -1;
+	fd_set fds;
+	struct timeval timeout;
+	char *my_pipe_path;
+
+	timeout.tv_usec =3D 0;
+	timeout.tv_sec =3D 1;
+
+	/*
+	 * Create a fifo so that index-helper can reply (we don't want
+	 * it to reply on its own fifo because then we maybe have a
+	 * fifo with multiple readers, which causes doom).
+	 */
+	my_pipe_path =3D xstrdup(real_path(git_path("%d.pipe", pid)));
+
+	/*
+	 * It's important that the command fit in one PIPE_BUF
+	 * so that it doesn't interleave with other messages.
+	 *
+	 * POSIX specifies a 512 byte minimum for PIPE_BUF, so
+	 * this should rarely be a problem.
+	 */
+	if (strlen(my_pipe_path) + 6 /* "poke \0" */ > PIPE_BUF) {
+		const char *tmp =3D getenv("TMPDIR");
+
+		if (!tmp)
+			tmp =3D "/tmp";
+
+		free(my_pipe_path);
+		strbuf_addf(&buf, "%s/git-%d.pipe", tmp, pid);
+		my_pipe_path =3D strbuf_detach(&buf, NULL);
+		if (buf.len + 6 > PIPE_BUF)
+			goto no_fifo;
+	}
+	if (mkfifo(my_pipe_path, 0600)) {
+		if (errno !=3D EEXIST)
+			goto no_fifo;
+
+		unlink(my_pipe_path);
+		if (mkfifo(my_pipe_path, 0600))
+			goto no_fifo;
+	}
+	read_fd =3D open(my_pipe_path, O_RDONLY | O_NONBLOCK);
+	if (read_fd < 0)
+		goto done_poke;
+
+	strbuf_addstr(&buf, "poke ");
+	strbuf_addstr(&buf, my_pipe_path);
+	if (write_in_full(fd, buf.buf, buf.len + 1) !=3D buf.len + 1)
+		goto done_poke;
+
+	/* Now wait for a reply */
+	FD_ZERO(&fds);
+	FD_SET(read_fd, &fds);
+	if (select(read_fd + 1, &fds, NULL, NULL, &timeout) =3D=3D 0)
+		/* No reply, giving up */
+		goto done_poke;
+
+	if (strbuf_getwholeline_fd(&reply, read_fd, 0))
+		goto done_poke;
+
+	if (!starts_with(reply.buf, "OK"))
+		goto done_poke;
+
+	ret =3D 0;
+done_poke:
+	unlink(my_pipe_path);
+no_fifo:
+	free(my_pipe_path);
+	if (read_fd !=3D -1)
+		close(read_fd);
+	strbuf_release(&buf);
+	strbuf_release(&reply);
+
+	return ret;
+}
+
 static int poke_daemon(struct index_state *istate,
 		       const struct stat *st, int refresh_cache)
 {
 	int fd;
-	int ret =3D 0;
+	int ret =3D -1;
=20
 	/* if this is from index-helper, do not poke itself (recursively) */
 	if (istate->to_shm)
@@ -1738,7 +1821,7 @@ static int poke_daemon(struct index_state *istate=
,
 	if (refresh_cache) {
 		ret =3D write_in_full(fd, "refresh", 8) =3D=3D 8;
 	} else {
-		ret =3D write_in_full(fd, "poke", 5) =3D=3D 5;
+		ret =3D poke_and_wait_for_reply(fd);
 	}
=20
 	close(fd);
@@ -1790,6 +1873,50 @@ static int try_shm(struct index_state *istate)
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
@@ -1909,7 +2036,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	split_index =3D istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
 		post_read_index_from(istate);
-		return ret;
+		goto done;
 	}
=20
 	if (split_index->base)
@@ -1930,6 +2057,10 @@ int read_index_from(struct index_state *istate, =
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
@@ -2231,7 +2362,7 @@ out:
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
