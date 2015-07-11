From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 06/16] branch: publish die_if_checked_out()
Date: Fri, 10 Jul 2015 20:05:36 -0400
Message-ID: <1436573146-3893-7-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:20:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDp4r-0004vB-2N
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbbGKHT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:19:57 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36814 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbGKHT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:19:56 -0400
Received: by iecvh10 with SMTP id vh10so209117089iec.3
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=klmxgjw5cVZLMwOBfJ5B3IWnoaPegvCiK0vwk+G0E20=;
        b=amXik5+hfcIRPYiVZkRLOxGCkLpIpgwUrNa41j//2jk/NblNdRgl3nCXv6q2BiG0J/
         dypNSW88jLuUHlJNcL9x3tUlwO819CE5WYBxWQCe0MTJZ4avQI8Hm6NSJXDdDAa+k52M
         OEiqXdtfUmTErrtm9YkWY31wZTD/+EpGsFh7Cl3toh9gcaKgXwL4uIgmuo/dNIdqSjEK
         IIKBQycnZL+DoM2LzhdM/syI7JV0cg7MzQte7KfEwXgn/t3CDjoRK1OdCDQXweRFoTXu
         zBm7oBlqYojsCBFm9Bx720YXjMWBWJS+EiTs75sen5Rf7HmtByNfH/p91ZAnfKDYYK6R
         /tTg==
X-Received: by 10.107.133.234 with SMTP id p103mr6069868ioi.85.1436573193422;
        Fri, 10 Jul 2015 17:06:33 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.32
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273860>

git-worktree will eventually be retrofitted to populate the new worktree
via "git reset --hard" rather than "git checkout", at which time it will
need to be able to detect if the branch is already checked out
elsewhere, rather than relying upon git-branch to make this
determination, so publish die_if_checked_out().

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 branch.c           | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 branch.h           |  7 ++++++
 builtin/checkout.c | 65 ------------------------------------------------------
 3 files changed, 72 insertions(+), 65 deletions(-)

diff --git a/branch.c b/branch.c
index 4bab55a..7b8b9a3 100644
--- a/branch.c
+++ b/branch.c
@@ -309,3 +309,68 @@ void remove_branch_state(void)
 	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
 }
+
+static void check_linked_checkout(const char *branch, const char *id)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
+	const char *start, *end;
+
+	if (id)
+		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+	else
+		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+
+	if (strbuf_read_file(&sb, path.buf, 0) < 0 ||
+	    !skip_prefix(sb.buf, "ref:", &start))
+		goto done;
+	while (isspace(*start))
+		start++;
+	end = start;
+	while (*end && !isspace(*end))
+		end++;
+	if (strncmp(start, branch, end - start) || branch[end - start] != '\0')
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
+	/*
+	 * $GIT_COMMON_DIR/HEAD is practically outside
+	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
+	 * uses git_path). Parse the ref ourselves.
+	 */
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
index 673daa0..4ae895c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -873,71 +873,6 @@ static const char *unique_tracking_name(const char *name, unsigned char *sha1)
 	return NULL;
 }
 
-static void check_linked_checkout(const char *branch, const char *id)
-{
-	struct strbuf sb = STRBUF_INIT;
-	struct strbuf path = STRBUF_INIT;
-	struct strbuf gitdir = STRBUF_INIT;
-	const char *start, *end;
-
-	if (id)
-		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
-	else
-		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
-
-	if (strbuf_read_file(&sb, path.buf, 0) < 0 ||
-	    !skip_prefix(sb.buf, "ref:", &start))
-		goto done;
-	while (isspace(*start))
-		start++;
-	end = start;
-	while (*end && !isspace(*end))
-		end++;
-	if (strncmp(start, branch, end - start) || branch[end - start] != '\0')
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
-	/*
-	 * $GIT_COMMON_DIR/HEAD is practically outside
-	 * $GIT_DIR so resolve_ref_unsafe() won't work (it
-	 * uses git_path). Parse the ref ourselves.
-	 */
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
2.5.0.rc1.201.ga12d9f8
