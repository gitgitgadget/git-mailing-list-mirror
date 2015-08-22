From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v5 1/2] worktree: add 'for_each_worktree' function
Date: Sat, 22 Aug 2015 17:51:33 -0400
Message-ID: <1440280294-50679-2-git-send-email-rappazzo@gmail.com>
References: <1440280294-50679-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Aug 22 23:51:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTGhi-0001LV-VO
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 23:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbbHVVvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 17:51:42 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33812 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbbHVVvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 17:51:40 -0400
Received: by qgeg42 with SMTP id g42so66263716qge.1
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 14:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HWY1AmwUmS53NRJjAsRb1w5+9qES6JTSknhfDDAnnBg=;
        b=KK4F06UdFQmcFJO6n+69SO1ezgKfxalCy6FT/Q/Hgnf31KrtH5xC781CaWpB9kkyvw
         MtnV2+pbFOK1TAZ+hEEBdZAnhxGVD6cqGVL3VdbG1sKAO6zySbs2/GSpnZAwdcfgrM4K
         YahO6iFakD2o9sW7aZgs2QqCie2s0AB5FllKM3Lnq+2IxaTQtPchfg/4ehx/zseKfr0k
         mxuLiU3zCTDtxrO0qqT/rtMvUrCzRURpLDNXbIGGWpVjj4VED2MbbDWOWr9E2HpLHCdf
         0V2i/7ymLdpfvLeD5i4Sde7A/vdvucMnoB+kzI6sKIBxiCqLXXyj4giMJObXfxWJ4xZp
         E1Kw==
X-Received: by 10.140.217.199 with SMTP id n190mr36567445qhb.74.1440280299418;
        Sat, 22 Aug 2015 14:51:39 -0700 (PDT)
Received: from Macbook-wireless.gtnexus.info (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by smtp.gmail.com with ESMTPSA id v22sm982607qkv.45.2015.08.22.14.51.38
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Aug 2015 14:51:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440280294-50679-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276396>

for_each_worktree iterates through each worktree and invokes a callback
function.  The main worktree (if not bare) is always encountered first,
followed by worktrees created by `git worktree add`.

If the callback function returns a non-zero value, iteration stops, and
the callback's return value is returned from the for_each_worktree
function.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 builtin/worktree.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 430b51e..7b3cb96 100644
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
@@ -359,6 +367,81 @@ static int add(int ac, const char **av, const char *prefix)
 	return add_worktree(path, branch, &opts);
 }
 
+/*
+ * Iterate through each worktree and invoke the callback function.  If
+ * the callback function returns non-zero, the iteration stops, and
+ * this function returns that return value
+ */
+static int for_each_worktree(each_worktree_fn fn, void *cb_data)
+{
+	struct strbuf worktree_path = STRBUF_INIT;
+	struct strbuf worktree_git = STRBUF_INIT;
+	const char *common_dir;
+	int main_is_bare = 0;
+	int ret = 0;
+
+	common_dir = get_git_common_dir();
+	if (!strcmp(common_dir, get_git_dir())) {
+		/* simple case - this is the main repo */
+		main_is_bare = is_bare_repository();
+		if (!main_is_bare) {
+			strbuf_addstr(&worktree_path, get_git_work_tree());
+		} else {
+			strbuf_addstr(&worktree_path, common_dir);
+		}
+	} else {
+		strbuf_addstr(&worktree_path, common_dir);
+		/* If the common_dir DOES NOT end with '/.git', then it is bare */
+		main_is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
+	}
+	strbuf_addstr(&worktree_git, worktree_path.buf);
+
+	if (!main_is_bare) {
+		strbuf_addstr(&worktree_git, "/.git");
+
+		ret = fn(worktree_path.buf, worktree_git.buf, cb_data);
+		if (ret)
+			goto done;
+	}
+	strbuf_addstr(&worktree_git, "/worktrees");
+
+	if (is_directory(worktree_git.buf)) {
+		DIR *dir = opendir(worktree_git.buf);
+		if (dir) {
+			struct stat st;
+			struct dirent *d;
+			size_t base_path_len = worktree_git.len;
+
+			while ((d = readdir(dir)) != NULL) {
+				if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+					continue;
+
+				strbuf_setlen(&worktree_git, base_path_len);
+				strbuf_addf(&worktree_git, "/%s/gitdir", d->d_name);
+
+				if (stat(worktree_git.buf, &st)) {
+					fprintf(stderr, "Unable to read worktree git dir: %s\n", worktree_git.buf);
+					continue;
+				}
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
+	return ret;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
-- 
2.5.0
