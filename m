From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 1/2] worktrees: add find_shared_symref
Date: Mon,  3 Aug 2015 14:48:25 -0400
Message-ID: <1438627706-6743-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, johan@herland.net,
	sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon Aug 03 20:48:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMKmp-0002zG-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 20:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbbHCSsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 14:48:31 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36818 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbbHCSsa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 14:48:30 -0400
Received: by qkdv3 with SMTP id v3so54125984qkd.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 11:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LXjFFLW+y0dpQnufrilE37hunbXcGDLiFgC/wDyLc0Y=;
        b=QELE7KUJT4W2ribRZyFkk56pKsupmlF4FVybsDiKw3k+lT0CbSal405f/MOSAvvIPn
         YSWHpEabA+pz5FbjTnPRHu9gHfjYbfNR0NcKuLlZQcnovhNg3VOzLEA81Jh1x+075ou7
         qtcvCbZLKc5OvuzIHVhL2NJz4uBypoW3DjWgQ3wJQbUPv+EnmSQ9M6au4xJh0IZoGMwo
         ozQ6e1V56aYqPxrHNqVF65qUew8CPKyoyPOVLtGgV2siMtyIw6yzwn5uJkz2l8fFxWTb
         lWQdPCmjh6+S1I4fTjRYDKjW/WqNDmUudLSPi4Jmm6SVE8LLAqPl2G/pTg8ctAZfah85
         Gq/Q==
X-Gm-Message-State: ALoCoQlyV+AqO5HztgYSWund5Qx+N0OPUJlUpPS+Jw/5hfvT51OGAeg2dsD6/pynpqf/o3kpIPFt
X-Received: by 10.55.31.65 with SMTP id f62mr25967046qkf.73.1438627709837;
        Mon, 03 Aug 2015 11:48:29 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id z18sm7321515qkz.3.2015.08.03.11.48.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Aug 2015 11:48:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275187>

Add a new function, find_shared_symref, which contains the heart of
die_if_checked_out, but works for any symref, not just HEAD.  Refactor
die_if_checked_out to use the same infrastructure as
find_shared_symref.

Soon, we will use find_shared_symref to protect notes merges in
worktrees.

Signed-off-by: David Turner <dturner@twopensource.com>
---

This reroll fixes issues reported by Eric Sunshine: leaks
and Johan Herland: prepositions and broken &&

---
 branch.c | 45 ++++++++++++++++++++++++++++++++++-----------
 branch.h |  8 ++++++++
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/branch.c b/branch.c
index c85be07..d2b3586 100644
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
@@ -349,31 +350,53 @@ static void check_linked_checkout(const char *branch, const char *id)
 		strbuf_addstr(&gitdir, get_git_common_dir());
 	skip_prefix(branch, "refs/heads/", &branch);
 	strbuf_strip_suffix(&gitdir, ".git");
-	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
+
+	strbuf_release(&path);
+	strbuf_release(&sb);
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
+		existing = find_linked_symref(symref, target, d->d_name);
+		if (existing) {
+			closedir(dir);
+			return existing;
+		}
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
