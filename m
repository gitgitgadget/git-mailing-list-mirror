From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 11/13] revert: Introduce a layer of indirection over pick_commits
Date: Tue, 21 Jun 2011 13:04:47 +0000
Message-ID: <1308661489-20080-12-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0e8-00065X-Rx
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681Ab1FUNFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:05:18 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37268 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667Ab1FUNFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:05:12 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so1674206vws.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=v8ebA2qjyIi+kMlCACDgypCk1g7ojNpC3aXvHq0aPy4=;
        b=rwu2mB9rRzLi1LoSaSWDF0l6UOWf+wgJYig0o2P+LQozTea/puSnuYVo/qiF62BJ5w
         M1LoeSED8IGsWDWEWGNRLM3wg8XTokB0vYuQhuKvOR9UsWdhraJyDvLU7Sn6k7K722Br
         WCjm0zfMHOZ4sNYi0TDW/rxBPRbMnWlvag4IE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wg993itE7WeWxKa/2tRAodItmAeGpVpEWigW5lvjNpb5gNv+I2BH8K9HVynmCNXucA
         6bVt5pHXp/UnyYF0LDIiug4G1UAFbf3c2QuQF/1HOUGjIyMRrH0JPXpG3KbFUc0XtRE/
         2lathCrEpphVagQODqLAU9LTBIFHp/arEcXmY=
Received: by 10.52.76.198 with SMTP id m6mr7792489vdw.0.1308661511581;
        Tue, 21 Jun 2011 06:05:11 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.05.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:05:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176146>

Write a new function called process_continuation to prepare a
todo_list to call pick_commits with; the job of pick_commits is
simplified into performing the tasks listed in todo_list.  This will
be useful when continuation functionality like "--continue" is
introduced later in the series.

Helped-by: Jonathan Nieder <jrnider@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ca5756b..5c0b97e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -675,21 +675,13 @@ static int cleanup_sequencer_data(void)
 	return 0;
 }
 
-static int pick_commits(struct replay_opts *opts)
+static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 {
-	struct commit_list *todo_list = NULL;
-	unsigned char sha1[20];
 	struct commit_list *cur;
 	int res;
 
-	read_and_refresh_cache(me, opts);
 	setenv(GIT_REFLOG_ACTION, me, 0);
 
-	walk_revs_populate_todo(&todo_list, opts);
-	if (!get_sha1("HEAD", sha1))
-		persist_head(sha1_to_hex(sha1));
-	persist_todo(todo_list, opts);
-
 	for (cur = todo_list; cur; cur = cur->next) {
 		persist_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
@@ -702,6 +694,21 @@ static int pick_commits(struct replay_opts *opts)
 	return cleanup_sequencer_data();
 }
 
+static int process_continuation(struct replay_opts *opts)
+{
+	struct commit_list *todo_list = NULL;
+	unsigned char sha1[20];
+
+	read_and_refresh_cache(me, opts);
+
+	walk_revs_populate_todo(&todo_list, opts);
+	if (!get_sha1("HEAD", sha1))
+		persist_head(sha1_to_hex(sha1));
+	persist_todo(todo_list, opts);
+
+	return pick_commits(todo_list, opts);
+}
+
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	int res;
@@ -714,7 +721,11 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "revert";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+
+	/* Decide what to do depending on the arguments; a fresh
+	   cherry-pick should be handled differently from an existing
+	   one that is being continued */
+	res = process_continuation(&opts);
 	if (res > 0)
 		/* Exit status from conflict */
 		return res;
@@ -734,7 +745,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	me = "cherry-pick";
 	parse_args(argc, argv, &opts);
-	res = pick_commits(&opts);
+	res = process_continuation(&opts);
 	if (res > 0)
 		return res;
 	if (res < 0)
-- 
1.7.5.GIT
