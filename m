From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH v4 2/5] setup: sanity check file size in read_gitfile_gently
Date: Sat, 25 Apr 2015 19:59:40 +0200
Message-ID: <1429984780-22868-1-git-send-email-erik.elfstrom@gmail.com>
References: <xmqqa8xw17ew.fsf@gitster.dls.corp.google.com>
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 25 20:00:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym4NO-0005aW-Sw
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 20:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965522AbbDYSAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 14:00:22 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:35041 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965267AbbDYSAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 14:00:21 -0400
Received: by labbd9 with SMTP id bd9so55126874lab.2
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a1we4pnr7tLSBuvwQb1tys2ZmaEIk1/xuomjYGnagq4=;
        b=QFBDANtTqy+m0q5Hihb38tQmZS4IO4q0DHQ2WHSDrWtB3sTpkVUEFMA4pylvoICPEs
         krXbBGPs9+xIKKlhp5VKmRv0PxBsmdv6G6M/N3Lo+18J7AUlSw5IMZ9ofjZVMsn2vKRV
         Hm2sRUjpUSUKfpEb0EX9SP4nQusT4qrg+dsxpSdOf7Jh24BUKJPLZu9EZZ3u5ShGChBt
         hFuTzYJa3Yjew+pysJTyszTXWdy86miyUablWLoKg2ICWgvOsjZ3vX0teV3MQ5l0+R9h
         x8/8qEy+KDabVlmNr9+OR2h6mHDiemgnwmiA3EhAOGOIkcuUijQJfSuVTqDF+S8rGsKR
         8anQ==
X-Received: by 10.112.172.35 with SMTP id az3mr3369567lbc.99.1429984820360;
        Sat, 25 Apr 2015 11:00:20 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id lh8sm3529221lab.30.2015.04.25.11.00.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Apr 2015 11:00:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.8.g86acfbd.dirty
In-Reply-To: <xmqqa8xw17ew.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267797>

On Sat, Apr 25, 2015 at 6:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I do not think it is wrong per-se, but the changes in this patch
> shows why hardcoded values assigned to error_code without #define is
> not a good idea, as these values are now exposed to the callers of
> the new function.  After we gain a new caller that does care about
> the exact error code (e.g. to react differently to the reason why we
> failed to read by giving different error messages) if we decide to
> revert this step, or if we decide to add a new error type, for
> whatever reason, this organization forces the caller to be updated.

Yes, it was a bit silly of me not to add that. Would something like
this be ok?

---
 cache.h |  9 +++++++++
 setup.c | 32 ++++++++++++++++----------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index 6e29068..177337a 100644
--- a/cache.h
+++ b/cache.h
@@ -431,6 +431,15 @@ extern int set_git_dir(const char *path);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
+
+#define READ_GITFILE_ERR_STAT_FAILED 1
+#define READ_GITFILE_ERR_NOT_A_FILE 2
+#define READ_GITFILE_ERR_OPEN_FAILED 3
+#define READ_GITFILE_ERR_TOO_LARGE 4
+#define READ_GITFILE_ERR_READ_FAILED 5
+#define READ_GITFILE_ERR_INVALID_FORMAT 6
+#define READ_GITFILE_ERR_NO_PATH 7
+#define READ_GITFILE_ERR_NOT_A_REPO 8
 extern const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
 extern const char *resolve_gitdir(const char *suspect);
diff --git a/setup.c b/setup.c
index ed87334..792c37b 100644
--- a/setup.c
+++ b/setup.c
@@ -352,38 +352,38 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	ssize_t len;
 
 	if (stat(path, &st)) {
-		error_code = 1;
+		error_code = READ_GITFILE_ERR_STAT_FAILED;
 		goto cleanup_return;
 	}
 	if (!S_ISREG(st.st_mode)) {
-		error_code = 2;
+		error_code = READ_GITFILE_ERR_NOT_A_FILE;
 		goto cleanup_return;
 	}
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		error_code = 3;
+		error_code = READ_GITFILE_ERR_OPEN_FAILED;
 		goto cleanup_return;
 	}
 	if (st.st_size > PATH_MAX * 4) {
-		error_code = 4;
+		error_code = READ_GITFILE_ERR_TOO_LARGE;
 		goto cleanup_return;
 	}
 	buf = xmalloc(st.st_size + 1);
 	len = read_in_full(fd, buf, st.st_size);
 	close(fd);
 	if (len != st.st_size) {
-		error_code = 5;
+		error_code = READ_GITFILE_ERR_READ_FAILED;
 		goto cleanup_return;
 	}
 	buf[len] = '\0';
 	if (!starts_with(buf, "gitdir: ")) {
-		error_code = 6;
+		error_code = READ_GITFILE_ERR_INVALID_FORMAT;
 		goto cleanup_return;
 	}
 	while (buf[len - 1] == '\n' || buf[len - 1] == '\r')
 		len--;
 	if (len < 9) {
-		error_code = 7;
+		error_code = READ_GITFILE_ERR_NO_PATH;
 		goto cleanup_return;
 	}
 	buf[len] = '\0';
@@ -401,7 +401,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	}
 
 	if (!is_git_directory(dir)) {
-		error_code = 8;
+		error_code = READ_GITFILE_ERR_NOT_A_REPO;
 		goto cleanup_return;
 	}
 	path = real_path(dir);
@@ -417,20 +417,20 @@ cleanup_return:
 			return NULL;
 
 		switch (error_code) {
-		case 1: // failed to stat
-		case 2: // not regular file
+		case READ_GITFILE_ERR_STAT_FAILED:
+		case READ_GITFILE_ERR_NOT_A_FILE:
 			return NULL;
-		case 3:
+		case READ_GITFILE_ERR_OPEN_FAILED:
 			die_errno("Error opening '%s'", path);
-		case 4:
+		case READ_GITFILE_ERR_TOO_LARGE:
 			die("Too large to be a .git file: '%s'", path);
-		case 5:
+		case READ_GITFILE_ERR_READ_FAILED:
 			die("Error reading %s", path);
-		case 6:
+		case READ_GITFILE_ERR_INVALID_FORMAT:
 			die("Invalid gitfile format: %s", path);
-		case 7:
+		case READ_GITFILE_ERR_NO_PATH:
 			die("No path in gitfile: %s", path);
-		case 8:
+		case READ_GITFILE_ERR_NOT_A_REPO:
 			die("Not a git repository: %s", dir);
 		default:
 			assert(0);
-- 
2.4.0.rc3.8.g86acfbd.dirty
