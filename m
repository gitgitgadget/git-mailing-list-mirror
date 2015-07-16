From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/20] branch: publish die_if_checked_out()
Date: Thu, 16 Jul 2015 04:20:14 -0400
Message-ID: <1437034825-32054-10-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:22:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeQm-0000KH-KO
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbbGPIU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:20:57 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33930 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbbGPIUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:55 -0400
Received: by iebmu5 with SMTP id mu5so50727478ieb.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6XPWBENnMp3C94SUyRjKDr69ToosLqAAaGSniIEza/U=;
        b=ks4Cxh0Dg6BGoEJqENURvDmfUHhjbkdbnu7T8n8i8GNVN6VgpGtOCMaPMB9wStyNRX
         zdxtRbSrHUgYPzwhgniAn8pPM1q+8/PZrtFy6TVSmXPE+5bHBJT11b28YSs+TNtbZIsR
         e6JYvxy3+1pXLIYiLVBrLhGhgd9NelQZUkzfQ5nShDb2hngTZAaYm/2oTAwon32QtkiY
         kA5jSwKFqkG2nFgAN/PnymhjjWiHebD/oeQClUVHL1NjYR31ROVFgO5bNLhENA3O+w/e
         yQLBXDcOK12dY13d20/mRuNVI6/01LJ3F+vgxtASAUv6S5Wg2qw5SNHmWYDuN6aqRDJR
         vplQ==
X-Received: by 10.107.47.224 with SMTP id v93mr9706532iov.86.1437034855131;
        Thu, 16 Jul 2015 01:20:55 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.54
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:54 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274021>

git-worktree currently conflates new branch creation, setting of HEAD in
the new wortkree, and worktree population into a single sub-invocation
of git-checkout. However, these operations will eventually be separated,
and git-worktree itself will need to be able to detect if the branch is
already checked out elsewhere, rather than relying upon git-branch to
make this determination, so publish die_if_checked_out().

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v1: reword commit message.

 branch.c           | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 branch.h           |  7 ++++++
 builtin/checkout.c | 67 ------------------------------------------------------
 3 files changed, 74 insertions(+), 67 deletions(-)

diff --git a/branch.c b/branch.c
index 4bab55a..dfd7698 100644
--- a/branch.c
+++ b/branch.c
@@ -309,3 +309,70 @@ void remove_branch_state(void)
 	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
 }
+
+static void check_linked_checkout(const char *branch, const char *id)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
+
+	/*
+	 * $GIT_COMMON_DIR/HEAD is practically outside
+	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
+	 * uses git_path). Parse the ref ourselves.
+	 */
+	if (id)
+		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+	else
+		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+
+	if (!strbuf_readlink(&sb, path.buf, 0)) {
+		if (!starts_with(sb.buf, "refs/") ||
+		    check_refname_format(sb.buf, 0))
+			goto done;
+	} else if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
+	    starts_with(sb.buf, "ref:")) {
+		strbuf_remove(&sb, 0, strlen("ref:"));
+		strbuf_trim(&sb);
+	} else
+		goto done;
+	if (strcmp(sb.buf, branch))
+		goto done;
+	if (id) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/worktrees/%s/gitdir", get_git_common_dir(), id);
+		if (strbuf_read_file(&gitdir, path.buf, 0) <= 0)
+			goto done;
+		strbuf_rtrim(&gitdir);
+	} else
+		strbuf_addstr(&gitdir, get_git_common_dir());
+	skip_prefix(branch, "refs/heads/", &branch);
+	strbuf_strip_suffix(&gitdir, "/.git");
+	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
+done:
+	strbuf_release(&path);
+	strbuf_release(&sb);
+	strbuf_release(&gitdir);
+}
+
+void die_if_checked_out(const char *branch)
+{
+	struct strbuf path = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *d;
+
+	check_linked_checkout(branch, NULL);
+
+	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	dir = opendir(path.buf);
+	strbuf_release(&path);
+	if (!dir)
+		return;
+
+	while ((d = readdir(dir)) != NULL) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		check_linked_checkout(branch, d->d_name);
+	}
+	closedir(dir);
+}
diff --git a/branch.h b/branch.h
index 64173ab..58aa45f 100644
--- a/branch.h
+++ b/branch.h
@@ -52,4 +52,11 @@ extern void install_branch_config(int flag, const char *local, const char *origi
  */
 extern int read_branch_desc(struct strbuf *, const char *branch_name);
 
+/*
+ * Check if a branch is checked out in the main worktree or any linked
+ * worktree and die (with a message describing its checkout location) if
+ * it is.
+ */
+extern void die_if_checked_out(const char *branch);
+
 #endif
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3326aa8..4ae895c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -873,73 +873,6 @@ static const char *unique_tracking_name(const char *name, unsigned char *sha1)
 	return NULL;
 }
 
-static void check_linked_checkout(const char *branch, const char *id)
-{
-	struct strbuf sb = STRBUF_INIT;
-	struct strbuf path = STRBUF_INIT;
-	struct strbuf gitdir = STRBUF_INIT;
-
-	/*
-	 * $GIT_COMMON_DIR/HEAD is practically outside
-	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
-	 * uses git_path). Parse the ref ourselves.
-	 */
-	if (id)
-		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
-	else
-		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
-
-	if (!strbuf_readlink(&sb, path.buf, 0)) {
-		if (!starts_with(sb.buf, "refs/") ||
-		    check_refname_format(sb.buf, 0))
-			goto done;
-	} else if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
-	    starts_with(sb.buf, "ref:")) {
-		strbuf_remove(&sb, 0, strlen("ref:"));
-		strbuf_trim(&sb);
-	} else
-		goto done;
-	if (strcmp(sb.buf, branch))
-		goto done;
-	if (id) {
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s/worktrees/%s/gitdir", get_git_common_dir(), id);
-		if (strbuf_read_file(&gitdir, path.buf, 0) <= 0)
-			goto done;
-		strbuf_rtrim(&gitdir);
-	} else
-		strbuf_addstr(&gitdir, get_git_common_dir());
-	skip_prefix(branch, "refs/heads/", &branch);
-	strbuf_strip_suffix(&gitdir, "/.git");
-	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
-done:
-	strbuf_release(&path);
-	strbuf_release(&sb);
-	strbuf_release(&gitdir);
-}
-
-static void die_if_checked_out(const char *branch)
-{
-	struct strbuf path = STRBUF_INIT;
-	DIR *dir;
-	struct dirent *d;
-
-	check_linked_checkout(branch, NULL);
-
-	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
-	dir = opendir(path.buf);
-	strbuf_release(&path);
-	if (!dir)
-		return;
-
-	while ((d = readdir(dir)) != NULL) {
-		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
-			continue;
-		check_linked_checkout(branch, d->d_name);
-	}
-	closedir(dir);
-}
-
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
-- 
2.5.0.rc2.378.g0af52e8
