From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] index-helper: use watchman to avoid refreshing index with lstat()
Date: Sun,  1 Nov 2015 14:55:45 +0100
Message-ID: <1446386146-10438-5-git-send-email-pclouds@gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:56:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zst7N-0002MO-17
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbbKAN4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:56:16 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37406 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbKAN4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:56:11 -0500
Received: by wmff134 with SMTP id f134so41698902wmf.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8fKtCl5/B41g1agLYzJcXoogkH1hjD1Cjs2Y3W5cnDU=;
        b=l+cXEeA0nkw0U5oH4VOoUSpDjFmTPDJBIQPYUiufPQ4yJcSssKRnjMIpZdodn1tm3G
         sFt7cYrNQ+kXo0fjSsX7dZyq8mk9I42m32JCY/9sfKBe/o7fqOqbsdc83go7jSu7jMph
         bsl0Lur2oMeoXjs51dqBfEwsaqggYYIFPoLD/KILq41qbRxkBoP/xGE+vv7+7UssjA8p
         VaL2PVPhv0/UioLgUEqpNw9wKY674dxxTLozHzLQd+EYAguevOvmgmthwT6y0pBk1l/g
         wqTuStnBlaJHMECTx92hNdvvP6YJi+EL4csS05K+hAObyWo0T6Vsk6IYTUbZFgkf7bRB
         GiYA==
X-Received: by 10.28.21.134 with SMTP id 128mr8382129wmv.29.1446386169565;
        Sun, 01 Nov 2015 05:56:09 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id bk2sm17185525wjc.3.2015.11.01.05.56.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:56:08 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280633>

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
 Makefile           |  5 ++++
 cache.h            |  2 ++
 index-helper.c     | 84 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 read-cache.c       | 43 ++++++++++++++++++++++++++--
 watchman-support.h |  1 -
 5 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 761acb6..3f5eac8 100644
--- a/Makefile
+++ b/Makefile
@@ -434,6 +434,7 @@ MSGFMT =3D msgfmt
 CURL_CONFIG =3D curl-config
 PTHREAD_LIBS =3D -lpthread
 PTHREAD_CFLAGS =3D
+WATCHMAN_LIBS =3D
 GCOV =3D gcov
=20
 export TCL_PATH TCLTK_PATH
@@ -1392,6 +1393,7 @@ endif
 ifdef USE_WATCHMAN
 	LIB_H +=3D watchman-support.h
 	LIB_OBJS +=3D watchman-support.o
+	WATCHMAN_LIBS =3D -lwatchman
 	BASIC_CFLAGS +=3D -DUSE_WATCHMAN
 endif
=20
@@ -2005,6 +2007,9 @@ git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAG=
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
index 572299c..c04141b 100644
--- a/cache.h
+++ b/cache.h
@@ -518,6 +518,7 @@ extern int daemonize(int *);
=20
 /* Initialize and use the cache information */
 struct lock_file;
+extern int verify_index(const struct index_state *);
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const struct paths=
pec *pathspec);
 extern int do_read_index(struct index_state *istate, const char *path,
@@ -525,6 +526,7 @@ extern int do_read_index(struct index_state *istate=
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
index cf26da7..421887e 100644
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
+	free_watchman_shm(&shm_watchman);
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
index ae33951..1b84538 100644
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
@@ -1678,6 +1678,39 @@ static int try_shm(struct index_state *istate)
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
+	     * No need to clear CE_NO_WATCH set by 'WAMA' on
+	     * disk. Watchman can only set more, not clear any, so
+	     * this is OR mask.
+	     */
+	    read_watchman_ext(istate, shm, length - 20))
+		goto done;
+
+	for (i =3D 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce =3D istate->cache[i];
+		if (ce_stage(ce) || (ce->ce_flags & CE_NO_WATCH))
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
@@ -1797,7 +1830,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	split_index =3D istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
 		check_ce_order(istate);
-		return ret;
+		goto done;
 	}
=20
 	if (split_index->base)
@@ -1818,6 +1851,10 @@ int read_index_from(struct index_state *istate, =
const char *path)
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
 	check_ce_order(istate);
+
+done:
+	if (ret > 0 && istate->from_shm && istate->last_update)
+		refresh_by_watchman(istate);
 	return ret;
 }
=20
@@ -2119,7 +2156,7 @@ out:
 	return 0;
 }
=20
-static int verify_index(const struct index_state *istate)
+int verify_index(const struct index_state *istate)
 {
 	return verify_index_from(istate, get_index_file());
 }
diff --git a/watchman-support.h b/watchman-support.h
index 5610409..ee1ef2c 100644
--- a/watchman-support.h
+++ b/watchman-support.h
@@ -4,5 +4,4 @@
 struct index_state;
 int check_watchman(struct index_state *index);
=20
-
 #endif /* WATCHMAN_SUPPORT_H */
--=20
2.2.0.513.g477eb31
