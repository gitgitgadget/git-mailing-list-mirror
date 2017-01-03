Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214B6209B3
	for <e@80x24.org>; Tue,  3 Jan 2017 19:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757795AbdACTKA (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:10:00 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33908 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757314AbdACTJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:09:58 -0500
Received: by mail-pg0-f41.google.com with SMTP id y62so165651141pgy.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/llV4QddwE65nJuNf4Y4WR0F7S5jgr886A3M+DyjsI=;
        b=G/37UzDPuVrYT7XlU65rCJprr/6nkucgDDKnw+ZKLi9h/LRBWg+xqjBv7kb7rp0iNx
         g4V9MGYVYgyc1hRJBKv93f1qSUqhWdrW2/rZqwnifJ23fIiDpUNLj8u31U/Cg50z+Wku
         iJBbLz3dM8v9C7eqRc+Rt2hiJCpMsA3I2fKTWErZIQHq932pSy2cc4vLBQkaz+sENE9j
         kzC2yR77H/eA9hRX34F/LQBlElfbpcGMqi8zslow9MyHmTYr4CkD3aJPLXJ2RFPD42kn
         fCwyjdvspYauhuQTaGbK3Kefp+jg7xRWXiOyZ1+GeXsxDgDluS02cd73LpfmJ3hcFd00
         OxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/llV4QddwE65nJuNf4Y4WR0F7S5jgr886A3M+DyjsI=;
        b=ckjCDptHKLbNyqTkj71ZokLGPh/qmPgMEEPWBQEhEkYdwPk/nfqIHLcRkJC/Z9KPRA
         IcNM8F7uu+TqW5MINUkgNIpZc0BRe5jXlQML5XnOUJ5RBrFrDKe33SgsD8nQBUxxx5kv
         apSRTzmXPtUxzF7MurN5vrx/cTQg4V2sjuOsXzN0VsqIK/75c8KkW3K31V1dq3yFMjBT
         r+4EXwa50ONbzO8fsFbBtawP4Jjzirae6DiXpaJ6XNLEBBaoQhxpYcapg8g535TxOKRy
         x/hRdzF187zDFrGJ4zzjg5N5av0bSWCDglqfX+9f0qdvpXGoZ0jdIMWY3D0IyAS/3yMP
         PN/Q==
X-Gm-Message-State: AIkVDXJm7BQFA6ShON0WH2eXliUAguDVpwn6riDtLDiKU0ZJ70znLvHatCz4IzjGA65k/m9o
X-Received: by 10.84.217.66 with SMTP id e2mr120383423plj.109.1483470598092;
        Tue, 03 Jan 2017 11:09:58 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id q5sm66947112pgf.45.2017.01.03.11.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 11:09:56 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 1/5] real_path: resolve symlinks by hand
Date:   Tue,  3 Jan 2017 11:09:19 -0800
Message-Id: <20170103190923.11882-2-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103190923.11882-1-bmwill@google.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current implementation of real_path uses chdir() in order to resolve
symlinks.  Unfortunately this isn't thread-safe as chdir() affects a
process as a whole and not just an individual thread.  Instead perform
the symlink resolution by hand so that the calls to chdir() can be
removed, making real_path one step closer to being reentrant.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 abspath.c | 188 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 128 insertions(+), 60 deletions(-)

diff --git a/abspath.c b/abspath.c
index 2825de859..0f34636a8 100644
--- a/abspath.c
+++ b/abspath.c
@@ -11,6 +11,43 @@ int is_directory(const char *path)
 	return (!stat(path, &st) && S_ISDIR(st.st_mode));
 }
 
+/* removes the last path component from 'path' except if 'path' is root */
+static void strip_last_component(struct strbuf *path)
+{
+	size_t offset = offset_1st_component(path->buf);
+	size_t len = path->len;
+
+	/* Find start of the last component */
+	while (offset < len && !is_dir_sep(path->buf[len - 1]))
+		len--;
+	/* Skip sequences of multiple path-separators */
+	while (offset < len && is_dir_sep(path->buf[len - 1]))
+		len--;
+
+	strbuf_setlen(path, len);
+}
+
+/* get (and remove) the next component in 'remaining' and place it in 'next' */
+static void get_next_component(struct strbuf *next, struct strbuf *remaining)
+{
+	char *start = NULL;
+	char *end = NULL;
+
+	strbuf_reset(next);
+
+	/* look for the next component */
+	/* Skip sequences of multiple path-separators */
+	for (start = remaining->buf; is_dir_sep(*start); start++)
+		; /* nothing */
+	/* Find end of the path component */
+	for (end = start; *end && !is_dir_sep(*end); end++)
+		; /* nothing */
+
+	strbuf_add(next, start, end - start);
+	/* remove the component from 'remaining' */
+	strbuf_remove(remaining, 0, end - remaining->buf);
+}
+
 /* We allow "recursive" symbolic links. Only within reason, though. */
 #define MAXDEPTH 5
 
@@ -21,7 +58,6 @@ int is_directory(const char *path)
  * absolute_path().)  The return value is a pointer to a static
  * buffer.
  *
- * The input and all intermediate paths must be shorter than MAX_PATH.
  * The directory part of path (i.e., everything up to the last
  * dir_sep) must denote a valid, existing directory, but the last
  * component need not exist.  If die_on_error is set, then die with an
@@ -33,22 +69,16 @@ int is_directory(const char *path)
  */
 static const char *real_path_internal(const char *path, int die_on_error)
 {
-	static struct strbuf sb = STRBUF_INIT;
+	static struct strbuf resolved = STRBUF_INIT;
+	struct strbuf remaining = STRBUF_INIT;
+	struct strbuf next = STRBUF_INIT;
+	struct strbuf symlink = STRBUF_INIT;
 	char *retval = NULL;
-
-	/*
-	 * If we have to temporarily chdir(), store the original CWD
-	 * here so that we can chdir() back to it at the end of the
-	 * function:
-	 */
-	struct strbuf cwd = STRBUF_INIT;
-
-	int depth = MAXDEPTH;
-	char *last_elem = NULL;
+	int num_symlinks = 0;
 	struct stat st;
 
 	/* We've already done it */
-	if (path == sb.buf)
+	if (path == resolved.buf)
 		return path;
 
 	if (!*path) {
@@ -58,74 +88,112 @@ static const char *real_path_internal(const char *path, int die_on_error)
 			goto error_out;
 	}
 
-	strbuf_reset(&sb);
-	strbuf_addstr(&sb, path);
-
-	while (depth--) {
-		if (!is_directory(sb.buf)) {
-			char *last_slash = find_last_dir_sep(sb.buf);
-			if (last_slash) {
-				last_elem = xstrdup(last_slash + 1);
-				strbuf_setlen(&sb, last_slash - sb.buf + 1);
-			} else {
-				last_elem = xmemdupz(sb.buf, sb.len);
-				strbuf_reset(&sb);
-			}
+	strbuf_reset(&resolved);
+
+	if (is_absolute_path(path)) {
+		/* absolute path; start with only root as being resolved */
+		int offset = offset_1st_component(path);
+		strbuf_add(&resolved, path, offset);
+		strbuf_addstr(&remaining, path + offset);
+	} else {
+		/* relative path; can use CWD as the initial resolved path */
+		if (strbuf_getcwd(&resolved)) {
+			if (die_on_error)
+				die_errno("unable to get current working directory");
+			else
+				goto error_out;
 		}
+		strbuf_addstr(&remaining, path);
+	}
 
-		if (sb.len) {
-			if (!cwd.len && strbuf_getcwd(&cwd)) {
+	/* Iterate over the remaining path components */
+	while (remaining.len > 0) {
+		get_next_component(&next, &remaining);
+
+		if (next.len == 0) {
+			continue; /* empty component */
+		} else if (next.len == 1 && !strcmp(next.buf, ".")) {
+			continue; /* '.' component */
+		} else if (next.len == 2 && !strcmp(next.buf, "..")) {
+			/* '..' component; strip the last path component */
+			strip_last_component(&resolved);
+			continue;
+		}
+
+		/* append the next component and resolve resultant path */
+		if (!is_dir_sep(resolved.buf[resolved.len - 1]))
+			strbuf_addch(&resolved, '/');
+		strbuf_addbuf(&resolved, &next);
+
+		if (lstat(resolved.buf, &st)) {
+			/* error out unless this was the last component */
+			if (errno != ENOENT || remaining.len) {
 				if (die_on_error)
-					die_errno("Could not get current working directory");
+					die_errno("Invalid path '%s'",
+						  resolved.buf);
 				else
 					goto error_out;
 			}
+		} else if (S_ISLNK(st.st_mode)) {
+			ssize_t len;
+			strbuf_reset(&symlink);
 
-			if (chdir(sb.buf)) {
+			if (num_symlinks++ > MAXDEPTH) {
 				if (die_on_error)
-					die_errno("Could not switch to '%s'",
-						  sb.buf);
+					die("More than %d nested symlinks "
+					    "on path '%s'", MAXDEPTH, path);
 				else
 					goto error_out;
 			}
-		}
-		if (strbuf_getcwd(&sb)) {
-			if (die_on_error)
-				die_errno("Could not get current working directory");
-			else
-				goto error_out;
-		}
-
-		if (last_elem) {
-			if (sb.len && !is_dir_sep(sb.buf[sb.len - 1]))
-				strbuf_addch(&sb, '/');
-			strbuf_addstr(&sb, last_elem);
-			free(last_elem);
-			last_elem = NULL;
-		}
 
-		if (!lstat(sb.buf, &st) && S_ISLNK(st.st_mode)) {
-			struct strbuf next_sb = STRBUF_INIT;
-			ssize_t len = strbuf_readlink(&next_sb, sb.buf, 0);
+			len = strbuf_readlink(&symlink, resolved.buf,
+					      st.st_size);
 			if (len < 0) {
 				if (die_on_error)
 					die_errno("Invalid symlink '%s'",
-						  sb.buf);
+						  resolved.buf);
 				else
 					goto error_out;
 			}
-			strbuf_swap(&sb, &next_sb);
-			strbuf_release(&next_sb);
-		} else
-			break;
+
+			if (is_absolute_path(symlink.buf)) {
+				/* absolute symlink; set resolved to root */
+				int offset = offset_1st_component(symlink.buf);
+				strbuf_reset(&resolved);
+				strbuf_add(&resolved, symlink.buf, offset);
+				strbuf_remove(&symlink, 0, offset);
+			} else {
+				/*
+				 * relative symlink
+				 * strip off the last component since it will
+				 * be replaced with the contents of the symlink
+				 */
+				strip_last_component(&resolved);
+			}
+
+			/*
+			 * if there are still remaining components to resolve
+			 * then append them to symlink
+			 */
+			if (remaining.len) {
+				strbuf_addch(&symlink, '/');
+				strbuf_addbuf(&symlink, &remaining);
+			}
+
+			/*
+			 * use the symlink as the remaining components that
+			 * need to be resloved
+			 */
+			strbuf_swap(&symlink, &remaining);
+		}
 	}
 
-	retval = sb.buf;
+	retval = resolved.buf;
+
 error_out:
-	free(last_elem);
-	if (cwd.len && chdir(cwd.buf))
-		die_errno("Could not change back to '%s'", cwd.buf);
-	strbuf_release(&cwd);
+	strbuf_release(&remaining);
+	strbuf_release(&next);
+	strbuf_release(&symlink);
 
 	return retval;
 }
-- 
2.11.0.390.gc69c2f50cf-goog

