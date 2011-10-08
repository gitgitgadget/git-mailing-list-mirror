From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] revert: Make commit descriptions in insn sheet optional
Date: Sat,  8 Oct 2011 23:06:45 +0530
Message-ID: <1318095407-26429-5-git-send-email-artagnon@gmail.com>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 08 19:37:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCaps-0004l3-1t
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 19:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346Ab1JHRhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 13:37:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43229 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab1JHRhN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 13:37:13 -0400
Received: by mail-gy0-f174.google.com with SMTP id 10so4416168gyg.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uhxb+A2W86/DnR/riNfOEYEynmbtzebA4mU4PcTv958=;
        b=RAFPThSYzAf4sS7j6pISqQ3jMyhwhXZnxpAH5TN3qT8axABH+imYSLRACFcQOXHpXI
         2AfvLocSsNA+eRlA68WZj2qMLc9MmP8GSUhbHz4avSaesdRNC/mlWhviMHG5WPZ4KwRs
         4kYGhnC88IloJwNEUkOT6ZJIQ92Rs5pVsZqvM=
Received: by 10.68.35.1 with SMTP id d1mr23576022pbj.55.1318095432740;
        Sat, 08 Oct 2011 10:37:12 -0700 (PDT)
Received: from localhost.localdomain ([122.174.152.157])
        by mx.google.com with ESMTPS id h5sm45151528pbq.11.2011.10.08.10.37.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 10:37:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183159>

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
index 6451089..aa6c34e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -692,26 +692,23 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
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
index 2113308..39b55c1 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -225,4 +225,18 @@ test_expect_success 'malformed instruction sheet 3' '
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
1.7.4.1
