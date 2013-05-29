From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/8] sequencer: run post-rewrite hook
Date: Tue, 28 May 2013 22:56:25 -0500
Message-ID: <1369799788-24803-6-git-send-email-felipe.contreras@gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:58:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXX3-00035O-FT
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934916Ab3E2D60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:58:26 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:48662 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934810Ab3E2D6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:58:23 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so6643281obc.20
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Js9naPOJn/cKxAS5XSi7CE+xEA02eZ9812demcEMVe8=;
        b=xbyqqBnlJs0ztK1BzK2ZHPpDyLmaisZiCjJD+ocYnM0ArEWKgULpIKviCfJ9uofPFH
         hvxFoGT338ownMA/YulV4Rl7DFKkkpMJHk0uia/aBh5GG7oQJbk36IHRO5j5gyWC/jYI
         8eQpApddF43LAM3CkYdCr8Kzw7BUtOAYEJfa8vrHkBieGuVMY0p/pdnQXKjf7LLggRAx
         eBW9WAR3GhtEvUJ65SeXLzVQxXg00Rvm5YCtSFCfgULd6Uk02HE5OKe8r5qBt3SCbK23
         NknUrSMz019foqVulWQmPjFset33E0cMYcCMl5i26x9+863k3F6mXJgHV+AKD7Ew0JW6
         WEDg==
X-Received: by 10.182.74.131 with SMTP id t3mr464602obv.87.1369799903457;
        Tue, 28 May 2013 20:58:23 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm39273967oel.2.2013.05.28.20.58.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:58:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225718>

As we should.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index c217716..3aa480e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -127,6 +127,37 @@ static void add_rewritten(unsigned char *from, unsigned char *to)
 	rewritten.nr++;
 }
 
+static void run_rewrite_hook(void)
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
+	argv[1] = "rebase";
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
@@ -1099,6 +1130,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		}
 	}
 
+	run_rewrite_hook();
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -1136,14 +1169,24 @@ static int sequencer_continue(struct replay_opts *opts)
 	}
 	if (index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
+	{
+		unsigned char to[20];
+		if (!read_ref("HEAD", to))
+			add_rewritten(todo_list->item->object.sha1, to);
+	}
 	todo_list = todo_list->next;
 	return pick_commits(todo_list, opts);
 }
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
+	int ret;
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(cmit, opts);
+	ret = do_pick_commit(cmit, opts);
+	if (ret)
+		return ret;
+	run_rewrite_hook();
+	return 0;
 }
 
 int sequencer_pick_revisions(struct replay_opts *opts)
-- 
1.8.3.rc3.312.g47657de
