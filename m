From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/11] revert: Write head, todo, done files
Date: Sun, 10 Apr 2011 20:41:55 +0530
Message-ID: <1302448317-32387-10-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:14:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wKu-0008Ux-Mo
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048Ab1DJPNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:13:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58633 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab1DJPNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:13:54 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so4864294iwn.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=90qKmipUpcEVC9dmx42hO9RqE39aT49PAEy8OiMTGJo=;
        b=HaQ6ohrdARJN5ENjU8AlAVcMR373uICXESwr6p12Bi+fcX2dS+p3xukZLZSkBrJiIz
         M2Eq4WxFYCY3UycmiTkMyTq5C5OAd+KTNOvjg273fPtyYsLbIDrekz8zlY7IwqM25l6b
         P3VPdwP5haXxzDquneoEg2HcIGBwnzeSrd2jc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S825cZAYflQs0tXYb8/pdTr34gzmu4udAhWD9BEgdsMLZPkj8XIHDfXL0uql0utr98
         ryISlDRW02hCTwQnGCsbYXK7j6kSC6uCauaDFyGqYpBqz6gncZXWWi288YBlWbdBrdZT
         uSJ5PqYJcDkKaUC5UojFfJUFlthZyKR3QWOG8=
Received: by 10.231.1.30 with SMTP id 30mr4205179ibd.168.1302448434516;
        Sun, 10 Apr 2011 08:13:54 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.13.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:13:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171263>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e0352d4..25969a5 100644
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
@@ -643,21 +651,95 @@ static int read_and_refresh_cache(void)
 	return 0;
 }
 
+static void format_todo(struct strbuf *buf, struct commit_list *list)
+{
+	struct commit_list *cur = NULL;
+	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
+	const char *sha1 = NULL;
+	const char *action;
+
+	action = (cmd_opts.action == REVERT ? "revert" : "pick");
+	for (cur = list; cur; cur = cur->next) {
+		sha1 = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
+		if (get_message(cur->item, cur->item->buffer, &msg))
+			die("Cannot get commit message for %s", sha1);
+
+		strbuf_addf(buf, "%s %s %s\n", action, sha1, msg.subject);
+	}
+}
+
+static int persist_initialize(unsigned char *head)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	if (!file_exists(SEQ_PATH) && mkdir(SEQ_PATH, 0777))
+		return error_errno(_("Could not create sequencer directory '%s'"), SEQ_PATH);
+
+	if ((fd = open(HEAD_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0666)) < 0)
+		return error_errno(_("Could not open '%s' for writing"), HEAD_FILE);
+
+	strbuf_addf(&buf, "%s", find_unique_abbrev(head, DEFAULT_ABBREV));
+	write_or_whine(fd, buf.buf, buf.len, HEAD_FILE);
+	close(fd);
+	strbuf_release(&buf);
+	return 0;
+}
+
+static int persist_todo_done(int res, struct commit_list *todo_list,
+			struct commit_list *done_list)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	if (!res)
+		return 0;
+
+	/* TODO file */
+	if ((fd = open(TODO_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0666)) < 0)
+		return error_errno(_("Could not open '%s' for writing"), TODO_FILE);
+
+	format_todo(&buf, todo_list);
+	write_or_whine(fd, buf.buf, buf.len, TODO_FILE);
+	close(fd);
+
+	/* DONE file */
+	strbuf_reset(&buf);
+	if ((fd = open(DONE_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0666)) < 0)
+		return error_errno(_("Could not open '%s' for writing"), DONE_FILE);
+
+	format_todo(&buf, done_list);
+	write_or_whine(fd, buf.buf, buf.len, DONE_FILE);
+	close(fd);
+	strbuf_release(&buf);
+	return res;
+}
+
 static int pick_commits(void)
 {
+	struct commit_list *done_list = NULL;
 	struct rev_info revs;
 	struct commit *commit;
+	unsigned char head[20];
 	int res;
 
+	if (get_sha1("HEAD", head))
+		return error(_("You do not have a valid HEAD"));
+
 	if ((res = read_and_refresh_cache()) ||
-		(res = prepare_revs(&revs)))
+		(res = prepare_revs(&revs)) ||
+		(res = persist_initialize(head)))
 		return res;
 
-	while ((commit = get_revision(&revs)) &&
-		!(res = do_pick_commit(commit)))
-		;
-
-	return res;
+	while ((commit = get_revision(&revs))) {
+		if (!(res = do_pick_commit(commit)))
+			commit_list_insert(commit, &done_list);
+		else {
+			commit_list_insert(commit, &revs.commits);
+			break;
+		}
+	}
+	return persist_todo_done(res, revs.commits, done_list);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
-- 
1.7.4.rc1.7.g2cf08.dirty
