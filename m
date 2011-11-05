From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] sequencer: remove CHERRY_PICK_HEAD with sequencer state
Date: Sat,  5 Nov 2011 21:59:43 +0530
Message-ID: <1320510586-3940-3-git-send-email-artagnon@gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 05 17:32:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMj9w-0005JL-N0
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 17:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab1KEQbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 12:31:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53689 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab1KEQbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 12:31:49 -0400
Received: by mail-iy0-f174.google.com with SMTP id e36so3884876iag.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6NitCnBdkbkGgXfijxhq2if7ooBDTc/RXgkybcuYWMw=;
        b=ASrWh1P8IdnjCue2SFEjHKzQYB15+r1IymUPkEHsbnDXK9XskrQTfPe7CjobVradC6
         h+VHKBDTqYQPsWUR2z0mzCd9rekqcyKZ5AavYKgNLnnSmnHnYCHezv1NZv8Ic0MfvPUC
         W3luTEu2+zXJJE0uFHZ2XGnuX2BePb6cgFyXA=
Received: by 10.42.153.74 with SMTP id l10mr26765519icw.52.1320510708982;
        Sat, 05 Nov 2011 09:31:48 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id p10sm19248815pbd.15.2011.11.05.09.31.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 09:31:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184860>

Make remove_sequencer_state() remove '.git/CHERRY_PICK_HEAD' when
invoked aggressively, since we want to treat it as part of the
sequencer state now.  While at it, make some minor improvements to the
function.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 87f146b..e566043 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -25,17 +25,22 @@ static char *get_encoding(const char *message);
 
 void remove_sequencer_state(int aggressive)
 {
-	struct strbuf seq_dir = STRBUF_INIT;
-	struct strbuf seq_old_dir = STRBUF_INIT;
-
-	strbuf_addf(&seq_dir, "%s", git_path(SEQ_DIR));
-	strbuf_addf(&seq_old_dir, "%s", git_path(SEQ_OLD_DIR));
-	remove_dir_recursively(&seq_old_dir, 0);
-	rename(git_path(SEQ_DIR), git_path(SEQ_OLD_DIR));
-	if (aggressive)
-		remove_dir_recursively(&seq_old_dir, 0);
-	strbuf_release(&seq_dir);
-	strbuf_release(&seq_old_dir);
+	const char *seq_dir = git_path(SEQ_DIR);
+	const char *seq_old_dir = git_path(SEQ_OLD_DIR);
+	const char *cherry_pick_head = git_path("CHERRY_PICK_HEAD");
+	struct strbuf seq_dir_buf = STRBUF_INIT;
+	struct strbuf seq_old_dir_buf = STRBUF_INIT;
+
+	strbuf_addf(&seq_dir_buf, "%s", seq_dir);
+	strbuf_addf(&seq_old_dir_buf, "%s", seq_old_dir);
+	remove_dir_recursively(&seq_old_dir_buf, 0);
+	rename(seq_dir, seq_old_dir);
+	if (aggressive) {
+		remove_dir_recursively(&seq_old_dir_buf, 0);
+		unlink(cherry_pick_head);
+	}
+	strbuf_release(&seq_dir_buf);
+	strbuf_release(&seq_old_dir_buf);
 }
 
 struct commit_message {
-- 
1.7.6.351.gb35ac.dirty
