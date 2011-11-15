From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] revert: prettify fatal messages
Date: Tue, 15 Nov 2011 15:01:32 +0530
Message-ID: <1321349492-5653-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 10:33:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQFOG-0007u5-0S
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 10:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab1KOJdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 04:33:10 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64794 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab1KOJdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 04:33:09 -0500
Received: by yenq3 with SMTP id q3so396254yen.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 01:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/Mq9ru998oBDb1H0zzGJoS841qsjadlYWcOWODESH0Y=;
        b=Z05uv4aLZrd8De2uKiXgQI7GsWWfuRwey80NRD7AmjWotpfrkAsRg30eHXpSHm/hVM
         MPqJKcYESkHu+TWXI3hK21bJrPhYyA6WKWRvjzygbJjy0lulWJABbfYzDsHDZ3zSntT1
         xgS3R2UcS48POiJk2uap4QY0lhzf3f7U2gfg0=
Received: by 10.68.0.129 with SMTP id 1mr57570905pbe.94.1321349587863;
        Tue, 15 Nov 2011 01:33:07 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id g8sm45295602pbe.11.2011.11.15.01.33.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 01:33:06 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185448>

Some of the fatal messages printed by revert and cherry-pick look ugly
like the following:

  fatal: Could not open .git/sequencer/todo.: No such file or directory

The culprit here is the die_errno() function that takes a custom error
message string as an argument and appends ": <message from errno>"
before printing it.  So, we can fix the problem by not terminating the
string argument to the function with a '.' (period).  Fatal messages
look nicer now:

  fatal: Could not open .git/sequencer/todo: No such file or directory

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Candidate for 'maint'?

 builtin/revert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 87df70e..e0319c8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -331,7 +331,7 @@ static void write_message(struct strbuf *msgbuf, const char *filename)
 	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
 					       LOCK_DIE_ON_ERROR);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		die_errno(_("Could not write to %s."), filename);
+		die_errno(_("Could not write to %s"), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
 		die(_("Error wrapping up %s"), filename);
@@ -767,7 +767,7 @@ static void read_populate_todo(struct commit_list **todo_list,
 
 	fd = open(todo_file, O_RDONLY);
 	if (fd < 0)
-		die_errno(_("Could not open %s."), todo_file);
+		die_errno(_("Could not open %s"), todo_file);
 	if (strbuf_read(&buf, fd, 0) < 0) {
 		close(fd);
 		strbuf_release(&buf);
@@ -845,7 +845,7 @@ static int create_seq_dir(void)
 	if (file_exists(seq_dir))
 		return error(_("%s already exists."), seq_dir);
 	else if (mkdir(seq_dir, 0777) < 0)
-		die_errno(_("Could not create sequencer directory '%s'."), seq_dir);
+		die_errno(_("Could not create sequencer directory %s"), seq_dir);
 	return 0;
 }
 
@@ -859,7 +859,7 @@ static void save_head(const char *head)
 	fd = hold_lock_file_for_update(&head_lock, head_file, LOCK_DIE_ON_ERROR);
 	strbuf_addf(&buf, "%s\n", head);
 	if (write_in_full(fd, buf.buf, buf.len) < 0)
-		die_errno(_("Could not write to %s."), head_file);
+		die_errno(_("Could not write to %s"), head_file);
 	if (commit_lock_file(&head_lock) < 0)
 		die(_("Error wrapping up %s."), head_file);
 }
@@ -876,7 +876,7 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 		die(_("Could not format %s."), todo_file);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
-		die_errno(_("Could not write to %s."), todo_file);
+		die_errno(_("Could not write to %s"), todo_file);
 	}
 	if (commit_lock_file(&todo_lock) < 0) {
 		strbuf_release(&buf);
-- 
1.7.6.351.gb35ac.dirty
