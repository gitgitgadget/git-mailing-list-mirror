From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] revert: make commit subjects in insn sheet optional
Date: Sun, 23 Oct 2011 00:43:44 +0530
Message-ID: <1319310826-508-4-git-send-email-artagnon@gmail.com>
References: <1319310826-508-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:16:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHh3o-0003Wl-Nq
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab1JVTQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:16:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48293 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1JVTQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:16:43 -0400
Received: by iaek3 with SMTP id k3so6148257iae.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xg5Rh6eMbEtrMtBBC5WmKlwxTSUxKcZVG+CCDGfg6Sg=;
        b=kEuXcrgu8EGdu1iC4xEj5QsgvWQl86c7/cqwLKb1d36b5CTx6kf3C6DylatalRjNv7
         kNUiI01Z+k0yjQCPlRH+B+1h5Tc0c2TUOX07aFX6HpS0Khohx1q4VKHf2cp3wZbBrLEQ
         cB+WEiaqTAVmB5H7Ze6V3nznjPn1p2wOBDyy8=
Received: by 10.68.14.6 with SMTP id l6mr36637782pbc.84.1319311002692;
        Sat, 22 Oct 2011 12:16:42 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e10sm36939881pbq.10.2011.10.22.12.16.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Oct 2011 12:16:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1319310826-508-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184115>

Change the instruction sheet format subtly so that the subject of the
commit message that follows the object name is optional.  As a result,
an instruction sheet like this is now perfectly valid:

  pick 35b0426
  pick fbd5bbcbc2e
  pick 7362160f

While at it, also fix a bug: currently, we use a commit-id-shaped
buffer to store the word after "pick" in '.git/sequencer/todo'.  This
is both wasteful and wrong because it places an artificial limit on
the line length.  Eliminate the need for the buffer altogether, and
add a test demonstrating this.

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
index efa8d00..14462ca 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -694,31 +694,27 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
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
@@ -731,7 +727,7 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 		return NULL;
 	}
 
-	if (get_sha1(sha1_abbrev, commit_sha1) < 0)
+	if (status < 0)
 		return NULL;
 
 	return lookup_commit_reference(commit_sha1);
@@ -746,13 +742,12 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
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
index 3bca2b3..39b55c1 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -12,6 +12,9 @@ test_description='Test cherry-pick continuation features
 
 . ./test-lib.sh
 
+# Repeat first match 10 times
+_r10='\1\1\1\1\1\1\1\1\1\1'
+
 pristine_detach () {
 	git cherry-pick --reset &&
 	git checkout -f "$1^0" &&
@@ -211,4 +214,29 @@ test_expect_success 'malformed instruction sheet 2' '
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
+	git rev-list HEAD >commits
+	test_line_count = 4 commits
+'
+
 test_done
-- 
1.7.6.351.gb35ac.dirty
