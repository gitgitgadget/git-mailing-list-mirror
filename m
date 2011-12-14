From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/10] revert: report fine-grained error messages from insn parser
Date: Wed, 14 Dec 2011 22:24:37 +0530
Message-ID: <1323881677-11117-11-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:55:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras7E-0004kJ-QS
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637Ab1LNQz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:55:27 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35295 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757629Ab1LNQzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:55:24 -0500
Received: by vcbfk14 with SMTP id fk14so764128vcb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lqxb7TgvzahNHSuS2ze/Bm1R/Fg7+ENgmlzbkfbeaQ0=;
        b=Q0sCYuiL4HFfOhtu1pdJ48KGwKApDzR11KHDU5CFBFrgjlgP0+pYWA3ariMcN94gXQ
         fs+ZHxFXratkISMJJ9vpQkTkuQdCpmanzdX/axyfWLQxNckrSc1Ty3CZqXRvyWNDrKSP
         c2ZYFW9fpEpZ/HiJXhoFVGjdeM0FhlYA4GlvQ=
Received: by 10.52.94.97 with SMTP id db1mr5579963vdb.16.1323881724195;
        Wed, 14 Dec 2011 08:55:24 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.55.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:55:23 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187151>

Three kinds of errors can arise from parsing '.git/sequencer/todo':
1. Unrecognized action
2. Missing space after valid action prefix
3. Malformed object name
4. Object name does not refer to a valid commit

Since we would like to make the instruction sheet user-editable in the
future (much like the 'rebase -i' sheet), report more fine-grained
parse errors prefixed with the filename and line number.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   37 ++++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 50af439..d106c3c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -705,11 +705,14 @@ static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
 	return 0;
 }
 
-static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
+static int parse_insn_line(char *bol, char *eol,
+			struct replay_insn_list *item, int lineno)
 {
+	const char *todo_file = git_path(SEQ_TODO_FILE);
 	unsigned char commit_sha1[20];
 	char *end_of_object_name;
 	int saved, status, padding;
+	size_t error_len;
 
 	if (!prefixcmp(bol, "pick")) {
 		item->action = REPLAY_PICK;
@@ -717,13 +720,19 @@ static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
 	} else if (!prefixcmp(bol, "revert")) {
 		item->action = REPLAY_REVERT;
 		bol += strlen("revert");
-	} else
-		return -1;
+	} else {
+		error_len = eol - bol > 255 ? 255 : eol - bol;
+		return error(_("%s:%d: Unrecognized action: %.*s"),
+			todo_file, lineno, (int)error_len, bol);
+	}
 
 	/* Eat up extra spaces/ tabs before object name */
 	padding = strspn(bol, " \t");
-	if (!padding)
-		return -1;
+	if (!padding) {
+		error_len = eol - bol > 255 ? 255 : eol - bol;
+		return error(_("%s:%d: Missing space after action: %.*s"),
+			todo_file, lineno, (int)error_len, bol);
+	}
 	bol += padding;
 
 	end_of_object_name = bol + strcspn(bol, " \t\n");
@@ -732,12 +741,18 @@ static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
 	status = get_sha1(bol, commit_sha1);
 	*end_of_object_name = saved;
 
-	if (status < 0)
-		return -1;
+	if (status < 0) {
+		error_len = eol - bol > 255 ? 255 : eol - bol;
+		return error(_("%s:%d: Malformed object name: %.*s"),
+			todo_file, lineno, (int)error_len, bol);
+	}
 
 	item->operand = lookup_commit_reference(commit_sha1);
-	if (!item->operand)
-		return -1;
+	if (!item->operand) {
+		error_len = eol - bol > 255 ? 255 : eol - bol;
+		return error(_("%s:%d: Not a valid commit: %.*s"),
+			todo_file, lineno, (int)error_len, bol);
+	}
 
 	item->next = NULL;
 	return 0;
@@ -752,8 +767,8 @@ static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
 
 	for (i = 1; *p; i++) {
 		char *eol = strchrnul(p, '\n');
-		if (parse_insn_line(p, eol, &item) < 0)
-			return error(_("Could not parse line %d."), i);
+		if (parse_insn_line(p, eol, &item, i) < 0)
+			return -1;
 		next = replay_insn_list_append(item.action, item.operand, next);
 		p = *eol ? eol + 1 : eol;
 	}
-- 
1.7.4.1
