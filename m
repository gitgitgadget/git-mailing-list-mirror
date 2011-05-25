From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/10] revert: Introduce HEAD, TODO files to persist state, plan
Date: Wed, 25 May 2011 14:17:03 +0000
Message-ID: <1306333025-29893-9-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 16:17:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEtt-0003Uq-Ey
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613Ab1EYORX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:17:23 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53758 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab1EYORV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:17:21 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so3913824qwk.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=JJjG/TQssM4xnMYKgBKmFbdO8aVxofA0vVrCOQIaf2g=;
        b=H+ZuQUnI4vQjuX2qvrIYYwGG+ngxuT5nxKhQ3uzMlNSF6KhykP8v+asiUjrl2dIZBx
         2LRQHawryReN/69jbsBdzKtn6JkZxVXQFTNgkEoMpraz+n/+awFR4FB0UVHJ72ttx35G
         l9yTT3+eGTW2ZGXgPuyowpfFwJwXgwOWxTD+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fmSQ9+YsxHp1oewjjklXLPPHyUh++tI7IrCdWe4c1Z2/3zGeB8gSFBdW1xJ3k1iutl
         aNr4UEHRWB+nbh+dizFOWnivIvQNpFYvrYCX7NxdGYI+Q/JfmtS5HJT8I9Kgj+Ni7IS/
         4JkVODmxiWqGkXgI2sMN65vP1rI960X8KmvPg=
Received: by 10.224.217.133 with SMTP id hm5mr3734036qab.329.1306333040833;
        Wed, 25 May 2011 07:17:20 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id t17sm5285636qcs.35.2011.05.25.07.17.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:17:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174396>

Ever since v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than
one commit, 2010-06-02), a single invocation of "git cherry-pick" or
"git revert" can perform picks of several individual commits.  To
allow "git cherry-pick --abort" to cancel and "git cherry-pick
--continue" to resume the entire command, we will need to store some
information about the state and the plan at the beginning.  Introduce
a HEAD file to store this state, and TODO file to store the plan.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index d21af96..4741252 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -13,6 +13,7 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
+#include "dir.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -25,6 +26,12 @@
  * Copyright (c) 2005 Junio C Hamano
  */
 
+#define SEQ_DIR "sequencer"
+
+#define SEQ_PATH	git_path(SEQ_DIR)
+#define HEAD_FILE	git_path(SEQ_DIR "/head")
+#define TODO_FILE	git_path(SEQ_DIR "/todo")
+
 static const char * const revert_usage[] = {
 	"git revert [options] <commit-ish>",
 	NULL
@@ -584,22 +591,85 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
 }
 
+static void format_todo(struct strbuf *buf, struct commit_list *list,
+			struct replay_opts *opts)
+{
+	struct commit_list *cur = NULL;
+	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+	const char *sha1_abbrev = NULL;
+	const char *action;
+
+	action = (opts->action == REVERT ? "revert" : "pick");
+	for (cur = list; cur; cur = cur->next) {
+		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
+		if (get_message(sha1_abbrev, cur->item->buffer, &msg))
+			die(_("Cannot get commit message for %s"), sha1_abbrev);
+		strbuf_addf(buf, "%s %s %s\n", action, sha1_abbrev, msg.subject);
+	}
+}
+
+static void persist_head(unsigned char *head)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct lock_file head_lock;
+	int fd;
+
+	if (file_exists(SEQ_PATH)) {
+		if (!is_directory(SEQ_PATH) && remove_path(SEQ_PATH) < 0) {
+			strbuf_release(&buf);
+			die(_("Could not remove %s"), SEQ_PATH);
+		}
+	}
+	if (!file_exists(SEQ_PATH) && mkdir(SEQ_PATH, 0777) < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not create sequencer directory '%s'."), SEQ_PATH);
+	}
+
+	fd = hold_lock_file_for_update(&head_lock, HEAD_FILE, LOCK_DIE_ON_ERROR);
+	strbuf_addf(&buf, "%s", head);
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		die_errno(_("Could not write to %s."), HEAD_FILE);
+	if (commit_lock_file(&head_lock) < 0)
+		die(_("Error wrapping up %s"), HEAD_FILE);
+}
+
+static void persist_todo(struct commit_list *todo_list, struct replay_opts *opts)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct lock_file todo_lock;
+	int fd;
+
+	fd = hold_lock_file_for_update(&todo_lock, TODO_FILE, LOCK_DIE_ON_ERROR);
+	format_todo(&buf, todo_list, opts);
+	if (write_in_full(fd, buf.buf, buf.len) < 0)
+		die_errno(_("Could not write to %s."), TODO_FILE);
+	if (commit_lock_file(&todo_lock) < 0)
+		die(_("Error wrapping up %s"), TODO_FILE);
+}
+
 static int pick_commits(struct replay_opts *opts)
 {
 	struct rev_info revs;
 	struct commit *commit;
+	unsigned char head[20];
 
 	setenv(GIT_REFLOG_ACTION, me, 0);
-	read_and_refresh_cache(me, opts);
 
+	if (get_sha1("HEAD", head))
+		return error(_("You do not have a valid HEAD"));
+
+	read_and_refresh_cache(me, opts);
 	prepare_revs(&revs, opts);
+	persist_head(head);
 
 	while ((commit = get_revision(&revs))) {
 		int res = do_pick_commit(commit, opts);
-		if (res)
+		if (res) {
+			commit_list_insert(commit, &revs.commits);
+			persist_todo(revs.commits, opts);
 			return res;
+		}
 	}
-
 	return 0;
 }
 
-- 
1.7.5.GIT
