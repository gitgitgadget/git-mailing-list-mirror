From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 1/2] worktrees: add find_shared_symref
Date: Fri, 31 Jul 2015 18:11:08 -0400
Message-ID: <1438380669-11012-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, johan@herland.net
X-From: git-owner@vger.kernel.org Sat Aug 01 00:11:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLIWU-00029V-N4
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 00:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbbGaWLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 18:11:22 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34787 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbbGaWLV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 18:11:21 -0400
Received: by qgeu79 with SMTP id u79so55657233qge.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 15:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WF9yj5cQfLdAoqPXUJkj9DDAy5QTM6Hs2RLRexnQ+hQ=;
        b=O2YlFBU76rMZ+xwBVFeI8xm8tX1lgCbVjiLAFSVWGAW+KZsGcYU82kTYrwc118lxNA
         pnBrzKxeERk3oqmPrziDkLV2ZkIKEv07bDyfJQyB6CERAiH041qVMd+7h486DlICAUq3
         ZIZfDlRqrZRU9Z3FAOAg440Kk0o6woxQqtVZNIQXrwvlP00DQvvSs4q++hdLGCIxpsQp
         dolsVVnA63JYJD3ORqDBZj5ApRmT/kw7YF1k+t3ZhR9sFjyniKJRQsfmfV9kJZFyjZ7D
         ylxZbfN7e3lg8k8CGcTAm1FF/83eVEyITxhZuBD0DtVsW5n1rhBrgaqGvqqnqAem4ItE
         LQQw==
X-Gm-Message-State: ALoCoQk/Ca6MXpHzQY8uTbEeFVAqPV8CmwNk7A2b4UHSbx0VV0/mr2Y+buB7q/wVAlYgb2gn/Dmc
X-Received: by 10.140.134.199 with SMTP id 190mr8818646qhg.15.1438380680511;
        Fri, 31 Jul 2015 15:11:20 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id t77sm2903661qge.42.2015.07.31.15.11.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Jul 2015 15:11:19 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275085>

Add a new function, find_shared_symref, which contains the heart of
die_if_checked_out, but works for all symrefs.  Refactor
die_if_checked_out to use the same infrastructure as
find_shared_symref.

Soon, we will use find_shared_symref to protect notes merges in
worktrees.

Signed-off-by: David Turner <dturner@twopensource.com>
---

This version includes Junio's suggested comment fix, and Eric's
suggestions for error message improvements.

---
 branch.c | 39 ++++++++++++++++++++++++++++-----------
 branch.h |  8 ++++++++
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/branch.c b/branch.c
index c85be07..9b5e3b3 100644
--- a/branch.c
+++ b/branch.c
@@ -311,21 +311,22 @@ void remove_branch_state(void)
 	unlink(git_path("SQUASH_MSG"));
 }
 
-static void check_linked_checkout(const char *branch, const char *id)
+static char *find_linked_symref(const char *symref, const char *branch,
+				const char *id)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 
 	/*
-	 * $GIT_COMMON_DIR/HEAD is practically outside
-	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
-	 * uses git_path). Parse the ref ourselves.
+	 * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside
+	 * $GIT_DIR so resolve_ref_unsafe() won't work (it uses
+	 * git_path). Parse the ref ourselves.
 	 */
 	if (id)
-		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+		strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
 	else
-		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+		strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
 
 	if (!strbuf_readlink(&sb, path.buf, 0)) {
 		if (!starts_with(sb.buf, "refs/") ||
@@ -349,31 +350,47 @@ static void check_linked_checkout(const char *branch, const char *id)
 		strbuf_addstr(&gitdir, get_git_common_dir());
 	skip_prefix(branch, "refs/heads/", &branch);
 	strbuf_strip_suffix(&gitdir, ".git");
-	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
+	return strbuf_detach(&gitdir, NULL);
 done:
 	strbuf_release(&path);
 	strbuf_release(&sb);
 	strbuf_release(&gitdir);
+
+	return NULL;
 }
 
-void die_if_checked_out(const char *branch)
+char *find_shared_symref(const char *symref, const char *target)
 {
 	struct strbuf path = STRBUF_INIT;
 	DIR *dir;
 	struct dirent *d;
+	char *existing;
 
-	check_linked_checkout(branch, NULL);
+	if ((existing = find_linked_symref(symref, target, NULL)))
+		return existing;
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (!dir)
-		return;
+		return NULL;
 
 	while ((d = readdir(dir)) != NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
-		check_linked_checkout(branch, d->d_name);
+		if ((existing = find_linked_symref(symref, target, d->d_name)))
+			return existing;
 	}
 	closedir(dir);
+
+	return NULL;
+}
+
+void die_if_checked_out(const char *branch)
+{
+	char *existing;
+
+	existing = find_shared_symref("HEAD", branch);
+	if (existing)
+		die(_("'%s' is already checked out at '%s'"), branch, existing);
 }
diff --git a/branch.h b/branch.h
index 58aa45f..0f466c7 100644
--- a/branch.h
+++ b/branch.h
@@ -59,4 +59,12 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
  */
 extern void die_if_checked_out(const char *branch);
 
+/*
+ * Check if a per-worktree symref points to a ref in the main worktree
+ * or any linked worktree, and return the path to the exising worktree
+ * if it is.  Returns NULL if there is no existing ref.  The caller is
+ * responsible for freeing the returned path.
+ */
+extern char *find_shared_symref(const char *symref, const char *branch);
+
 #endif
-- 
2.0.4.315.gad8727a-twtrsrc
