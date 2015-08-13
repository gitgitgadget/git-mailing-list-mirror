From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 1/2 v4] worktree: add 'for_each_worktree' function
Date: Thu, 13 Aug 2015 14:32:18 -0400
Message-ID: <1439490739-9361-2-git-send-email-rappazzo@gmail.com>
References: <1439490739-9361-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Thu Aug 13 20:33:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxJE-0002dE-7x
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 20:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbbHMScx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 14:32:53 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34987 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbbHMScv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 14:32:51 -0400
Received: by iodt126 with SMTP id t126so61521043iod.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Cs5N1u3aibdMtpTxBBJ1Ibhti7CKF3u4PifCucykNQ=;
        b=O+U3ddR7voD8R4H0ixsHujvo1WxWa7/U65Yb4945ScwWjd8GBljTlKCVFH3/JJVOCv
         30HFfSoF/uzeB4/YQFGDt4Ix+feQGVThXQ/umHDykW7mXaOgdZjcAwYDhsW+HHeYgye6
         gHPuvAvkmULlNvK6qysURa2Q32qJoi3SjM7QeljE5XYARMPuTrBnoKy/glwZwl/iTu2n
         /CupBw75i8QcmgJQcDJTnaX+DQglndW03rVY/lyu8G80e1dmoCCm9Y5k99wrvTJoLd78
         owUC0pjTzgqasE5XDulxdzKtRZSjs61vnp+vXrvweHwK5vB64jyrN9MXWk3stdN/jHCH
         kTXg==
X-Received: by 10.107.47.219 with SMTP id v88mr36401235iov.78.1439490770600;
        Thu, 13 Aug 2015 11:32:50 -0700 (PDT)
Received: from localhost.localdomain (114.sub-70-199-83.myvzw.com. [70.199.83.114])
        by smtp.gmail.com with ESMTPSA id g12sm2038690ioe.28.2015.08.13.11.32.48
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 11:32:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439490739-9361-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275872>

for_each_worktree iterates through each worktree and invokes a callback
function.  The main worktree (if not bare) is always encountered first,
followed by worktrees created by `git worktree add`.

If the callback function returns a non-zero value, iteration stops, and
the callback's return value is returned from the for_each_worktree
function.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 builtin/worktree.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 430b51e..a43e360 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -26,6 +26,14 @@ static int show_only;
 static int verbose;
 static unsigned long expire;
 
+/*
+ * The signature for the callback function for the for_each_worktree()
+ * function below.  The memory pointed to by the callback arguments
+ * is only guaranteed to be valid for the duration of a single
+ * callback invocation.
+ */
+typedef int each_worktree_fn(const char *path, const char *git_dir, void *cb_data);
+
 static int prune_worktree(const char *id, struct strbuf *reason)
 {
 	struct stat st;
@@ -358,6 +366,82 @@ static int add(int ac, const char **av, const char *prefix)
 
 	return add_worktree(path, branch, &opts);
 }
+/*
+ * Iterate through each worktree and invoke the callback function.  If
+ * the callback function returns non-zero, the iteration stops, and
+ * this function returns that return value
+ */
+static int for_each_worktree(each_worktree_fn fn, void *cb_data)
+{
+	struct strbuf main_path = STRBUF_INIT;
+	struct dirent *d;
+	struct stat st;
+	struct strbuf worktree_path = STRBUF_INIT;
+	struct strbuf worktree_git = STRBUF_INIT;
+	const char *common_dir;
+	DIR *dir;
+	int main_is_bare = 0;
+	int ret = 0;
+
+	common_dir = get_git_common_dir();
+	if (!strcmp(common_dir, get_git_dir())) {
+		/* simple case - this is the main repo */
+		main_is_bare = is_bare_repository();
+		if (!main_is_bare) {
+			strbuf_addstr(&main_path, get_git_work_tree());
+		} else {
+			strbuf_addstr(&main_path, common_dir);
+		}
+	} else {
+		strbuf_addstr(&main_path, common_dir);
+		strbuf_strip_suffix(&main_path, "/.git");
+		/* If the common_dir DOES NOT end with '/.git', then it is bare */
+		main_is_bare = !strcmp(common_dir, main_path.buf);
+	}
+
+	if (!main_is_bare) {
+		strbuf_addstr(&worktree_path, main_path.buf);
+
+		strbuf_addstr(&main_path, "/.git");
+		strbuf_addstr(&worktree_git, main_path.buf);
+
+		ret = fn(worktree_path.buf, worktree_git.buf, cb_data);
+		if (ret)
+			goto done;
+	}
+	strbuf_addstr(&main_path, "/worktrees");
+
+	if (is_directory(main_path.buf)) {
+		dir = opendir(main_path.buf);
+		if (dir) {
+			while ((d = readdir(dir)) != NULL) {
+				if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+					continue;
+
+				strbuf_reset(&worktree_git);
+				strbuf_addf(&worktree_git, "%s/%s/gitdir", main_path.buf, d->d_name);
+
+				if (stat(worktree_git.buf, &st))
+					continue;
+
+				strbuf_reset(&worktree_path);
+				strbuf_read_file(&worktree_path, worktree_git.buf, st.st_size);
+				strbuf_strip_suffix(&worktree_path, "/.git\n");
+
+				strbuf_strip_suffix(&worktree_git, "/gitdir");
+				ret = fn(worktree_path.buf, worktree_git.buf, cb_data);
+				if (ret)
+					break;
+			}
+		}
+		closedir(dir);
+	}
+done:
+	strbuf_release(&worktree_git);
+	strbuf_release(&worktree_path);
+	strbuf_release(&main_path);
+	return ret;
+}
 
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
-- 
2.5.0
