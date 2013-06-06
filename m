From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/9] sequencer: run post-rewrite hook
Date: Thu,  6 Jun 2013 03:59:00 -0500
Message-ID: <1370509144-31974-6-git-send-email-felipe.contreras@gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 11:01:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkW4n-0006ZS-Sl
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 11:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452Ab3FFJBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 05:01:39 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41369 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423Ab3FFJBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 05:01:11 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so4251767obb.19
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9gyvKqiKWVcnsnM1GDpZrzo2hXBQjxpISTkdFrpHW/c=;
        b=Nys3QuHmESZB81BRpLVwWFomudmcg2z3qYqvHwkwc/WTyrmF+QEw0naqExvfq5b+i5
         clQSPE0/4Zand5cppzL9WycJbRvRziecy1VpesXvetw7qBnWHPiAouLWDX83RJ6tiNTi
         OAjFb0nPhPhSHi2MjyikHHMeddoWazpvh0wF/LRwHQcolf0l6tevBJacAuNDtEZJOmEj
         C0Br1zgz21gsTAuWMx00bkLBaeqJtQv14vV/nv1+ATcp8z/e1zmsuQwtqwkpoFQu22D5
         iWbj+qRnCicY6PieAOaaW/yTYWFkfWYI1+E5DJxP51zbpyprvFOpp9rjW4iS+MHd7kXc
         ITqQ==
X-Received: by 10.60.44.209 with SMTP id g17mr6485378oem.23.1370509270105;
        Thu, 06 Jun 2013 02:01:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i2sm27616938obz.11.2013.06.06.02.01.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 02:01:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226496>

As we should.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 76ff2ff..74480d7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -127,6 +127,37 @@ static void add_rewritten(unsigned char *from, unsigned char *to)
 	rewritten.nr++;
 }
 
+static void run_rewrite_hook(const char *name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process proc;
+	const char *argv[3];
+	int code, i;
+
+	argv[0] = find_hook("post-rewrite");
+	if (!argv[0])
+		return;
+
+	argv[1] = name;
+	argv[2] = NULL;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv = argv;
+	proc.in = -1;
+	proc.stdout_to_stderr = 1;
+
+	code = start_command(&proc);
+	if (code)
+		return;
+	for (i = 0; i < rewritten.nr; i++) {
+		struct rewritten_list_item *item = &rewritten.items[i];
+		strbuf_addf(&buf, "%s %s\n", sha1_to_hex(item->from), sha1_to_hex(item->to));
+	}
+	write_in_full(proc.in, buf.buf, buf.len);
+	close(proc.in);
+	finish_command(&proc);
+}
+
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -1100,6 +1131,9 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		}
 	}
 
+	if (opts->action == REPLAY_PICK)
+		run_rewrite_hook("cherry-pick");
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -1149,8 +1183,14 @@ static int sequencer_continue(struct replay_opts *opts)
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
+	int ret;
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(cmit, opts);
+	ret = do_pick_commit(cmit, opts);
+	if (ret)
+		return ret;
+	if (opts->action == REPLAY_PICK)
+		run_rewrite_hook("cherry-pick");
+	return 0;
 }
 
 int sequencer_pick_revisions(struct replay_opts *opts)
-- 
1.8.3.698.g079b096
