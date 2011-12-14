From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/10] revert: make commit subjects in insn sheet optional
Date: Wed, 14 Dec 2011 22:24:29 +0530
Message-ID: <1323881677-11117-3-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:55:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras6i-0004US-1R
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757590Ab1LNQy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:54:58 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61872 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580Ab1LNQy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:54:57 -0500
Received: by vcbfk14 with SMTP id fk14so763696vcb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=szw/Ul8/64XwDib+dPqjF9v+bh8JFaVsDmS1cnMD2Tk=;
        b=C7zwe1kCjObBSo5a5BjuvciZA72l84gk60C+1yMAL4+C2Fg/O56AhHT3JFTP2MBtBW
         GeWyMtow+jk9yo+OEzm/gtmnZn4pxXOneNwjltzO1TJq88bJPTVFVzWyOcsXvxE42GGJ
         qvkZcBWHnULn+3vPW5ZpxxCT1n/TJAMn1oUZE=
Received: by 10.52.29.228 with SMTP id n4mr2993071vdh.57.1323881696445;
        Wed, 14 Dec 2011 08:54:56 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.54.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:54:55 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187146>

Change the instruction sheet format subtly so that the subject of the
commit message that follows the object name is optional.  As a result,
an instruction sheet like this is now perfectly valid:

  pick 35b0426
  pick fbd5bbcbc2e
  pick 7362160f

While at it, also fix a bug introduced by 5a5d80f4 (revert: Introduce
--continue to continue the operation, 2011-08-04) that failed to read
lines that are too long to fit on the commit-id-shaped buffer we
currently use; eliminate the need for the buffer altogether.  In
addition to literal SHA-1 hexes, you can now safely use expressions
like the following in the instruction sheet:

  featurebranch~4
  rr/revert-cherry-pick-continue^2~12@{12 days ago}

[jc: simplify parsing]

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c                |   37 ++++++++++++++++---------------------
 t/t3510-cherry-pick-sequence.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0c6d3d8..70055e5 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -711,31 +711,27 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
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
-	if (!q)
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
@@ -748,7 +744,7 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 		return NULL;
 	}
 
-	if (get_sha1(sha1_abbrev, commit_sha1) < 0)
+	if (status < 0)
 		return NULL;
 
 	return lookup_commit_reference(commit_sha1);
@@ -763,13 +759,12 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
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
index 2c4c1c8..6390f2a 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -13,6 +13,9 @@ test_description='Test cherry-pick continuation features
 
 . ./test-lib.sh
 
+# Repeat first match 10 times
+_r10='\1\1\1\1\1\1\1\1\1\1'
+
 pristine_detach () {
 	git cherry-pick --quit &&
 	git checkout -f "$1^0" &&
@@ -328,4 +331,29 @@ test_expect_success 'malformed instruction sheet 2' '
 	test_must_fail git cherry-pick --continue
 '
 
+test_expect_success 'malformed instruction sheet 3' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick \([0-9a-f]*\)/pick $_r10/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	test_must_fail git cherry-pick --continue
+'
+
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
+	git rev-list HEAD >commits &&
+	test_line_count = 4 commits
+'
+
 test_done
-- 
1.7.4.1
