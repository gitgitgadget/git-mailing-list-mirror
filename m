From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 23/28] sequencer: store progress information
Date: Fri, 30 Aug 2013 00:56:17 -0500
Message-ID: <1377842182-18724-24-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHme-0007iQ-05
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab3H3GCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:02:01 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:41855 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3H3GB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:59 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so1457562obc.7
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZkpaQpTMaat5shK+yGMlLE+OzRHUS7s3N7gUlrm0xmk=;
        b=ACHmSSrQaXzGVyJgpT9ZPNcR/diPGScZFOhKRIAPSk5GnZARaWT6vtFAZBXMEXeTV3
         cEqerhosX6mp+4GBUnrH52NTYDMcLFUZ6Bq5bQE+V3C4Wgzxcc09fm4+t8zs1HIPBi+f
         1OVyKUl5/Q9QD41SxPTQflNNZL9rGD5r59jx512pP3Kmcc1mMbUezaSjSbLQO6r67DTO
         uNPtucEvmQ4VJf6ZgCe8WD+O16bT/DWBb+dfxmEzm6LETyi3scQDRBjuM3GUEgAZE9j9
         FLXxEXzBJkZcoYjhN8cQ9edqBwQRUt1M2/b9v2wKwodCmc7jRkbkBmS/qkYvJbpZ6vNV
         Oh5g==
X-Received: by 10.60.102.66 with SMTP id fm2mr5699447oeb.21.1377842519190;
        Thu, 29 Aug 2013 23:01:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id a18sm35717638obf.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233415>

So that it can be used by shell prompts.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 453e4a4..c855dd4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -21,6 +21,7 @@
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 static struct rewritten rewritten;
+static int total;
 
 static void finish(struct replay_opts *opts)
 {
@@ -877,8 +878,10 @@ static void walk_revs_populate_todo(struct commit_list **todo_list,
 	prepare_revs(opts);
 
 	next = todo_list;
-	while ((commit = get_revision(opts->revs)))
+	while ((commit = get_revision(opts->revs))) {
 		next = commit_list_append(commit, next);
+		total++;
+	}
 }
 
 static int create_seq_dir(void)
@@ -1036,6 +1039,21 @@ static void save_opts(struct replay_opts *opts)
 	}
 }
 
+static void save_info(int total, int step)
+{
+	FILE *f;
+	f = fopen(git_path("sequencer/total"), "w");
+	if (f) {
+		fprintf(f, "%i\n", total);
+		fclose(f);
+	}
+	f = fopen(git_path("sequencer/step"), "w");
+	if (f) {
+		fprintf(f, "%i\n", step);
+		fclose(f);
+	}
+}
+
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 {
 	struct commit_list *cur;
@@ -1051,8 +1069,10 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
 		if (res) {
-			if (opts->action == REPLAY_PICK)
+			if (opts->action == REPLAY_PICK) {
 				store_rewritten(&rewritten, git_path(SEQ_REWR_FILE));
+				save_info(total, rewritten.nr + 1);
+			}
 			return res;
 		}
 	}
-- 
1.8.4-fc
