From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v9 4/5] worktree: add details to the worktree struct
Date: Fri,  2 Oct 2015 07:55:34 -0400
Message-ID: <1443786935-81131-5-git-send-email-rappazzo@gmail.com>
References: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Oct 02 13:56:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhywr-00027e-1D
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 13:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbbJBL4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 07:56:11 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33331 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbbJBLzt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 07:55:49 -0400
Received: by ykft14 with SMTP id t14so107992979ykf.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6IYWE4UeqxJbo/DgSfCc96HTZW68sdEhtBkDq+EvfHw=;
        b=0cuI84uufigdbPcM9aYsD/3hfREOhUH2vPF/Cscc9siWjjLlHMNq+T8id0U8XcaH8M
         wyPJDfy0QG4obj1F6r9V0M7GV18ZKPLCoz7xTU5ZfTKDYESQ2vEjgnfmlgdDVlhLVLSf
         cdIwoqFhJ+cCs5i1g8tTo5mbotNjwkj2mSNBI+hRDNtcTiDcN2stPfqp83d49PP2byQg
         zE5IBAPx7M+E1STfeuoUIpW0ZOewEGCmXzznwXOkj1dY5Cy+E2TzNRyyO5EcduFD2X44
         Wkuk4/xZ+MEhuEcYaCG3EMG6i5DemEEC2GRrLhNQIInq81ZqiJhq0wTjF+YxgSphnclw
         1tHQ==
X-Received: by 10.170.73.66 with SMTP id p63mr12976519ykp.42.1443786949000;
        Fri, 02 Oct 2015 04:55:49 -0700 (PDT)
Received: from localhost.localdomain (113.sub-70-208-69.myvzw.com. [70.208.69.113])
        by smtp.gmail.com with ESMTPSA id v4sm7550431ywf.5.2015.10.02.04.55.47
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 04:55:48 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1443786935-81131-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278915>

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
index 11a3364..27af98a 100644
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
@@ -48,6 +50,21 @@ static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
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
@@ -57,19 +74,29 @@ static struct worktree *get_main_worktree(void)
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
@@ -84,6 +111,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	struct strbuf worktree_path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf head_ref = STRBUF_INIT;
+	int is_detached = 0;
 
 	if (!id)
 		die("Missing linked worktree name");
@@ -105,11 +133,16 @@ static struct worktree *get_linked_worktree(const char *id)
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
