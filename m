From: David Turner <dturner@twopensource.com>
Subject: [PATCH 13/19] index-helper: use watchman to avoid refreshing index with lstat()
Date: Wed,  9 Mar 2016 13:36:16 -0500
Message-ID: <1457548582-28302-14-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiz1-0007bL-1E
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933871AbcCIShN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:37:13 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34291 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933798AbcCISgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:46 -0500
Received: by mail-qk0-f176.google.com with SMTP id x1so24105068qkc.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l/7TJVvnUZ2pa8r4vcxZsgfTc9u8dWftad/s1obv44A=;
        b=CEfBY3cqKh59kkPmSPQ7NGJoM5+h5hNq1HFsQAzIthMf1aks+5+N/9RX1TjpMVd+Ok
         7MVUGVAEREiJL2gkeep6UPXhPncYSFUI1EM/kofEecjcw5lc5AE5CGr3e13NDw2+aqd+
         gk1regUjOLHxyuEZAJFhO02ddP/kElmodMpQWSZg/kfqtMsyd64VO1TT29nS33wJg6kP
         LkH5ant6syQy1trgQiOr9YHnxwKZrFPgV1opeUCJPgYhGiLzdubu+V4OE0CvZkBrFJEc
         GZYAbpFFs20x4xQ+bd6A04T26x3nxukIr4nopNec2LZlu+2FyFCstuRlWRVNKGuN1Plj
         R1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/7TJVvnUZ2pa8r4vcxZsgfTc9u8dWftad/s1obv44A=;
        b=FkzLXa5WF67wp3JCykes6rC2NAioA7Rhi78/by0yfzuvnaWSKDJdzSZ+5SocYmy2CK
         c16tCmXILXyafjs4jvbz3+1w37Ncmzbuxt+cFzlbsqWMQpGc/DN6Lz/uUWP1l3jScer9
         GlimFiStYYrVZYMIep+GtEcsxNlBgpPhXU/GgBAkR93h7Ejpqmm9xKwtpr2lxgQW2s7v
         cmPeaUQt+CGVR3atmDELU7Tt46jdZLoJjl9oF/4mSfBxCaUf9TGfzLJawc1KeWKBhDSS
         MzmmrCq95yZ5eFon6gAJxy5UneAHD1s0IkKDPAnSolVPto7pPx45NUPWegEemQquzDfv
         4ztw==
X-Gm-Message-State: AD7BkJKXUSCtpz9H+IaUrjI6Rk6g3HMSFzEbziFxK8ZNvBLGuvv61myye1gky1kJE9sOHQ==
X-Received: by 10.55.18.168 with SMTP id 40mr44019585qks.99.1457548605203;
        Wed, 09 Mar 2016 10:36:45 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:44 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288562>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Watchman is hidden behind index-helper. Before git tries to read the
index from shm, it notifies index-helper with SIGHUP and sleep,
waiting for index-helper to prepare shm. index-helper then contacts
watchman, updates 'WAMA' extension and put it in a separate shm and
wakes git up with SIGHUP.

Git uses this extension to not lstat unchanged entries. Git only trust
'WAMA' extension when it's received from the separate shm, not from
disk. Unmarked entries are "clean". Marked entries are dirty from
watchman point of view. If it finds out some entries are
'watchman-dirty', but are really unchanged (e.g. the file was changed,
then reverted back), then Git will clear the marking in 'WAMA' before
writing it down.

Hiding watchman behind index-helper means you need both daemons. You
can't run watchman alone. Not so good. But on the other hand, 'git'
binary is not linked to watchman/json libraries, which is good for
packaging. Core git package will run fine without watchman-related
packages. If they need watchman, they can install git-index-helper and
dependencies.

Another reason for tying watchman to index-helper is, when used with
untracked cache, we need to keep track of $GIT_WORK_TREE file
listing. That kind of list can be kept in index-helper.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile       |  5 ++++
 cache.h        |  2 ++
 index-helper.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 read-cache.c   | 43 +++++++++++++++++++++++++++---
 4 files changed, 127 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index e51331c..d79fc0c 100644
--- a/Makefile
+++ b/Makefile
@@ -450,6 +450,7 @@ MSGFMT =3D msgfmt
 CURL_CONFIG =3D curl-config
 PTHREAD_LIBS =3D -lpthread
 PTHREAD_CFLAGS =3D
+WATCHMAN_LIBS =3D
 GCOV =3D gcov
=20
 export TCL_PATH TCLTK_PATH
@@ -1419,6 +1420,7 @@ endif
 ifdef USE_WATCHMAN
 	LIB_H +=3D watchman-support.h
 	LIB_OBJS +=3D watchman-support.o
+	WATCHMAN_LIBS =3D -lwatchman
 	BASIC_CFLAGS +=3D -DUSE_WATCHMAN
 endif
=20
@@ -2032,6 +2034,9 @@ git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAG=
S $(GITLIBS) $(VCSSVN_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS) \
 	$(VCSSVN_LIB)
=20
+git-index-helper$X: index-helper.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS) $(WATCHMAN_LIBS)
+
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
diff --git a/cache.h b/cache.h
index bf20652..272c928 100644
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
diff --git a/index-helper.c b/index-helper.c
index cf26da7..7e7ce9b 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -5,15 +5,18 @@
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
@@ -25,10 +28,21 @@ static void release_index_shm(struct shm *is)
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
@@ -120,13 +134,15 @@ static void share_the_index(void)
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
 static void refresh(int sig)
 {
+	discard_index(&the_index);
 	the_index.keep_mmap =3D 1;
 	the_index.to_shm    =3D 1;
 	if (read_cache() < 0)
@@ -136,7 +152,55 @@ static void refresh(int sig)
=20
 #ifdef HAVE_SHM
=20
-static void do_nothing(int sig)
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
+static void prepare_with_watchman(pid_t pid)
+{
+	/*
+	 * with the help of watchman, maybe we could detect if
+	 * $GIT_DIR/index is updated..
+	 */
+	if (!verify_index(&the_index))
+		refresh(0);
+
+	if (check_watchman(&the_index))
+		return;
+
+	share_watchman(&the_index, &shm_watchman, pid);
+}
+
+static void prepare_index(int sig, siginfo_t *si, void *context)
+{
+	release_watchman_shm(&shm_watchman);
+	if (the_index.last_update)
+		prepare_with_watchman(si->si_pid);
+	kill(si->si_pid, SIGHUP); /* stop the waiting in poke_daemon() */
+}
+
+#else
+
+static void prepare_index(int sig, siginfo_t *si, void *context)
 {
 	/*
 	 * what we need is the signal received and interrupts
@@ -145,11 +209,21 @@ static void do_nothing(int sig)
 	 */
 }
=20
+#endif
+
 static void loop(const char *pid_file, int idle_in_seconds)
 {
+	struct sigaction sa;
+
 	sigchain_pop(SIGHUP);	/* pushed by sigchain_push_common */
 	sigchain_push(SIGHUP, refresh);
-	sigchain_push(SIGUSR1, do_nothing);
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction =3D prepare_index;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags =3D SA_SIGINFO;
+	sigaction(SIGUSR1, &sa, NULL);
+
 	refresh(0);
 	while (sleep(idle_in_seconds))
 		; /* do nothing, all is handled by signal handlers already */
@@ -245,6 +319,8 @@ int main(int argc, char **argv)
 				       LOCK_DIE_ON_ERROR);
 #ifdef GIT_WINDOWS_NATIVE
 	strbuf_addstr(&sb, "HWND");
+#elif defined(USE_WATCHMAN)
+	strbuf_addch(&sb, 'W');	/* see poke_daemon() */
 #endif
 	strbuf_addf(&sb, "%" PRIuMAX, (uintmax_t) getpid());
 	write_in_full(fd, sb.buf, sb.len);
diff --git a/read-cache.c b/read-cache.c
index 57c5df9..78f5f0e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1405,7 +1405,7 @@ static int read_watchman_ext(struct index_state *=
istate, const void *data,
 	return 0;
 }
=20
-static void write_watchman_ext(struct strbuf *sb, struct index_state* =
istate)
+void write_watchman_ext(struct strbuf *sb, struct index_state* istate)
 {
 	struct ewah_bitmap *bitmap;
 	int i;
@@ -1722,6 +1722,39 @@ static int try_shm(struct index_state *istate)
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
@@ -1842,7 +1875,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	split_index =3D istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
 		post_read_index_from(istate);
-		return ret;
+		goto done;
 	}
=20
 	if (split_index->base)
@@ -1863,6 +1896,10 @@ int read_index_from(struct index_state *istate, =
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
@@ -2164,7 +2201,7 @@ out:
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
