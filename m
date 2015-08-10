From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 1/2] worktrees: add find_shared_symref
Date: Mon, 10 Aug 2015 13:52:44 -0400
Message-ID: <1439229165-25773-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, johan@herland.net,
	sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon Aug 10 19:53:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOrFz-00015Z-7V
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 19:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbbHJRxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 13:53:00 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38862 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbbHJRw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 13:52:57 -0400
Received: by igfj19 with SMTP id j19so55043408igf.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 10:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tn7k4+Tb5HtPR050Wquqp5kRohWglQHXHU30cczft6w=;
        b=I72Q02FZPARBe3PA7A1K94VanTp35i8hbUnQ3YbUvGrzfvD6FiT/oE6PaSFkbhcNE2
         0SWp09QbPX6R6qKvT/M/meV4C1RZvVgLibXYBl3/7VpL2tj5wd8cua5A88ZFvdvh8ZwG
         dIm6FVRA2ao1sujoAfXVa1AZ/diZsjxwEQCKcZhZM/irRDc+KYZjGnrkecCqXCH5ldIt
         iZZhZo8AyS7g31MSxZHR7KzAt5dVTuV2hGE0twrRU6cFFsAxw8dkEGBqUBHQUsaNQsly
         O6FgR/6GCgv2JAArL9YGTPgMNB5Rdr6Xl9Qn203G3RpwCmoPJ69v52iG1+BJzXoiZ7Om
         9BZg==
X-Gm-Message-State: ALoCoQlovH0El5JeyjUNBNyBAiRUUmzm6Xs16+Y74V7V0ZZzOoJAAQsLYuHnQjOh92v7HG6kXmi0
X-Received: by 10.50.67.99 with SMTP id m3mr11992088igt.68.1439229177328;
        Mon, 10 Aug 2015 10:52:57 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id v18sm6296551igr.3.2015.08.10.10.52.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Aug 2015 10:52:56 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275643>

Add a new function, find_shared_symref, which contains the heart of
die_if_checked_out, but works for any symref, not just HEAD.  Refactor
die_if_checked_out to use the same infrastructure as
find_shared_symref.

Soon, we will use find_shared_symref to protect notes merges in
worktrees.

Signed-off-by: David Turner <dturner@twopensource.com>
---

Please disregard v6.

This version addresses Eric Sunshine's comments on v5.  It fixes an error
message and cleans up the code.

---
 branch.c | 46 ++++++++++++++++++++++++++++++++++------------
 branch.h |  8 ++++++++
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/branch.c b/branch.c
index c85be07..07c8b1e 100644
--- a/branch.c
+++ b/branch.c
@@ -311,21 +311,23 @@ void remove_branch_state(void)
 	unlink(git_path("SQUASH_MSG"));
 }
 
-static void check_linked_checkout(const char *branch, const char *id)
+static char *find_linked_symref(const char *symref, const char *branch,
+				const char *id)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
+	char *existing = NULL;
 
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
@@ -347,33 +349,53 @@ static void check_linked_checkout(const char *branch, const char *id)
 		strbuf_rtrim(&gitdir);
 	} else
 		strbuf_addstr(&gitdir, get_git_common_dir());
-	skip_prefix(branch, "refs/heads/", &branch);
 	strbuf_strip_suffix(&gitdir, ".git");
-	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
+
+	existing = strbuf_detach(&gitdir, NULL);
 done:
 	strbuf_release(&path);
 	strbuf_release(&sb);
 	strbuf_release(&gitdir);
+
+	return existing;
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
+		existing = find_linked_symref(symref, target, d->d_name);
+		if (existing)
+			goto done;
 	}
+done:
 	closedir(dir);
+
+	return existing;
+}
+
+void die_if_checked_out(const char *branch)
+{
+	char *existing;
+
+	existing = find_shared_symref("HEAD", branch);
+	if (existing) {
+		skip_prefix(branch, "refs/heads/", &branch);
+		die(_("'%s' is already checked out at '%s'"), branch, existing);
+	}
 }
diff --git a/branch.h b/branch.h
index 58aa45f..d3446ed 100644
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
+extern char *find_shared_symref(const char *symref, const char *target);
+
 #endif
-- 
2.0.4.315.gad8727a-twtrsrc
