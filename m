From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/32] update-index: new options to enable/disable split index mode
Date: Mon, 28 Apr 2014 17:55:46 +0700
Message-ID: <1398682553-11634-26-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:57:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejF6-0003YT-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbaD1K4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:56:50 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:58068 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbaD1K4q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:56:46 -0400
Received: by mail-pb0-f41.google.com with SMTP id rr13so5738999pbb.28
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NHQsyz1PaYCdRMuZgHHRbkBCeiSQW+m3TqA7tL/NjkA=;
        b=c7LLiDrNRXrE0NQhlBU/GY38Y5nsdAuWMWzfAdWw5QeXfzXSSIUMXmZCSYGTbEfiw+
         IxUZySDCo7Fu5HnmUNA9OJfDW7kRm7dIDqLOJM5ou+4MHZoF880xgH9psobsUWLC9kK5
         JFy9zdRrv7d++14i3I2VvG+gAh6OJXqeYDMlnQIPR9+FSYjhhbi+AGUczV58PiaJBhi0
         viR6JjqrMkj0mWj1fKLYLZ1UtCSgSDrRxyRpT9j2gLuQLoLIONOif9Aa6O5SVkBwXOYp
         6WAd1xtrH/dfLPMl5EJ8FtcgCf9WyyMiW8tlZlDmKmwiG1j35aVSBrdtr5nz5CjRDcyI
         qxtA==
X-Received: by 10.66.66.202 with SMTP id h10mr24765304pat.70.1398682606260;
        Mon, 28 Apr 2014 03:56:46 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id ir10sm34187664pbc.59.2014.04.28.03.56.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:56:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:58:14 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247290>

If you have a large work tree but only make changes in a subset, then
$GIT_DIR/index's size should be stable after a while. If you change
branches that touch something else, $GIT_DIR/index's size may grow
large that it becomes as slow as the unified index. Do --split-index
again occasionally to force all changes back to the shared index and
keep $GIT_DIR/index small.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-update-index.txt | 11 +++++++
 builtin/update-index.c             | 18 ++++++++++
 cache.h                            |  1 +
 read-cache.c                       | 67 ++++++++++++++++++++++++++++++=
++++----
 split-index.c                      | 23 +++++++++++++
 5 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index d6de4a0..dfc09d9 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -161,6 +161,17 @@ may not support it yet.
 	Only meaningful with `--stdin` or `--index-info`; paths are
 	separated with NUL character instead of LF.
=20
+--split-index::
+--no-split-index::
+	Enable or disable split index mode. If enabled, the index is
+	split into two files, $GIT_DIR/index and $GIT_DIR/sharedindex.<SHA-1>=
=2E
+	Changes are accumulated in $GIT_DIR/index while the shared
+	index file contains all index entries stays unchanged. If
+	split-index mode is already enabled and `--split-index` is
+	given again, all changes in $GIT_DIR/index are pushed back to
+	the shared index file. This mode is designed for very large
+	indexes that take a signficant amount of time to read or write.
+
 \--::
 	Do not interpret any more arguments as options.
=20
diff --git a/builtin/update-index.c b/builtin/update-index.c
index f7a19c4..b0503f4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -13,6 +13,7 @@
 #include "parse-options.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "split-index.h"
=20
 /*
  * Default to not allowing changes to the list of files. The
@@ -742,6 +743,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 	char set_executable_bit =3D 0;
 	struct refresh_params refresh_args =3D {0, &has_errors};
 	int lock_error =3D 0;
+	int split_index =3D -1;
 	struct lock_file *lock_file;
 	struct parse_opt_ctx_t ctx;
 	int parseopt_state =3D PARSE_OPT_UNKNOWN;
@@ -824,6 +826,8 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			resolve_undo_clear_callback},
 		OPT_INTEGER(0, "index-version", &preferred_index_format,
 			N_("write index in this format")),
+		OPT_BOOL(0, "split-index", &split_index,
+			N_("enable or disable split index")),
 		OPT_END()
 	};
=20
@@ -917,6 +921,20 @@ int cmd_update_index(int argc, const char **argv, =
const char *prefix)
 		strbuf_release(&buf);
 	}
=20
+	if (split_index > 0) {
+		init_split_index(&the_index);
+		the_index.cache_changed |=3D SPLIT_INDEX_ORDERED;
+	} else if (!split_index && the_index.split_index) {
+		/*
+		 * can't discard_split_index(&the_index); because that
+		 * will destroy split_index->base->cache[], which may
+		 * be shared with the_index.cache[]. So yeah we're
+		 * leaking a bit here.
+		 */
+		the_index.split_index =3D NULL;
+		the_index.cache_changed |=3D SOMETHING_CHANGED;
+	}
+
 	if (active_cache_changed) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
diff --git a/cache.h b/cache.h
index 604328b..42cdfe6 100644
--- a/cache.h
+++ b/cache.h
@@ -278,6 +278,7 @@ static inline unsigned int canon_mode(unsigned int =
mode)
 #define SOMETHING_CHANGED	(1 << 3) /* unclassified changes go here */
 #define RESOLVE_UNDO_CHANGED	(1 << 4)
 #define CACHE_TREE_CHANGED	(1 << 5)
+#define SPLIT_INDEX_ORDERED	(1 << 6)
=20
 struct split_index;
 struct index_state {
diff --git a/read-cache.c b/read-cache.c
index 81835a6..a6c9407 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -15,6 +15,7 @@
 #include "strbuf.h"
 #include "varint.h"
 #include "split-index.h"
+#include "sigchain.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -39,7 +40,8 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce,
=20
 /* changes that can be kept in $GIT_DIR/index (basically all extension=
s) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
-		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED)
+		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
+		 SPLIT_INDEX_ORDERED)
=20
 struct index_state the_index;
 static const char *alternate_index_output;
@@ -1860,7 +1862,8 @@ void update_index_if_able(struct index_state *ist=
ate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
=20
-static int do_write_index(struct index_state *istate, int newfd)
+static int do_write_index(struct index_state *istate, int newfd,
+			  int strip_extensions)
 {
 	git_SHA_CTX c;
 	struct cache_header hdr;
@@ -1923,7 +1926,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd)
 	strbuf_release(&previous_name_buf);
=20
 	/* Write extension data here */
-	if (istate->split_index) {
+	if (!strip_extensions && istate->split_index) {
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		err =3D write_link_extension(&sb, istate) < 0 ||
@@ -1934,7 +1937,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd)
 		if (err)
 			return -1;
 	}
-	if (istate->cache_tree) {
+	if (!strip_extensions && istate->cache_tree) {
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		cache_tree_write(&sb, istate->cache_tree);
@@ -1944,7 +1947,7 @@ static int do_write_index(struct index_state *ist=
ate, int newfd)
 		if (err)
 			return -1;
 	}
-	if (istate->resolve_undo) {
+	if (!strip_extensions && istate->resolve_undo) {
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		resolve_undo_write(&sb, istate->resolve_undo);
@@ -1985,7 +1988,7 @@ static int commit_locked_index(struct lock_file *=
lk)
 static int do_write_locked_index(struct index_state *istate, struct lo=
ck_file *lock,
 				 unsigned flags)
 {
-	int ret =3D do_write_index(istate, lock->fd);
+	int ret =3D do_write_index(istate, lock->fd, 0);
 	if (ret)
 		return ret;
 	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=3D
@@ -2009,6 +2012,52 @@ static int write_split_index(struct index_state =
*istate,
 	return ret;
 }
=20
+static char *temporary_sharedindex;
+
+static void remove_temporary_sharedindex(void)
+{
+	if (temporary_sharedindex) {
+		unlink_or_warn(temporary_sharedindex);
+		free(temporary_sharedindex);
+		temporary_sharedindex =3D NULL;
+	}
+}
+
+static void remove_temporary_sharedindex_on_signal(int signo)
+{
+	remove_temporary_sharedindex();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+static int write_shared_index(struct index_state *istate)
+{
+	struct split_index *si =3D istate->split_index;
+	static int installed_handler;
+	int fd, ret;
+
+	temporary_sharedindex =3D git_pathdup("sharedindex_XXXXXX");
+	fd =3D xmkstemp(temporary_sharedindex);
+	if (!installed_handler) {
+		atexit(remove_temporary_sharedindex);
+		sigchain_push_common(remove_temporary_sharedindex_on_signal);
+	}
+	move_cache_to_base_index(istate);
+	ret =3D do_write_index(si->base, fd, 1);
+	close(fd);
+	if (ret) {
+		remove_temporary_sharedindex();
+		return ret;
+	}
+	ret =3D rename(temporary_sharedindex,
+		     git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
+	free(temporary_sharedindex);
+	temporary_sharedindex =3D NULL;
+	if (!ret)
+		hashcpy(si->base_sha1, si->base->sha1);
+	return ret;
+}
+
 int write_locked_index(struct index_state *istate, struct lock_file *l=
ock,
 		       unsigned flags)
 {
@@ -2020,6 +2069,12 @@ int write_locked_index(struct index_state *istat=
e, struct lock_file *lock,
 		return do_write_locked_index(istate, lock, flags);
 	}
=20
+	if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
+		int ret =3D write_shared_index(istate);
+		if (ret)
+			return ret;
+	}
+
 	return write_split_index(istate, lock, flags);
 }
=20
diff --git a/split-index.c b/split-index.c
index ee3246f..21485e2 100644
--- a/split-index.c
+++ b/split-index.c
@@ -74,6 +74,29 @@ static void mark_base_index_entries(struct index_sta=
te *base)
 		base->cache[i]->index =3D i + 1;
 }
=20
+void move_cache_to_base_index(struct index_state *istate)
+{
+	struct split_index *si =3D istate->split_index;
+	int i;
+
+	/*
+	 * do not delete old si->base, its index entries may be shared
+	 * with istate->cache[]. Accept a bit of leaking here because
+	 * this code is only used by short-lived update-index.
+	 */
+	si->base =3D xcalloc(1, sizeof(*si->base));
+	si->base->version =3D istate->version;
+	/* zero timestamp disables racy test in ce_write_index() */
+	si->base->timestamp =3D istate->timestamp;
+	ALLOC_GROW(si->base->cache, istate->cache_nr, si->base->cache_alloc);
+	si->base->cache_nr =3D istate->cache_nr;
+	memcpy(si->base->cache, istate->cache,
+	       sizeof(*istate->cache) * istate->cache_nr);
+	mark_base_index_entries(si->base);
+	for (i =3D 0; i < si->base->cache_nr; i++)
+		si->base->cache[i]->ce_flags &=3D ~CE_UPDATE_IN_BASE;
+}
+
 static void mark_entry_for_delete(size_t pos, void *data)
 {
 	struct index_state *istate =3D data;
--=20
1.9.1.346.ga2b5940
