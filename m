From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] sequencer: sequencer state is useless without todo
Date: Sat,  5 Nov 2011 21:59:44 +0530
Message-ID: <1320510586-3940-4-git-send-email-artagnon@gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 05 17:32:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMjA9-0005OF-3n
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 17:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab1KEQbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 12:31:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60597 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab1KEQby (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 12:31:54 -0400
Received: by ggnb2 with SMTP id b2so3620826ggn.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+/PVIq6h0z5lPxcMfz3r851eORuoRTYNxtaa9/IiCjw=;
        b=VclXF2930sYX7+0oEEzwvF3L9kbAPJysBPbUWPoVTv09YhWd+MAXSkuSO4oFrgvjHF
         KwTBkSkOm+6xgXcyQVWZnFeq5Tei9ZzgZ+uWXLJB9k77gl9bXa2jvcPc/1MNxoE2AEQt
         AQfkiyDaR2cLaoAluOCOK4V6T54JRvjul6YQA=
Received: by 10.50.87.227 with SMTP id bb3mr23222321igb.29.1320510713133;
        Sat, 05 Nov 2011 09:31:53 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id p10sm19248815pbd.15.2011.11.05.09.31.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 09:31:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184862>

Later in the series, we will not write '.git/sequencer/todo' for a
single commit cherry-pick, because 'CHERRY_PICK_HEAD' already contains
this information.  So, stomp the sequencer state in create_seq_state()
unless the todo file is present.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e566043..517eb23 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -654,11 +654,15 @@ static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
 
 static int create_seq_dir(void)
 {
+	const char *todo_file = git_path(SEQ_TODO_FILE);
 	const char *seq_dir = git_path(SEQ_DIR);
 
-	if (file_exists(seq_dir))
-		return error(_("%s already exists."), seq_dir);
-	else if (mkdir(seq_dir, 0777) < 0)
+	if (file_exists(todo_file))
+		return error(_("%s already exists."), todo_file);
+
+	/* If todo_file doesn't exist, discard sequencer state */
+	remove_sequencer_state(1);
+	if (mkdir(seq_dir, 0777) < 0)
 		die_errno(_("Could not create sequencer directory '%s'."), seq_dir);
 	return 0;
 }
-- 
1.7.6.351.gb35ac.dirty
