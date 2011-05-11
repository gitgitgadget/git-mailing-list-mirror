From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/8] revert: Introduce head, todo, done files to persist state
Date: Wed, 11 May 2011 13:30:20 +0530
Message-ID: <1305100822-20470-7-git-send-email-artagnon@gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 17:36:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBSm-0004Z1-I7
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab1EKPgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 11:36:33 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:17875 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab1EKPgP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 11:36:15 -0400
X-IronPort-AV: E=Sophos;i="4.64,351,1301875200"; 
   d="scan'208";a="77408856"
Received: from smtp-in-1105.vdc.amazon.com ([10.140.9.24])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 May 2011 08:01:01 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-1105.vdc.amazon.com (8.13.8/8.13.8) with ESMTP id p4B80xDJ022008;
	Wed, 11 May 2011 08:01:00 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id A4C15754837; Wed, 11 May 2011 13:30:22 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173388>

A cherry-pick/ revert operation consists of several smaller steps.
Later in the series, we would like to be able to resume a failed
operation.  As a prelude, we first need to persist the current state
of operation.  Introduce a "head" file to make note of the HEAD when
the operation stated (so that the operation can be aborted), a "todo"
file to keep the list of the steps to be performed, and a "done" file
to keep a list of steps that have completed successfully.  The format
of these files is similar to the one used by the "rebase -i" process.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Note how I've used the words "operation" and "step" to differentiate
 between a picking/ reverting a single commit versus the entire
 operation in the commit message.  In one discussion involving
 Jonathan and Daniel, it was discussed that multiple meta-picking/
 reverting levels is a goal that is tangential to this project.  I
 only intend to support two levels: the overall "operation", and the
 composite "steps".

 builtin/revert.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 111 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0fe87e8..13569c2 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -13,6 +13,7 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
+#include "dir.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -25,6 +26,13 @@
  * Copyright (c) 2005 Junio C Hamano
  */
 
+#define SEQ_DIR "sequencer"
+
+#define SEQ_PATH	git_path(SEQ_DIR)
+#define HEAD_FILE	git_path(SEQ_DIR "/head")
+#define TODO_FILE	git_path(SEQ_DIR "/todo")
+#define DONE_FILE	git_path(SEQ_DIR "/done")
+
 static const char * const revert_usage[] = {
 	"git revert [options] <commit-ish>",
 	NULL
@@ -629,21 +637,118 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 	return 0;
 }
 
+static int format_todo(struct strbuf *buf, struct commit_list *list,
+			struct replay_opts *opts)
+{
+	struct commit_list *cur = NULL;
+	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+	const char *sha1 = NULL;
+	const char *action;
+
+	action = (opts->action == REVERT ? "revert" : "pick");
+	for (cur = list; cur; cur = cur->next) {
+		sha1 = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
+		if (get_message(cur->item, cur->item->buffer, &msg))
+			return error(_("Cannot get commit message for %s"), sha1);
+		strbuf_addf(buf, "%s %s %s\n", action, sha1, msg.subject);
+	}
+	return 0;
+}
+
+static int persist_initialize(unsigned char *head)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	if (!file_exists(SEQ_PATH) && mkdir(SEQ_PATH, 0777)) {
+		int err = errno;
+		strbuf_release(&buf);
+		error(_("Could not create sequencer directory '%s': %s"),
+			SEQ_PATH, strerror(err));
+		return -err;
+	}
+
+	if ((fd = open(HEAD_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0666)) < 0) {
+		int err = errno;
+		strbuf_release(&buf);
+		error(_("Could not open '%s' for writing: %s"),
+			HEAD_FILE, strerror(err));
+		return -err;
+	}
+
+	strbuf_addf(&buf, "%s", find_unique_abbrev(head, DEFAULT_ABBREV));
+	write_or_whine(fd, buf.buf, buf.len, HEAD_FILE);
+	close(fd);
+	strbuf_release(&buf);
+	return 0;
+}
+
+static int persist_todo_done(int res, struct commit_list *todo_list,
+			struct commit_list *done_list, struct replay_opts *opts)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int fd, res2;
+
+	if (!res)
+		return 0;
+
+	/* TODO file */
+	if ((fd = open(TODO_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0666)) < 0) {
+		int err = errno;
+		strbuf_release(&buf);
+		error(_("Could not open '%s' for writing: %s"),
+			TODO_FILE, strerror(err));
+		return -err;
+	}
+
+	if ((res2 = format_todo(&buf, todo_list, opts)))
+		return res2;
+	write_or_whine(fd, buf.buf, buf.len, TODO_FILE);
+	close(fd);
+
+	/* DONE file */
+	strbuf_reset(&buf);
+	if ((fd = open(DONE_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0666)) < 0) {
+		int err = errno;
+		strbuf_release(&buf);
+		error(_("Could not open '%s' for writing: %s"),
+			DONE_FILE, strerror(err));
+		return -err;
+	}
+
+	if ((res2 = format_todo(&buf, done_list, opts)))
+		return res2;
+	write_or_whine(fd, buf.buf, buf.len, DONE_FILE);
+	close(fd);
+	strbuf_release(&buf);
+	return res;
+}
+
 static int pick_commits(struct replay_opts *opts)
 {
+	struct commit_list *done_list = NULL;
 	struct rev_info revs;
 	struct commit *commit;
+	unsigned char head[20];
 	int res;
 
+	if (get_sha1("HEAD", head))
+		return error(_("You do not have a valid HEAD"));
+
 	if ((res = read_and_refresh_cache(opts)) ||
-		(res = prepare_revs(&revs, opts)))
+		(res = prepare_revs(&revs, opts)) ||
+		(res = persist_initialize(head)))
 		return res;
 
-	while ((commit = get_revision(&revs)) &&
-		!(res = do_pick_commit(commit, opts)))
-		;
-
-	return res;
+	while ((commit = get_revision(&revs))) {
+		if (!(res = do_pick_commit(commit, opts)))
+			commit_list_insert(commit, &done_list);
+		else {
+			commit_list_insert(commit, &revs.commits);
+			break;
+		}
+	}
+	return persist_todo_done(res, revs.commits, done_list, opts);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
-- 
1.7.5.GIT
