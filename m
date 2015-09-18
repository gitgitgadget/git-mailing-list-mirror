From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v8 2/4] worktree: refactor find_linked_symref function
Date: Fri, 18 Sep 2015 09:30:25 -0400
Message-ID: <1442583027-47653-3-git-send-email-rappazzo@gmail.com>
References: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Sep 18 15:31:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcvl0-0005du-1r
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 15:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbbIRNbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 09:31:08 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33850 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbbIRNbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 09:31:07 -0400
Received: by qkfq186 with SMTP id q186so19281743qkf.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jo/hgj0nwZQoglP8CaBfCra2T1N2JK1Q24HUXBlB9A0=;
        b=iCiwxJ460Sdp6X7tdHrZ5KbyWwktO2MUf7oSkMBNUGRtiAGIZYBoJ+LlHwKIz4kGR/
         MfPCa+YZjCQRZb/iN4lj5/M2IFTqe3vJ+M58rn2ZtUh7g+vJiyXLbdGdfG4tSyKXJ6PA
         VXJ9FQKV9B4/5nezyUiYfDKwgDiSe51M0EgaVafHTgYBAjGamtLUJmcH6dy/sEeUrKSX
         oliOnoK+cAjVoKbRDVecC55z0hgsaXcnfL5wSm2nYA85cjXkTvzzMtNaLhZuv41l2U5X
         6j7HRvn1T8XFc9Te39QcxUWBnZRR3WEKfXoD4Dk5ViqmjDyF9vVyAe6psMshXvrdAR4P
         mGkQ==
X-Received: by 10.55.42.65 with SMTP id q62mr6362283qkh.12.1442583066146;
        Fri, 18 Sep 2015 06:31:06 -0700 (PDT)
Received: from localhost.localdomain (109.sub-70-199-70.myvzw.com. [70.199.70.109])
        by smtp.gmail.com with ESMTPSA id i19sm3586051qkh.13.2015.09.18.06.31.05
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Sep 2015 06:31:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278193>

Refactoring will help transition this code to provide additional useful
worktree functions.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 worktree.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 22 deletions(-)

diff --git a/worktree.c b/worktree.c
index 10e1496..5c75875 100644
--- a/worktree.c
+++ b/worktree.c
@@ -3,6 +3,60 @@
 #include "strbuf.h"
 #include "worktree.h"
 
+/*
+ * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
+ * set is_detached to 1 if the ref is detatched.
+ *
+ * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so
+ * for linked worktrees, `resolve_ref_unsafe()` won't work (it uses
+ * git_path). Parse the ref ourselves.
+ *
+ * return -1 if the ref is not a proper ref, 0 otherwise (success)
+ */
+static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
+{
+	if (is_detached)
+		*is_detached = 0;
+	if (!strbuf_readlink(ref, path_to_ref, 0)) {
+		if (!starts_with(ref->buf, "refs/")
+				|| check_refname_format(ref->buf, 0))
+			return -1;
+
+	} else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
+		if (starts_with(ref->buf, "ref:")) {
+			strbuf_remove(ref, 0, strlen("ref:"));
+			strbuf_trim(ref);
+			if (check_refname_format(ref->buf, 0))
+				return -1;
+		} else if (is_detached)
+			*is_detached = 1;
+	}
+	return 0;
+}
+
+static char *find_main_symref(const char *symref, const char *branch)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
+	char *existing = NULL;
+
+	strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
+	if (parse_ref(path.buf, &sb, NULL) == -1)
+		goto done;
+	if (strcmp(sb.buf, branch))
+		goto done;
+	strbuf_addstr(&gitdir, get_git_common_dir());
+	strbuf_strip_suffix(&gitdir, ".git");
+	existing = strbuf_detach(&gitdir, NULL);
+done:
+	strbuf_release(&path);
+	strbuf_release(&sb);
+	strbuf_release(&gitdir);
+
+	return existing;
+}
+
 static char *find_linked_symref(const char *symref, const char *branch,
 				const char *id)
 {
@@ -11,36 +65,24 @@ static char *find_linked_symref(const char *symref, const char *branch,
 	struct strbuf gitdir = STRBUF_INIT;
 	char *existing = NULL;
 
+	if (!id)
+		goto done;
 	/*
 	 * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside
 	 * $GIT_DIR so resolve_ref_unsafe() won't work (it uses
 	 * git_path). Parse the ref ourselves.
 	 */
-	if (id)
-		strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
-	else
-		strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
+	strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
 
-	if (!strbuf_readlink(&sb, path.buf, 0)) {
-		if (!starts_with(sb.buf, "refs/") ||
-		    check_refname_format(sb.buf, 0))
-			goto done;
-	} else if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
-	    starts_with(sb.buf, "ref:")) {
-		strbuf_remove(&sb, 0, strlen("ref:"));
-		strbuf_trim(&sb);
-	} else
+	if (parse_ref(path.buf, &sb, NULL) == -1)
 		goto done;
 	if (strcmp(sb.buf, branch))
 		goto done;
-	if (id) {
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s/worktrees/%s/gitdir", get_git_common_dir(), id);
-		if (strbuf_read_file(&gitdir, path.buf, 0) <= 0)
-			goto done;
-		strbuf_rtrim(&gitdir);
-	} else
-		strbuf_addstr(&gitdir, get_git_common_dir());
+	strbuf_reset(&path);
+	strbuf_addf(&path, "%s/worktrees/%s/gitdir", get_git_common_dir(), id);
+	if (strbuf_read_file(&gitdir, path.buf, 0) <= 0)
+		goto done;
+	strbuf_rtrim(&gitdir);
 	strbuf_strip_suffix(&gitdir, ".git");
 
 	existing = strbuf_detach(&gitdir, NULL);
@@ -59,7 +101,7 @@ char *find_shared_symref(const char *symref, const char *target)
 	struct dirent *d;
 	char *existing;
 
-	if ((existing = find_linked_symref(symref, target, NULL)))
+	if ((existing = find_main_symref(symref, target)))
 		return existing;
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
-- 
2.5.0
