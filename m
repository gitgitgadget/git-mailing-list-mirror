Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006071FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966608AbdAFQXF (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:05 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47448 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965034AbdAFQXE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:04 -0500
X-AuditID: 1207440d-8b7ff700000009ba-d7-586fc46696de
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CE.6A.02490.664CF685; Fri,  6 Jan 2017 11:23:02 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmWu023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:01 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 06/23] raceproof_create_file(): new function
Date:   Fri,  6 Jan 2017 17:22:26 +0100
Message-Id: <dd5ffa31393a5b243fe83c5dc4472ee389f55658.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqJt2JD/CYFm7iUXXlW4mi4beK8wW
        uxf3M1vcXjGf2WLJw9fMFj9aepgtOqfKOrB7/H3/gclj56y77B7Ll65j9OhqP8Lm8ax3D6PH
        xUvKHp83yQWwR3HZpKTmZJalFunbJXBltC8+y1bQqlPxZFYTawPjbaUuRg4OCQETifNrVLoY
        uTiEBC4zSkzrecYO4Zxgkri95wZbFyMnB5uArsSinmYmEFtEQE1iYtshFpAiZoEPjBK/Omex
        gySEBewlHj+dAGazCKhKLNm8kRVkA69AlETbFl+QsISAnMSlbV+YQWxOAQuJxl3fGEFsIQFz
        iU8TDzNPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkvHh3MP5f
        J3OIUYCDUYmHN8IrL0KINbGsuDL3EKMkB5OSKG+YY36EEF9SfkplRmJxRnxRaU5q8SFGCQ5m
        JRFeu0NAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO8fkEbBotT0
        1Iq0zJwShDQTByfIcB6g4YKHQYYXFyTmFmemQ+RPMSpKifNuAWkWAElklObB9cLi/xWjONAr
        wrw9IO08wNQB1/0KaDATyGBPsMEliQgpqQZGs+1sMcVCvS3TplxmVHfy6l6pO9XW2C3JQSnD
        uYIt5F+maLIa456lc5qeVDwtbD56Pf5Jzq5yoYXyjMcuS647vHm26cfJaofz4v5p11owe7ww
        f2el5ltedHfHyv0qH27NWiL90mfFgezGYxuWH7FZlm3EyHFyieS5tlyTZqtNJ+X/X2Hud1mm
        xFKckWioxVxUnAgA3TK+gdoCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function that tries to create a file and any containing
directories in a way that is robust against races with other processes
that might be cleaning up empty directories at the same time.

The actual file creation is done by a callback function, which, if it
fails, should set errno to EISDIR or ENOENT according to the convention
of open(). raceproof_create_file() detects such failures, and
respectively either tries to delete empty directories that might be in
the way of the file or tries to create the containing directories. Then
it retries the callback function.

This function is not yet used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h     | 43 ++++++++++++++++++++++++++++++++++++++
 sha1_file.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/cache.h b/cache.h
index 8177c3a..95cde14 100644
--- a/cache.h
+++ b/cache.h
@@ -1057,6 +1057,49 @@ enum scld_error {
 enum scld_error safe_create_leading_directories(char *path);
 enum scld_error safe_create_leading_directories_const(const char *path);
 
+/*
+ * Callback function for raceproof_create_file(). This function is
+ * expected to do something that makes dirname(path) permanent despite
+ * the fact that other processes might be cleaning up empty
+ * directories at the same time. Usually it will create a file named
+ * path, but alternatively it could create another file in that
+ * directory, or even chdir() into that directory. The function should
+ * return 0 if the action was completed successfully. On error, it
+ * should return a nonzero result and set errno.
+ * raceproof_create_file() treats two errno values specially:
+ *
+ * - ENOENT -- dirname(path) does not exist. In this case,
+ *             raceproof_create_file() tries creating dirname(path)
+ *             (and any parent directories, if necessary) and calls
+ *             the function again.
+ *
+ * - EISDIR -- the file already exists and is a directory. In this
+ *             case, raceproof_create_file() removes the directory if
+ *             it is empty (and recursively any empty directories that
+ *             it contains) and calls the function again.
+ *
+ * Any other errno causes raceproof_create_file() to fail with the
+ * callback's return value and errno.
+ *
+ * Obviously, this function should be OK with being called again if it
+ * fails with ENOENT or EISDIR. In other scenarios it will not be
+ * called again.
+ */
+typedef int create_file_fn(const char *path, void *cb);
+
+/*
+ * Create a file in dirname(path) by calling fn, creating leading
+ * directories if necessary. Retry a few times in case we are racing
+ * with another process that is trying to clean up the directory that
+ * contains path. See the documentation for create_file_fn for more
+ * details.
+ *
+ * Return the value and set the errno that resulted from the most
+ * recent call of fn. fn is always called at least once, and will be
+ * called more than once if it returns ENOENT or EISDIR.
+ */
+int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
+
 int mkdir_in_gitdir(const char *path);
 extern char *expand_user_path(const char *path);
 const char *enter_repo(const char *path, int strict);
diff --git a/sha1_file.c b/sha1_file.c
index ae8f0b4..b08f54c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -179,6 +179,74 @@ enum scld_error safe_create_leading_directories_const(const char *path)
 	return result;
 }
 
+int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
+{
+	/*
+	 * The number of times we will try to remove empty directories
+	 * in the way of path. This is only 1 because if another
+	 * process is racily creating directories that conflict with
+	 * us, we don't want to fight against them.
+	 */
+	int remove_directories_remaining = 1;
+
+	/*
+	 * The number of times that we will try to create the
+	 * directories containing path. We are willing to attempt this
+	 * more than once, because another process could be trying to
+	 * clean up empty directories at the same time as we are
+	 * trying to create them.
+	 */
+	int create_directories_remaining = 3;
+
+	/* A scratch copy of path, filled lazily if we need it: */
+	struct strbuf path_copy = STRBUF_INIT;
+
+	int ret, save_errno;
+
+	/* Sanity check: */
+	assert(*path);
+
+retry_fn:
+	ret = fn(path, cb);
+	save_errno = errno;
+	if (!ret)
+		goto out;
+
+	if (errno == EISDIR && remove_directories_remaining-- > 0) {
+		/*
+		 * A directory is in the way. Maybe it is empty; try
+		 * to remove it:
+		 */
+		if (!path_copy.len)
+			strbuf_addstr(&path_copy, path);
+
+		if (!remove_dir_recursively(&path_copy, REMOVE_DIR_EMPTY_ONLY))
+			goto retry_fn;
+	} else if (errno == ENOENT && create_directories_remaining-- > 0) {
+		/*
+		 * Maybe the containing directory didn't exist, or
+		 * maybe it was just deleted by a process that is
+		 * racing with us to clean up empty directories. Try
+		 * to create it:
+		 */
+		enum scld_error scld_result;
+
+		if (!path_copy.len)
+			strbuf_addstr(&path_copy, path);
+
+		do {
+			scld_result = safe_create_leading_directories(path_copy.buf);
+			if (scld_result == SCLD_OK)
+				goto retry_fn;
+		} while (scld_result == SCLD_VANISHED && create_directories_remaining-- > 0);
+	}
+
+out:
+	strbuf_release(&path_copy);
+	errno = save_errno;
+	return ret;
+}
+
 static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 {
 	int i;
-- 
2.9.3

