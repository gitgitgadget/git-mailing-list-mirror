From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/7] revert: Make commit descriptions in insn sheet optional
Date: Sun, 14 Aug 2011 14:03:05 +0530
Message-ID: <1313310789-10216-4-git-send-email-artagnon@gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 10:36:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWBQ-0000Mz-Jc
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353Ab1HNIgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 04:36:32 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63576 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab1HNIgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 04:36:31 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1545680pzk.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=g7PJwbnnQvov57Wbq2GaehpSGkDiGBohEU8s+NAl3rw=;
        b=prFLFd/kK6RduBYhgFze2OcPfxXnuJmRvKeuo89wTxkCD3cI70tPLlcVZlWe6vMi7T
         WsXguxpI5iE39Bifs4DBLbnGu9QnMriDl9qVXliHKDjearc/fyVy8U0SJkH4odILTlC6
         VYCL4/6UZXEH5MRLrlytC3FuPDWxJSts8lIGw=
Received: by 10.143.97.40 with SMTP id z40mr1116040wfl.7.1313310991396;
        Sun, 14 Aug 2011 01:36:31 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id 14sm2642752wfl.5.2011.08.14.01.36.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 01:36:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179307>

Change the instruction sheet format subtly so that a description of
the commit after the object name is optional.  As a result, an
instruction sheet like this is now perfectly valid:

  pick 35b0426
  pick fbd5bbcbc2e
  pick 7362160f

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |   19 ++++++++-----------
 t/t3510-cherry-pick-sequence.sh |   14 ++++++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8d29003..89b2bba 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -697,26 +697,23 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 	unsigned char commit_sha1[20];
 	char sha1_abbrev[40];
 	enum replay_action action;
-	int insn_len = 0;
-	char *p, *q;
+	const char *p, *q;
 
+	p = start;
 	if (!prefixcmp(start, "pick ")) {
 		action = CHERRY_PICK;
-		insn_len = strlen("pick");
-		p = start + insn_len + 1;
+		p += strlen("pick ");
 	} else if (!prefixcmp(start, "revert ")) {
 		action = REVERT;
-		insn_len = strlen("revert");
-		p = start + insn_len + 1;
+		p += strlen("revert ");
 	} else
 		return NULL;
 
-	q = strchr(p, ' ');
-	if (!q || q - p + 1 > sizeof(sha1_abbrev))
+	q = p + strcspn(p, " \n");
+	if (q - p + 1 > sizeof(sha1_abbrev))
 		return NULL;
-	q++;
-
-	strlcpy(sha1_abbrev, p, q - p);
+	memcpy(sha1_abbrev, p, q - p);
+	sha1_abbrev[q - p] = '\0';
 
 	/*
 	 * Verify that the action matches up with the one in
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 6882acb..734ee12 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -222,4 +222,18 @@ test_expect_success 'malformed instruction sheet 3' '
 	test_must_fail git cherry-pick --continue
 '
 
+test_expect_success 'commit descriptions in insn sheet are optional' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	cut -d" " -f1,2 .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	git cherry-pick --continue &&
+	test_path_is_missing .git/sequencer &&
+	git rev-list HEAD >commits
+	test_line_count = 4 commits
+'
+
 test_done
-- 
1.7.6.351.gb35ac.dirty
