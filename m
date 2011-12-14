From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/10] revert: tolerate extra spaces, tabs in insn sheet
Date: Wed, 14 Dec 2011 22:24:30 +0530
Message-ID: <1323881677-11117-4-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:55:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras6i-0004US-IB
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603Ab1LNQzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:55:00 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53875 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580Ab1LNQzA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:55:00 -0500
Received: by mail-vw0-f46.google.com with SMTP id fc26so774122vbb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BpwLRhbPAuWeZcXvZOsgz1mf9Sh1N/EsWSLZjLC0GcY=;
        b=jHHHm6gTPTCcz5tIKKN0wZQo4d7MJQ10xUbqFNzR2/IwbhJFk4t6EzF8/yc/6tVdIi
         ksgujyTA2wSAf+XwrFgnwGzfXilmVdqfRSjnlFWcrhTyxy74IBDsWs7NnqYkN/kvP/R+
         7mvJ0v/vgfDFeFcn8sNC862NJ/vVTAy9izMOI=
Received: by 10.52.181.137 with SMTP id dw9mr5435948vdc.0.1323881699863;
        Wed, 14 Dec 2011 08:54:59 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.54.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:54:58 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187147>

Tolerate extra spaces and tabs as part of the the field separator in
'.git/sequencer/todo', for people with fat fingers.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |   18 ++++++++++++------
 t/t3510-cherry-pick-sequence.sh |   11 +++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 70055e5..be0686d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -716,18 +716,24 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	unsigned char commit_sha1[20];
 	enum replay_action action;
 	char *end_of_object_name;
-	int saved, status;
+	int saved, status, padding;
 
-	if (!prefixcmp(bol, "pick ")) {
+	if (!prefixcmp(bol, "pick")) {
 		action = CHERRY_PICK;
-		bol += strlen("pick ");
-	} else if (!prefixcmp(bol, "revert ")) {
+		bol += strlen("pick");
+	} else if (!prefixcmp(bol, "revert")) {
 		action = REVERT;
-		bol += strlen("revert ");
+		bol += strlen("revert");
 	} else
 		return NULL;
 
-	end_of_object_name = bol + strcspn(bol, " \n");
+	/* Eat up extra spaces/ tabs before object name */
+	padding = strspn(bol, " \t");
+	if (!padding)
+		return NULL;
+	bol += padding;
+
+	end_of_object_name = bol + strcspn(bol, " \t\n");
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
 	status = get_sha1(bol, commit_sha1);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 6390f2a..781c5ac 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -342,6 +342,17 @@ test_expect_success 'malformed instruction sheet 3' '
 	test_must_fail git cherry-pick --continue
 '
 
+test_expect_success 'instruction sheet, fat-fingers version' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "c" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick \([0-9a-f]*\)/pick 	 \1 	/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	git cherry-pick --continue
+'
+
 test_expect_success 'commit descriptions in insn sheet are optional' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
-- 
1.7.4.1
