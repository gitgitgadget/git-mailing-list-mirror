Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056471FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 18:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbcLES7Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 13:59:16 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34613 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbcLES7J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 13:59:09 -0500
Received: by mail-pg0-f54.google.com with SMTP id x23so139541036pgx.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 10:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5UEVQQVGbMFfgo+GD/0vf4nUYTJFTTZG8ftI8rqvU00=;
        b=pQmJc4u718H1lGND70Cv/yMIjGOMo7NbLTUKcXn1rSI4TLK/UnyEKUO/rfqVTUNjpE
         814cGRgsLBVcDBliFEtG7PIRKwrKkItDJpZ2v+zDBk4XaKjSnm1BgXXdpUnBf3mMJJuQ
         LqAn2GfeJHbGd1oqEvlB5jRCcAZpa1EUJi9HbSortqABzeIpQS4uqk5Xx7J6zIvMmUsO
         surQ4xTbnCivBo1xu3ANTEKDBWc3yV+wQp+PoxQBk6QSB0Rwnlr33mAzv2c2fzCKWkyx
         KjearqRvfUJMUwfqxEUFlZLaigajCqQ57tUnHcO/YWfqR7I0tyUBHnciVlegFpRFCHFU
         Ds8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5UEVQQVGbMFfgo+GD/0vf4nUYTJFTTZG8ftI8rqvU00=;
        b=nHcXtGWEMjnqoKsH9DWB9kUJrkYaJZWHthO66ziqAGQ8L0ezdmQmwGtZMpIbaEfYjH
         XyQP2VqNfnxmO+khNCiUDMbknqLn0plzbCwh4vYHMtBhDt4vdyfd2AiLmcEhEt/jo2dD
         PVGVxloyPRbVjfYg4IAeSwiWsNiFW9QyEVg0ftD+YT4by872Cjt5veKQeKbo2YegGg7q
         m/51LIYWLPidIzXF0MC+y3bnEWjMpUwQfAfydJivhji62kDKFJeC/mEf4rp95OJJGA/c
         c0yr5qJwJx5JPtjbzk+84RVvpaAUVtqT25NwO1+r3IsdXvbDIZmLKF1nDWCivhdmbbIp
         K1qg==
X-Gm-Message-State: AKaTC01N39BEbFAHhU+QmljyA/g7zQMtYRV5jlD15Xq6PpfvFV0YeiEL/AGU0XxTKLXeMJv/
X-Received: by 10.98.213.7 with SMTP id d7mr57997535pfg.3.1480964328561;
        Mon, 05 Dec 2016 10:58:48 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id t193sm29394125pgb.4.2016.12.05.10.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 10:58:47 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com
Subject: [PATCH] real_path: make real_path thread-safe
Date:   Mon,  5 Dec 2016 10:58:36 -0800
Message-Id: <1480964316-99305-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480964316-99305-1-git-send-email-bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current implementation of real_path uses chdir() in order to resolve
symlinks.  Unfortunately this isn't thread-safe as chdir() affects a
process as a whole and not just an individual thread.  Instead perform
the symlink resolution by hand so that the calls to chdir() can be
removed, making real_path reentrant.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 abspath.c | 183 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 122 insertions(+), 61 deletions(-)

diff --git a/abspath.c b/abspath.c
index 2825de8..6f546e0 100644
--- a/abspath.c
+++ b/abspath.c
@@ -11,8 +11,38 @@ int is_directory(const char *path)
 	return (!stat(path, &st) && S_ISDIR(st.st_mode));
 }
 
+/* removes the last path component from 'path' except if 'path' is root */
+static void strip_last_component(struct strbuf *path)
+{
+	if (path->len > 1) {
+		char *last_slash = find_last_dir_sep(path->buf);
+		strbuf_setlen(path, last_slash - path->buf);
+	}
+}
+
+/* gets the next component in 'remaining' and places it in 'next' */
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
+		/* nothing */;
+	/* Find end of the path component */
+	for (end = start; *end && !is_dir_sep(*end); end++)
+		/* nothing */;
+
+	strbuf_add(next, start, end - start);
+	/* remove the component from 'remaining' */
+	strbuf_remove(remaining, 0, end - remaining->buf);
+}
+
 /* We allow "recursive" symbolic links. Only within reason, though. */
-#define MAXDEPTH 5
+#define MAXSYMLINKS 5
 
 /*
  * Return the real path (i.e., absolute path, with symlinks resolved
@@ -21,7 +51,6 @@ int is_directory(const char *path)
  * absolute_path().)  The return value is a pointer to a static
  * buffer.
  *
- * The input and all intermediate paths must be shorter than MAX_PATH.
  * The directory part of path (i.e., everything up to the last
  * dir_sep) must denote a valid, existing directory, but the last
  * component need not exist.  If die_on_error is set, then die with an
@@ -33,22 +62,16 @@ int is_directory(const char *path)
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
@@ -58,74 +81,112 @@ static const char *real_path_internal(const char *path, int die_on_error)
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
+		strbuf_addch(&resolved, '/');
+		strbuf_addstr(&remaining, path + 1);
+	} else {
+		/* relative path; can use CWD as the initial resolved path */
+		if (strbuf_getcwd(&resolved)) {
+			if (die_on_error)
+				die_errno("Could not get current working directory");
+			else
+				goto error_out;
+		}
+		strbuf_addstr(&remaining, path);
+	}
+
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
 		}
 
-		if (sb.len) {
-			if (!cwd.len && strbuf_getcwd(&cwd)) {
+		/* append the next component and resolve resultant path */
+		if (resolved.buf[resolved.len - 1] != '/')
+			strbuf_addch(&resolved, '/');
+		strbuf_addbuf(&resolved, &next);
+
+		if (lstat(resolved.buf, &st)) {
+			/* error out unless this was the last component */
+			if (!(errno == ENOENT && !remaining.len)) {
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
+			if (num_symlinks++ > MAXSYMLINKS) {
 				if (die_on_error)
-					die_errno("Could not switch to '%s'",
-						  sb.buf);
+					die("More than %d nested symlinks "
+					    "on path '%s'", MAXSYMLINKS, path);
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
 
-		if (last_elem) {
-			if (sb.len && !is_dir_sep(sb.buf[sb.len - 1]))
-				strbuf_addch(&sb, '/');
-			strbuf_addstr(&sb, last_elem);
-			free(last_elem);
-			last_elem = NULL;
-		}
-
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
+				/*
+				 * absolute symlink
+				 * reset resolved path to root
+				 */
+				strbuf_setlen(&resolved, 1);
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
+	//strbuf_release(&resolved);
+	strbuf_release(&remaining);
+	strbuf_release(&next);
+	strbuf_release(&symlink);
 
 	return retval;
 }
-- 
2.8.0.rc3.226.g39d4020

