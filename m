From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] revert: make commit subjects in insn sheet optional
Date: Wed,  7 Dec 2011 12:07:54 +0530
Message-ID: <1323239877-24101-3-git-send-email-artagnon@gmail.com>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 07:39:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYB9w-0000Kw-6l
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 07:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034Ab1LGGjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 01:39:10 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51429 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab1LGGjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 01:39:10 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so437161iak.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 22:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9FdsGnTsdP9rz9oh3cLffurxudkXFLRiYgUBZsOZgac=;
        b=GTvdtjM9BUom7tLEhenzfcOChCso/0UXyo2fgJqP2A3Xp6YKRR/whhGAMzVIq9GbEw
         Sicg2kFev4jmPVE+i4tb1CJ5N2lukkk+W9+Dh7B4z/ApYB8QDo1lYJ3ZuwoXT41ZPgSv
         Bl2VR+Y7WiYnvj4z2CDrIb2UUz8TZMtFSO73c=
Received: by 10.231.60.212 with SMTP id q20mr4194615ibh.14.1323239949722;
        Tue, 06 Dec 2011 22:39:09 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id eb23sm3166839ibb.2.2011.12.06.22.39.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 22:39:08 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186427>

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
1.7.7.3
