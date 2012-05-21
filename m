From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/7] sequencer: fix leaked todo_list memory
Date: Mon, 21 May 2012 16:56:03 +0200
Message-ID: <20120521145610.1911.87598.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 17:10:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWUFq-0003PA-PQ
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 17:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205Ab2EUPK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 11:10:26 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39012 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab2EUPKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 11:10:23 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 156DDA6287;
	Mon, 21 May 2012 17:10:16 +0200 (CEST)
X-git-sha1: 1867b4334ddfc58bf199f79d939c415f03d8db4d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198110>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sequencer.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3c384b9..762c527 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -900,6 +900,7 @@ static int continue_single_pick(void)
 static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
+	int res;
 
 	if (!file_exists(git_path(SEQ_TODO_FILE)))
 		return continue_single_pick();
@@ -915,8 +916,11 @@ static int sequencer_continue(struct replay_opts *opts)
 	}
 	if (index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
-	todo_list = todo_list->next;
-	return pick_commits(todo_list, opts);
+	res = pick_commits(todo_list->next, opts);
+
+	free_commit_list(todo_list);
+
+	return res;
 }
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
@@ -929,6 +933,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 	unsigned char sha1[20];
+	int res;
 
 	if (opts->subcommand == REPLAY_NONE)
 		assert(opts->revs);
@@ -985,5 +990,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	}
 	save_head(sha1_to_hex(sha1));
 	save_opts(opts);
-	return pick_commits(todo_list, opts);
+	res = pick_commits(todo_list, opts);
+
+	free_commit_list(todo_list);
+
+	return res;
 }
-- 
1.7.10.2.555.g6528037
