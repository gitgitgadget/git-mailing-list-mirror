From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] revert: make commit subjects in insn sheet optional
Date: Thu, 20 Oct 2011 02:33:26 +0530
Message-ID: <1319058208-17923-5-git-send-email-artagnon@gmail.com>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:06:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdL4-0000Gz-Tz
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab1JSVGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:06:10 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35033 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab1JSVGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:06:08 -0400
Received: by mail-pz0-f42.google.com with SMTP id 36so5339523pzk.1
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jXrEBaUJ+k49o7zyUprZrkIcGW+Hs2RULIXE4Ka9fVU=;
        b=nHo9bHvyMmAky3pikl2myciCbGeJbUnGhX46jMaHpEAVT6858G+fcNcVcMBaGAe+xi
         /+pm/i57Vd07eVqUEaVgt2LkpSxXFu3ZZegEoi/4Kt62X+cZE6D2pUiQZLCvjoR/3LGl
         B2k/cIow+gAmIUJMIP21Q1/w5RYwWGixEyH9w=
Received: by 10.68.38.42 with SMTP id d10mr14868433pbk.50.1319058367977;
        Wed, 19 Oct 2011 14:06:07 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id jm5sm11111752pbc.1.2011.10.19.14.06.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Oct 2011 14:06:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183965>

Change the instruction sheet format subtly so that the subject of the
commit message that follows the object name is optional.  As a result,
an instruction sheet like this is now perfectly valid:

  pick 35b0426
  pick fbd5bbcbc2e
  pick 7362160f

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c                |   37 ++++++++++++++++---------------------
 t/t3510-cherry-pick-sequence.sh |   14 ++++++++++++++
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 474dda1..8e34dc0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -685,31 +685,27 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 	return 0;
 }
 
-static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
+static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *opts)
 {
 	unsigned char commit_sha1[20];
-	char sha1_abbrev[40];
 	enum replay_action action;
-	int insn_len = 0;
-	char *p, *q;
+	char *end_of_object_name;
+	int saved, status;
 
-	if (!prefixcmp(start, "pick ")) {
+	if (!prefixcmp(bol, "pick ")) {
 		action = CHERRY_PICK;
-		insn_len = strlen("pick");
-		p = start + insn_len + 1;
-	} else if (!prefixcmp(start, "revert ")) {
+		bol += strlen("pick ");
+	} else if (!prefixcmp(bol, "revert ")) {
 		action = REVERT;
-		insn_len = strlen("revert");
-		p = start + insn_len + 1;
+		bol += strlen("revert ");
 	} else
 		return NULL;
 
-	q = strchr(p, ' ');
-	if (!q || q - p + 1 > sizeof(sha1_abbrev))
-		return NULL;
-	q++;
-
-	strlcpy(sha1_abbrev, p, q - p);
+	end_of_object_name = bol + strcspn(bol, " \n");
+	saved = *end_of_object_name;
+	*end_of_object_name = '\0';
+	status = get_sha1(bol, commit_sha1);
+	*end_of_object_name = saved;
 
 	/*
 	 * Verify that the action matches up with the one in
@@ -722,7 +718,7 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 		return NULL;
 	}
 
-	if (get_sha1(sha1_abbrev, commit_sha1) < 0)
+	if (status < 0)
 		return NULL;
 
 	return lookup_commit_reference(commit_sha1);
@@ -737,13 +733,12 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 	int i;
 
 	for (i = 1; *p; i++) {
-		commit = parse_insn_line(p, opts);
+		char *eol = strchrnul(p, '\n');
+		commit = parse_insn_line(p, eol, opts);
 		if (!commit)
 			return error(_("Could not parse line %d."), i);
 		next = commit_list_append(commit, next);
-		p = strchrnul(p, '\n');
-		if (*p)
-			p++;
+		p = *eol ? eol + 1 : eol;
 	}
 	if (!*todo_list)
 		return error(_("No commits parsed."));
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
1.7.6.351.gb35ac.dirty
