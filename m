From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/7] sequencer: invalidate sequencer state without todo
Date: Sun, 13 Nov 2011 16:16:16 +0530
Message-ID: <1321181181-23923-3-git-send-email-artagnon@gmail.com>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXbp-0000Ss-Nl
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab1KMKsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 05:48:12 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52036 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1KMKsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 05:48:09 -0500
Received: by ywt32 with SMTP id 32so1398823ywt.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IsxTqDVNUT5bm2TEXLu/i8no/jVn4G0e4IQwo/QPmjU=;
        b=XYI7e1TMSzDKWytIf94hdsrZd8NLaWl6Rx483bhMeDpLmsDGQBPlQ190ZdF3uyOVcw
         WCY6DEF3+zi5GakADw4UYyPjpGhncRHcXFfm3yzW2acs+vzQ7xMmbZ4SfaNu/n1Rf+r/
         r/8o0/8H4N1jXd5ytOqDbnF8p/HmBGcDcdFLo=
Received: by 10.68.16.3 with SMTP id b3mr39795905pbd.86.1321181288725;
        Sun, 13 Nov 2011 02:48:08 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id g8sm28723464pbe.11.2011.11.13.02.48.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 02:48:07 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185331>

To check whether an existing sequencer operation is in progress and
error out, we currently check for the existence of the
'.git/sequencer' directory.

  $ git cherry-pick foo..bar
  ... conflict in bar~1 ...
  ... .git/sequencer is created ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git commit # Success!
  $ git cherry-pick moo # .git/sequencer exists
  error: A cherry-pick or revert is in progress

Although the sequencer state is useless without '.git/sequencer/todo',
this case never occurs.  However, in the light of the next patch,
where will handle single-commit picks as a special case by not
persisting '.git/sequencer/todo' in the first place, we are forced to
reconsider.  So, when starting a fresh sequencer invocation, remove
the sequencer state carried over from a previous invocation if it's
missing '.git/sequencer/todo'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 87f146b..8b2518c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -649,11 +649,15 @@ static void walk_revs_populate_todo(struct replay_insn_list **todo_list,
 
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
