From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v10 2/5] worktree: refactor find_linked_symref function
Date: Thu,  8 Oct 2015 13:01:02 -0400
Message-ID: <1444323665-64590-2-git-send-email-rappazzo@gmail.com>
References: <1444323665-64590-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Thu Oct 08 19:01:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkEZG-0003cj-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 19:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbbJHRBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 13:01:17 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33229 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964818AbbJHRBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 13:01:16 -0400
Received: by qgev79 with SMTP id v79so47242522qge.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8kcZ4/JHM72kMalhqPdggf1PMZ3+va7MjHH69BGGiBM=;
        b=L01ANDTZ80z/HOSjb+QuJR8Pcgei/6ZWxe2LEcnWC7wMYXGxQ6qyxKEzmJBCfqfWcf
         ++arpdc5Kvr8PXpQZFeWTRssCCfCVb1ItpbbS6Tf5Dsm4xDI28+dFnT3XJcAUC8YedgN
         5ti1/SJb26JItLOxUPut1Ekn2aKk/kHTGateqfp8Tds6qBjErpNpnOG83s9xzHH5aYVc
         KwH7oUgHFnmwb5oOiGW/XAeeig0Ys+IX/rY/5pNzg/3nAga3Z1zUXCM4nIH4N3jltbWP
         CErvpctGMDZ2HSE+xHP2HGW5gvd51StiY/24Ly8O8X26k59t/uSgkgaqCWVJBEct+4Pe
         1OYw==
X-Received: by 10.140.32.119 with SMTP id g110mr9444082qgg.15.1444323675989;
        Thu, 08 Oct 2015 10:01:15 -0700 (PDT)
Received: from localhost.localdomain (16.sub-70-199-78.myvzw.com. [70.199.78.16])
        by smtp.gmail.com with ESMTPSA id e131sm18913002qhc.10.2015.10.08.10.01.14
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 10:01:15 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1444323665-64590-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279244>

Refactoring will help transition this code to provide additional useful
worktree functions.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 worktree.c | 96 ++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 27 deletions(-)

diff --git a/worktree.c b/worktree.c
index 10e1496..3c2498a 100644
--- a/worktree.c
+++ b/worktree.c
@@ -3,6 +3,64 @@
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
+	if (!strbuf_readlink(ref, path_to_ref, 0)) {
+		/* HEAD is symbolic link */
+		if (!starts_with(ref->buf, "refs/") ||
+				check_refname_format(ref->buf, 0))
+			return -1;
+	} else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
+		/* textual symref or detached */
+		if (!starts_with(ref->buf, "ref:")) {
+			if (is_detached)
+				*is_detached = 1;
+		} else {
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
@@ -11,36 +69,20 @@ static char *find_linked_symref(const char *symref, const char *branch,
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
@@ -59,7 +101,7 @@ char *find_shared_symref(const char *symref, const char *target)
 	struct dirent *d;
 	char *existing;
 
-	if ((existing = find_linked_symref(symref, target, NULL)))
+	if ((existing = find_main_symref(symref, target)))
 		return existing;
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
-- 
2.6.0
