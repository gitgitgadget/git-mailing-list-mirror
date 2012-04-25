From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] sequencer: export commit_list_append()
Date: Wed, 25 Apr 2012 22:35:27 +0200
Message-ID: <4F98600F.6000404@lsrfire.ath.cx>
References: <CANV9Rr_ev+34Wd030cps0UbgjRYD0=L2DQhbrCOkBVWG-2xaug@mail.gmail.com> <20120425111435.GA21579@sigill.intra.peff.net> <4F985D0A.9020100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Michael Mueller <mmueller@vigilantsw.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 22:35:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN8wL-0001mh-1T
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 22:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758844Ab2DYUfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 16:35:48 -0400
Received: from india601.server4you.de ([85.25.151.105]:57249 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758815Ab2DYUfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 16:35:48 -0400
Received: from [192.168.2.105] (p4FFDBB95.dip.t-dialin.net [79.253.187.149])
	by india601.server4you.de (Postfix) with ESMTPSA id F1DE12F8047;
	Wed, 25 Apr 2012 22:35:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <4F985D0A.9020100@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196335>

This function can be used in other parts of git.  Give it a new home
in commit.c.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 commit.c    |   27 +++++++++++++++++++++++++++
 commit.h    |    2 ++
 sequencer.c |   27 ---------------------------
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/commit.c b/commit.c
index b80a452..8361acb 100644
--- a/commit.c
+++ b/commit.c
@@ -1214,3 +1214,30 @@ struct commit *get_merge_parent(const char *name)
 	}
 	return commit;
 }
+
+/*
+ * Append a commit to the end of the commit_list.
+ *
+ * next starts by pointing to the variable that holds the head of an
+ * empty commit_list, and is updated to point to the "next" field of
+ * the last item on the list as new commits are appended.
+ *
+ * Usage example:
+ *
+ *     struct commit_list *list;
+ *     struct commit_list **next = &list;
+ *
+ *     next = commit_list_append(c1, next);
+ *     next = commit_list_append(c2, next);
+ *     assert(commit_list_count(list) == 2);
+ *     return list;
+ */
+struct commit_list **commit_list_append(struct commit *commit,
+					struct commit_list **next)
+{
+	struct commit_list *new = xmalloc(sizeof(struct commit_list));
+	new->item = commit;
+	*next = new;
+	new->next = NULL;
+	return &new->next;
+}
diff --git a/commit.h b/commit.h
index f8d250d..bd17770 100644
--- a/commit.h
+++ b/commit.h
@@ -53,6 +53,8 @@ int find_commit_subject(const char *commit_buffer, const char **subject);
 
 struct commit_list *commit_list_insert(struct commit *item,
 					struct commit_list **list);
+struct commit_list **commit_list_append(struct commit *commit,
+					struct commit_list **next);
 unsigned commit_list_count(const struct commit_list *l);
 struct commit_list *commit_list_insert_by_date(struct commit *item,
 				    struct commit_list **list);
diff --git a/sequencer.c b/sequencer.c
index 4307364..ac6c823 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -468,33 +468,6 @@ static void read_and_refresh_cache(struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
 }
 
-/*
- * Append a commit to the end of the commit_list.
- *
- * next starts by pointing to the variable that holds the head of an
- * empty commit_list, and is updated to point to the "next" field of
- * the last item on the list as new commits are appended.
- *
- * Usage example:
- *
- *     struct commit_list *list;
- *     struct commit_list **next = &list;
- *
- *     next = commit_list_append(c1, next);
- *     next = commit_list_append(c2, next);
- *     assert(commit_list_count(list) == 2);
- *     return list;
- */
-static struct commit_list **commit_list_append(struct commit *commit,
-					       struct commit_list **next)
-{
-	struct commit_list *new = xmalloc(sizeof(struct commit_list));
-	new->item = commit;
-	*next = new;
-	new->next = NULL;
-	return &new->next;
-}
-
 static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 		struct replay_opts *opts)
 {
-- 
1.7.10
