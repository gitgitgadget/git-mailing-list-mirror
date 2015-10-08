From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v10 4/5] worktree: add details to the worktree struct
Date: Thu,  8 Oct 2015 13:01:04 -0400
Message-ID: <1444323665-64590-4-git-send-email-rappazzo@gmail.com>
References: <1444323665-64590-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Thu Oct 08 19:01:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkEZO-0003hm-Az
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 19:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbbJHRBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 13:01:24 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34369 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964818AbbJHRBT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 13:01:19 -0400
Received: by qkdo1 with SMTP id o1so12799778qkd.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F6yndwl05WsTQB/yvRvbddR6/UhUWX9iAJYHYBevJvM=;
        b=YfjaFn3wfwqOCzDj0FS13LYG4psPF2T0cc3bdOWho2g2IdnqfMNOqKSyzPJ/bCwon2
         gxt0gZ5m+eJJ3sH6NI0wGxPkLJmmE8eT2FqVCai6oHOTpSw+kfGLnw3lPAcw5UIxf2N7
         MKFKESTtglSKBAez9D8KuGjKUBhdh5TreipcnmQ1WU2GTqjax3VbyFVhZkivBDkYGR9Y
         fbcv2Jvpxds5LUf9oWurNq+2PXrx5ld3cFNfZbTjFtNKSRSthLXIy7aXaXUyQDzwy5LI
         6slfxSSqnL2NxUI+S3XuInS4Wl0je66P5TsOBi8xUFivexyWShfs0bs+feffHSF85mfI
         Mb8A==
X-Received: by 10.55.23.83 with SMTP id i80mr9601976qkh.5.1444323678689;
        Thu, 08 Oct 2015 10:01:18 -0700 (PDT)
Received: from localhost.localdomain (16.sub-70-199-78.myvzw.com. [70.199.78.16])
        by smtp.gmail.com with ESMTPSA id e131sm18913002qhc.10.2015.10.08.10.01.17
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 10:01:18 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1444323665-64590-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279247>

In addition to the absolute path in the worktree struct, add the location
of the git dir, the head ref (if not detached), the head revision sha1,
whether or not head is detached, and whether or not the worktree is a
bare repo.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 worktree.c | 55 ++++++++++++++++++++++++++++++++++++++++++++-----------
 worktree.h |  4 ++++
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/worktree.c b/worktree.c
index c2e6db0..981f810 100644
--- a/worktree.c
+++ b/worktree.c
@@ -9,6 +9,8 @@ void free_worktrees(struct worktree **worktrees)
 
 	for (i = 0; worktrees[i]; i++) {
 		free(worktrees[i]->path);
+		free(worktrees[i]->git_dir);
+		free(worktrees[i]->head_ref);
 		free(worktrees[i]);
 	}
 	free (worktrees);
@@ -50,6 +52,21 @@ static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
 }
 
 /**
+ * Add the head_sha1 and head_ref (if not detached) to the given worktree
+ */
+static void add_head_info(struct strbuf *head_ref, struct worktree *worktree)
+{
+	if (head_ref->len) {
+		if (worktree->is_detached) {
+			get_sha1_hex(head_ref->buf, worktree->head_sha1);
+		} else {
+			resolve_ref_unsafe(head_ref->buf, 0, worktree->head_sha1, NULL);
+			worktree->head_ref = strbuf_detach(head_ref, NULL);
+		}
+	}
+}
+
+/**
  * get the main worktree
  */
 static struct worktree *get_main_worktree(void)
@@ -59,19 +76,29 @@ static struct worktree *get_main_worktree(void)
 	struct strbuf worktree_path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf head_ref = STRBUF_INIT;
+	int is_bare = 0;
+	int is_detached = 0;
 
 	strbuf_addf(&gitdir, "%s", absolute_path(get_git_common_dir()));
 	strbuf_addbuf(&worktree_path, &gitdir);
-	if (!strbuf_strip_suffix(&worktree_path, "/.git"))
+	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
+	if (is_bare)
 		strbuf_strip_suffix(&worktree_path, "/.");
 
 	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
-	if (parse_ref(path.buf, &head_ref, NULL) >= 0) {
-		worktree = xmalloc(sizeof(struct worktree));
-		worktree->path = strbuf_detach(&worktree_path, NULL);
-		worktree->git_dir = strbuf_detach(&gitdir, NULL);
-	}
+	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
+		goto done;
+
+	worktree = xmalloc(sizeof(struct worktree));
+	worktree->path = strbuf_detach(&worktree_path, NULL);
+	worktree->git_dir = strbuf_detach(&gitdir, NULL);
+	worktree->is_bare = is_bare;
+	worktree->head_ref = NULL;
+	worktree->is_detached = is_detached;
+	add_head_info(&head_ref, worktree);
+
+done:
 	strbuf_release(&path);
 	strbuf_release(&gitdir);
 	strbuf_release(&worktree_path);
@@ -86,6 +113,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	struct strbuf worktree_path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf head_ref = STRBUF_INIT;
+	int is_detached = 0;
 
 	if (!id)
 		die("Missing linked worktree name");
@@ -107,11 +135,16 @@ static struct worktree *get_linked_worktree(const char *id)
 	strbuf_reset(&path);
 	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
 
-	if (parse_ref(path.buf, &head_ref, NULL) >= 0) {
-		worktree = xmalloc(sizeof(struct worktree));
-		worktree->path = strbuf_detach(&worktree_path, NULL);
-		worktree->git_dir = strbuf_detach(&gitdir, NULL);
-	}
+	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
+		goto done;
+
+	worktree = xmalloc(sizeof(struct worktree));
+	worktree->path = strbuf_detach(&worktree_path, NULL);
+	worktree->git_dir = strbuf_detach(&gitdir, NULL);
+	worktree->is_bare = 0;
+	worktree->head_ref = NULL;
+	worktree->is_detached = is_detached;
+	add_head_info(&head_ref, worktree);
 
 done:
 	strbuf_release(&path);
diff --git a/worktree.h b/worktree.h
index 7022029..b4b3dda 100644
--- a/worktree.h
+++ b/worktree.h
@@ -4,6 +4,10 @@
 struct worktree {
 	char *path;
 	char *git_dir;
+	char *head_ref;
+	unsigned char head_sha1[20];
+	int is_detached;
+	int is_bare;
 };
 
 /* Functions for acting on the information about worktrees. */
-- 
2.6.0
