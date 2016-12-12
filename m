Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F560206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 18:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbcLLSRK (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 13:17:10 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33736 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753660AbcLLSRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 13:17:05 -0500
Received: by mail-pg0-f50.google.com with SMTP id 3so37842384pgd.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 10:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IVNBpPD0cK5TkpIfrlgJp33a0dgpM4cdsOF1aw1Bs5o=;
        b=Yt+jJ8PLBl35Yh3/KhKPz18jPYiI/pfu6jgJ4YCfjdIuVAJgtvpxXD6wKdKVHUQB+O
         4ZySeVtU3CfOk0U+DBJ/naSMQZP9lyVfZCoHx3obuukH/FiUZcNAlHGVM5FYjQXzr0Kz
         p7j+BXUugnLQaVhq6CjHnc0ByyL8P+4J5Bl+ZeLI1ay0+UF7lHM1AlwCOOB2BXpJwyll
         slJjXQQRqfQXFIO66nklsAHAEf7oiPpJzgseWayH6yJnBLsrskf/hw9i9P+dNczhaB+W
         JzzX7j9r8sKP8TN0ZvT9AcnfPZY5XsiYM9xzFAAIQ4zy6eYnrZfHmGiFh2DX0ZgVdZEv
         7L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IVNBpPD0cK5TkpIfrlgJp33a0dgpM4cdsOF1aw1Bs5o=;
        b=FblwmLHWL4nRVuHhTxrXaIFjz53suepokVhw06k4X4fCaD/Oetqz+f2aegPVII5mQ+
         gq+CSNHGLyJWIkBSEuH3mAfy6ej9dgQuTA50GnNsZgPLK6Xm492D4DbUI68cWBTsXgpQ
         xtvuX6Q29NTACY3gAxQaaINHTvTlvfxkXmkdni8/VE/ZZK4CGUWo7qNibqZPkWXkn6PX
         sIKnbRpt/+FJp2Wwsv8ixLkPHToUsjMqzitUqMu95a0XIxiOt+fBnqe4raZKYZnHKtwt
         w7ZKzEnhKgajvhtC7sZQMlMELBvbyXikoYqmFUa2wdQYEqmvIG8SZPgLCVb7bQYy3bX+
         lDtw==
X-Gm-Message-State: AKaTC02aEWT5MCSPFMaQc+5YO2rVAfXmwBSIuNV0OOGej07lYuJgdXmoCpgJzKXyxcGntqNF
X-Received: by 10.99.64.133 with SMTP id n127mr171687676pga.104.1481566624440;
        Mon, 12 Dec 2016 10:17:04 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y66sm77644889pgb.21.2016.12.12.10.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 10:17:03 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com
Subject: [PATCH v3 1/4] real_path: resolve symlinks by hand
Date:   Mon, 12 Dec 2016 10:16:52 -0800
Message-Id: <1481566615-75299-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481566615-75299-1-git-send-email-bmwill@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com>
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
 abspath.c | 190 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 129 insertions(+), 61 deletions(-)

diff --git a/abspath.c b/abspath.c
index 2825de8..cafcae0 100644
--- a/abspath.c
+++ b/abspath.c
@@ -11,8 +11,45 @@ int is_directory(const char *path)
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
-#define MAXDEPTH 5
+#define MAXSYMLINKS 5
 
 /*
  * Return the real path (i.e., absolute path, with symlinks resolved
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
2.8.0.rc3.226.g39d4020

