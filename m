Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4912EC433F5
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 11:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbiDJLYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Apr 2022 07:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbiDJLYL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 07:24:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B0365D26
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:22:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso1677371wml.1
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gz4VKhxmT3HuHdMu4Ask1XtrJqIICVvrPR1Z949kDCc=;
        b=eGhTmfkxMMU/l4DH6/SAXrmt3glfin/E0t5sZJeNXWpyMX3goZ8C7uKyqsPnPcf9Qm
         WuIS/7CPZKixOeGeqA50CPr/5NLrRPHrfN/6MVcQ15WuzdB5Kz8zkYT9Gvuq8pqqPHTw
         KVhpdJt8mY1rijaCDoj8Uzi5cpC37DECUuA7A6nWEDacGayJHdaD9J+JLmP427g1wLk/
         sVa9KAezpoDkiuHVH5xi4oRn/7YDnwv4WlnRj2LWcQIOLlA3lwnIKl1gtXZX0EkOC6Xf
         7NwwUWmPbFjYt697p+pUwLaJXSw3BJBSZrX73LKnQ1/8IJZc4YRDdddIX9JMtw5a2C5f
         4Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gz4VKhxmT3HuHdMu4Ask1XtrJqIICVvrPR1Z949kDCc=;
        b=OFBLeF01tw4NcrjSqu9UGddN1sYvj3O97AbpfCgfblwSGjf2gUkTZ+TODahDLMGidI
         ezVy2PHnmP8Wr9wq9za08+2RspenEzqIv3e7Fx8VoLRTCH9SmIDFWehkLsone62jO75b
         yrUrZCit3nnSXb9OfJsXzlUspT3CE9/do+Ant9dLYvZOR/x7ZzGDR4yO3JtEaZbAAbyu
         vLliQNPBU4F5DDnZOUbOzu6p69P6DyiLpqNwiwHvfbv1v4+uFdAo8uz2tkhXtY0CMg2m
         mP9CLyTnXZ7KHjalxEmqnB0v4Uv7pf+9EU30G5Rga9VexlCAF1EhRJDi5xcg4J6DAc40
         RAgg==
X-Gm-Message-State: AOAM532GcNhcanS45SrEJ/KgT9eblRhkwp2LCvAfKB6Rm84o11BBKCyn
        1QXDvxUevclAqAMYwkBcR2s8KHJeXOY=
X-Google-Smtp-Source: ABdhPJwkZL+fKG/3dhTRE8dTPUJXb9NxvGCN0HWxAlgLOmhBlpJ64/aLHP7IMVo/Yy/vs5U9LUYqZA==
X-Received: by 2002:a05:600c:308:b0:38e:98d3:65e2 with SMTP id q8-20020a05600c030800b0038e98d365e2mr13994590wmd.92.1649589718913;
        Sun, 10 Apr 2022 04:21:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a18:7100:c718:bf46:5915:85be])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm19149452wmj.18.2022.04.10.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 04:21:58 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, mhagger@alum.mit.edu,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [RFC PATCH 3/6] dir-iterator: refactor dir_iterator_advance()
Date:   Sun, 10 Apr 2022 14:18:49 +0300
Message-Id: <20220410111852.2097418-4-kioplato@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410111852.2097418-1-kioplato@gmail.com>
References: <20220410111852.2097418-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify dir_iterator_advance by switch from iterative to recursive
implementation. In each recursive step one action is performed.

This makes dir-iterator easier to work with, understand and introduce
new functionality.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 dir-iterator.c          | 225 ++++++++++++++++++++++++++--------------
 t/t0066-dir-iterator.sh |   4 +-
 2 files changed, 148 insertions(+), 81 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index b17e9f970a..0f9ed95958 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -7,8 +7,7 @@ struct dir_iterator_level {
 	DIR *dir;
 
 	/*
-	 * The length of the directory part of path at this level
-	 * (including a trailing '/'):
+	 * The length of the directory part of path at this level.
 	 */
 	size_t prefix_len;
 };
@@ -34,8 +33,9 @@ struct dir_iterator_int {
 	size_t levels_alloc;
 
 	/*
-	 * A stack of levels. levels[0] is the uppermost directory
-	 * that will be included in this iteration.
+	 * A stack of levels. levels[0] is the root directory.
+	 * It won't be included in the iteration, but iteration will happen
+	 * inside it's subdirectories.
 	 */
 	struct dir_iterator_level *levels;
 
@@ -45,34 +45,53 @@ struct dir_iterator_int {
 
 /*
  * Push a level in the iter stack and initialize it with information from
- * the directory pointed by iter->base->path. It is assumed that this
- * strbuf points to a valid directory path. Return 0 on success and -1
- * otherwise, setting errno accordingly and leaving the stack unchanged.
+ * the directory pointed by iter->base->path. Don't open the directory.
+ *
+ * Return 1 on success.
+ * Return 0 when `iter->base->path` isn't a directory.
  */
 static int push_level(struct dir_iterator_int *iter)
 {
 	struct dir_iterator_level *level;
 
+	if (!S_ISDIR(iter->base.st.st_mode)) return 0;
+
 	ALLOC_GROW(iter->levels, iter->levels_nr + 1, iter->levels_alloc);
 	level = &iter->levels[iter->levels_nr++];
 
-	if (!is_dir_sep(iter->base.path.buf[iter->base.path.len - 1]))
-		strbuf_addch(&iter->base.path, '/');
+	level->dir = NULL;
+
 	level->prefix_len = iter->base.path.len;
 
-	level->dir = opendir(iter->base.path.buf);
-	if (!level->dir) {
-		int saved_errno = errno;
-		if (errno != ENOENT) {
-			warning_errno("error opening directory '%s'",
-				      iter->base.path.buf);
-		}
-		iter->levels_nr--;
+	return 1;
+}
+
+/*
+ * Activate most recent pushed level.
+ *
+ * Return 1 on success.
+ * Return -1 on failure when errno == ENOENT, leaving the stack unchanged.
+ * Return -2 on failure when errno != ENOENT, leaving the stack unchanged.
+ */
+static int activate_level(struct dir_iterator_int *iter)
+{
+	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
+	int saved_errno;
+
+	if (level->dir)
+		return 1;
+
+	if ((level->dir = opendir(iter->base.path.buf)) != NULL)
+		return 1;
+
+	saved_errno = errno;
+	if (errno != ENOENT) {
+		warning_errno("error opening directory '%s'", iter->base.path.buf);
 		errno = saved_errno;
-		return -1;
+		return -2;
 	}
-
-	return 0;
+	errno = saved_errno;
+	return -1;
 }
 
 /*
@@ -81,12 +100,10 @@ static int push_level(struct dir_iterator_int *iter)
  */
 static int pop_level(struct dir_iterator_int *iter)
 {
-	struct dir_iterator_level *level =
-		&iter->levels[iter->levels_nr - 1];
+	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
 
 	if (level->dir && closedir(level->dir))
-		warning_errno("error closing directory '%s'",
-			      iter->base.path.buf);
+		warning_errno("error closing directory '%s'", iter->base.path.buf);
 	level->dir = NULL;
 
 	return --iter->levels_nr;
@@ -94,82 +111,121 @@ static int pop_level(struct dir_iterator_int *iter)
 
 /*
  * Populate iter->base with the necessary information on the next iteration
- * entry, represented by the given dirent de. Return 0 on success and -1
- * otherwise, setting errno accordingly.
+ * entry, represented by the given relative path to the lowermost directory,
+ * d_name.
+ *
+ * Return values:
+ * 1 on successful exposure of the provided entry.
+ * -1 on failed exposure because entry does not exist.
+ * -2 on failed exposure because of error other than ENOENT.
  */
-static int prepare_next_entry_data(struct dir_iterator_int *iter,
-				   struct dirent *de)
+static int expose_entry(struct dir_iterator_int *iter, char *d_name)
 {
-	int err, saved_errno;
+	int stat_err;
 
-	strbuf_addstr(&iter->base.path, de->d_name);
-	/*
-	 * We have to reset these because the path strbuf might have
-	 * been realloc()ed at the previous strbuf_addstr().
-	 */
-	iter->base.relative_path = iter->base.path.buf +
-				   iter->levels[0].prefix_len;
-	iter->base.basename = iter->base.path.buf +
-			      iter->levels[iter->levels_nr - 1].prefix_len;
+	strbuf_addch(&iter->base.path, '/');
+	strbuf_addstr(&iter->base.path, d_name);
 
 	if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
-		err = stat(iter->base.path.buf, &iter->base.st);
+		stat_err = stat(iter->base.path.buf, &iter->base.st);
 	else
-		err = lstat(iter->base.path.buf, &iter->base.st);
+		stat_err = lstat(iter->base.path.buf, &iter->base.st);
 
-	saved_errno = errno;
-	if (err && errno != ENOENT)
+	if (stat_err && errno != ENOENT) {
 		warning_errno("failed to stat '%s'", iter->base.path.buf);
+		return -2;  // Stat failed not with ENOENT.
+	} else if (stat_err && errno == ENOENT)
+		return -1;  // Stat failed with ENOENT.
 
-	errno = saved_errno;
-	return err;
+	/*
+	 * We have to reset relative path and basename because the path strbuf
+	 * might have been realloc()'ed at the previous strbuf_addstr().
+	 */
+
+	iter->base.relative_path =
+		iter->base.path.buf + iter->levels[0].prefix_len + 1;
+	iter->base.basename =
+		iter->base.path.buf + iter->levels[iter->levels_nr - 1].prefix_len + 1;
+
+	return 1;
 }
 
 int dir_iterator_advance(struct dir_iterator *dir_iterator)
 {
-	struct dir_iterator_int *iter =
-		(struct dir_iterator_int *)dir_iterator;
-
-	if (S_ISDIR(iter->base.st.st_mode) && push_level(iter)) {
-		if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
-			goto error_out;
-		if (iter->levels_nr == 0)
-			goto error_out;
+	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
+	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
+
+	struct dirent *dir_entry = NULL;
+
+	int expose_err, activate_err;
+
+	/* For shorter code width-wise, more readable */
+	unsigned int PEDANTIC = iter->flags & DIR_ITERATOR_PEDANTIC;
+
+	/*
+	 * Attempt to open the directory of the last level if not opened yet.
+	 *
+	 * Remember that we ignore ENOENT errors so that the user of this API
+	 * can remove entries between calls to `dir_iterator_advance()`.
+	 * We care for errors other than ENOENT only when PEDANTIC is enabled.
+	 */
+
+	activate_err = activate_level(iter);
+
+	if (activate_err == -2 && PEDANTIC)
+		goto error_out;
+	else if (activate_err == -2 || activate_err == -1) {
+		/*
+		 * We activate the root level at `dir_iterator_begin()`.
+		 * Therefore, there isn't any case to run out of levels.
+		 */
+
+		--iter->levels_nr;
+
+		return dir_iterator_advance(dir_iterator);
 	}
 
-	/* Loop until we find an entry that we can give back to the caller. */
-	while (1) {
-		struct dirent *de;
-		struct dir_iterator_level *level =
-			&iter->levels[iter->levels_nr - 1];
+	strbuf_setlen(&iter->base.path, level->prefix_len);
+
+	errno = 0;
+	dir_entry = readdir(level->dir);
 
-		strbuf_setlen(&iter->base.path, level->prefix_len);
-		errno = 0;
-		de = readdir(level->dir);
-
-		if (!de) {
-			if (errno) {
-				warning_errno("error reading directory '%s'",
-					      iter->base.path.buf);
-				if (iter->flags & DIR_ITERATOR_PEDANTIC)
-					goto error_out;
-			} else if (pop_level(iter) == 0) {
+	if (dir_entry == NULL) {
+		if (errno) {
+			warning_errno("errno reading dir '%s'", iter->base.path.buf);
+			if (iter->flags & DIR_ITERATOR_PEDANTIC) goto error_out;
+			return dir_iterator_advance(dir_iterator);
+		} else {
+			/*
+			 * Current directory has been iterated through.
+			 */
+
+			if (pop_level(iter) == 0)
 				return dir_iterator_abort(dir_iterator);
-			}
-			continue;
+
+			return dir_iterator_advance(dir_iterator);
 		}
+	}
 
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
+	if (is_dot_or_dotdot(dir_entry->d_name))
+		return dir_iterator_advance(dir_iterator);
 
-		if (prepare_next_entry_data(iter, de)) {
-			if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
-				goto error_out;
-			continue;
-		}
+	/*
+	 * Successfully read entry from current directory level.
+	 */
 
-		return ITER_OK;
-	}
+	expose_err = expose_entry(iter, dir_entry->d_name);
+
+	if (expose_err == -2 && PEDANTIC)
+		goto error_out;
+
+	if (expose_err == 1)
+		push_level(iter);
+
+	if (expose_err == -1)
+		return dir_iterator_advance(dir_iterator);
+
+	return ITER_OK;
 
 error_out:
 	dir_iterator_abort(dir_iterator);
@@ -207,6 +263,7 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
 
 	strbuf_init(&iter->base.path, PATH_MAX);
 	strbuf_addstr(&iter->base.path, path);
+	strbuf_trim_trailing_dir_sep(&iter->base.path);
 
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
 	iter->levels_nr = 0;
@@ -226,6 +283,16 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
 		goto error_out;
 	}
 
+	if (push_level(iter) != 1) {
+		saved_errno = ENOTDIR;
+		goto error_out;
+	}
+
+	if (activate_level(iter) != 1) {
+		saved_errno = errno;
+		goto error_out;
+	}
+
 	return dir_iterator;
 
 error_out:
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 0a98dd54ba..2437ab21c4 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -285,7 +285,7 @@ test_expect_success 'iteration of dir w/ complex structure w/o symlinks' '
 '
 
 test_expect_success POSIXPERM,SANITY \
-'dir_iterator_advance() should fail on root dir w/o perms' '
+'dir_iterator_begin() should fail on root dir w/o perms' '
 
 	mkdir -p dir12/a &&
 	>dir12/a/b &&
@@ -293,7 +293,7 @@ test_expect_success POSIXPERM,SANITY \
 
 
 	cat >expected-no-permissions-out <<-EOF &&
-	dir_iterator_advance failure
+	dir_iterator_begin failure: ESOMETHINGELSE
 	EOF
 
 	test_must_fail test-tool dir-iterator ./dir12 >actual-out &&
-- 
2.35.1

