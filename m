Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323FF1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 19:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440132AbfJRTqF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 15:46:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfJRTqD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 15:46:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC709307846D;
        Fri, 18 Oct 2019 19:46:02 +0000 (UTC)
Received: from trillian.uncooperative.org.com (dhcp-10-20-1-15.bss.redhat.com [10.20.1.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E3EB5C1B5;
        Fri, 18 Oct 2019 19:46:02 +0000 (UTC)
From:   Peter Jones <pjones@redhat.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH v2 2/4] libgit: Expose more worktree functionality.
Date:   Fri, 18 Oct 2019 15:45:40 -0400
Message-Id: <20191018194542.1316981-2-pjones@redhat.com>
In-Reply-To: <20191018194542.1316981-1-pjones@redhat.com>
References: <20191018194317.wvqphshpkfskvkyh@redhat.com>
 <20191018194542.1316981-1-pjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 18 Oct 2019 19:46:02 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add delete_worktrees_dir_if_empty() and prune_worktree() to the public
API, so they can be used from more places.  Also add a new function,
prune_worktree_if_missing(), which prunes unlocked worktrees if they
aren't present on the filesystem.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 builtin/worktree.c | 73 +-------------------------------------
 worktree.c         | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h         | 19 ++++++++++
 3 files changed, 108 insertions(+), 72 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 86305cc1fe1..8ff37309be9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -62,77 +62,6 @@ static int delete_git_dir(const char *id)
 	return ret;
 }
 
-static void delete_worktrees_dir_if_empty(void)
-{
-	rmdir(git_path("worktrees")); /* ignore failed removal */
-}
-
-static int prune_worktree(const char *id, struct strbuf *reason)
-{
-	struct stat st;
-	char *path;
-	int fd;
-	size_t len;
-	ssize_t read_result;
-
-	if (!is_directory(git_path("worktrees/%s", id))) {
-		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"), id);
-		return 1;
-	}
-	if (file_exists(git_path("worktrees/%s/locked", id)))
-		return 0;
-	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
-		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file does not exist"), id);
-		return 1;
-	}
-	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
-	if (fd < 0) {
-		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
-			    id, strerror(errno));
-		return 1;
-	}
-	len = xsize_t(st.st_size);
-	path = xmallocz(len);
-
-	read_result = read_in_full(fd, path, len);
-	if (read_result < 0) {
-		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
-			    id, strerror(errno));
-		close(fd);
-		free(path);
-		return 1;
-	}
-	close(fd);
-
-	if (read_result != len) {
-		strbuf_addf(reason,
-			    _("Removing worktrees/%s: short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
-			    id, (uintmax_t)len, (uintmax_t)read_result);
-		free(path);
-		return 1;
-	}
-	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
-		len--;
-	if (!len) {
-		strbuf_addf(reason, _("Removing worktrees/%s: invalid gitdir file"), id);
-		free(path);
-		return 1;
-	}
-	path[len] = '\0';
-	if (!file_exists(path)) {
-		free(path);
-		if (stat(git_path("worktrees/%s/index", id), &st) ||
-		    st.st_mtime <= expire) {
-			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
-			return 1;
-		} else {
-			return 0;
-		}
-	}
-	free(path);
-	return 0;
-}
-
 static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
@@ -144,7 +73,7 @@ static void prune_worktrees(void)
 		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
-		if (!prune_worktree(d->d_name, &reason))
+		if (!prune_worktree(d->d_name, &reason, expire))
 			continue;
 		if (show_only || verbose)
 			printf("%s\n", reason.buf);
diff --git a/worktree.c b/worktree.c
index 4924805c389..08454a4e65d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -608,3 +608,91 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	free_worktrees(worktrees);
 	return ret;
 }
+
+void delete_worktrees_dir_if_empty(void)
+{
+	rmdir(git_path("worktrees")); /* ignore failed removal */
+}
+
+int prune_worktree(const char *id, struct strbuf *reason, timestamp_t expire)
+{
+	struct stat st;
+	char *path;
+	int fd;
+	size_t len;
+	ssize_t read_result;
+
+	if (!is_directory(git_path("worktrees/%s", id))) {
+		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"), id);
+		return 1;
+	}
+	if (file_exists(git_path("worktrees/%s/locked", id)))
+		return 0;
+	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
+		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file does not exist"), id);
+		return 1;
+	}
+	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
+	if (fd < 0) {
+		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
+			    id, strerror(errno));
+		return 1;
+	}
+	len = xsize_t(st.st_size);
+	path = xmallocz(len);
+
+	read_result = read_in_full(fd, path, len);
+	if (read_result < 0) {
+		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
+			    id, strerror(errno));
+		close(fd);
+		free(path);
+		return 1;
+	}
+	close(fd);
+
+	if (read_result != len) {
+		strbuf_addf(reason,
+			    _("Removing worktrees/%s: short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
+			    id, (uintmax_t)len, (uintmax_t)read_result);
+		free(path);
+		return 1;
+	}
+	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
+		len--;
+	if (!len) {
+		strbuf_addf(reason, _("Removing worktrees/%s: invalid gitdir file"), id);
+		free(path);
+		return 1;
+	}
+	path[len] = '\0';
+	if (!file_exists(path)) {
+		free(path);
+		if (stat(git_path("worktrees/%s/index", id), &st) ||
+		    st.st_mtime <= expire) {
+			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
+			return 1;
+		} else {
+			return 0;
+		}
+	}
+	free(path);
+	return 0;
+}
+
+int prune_worktree_if_missing(const struct worktree *wt)
+{
+	struct strbuf reason = STRBUF_INIT;
+	int ret;
+
+	if (is_worktree_locked(wt) ||
+	    access(wt->path, F_OK) >= 0 ||
+	    (errno != ENOENT && errno == ENOTDIR)) {
+		errno = EEXIST;
+		return -1;
+	}
+
+	strbuf_addf(&reason, _("Removing worktrees/%s: worktree directory is not present"), wt->id);
+	ret = prune_worktree(wt->id, &reason, TIME_MAX);
+	return ret;
+}
diff --git a/worktree.h b/worktree.h
index 5ff16c414b5..636bbb1c449 100644
--- a/worktree.h
+++ b/worktree.h
@@ -137,4 +137,23 @@ void strbuf_worktree_ref(const struct worktree *wt,
 const char *worktree_ref(const struct worktree *wt,
 			 const char *refname);
 
+/*
+ * Clean up the 'worktrees' directory, if necessary.
+ */
+void delete_worktrees_dir_if_empty(void);
+
+/*
+ * Prune a worktree if it's older than expire.
+ * Returns 0 on success, < 0 on failure.
+ */
+int prune_worktree(const char *id, struct strbuf *reason, timestamp_t expire);
+
+/*
+ * Prune a worktree if it is not locked and is no longer present at the
+ * checked out location.
+ * Returns < 0 if the checkout is there, if the worktree is locked, or if
+ * pruning fails.
+ */
+int prune_worktree_if_missing(const struct worktree *wt);
+
 #endif
-- 
2.23.0

