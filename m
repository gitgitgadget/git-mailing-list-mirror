From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v9 2/5] worktree: refactor find_linked_symref function
Date: Fri,  2 Oct 2015 07:55:32 -0400
Message-ID: <1443786935-81131-3-git-send-email-rappazzo@gmail.com>
References: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Oct 02 13:56:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhywj-00027e-S2
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 13:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbbJBL4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 07:56:10 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35083 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbbJBLzr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 07:55:47 -0400
Received: by ykdz138 with SMTP id z138so107729424ykd.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AQvi/EanrDtZS+OpwRYTD4XG4J39Vf1Bq6wjDlFj1qE=;
        b=y1Z0e7/UPkyOuOftDWHw29aEiM7KS3SGwzzJuDnTURnrFpLlqlAlFKQa8MJEovIxOI
         SidC9Q0fPw2iHbXdj5Ge0flxSpqLChwnAaybEJ5GrBtwVoi+itOXr7yyTwpYutCsYw8Z
         HyCMXjsnY5EnqkSAZUZtgv3MNmcY2f7Aw36FsQtcy1WLoDg3gCdOjzzQhOY+JurdOau/
         DIAat9CfQRabc9xPqh8HNgEvoo4VHjSeBFvkyEaa7jUGY9xbgvv2HtDtgwV7by5toB11
         cqi4BqsWeHcpBgnsr2OVKZjwAwiFMwcY7dNCLn3N9yThOfGD1GXvdl/qlsBegSRo8R2N
         4BTw==
X-Received: by 10.170.225.68 with SMTP id r65mr13062004ykf.58.1443786946523;
        Fri, 02 Oct 2015 04:55:46 -0700 (PDT)
Received: from localhost.localdomain (113.sub-70-208-69.myvzw.com. [70.208.69.113])
        by smtp.gmail.com with ESMTPSA id v4sm7550431ywf.5.2015.10.02.04.55.45
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 04:55:46 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278913>

Refactoring will help transition this code to provide additional useful
worktree functions.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 worktree.c | 94 ++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 27 deletions(-)

diff --git a/worktree.c b/worktree.c
index 10e1496..c049947 100644
--- a/worktree.c
+++ b/worktree.c
@@ -3,6 +3,62 @@
 #include "strbuf.h"
 #include "worktree.h"
 
+/*
+ * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
+ * set is_detached to 1 (0) if the ref is detatched (is not detached).
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
+	if (!strbuf_readlink(ref, path_to_ref, 0))
+		if (!starts_with(ref->buf, "refs/") ||
+				check_refname_format(ref->buf, 0))
+			return -1;
+	else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
+		if (!starts_with(ref->buf, "ref:"))
+			if (is_detached)
+				*is_detached = 1;
+		else {
+			strbuf_remove(ref, 0, strlen("ref:"));
+			strbuf_trim(ref);
+			if (check_refname_format(ref->buf, 0))
+				return -1;
+		}
+	} else
+		return -1;
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
+	if (parse_ref(path.buf, &sb, NULL) < 0)
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
@@ -11,36 +67,20 @@ static char *find_linked_symref(const char *symref, const char *branch,
 	struct strbuf gitdir = STRBUF_INIT;
 	char *existing = NULL;
 
-	/*
-	 * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside
-	 * $GIT_DIR so resolve_ref_unsafe() won't work (it uses
-	 * git_path). Parse the ref ourselves.
-	 */
-	if (id)
-		strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
-	else
-		strbuf_addf(&path, "%s/%s", get_git_common_dir(), symref);
+	if (!id)
+		die("Missing linked worktree name");
 
-	if (!strbuf_readlink(&sb, path.buf, 0)) {
-		if (!starts_with(sb.buf, "refs/") ||
-		    check_refname_format(sb.buf, 0))
-			goto done;
-	} else if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
-	    starts_with(sb.buf, "ref:")) {
-		strbuf_remove(&sb, 0, strlen("ref:"));
-		strbuf_trim(&sb);
-	} else
+	strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, symref);
+
+	if (parse_ref(path.buf, &sb, NULL) < 0)
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
@@ -59,7 +99,7 @@ char *find_shared_symref(const char *symref, const char *target)
 	struct dirent *d;
 	char *existing;
 
-	if ((existing = find_linked_symref(symref, target, NULL)))
+	if ((existing = find_main_symref(symref, target)))
 		return existing;
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
-- 
2.6.0
