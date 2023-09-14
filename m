Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95DEEEAA77
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 21:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjINVq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINVqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 17:46:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22A2270A
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 14:46:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63927256A6;
        Thu, 14 Sep 2023 17:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=G
        wiWw9M7gtPW3xBen4rMxdb/356HgslYSguRcYC+UrQ=; b=QbwMgTE5yREaqg9lr
        a6P6au6QaEREH6zNqbCy+lSv/KngvLZPO8Wk0tD+ujM5bnIrzkoFrmzjHELenyDT
        xPe5Zr5HYyUZcynLBYm/Qi9paXgk2WuXSUkpkJxqCpNm2OT2ys+HodFb/yik2zXw
        9dSgY4nx6s4qCowER6F38jDCC0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C5CE256A5;
        Thu, 14 Sep 2023 17:46:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E891F256A4;
        Thu, 14 Sep 2023 17:46:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Josip Sokcevic <sokcevic@google.com>
Subject: [PATCH] cache: add fake_lstat()
Date:   Thu, 14 Sep 2023 14:46:46 -0700
Message-ID: <xmqqcyykig1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 348FEDFE-5348-11EE-957A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At times, we may already know that a path represented by a
cache_entry ce has no changes via some out-of-line means, like
fsmonitor, and yet need the control to go through a codepath that
requires us to have "struct stat" obtained by lstat() on the path,
for various purposes (e.g. "ie_match_stat()" wants cached stat-info
is still current wrt "struct stat", "diff" wants to know st_mode).

The callers of lstat() on a tracked file, when its cache_entry knows
it is up-to-date, can instead call this helper to pretend that it
called lstat() by faking the "struct stat" information.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just setting the .st_mode member in check_removed() relies on
   the assumption that other members of "struct stat" are never
   looked at a bit too much.  We could use something like this to
   bypass calling lstat() and instead populate from the data we have
   in cache_entry.

 builtin/ls-files.c |  5 ++++-
 read-cache-ll.h    |  8 ++++++++
 read-cache.c       | 27 +++++++++++++++++++++++++++
 statinfo.c         | 27 +++++++++++++++++++++++++++
 statinfo.h         |  8 ++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git c/builtin/ls-files.c w/builtin/ls-files.c
index a0229c3277..7031ffcb0a 100644
--- c/builtin/ls-files.c
+++ w/builtin/ls-files.c
@@ -450,7 +450,10 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			continue;
 		if (ce_skip_worktree(ce))
 			continue;
-		stat_err = lstat(fullname.buf, &st);
+		if (!(ce->ce_flags & CE_FSMONITOR_VALID))
+			stat_err = lstat(fullname.buf, &st);
+		else
+			stat_err = fake_lstat(ce, &st);
 		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
 			error_errno("cannot lstat '%s'", fullname.buf);
 		if (stat_err && show_deleted) {
diff --git c/read-cache-ll.h w/read-cache-ll.h
index 9a1a7edc5a..2a50a784f0 100644
--- c/read-cache-ll.h
+++ w/read-cache-ll.h
@@ -436,6 +436,14 @@ int match_stat_data_racy(const struct index_state *istate,
 
 void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, struct stat *st);
 
+/*
+ * Fill members of st by members of sd enough to convince match_stat()
+ * to consider that they match.  It should be usable as a replacement
+ * for lstat() for a tracked path that is known to be up-to-date via
+ * some out-of-line means (like fsmonitor).
+ */
+int fake_lstat(const struct cache_entry *ce, struct stat *st);
+
 #define REFRESH_REALLY                   (1 << 0) /* ignore_valid */
 #define REFRESH_UNMERGED                 (1 << 1) /* allow unmerged */
 #define REFRESH_QUIET                    (1 << 2) /* be quiet about it */
diff --git c/read-cache.c w/read-cache.c
index 080bd39713..eb750e2e49 100644
--- c/read-cache.c
+++ w/read-cache.c
@@ -197,6 +197,33 @@ void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, st
 	}
 }
 
+static unsigned int st_mode_from_ce(const struct cache_entry *ce)
+{
+	extern int trust_executable_bit, has_symlinks;
+
+	switch (ce->ce_mode & S_IFMT) {
+	case S_IFLNK:
+		return has_symlinks ? S_IFLNK : (S_IFREG | 0644);
+	case S_IFREG:
+		return (ce->ce_mode & (trust_executable_bit ? 0755 : 0644)) | S_IFREG;
+	case S_IFGITLINK:
+		return S_IFDIR | 0755;
+	case S_IFDIR:
+		return ce->ce_mode;
+	default:
+		BUG("unsupported ce_mode: %o", ce->ce_mode);
+	}
+}
+
+int fake_lstat(const struct cache_entry *ce, struct stat *st)
+{
+	fake_lstat_data(&ce->ce_stat_data, st);
+	st->st_mode = st_mode_from_ce(ce);
+
+	/* always succeed as lstat() replacement */
+	return 0;
+}
+
 static int ce_compare_data(struct index_state *istate,
 			   const struct cache_entry *ce,
 			   struct stat *st)
diff --git c/statinfo.c w/statinfo.c
index 17bb8966c3..45156109de 100644
--- c/statinfo.c
+++ w/statinfo.c
@@ -15,6 +15,33 @@ void fill_stat_data(struct stat_data *sd, struct stat *st)
 	sd->sd_size = st->st_size;
 }
 
+static void set_times(struct stat *st, const struct stat_data *sd)
+{
+	st->st_ctime = sd->sd_ctime.sec;
+	st->st_mtime = sd->sd_mtime.sec;
+#ifdef NO_NSEC
+	; /* nothing */
+#else
+#ifdef USE_ST_TIMESPEC
+	st->st_ctimespec.tv_nsec = sd->sd_ctime.nsec;
+	st->st_mtimespec.tv_nsec = sd->sd_mtime.nsec;
+#else
+	st->st_ctim.tv_nsec = sd->sd_ctime.nsec;
+	st->st_mtim.tv_nsec = sd->sd_mtime.nsec;
+#endif
+#endif
+}
+
+void fake_lstat_data(const struct stat_data *sd, struct stat *st)
+{
+	set_times(st, sd);
+	st->st_dev = sd->sd_dev;
+	st->st_ino = sd->sd_ino;
+	st->st_uid = sd->sd_uid;
+	st->st_gid = sd->sd_gid;
+	st->st_size = sd->sd_size;
+}
+
 int match_stat_data(const struct stat_data *sd, struct stat *st)
 {
 	int changed = 0;
diff --git c/statinfo.h w/statinfo.h
index 700f502ac0..5b21a30f90 100644
--- c/statinfo.h
+++ w/statinfo.h
@@ -46,6 +46,14 @@ struct stat_validity {
  */
 void fill_stat_data(struct stat_data *sd, struct stat *st);
 
+/*
+ * The inverse of the above.  When we know the cache_entry that
+ * contains sd is up-to-date, but still need to pretend we called
+ * lstat() to learn that fact, this function fills "st" enough to
+ * fool ie_match_stat().
+ */
+void fake_lstat_data(const struct stat_data *sd, struct stat *st);
+
 /*
  * Return 0 if st is consistent with a file not having been changed
  * since sd was filled.  If there are differences, return a
