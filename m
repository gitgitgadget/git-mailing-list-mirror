From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] sequencer: fix leaked todo_list memory
Date: Fri, 04 May 2012 21:40:33 +0200
Message-ID: <20120504194035.25080.49271.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:46:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOSX-0005E7-Ot
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759492Ab2EDTq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 15:46:28 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55069 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754379Ab2EDTq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:46:27 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 73CC9A6227;
	Fri,  4 May 2012 21:46:17 +0200 (CEST)
X-git-sha1: 688916d32858678b20a282c00365bc122ca6d35a 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197062>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Hi,

This is a very small series to fix a few memory leaks.
It will not fix the main leaks but it's a start.

Regards,
Christian.

 sequencer.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f83cdfd..aa4c1a4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -892,6 +892,7 @@ static int continue_single_pick(void)
 static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
+	int res;
 
 	if (!file_exists(git_path(SEQ_TODO_FILE)))
 		return continue_single_pick();
@@ -907,8 +908,11 @@ static int sequencer_continue(struct replay_opts *opts)
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
@@ -921,6 +925,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 	unsigned char sha1[20];
+	int res;
 
 	if (opts->subcommand == REPLAY_NONE)
 		assert(opts->revs);
@@ -977,5 +982,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
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
1.7.10.579.g68891.dirty
