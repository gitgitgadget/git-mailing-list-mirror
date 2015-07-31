From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 1/2] worktrees: add die_if_shared_symref
Date: Fri, 31 Jul 2015 15:01:36 -0400
Message-ID: <1438369297-4838-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Jul 31 21:01:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLFZ7-00021T-PB
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 21:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbbGaTBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 15:01:52 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33910 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbGaTBw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 15:01:52 -0400
Received: by qgeu79 with SMTP id u79so52440214qge.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 12:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=COdjQBMuGnVIwZGej2utLmJIRkiPpWg8OtQko6G2eE4=;
        b=F2C0hjt7/0/tu9bGbJxfEJGyCsl5cUHXT/rCnohFWmCX+wiu9voOVQVQeZIdgiMB5A
         2SNXwX9fz+RjaJSnbvl0JEwDMuBNdVhKTXjqV8WnZPZ7aOFVl0gzbv5fZUJPty5D0Uar
         o+fIc6wfeLymTcePN8ZQw5DszVR6s7EwCBWVJM1J5lR2Vgk3B4Ls4+Fgp22vbRoRkHpH
         Tra991nSrfAe70Juy9fF4jp1x9En87ue7Ri4UDEk8hg9aA9lWaoIVbXZ03ZdLTYOam9s
         GtRJ0rWbl3Gx4qQVXllLXTAngb/QaXrqKKBQQCWBV1aDURKZw0kLExRBz6U+DompWOzr
         j+Yg==
X-Gm-Message-State: ALoCoQmbDmjJ3Ds/k5wnvTiTJSE7Pt7x9/oAC8tqhCcCfuvDnMTkXGh5doS7A+Jz9y6dxLeNGT2Q
X-Received: by 10.140.91.66 with SMTP id y60mr6886459qgd.90.1438369311317;
        Fri, 31 Jul 2015 12:01:51 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id a1sm2657952qgf.33.2015.07.31.12.01.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Jul 2015 12:01:50 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275064>

Add a new function, die_if_shared_symref, which works like
die_if_checked_out, but for all references.  Refactor
die_if_checked_out to work in terms of die_if_shared_symref.

Soon, we will use die_if_shared_symref to protect notes merges in
worktrees.

Signed-off-by: David Turner <dturner@twopensource.com>
---

Oops, forgot I had split this into two patches.  This v3 includes the first patch.

---
 branch.c | 20 +++++++++++++-------
 branch.h |  7 +++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index c85be07..1f1b385 100644
--- a/branch.c
+++ b/branch.c
@@ -311,21 +311,22 @@ void remove_branch_state(void)
 	unlink(git_path("SQUASH_MSG"));
 }
 
-static void check_linked_checkout(const char *branch, const char *id)
+static void check_linked_checkout(const char *symref, const char *branch,
+				  const char *id)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 
 	/*
-	 * $GIT_COMMON_DIR/HEAD is practically outside
+	 * $GIT_COMMON_DIR/$symref is practically outside
 	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
 	 * uses git_path). Parse the ref ourselves.
 	 */
 	if (id)
-		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+		strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
 	else
-		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+		strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
 
 	if (!strbuf_readlink(&sb, path.buf, 0)) {
 		if (!starts_with(sb.buf, "refs/") ||
@@ -356,13 +357,13 @@ done:
 	strbuf_release(&gitdir);
 }
 
-void die_if_checked_out(const char *branch)
+void die_if_shared_symref(const char *symref, const char *branch)
 {
 	struct strbuf path = STRBUF_INIT;
 	DIR *dir;
 	struct dirent *d;
 
-	check_linked_checkout(branch, NULL);
+	check_linked_checkout(symref, branch, NULL);
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	dir = opendir(path.buf);
@@ -373,7 +374,12 @@ void die_if_checked_out(const char *branch)
 	while ((d = readdir(dir)) != NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
-		check_linked_checkout(branch, d->d_name);
+		check_linked_checkout(symref, branch, d->d_name);
 	}
 	closedir(dir);
 }
+
+void die_if_checked_out(const char *branch)
+{
+	die_if_shared_symref("HEAD", branch);
+}
diff --git a/branch.h b/branch.h
index 58aa45f..b2fca30 100644
--- a/branch.h
+++ b/branch.h
@@ -59,4 +59,11 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
  */
 extern void die_if_checked_out(const char *branch);
 
+/*
+ * Check if a symref points to a branch in the main worktree or any linked
+ * worktree and die (with a message describing its checkout location) if
+ * it is.
+ */
+extern void die_if_shared_symref(const char *symref, const char *branch);
+
 #endif
-- 
2.0.4.315.gad8727a-twtrsrc
