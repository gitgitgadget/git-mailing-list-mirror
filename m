From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] revert: report fine-grained error messages from insn parser
Date: Sun,  8 Jan 2012 17:57:32 +0530
Message-ID: <1326025653-11922-6-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 13:29:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjrsh-0008M1-0w
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 13:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab2AHM3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 07:29:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab2AHM33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 07:29:29 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5271273iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 04:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BqiTROtqKhpyXxUPvf179tkPauOQ7dpFiYaAINHIQNA=;
        b=eN8QxwbW3QDoT6FhTVqD2PICmZo/CSb1RKX7Vs5/iwWL+8GHgTSNUIL1ZMH9nXC7eS
         D1WgzE1OsACP/IO67xiEf0dx5AX7bE90pYvtapPtJ6og9QOBk0NsJILxlzbXKf19nIoE
         yDr5h4vapFnQ7MU4g00NuJrWPgJPJ3qzlgh5g=
Received: by 10.50.183.166 with SMTP id en6mr14656554igc.7.1326025768843;
        Sun, 08 Jan 2012 04:29:28 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id r5sm106707878igl.3.2012.01.08.04.29.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 04:29:28 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188110>

Three kinds of errors can arise from parsing '.git/sequencer/todo':
1. Unrecognized action
2. Malformed object name
3. Object name does not refer to a valid commit

Since we would like to make the instruction sheet user-editable in the
future (much like the 'rebase -i' sheet), report more fine-grained
parse errors prefixed with the filename and line number.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   45 +++++++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 54ea394..35553e7 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -714,26 +714,29 @@ static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
 	return 0;
 }
 
-static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
+static int parse_insn_line(char *bol, char *eol,
+			struct replay_insn_list *item, int lineno)
 {
+	const char *todo_file = git_path(SEQ_TODO_FILE);
 	unsigned char commit_sha1[20];
 	char *end_of_object_name;
-	int saved, status, padding;
+	int saved, status;
+	size_t error_len;
 
-	if (!prefixcmp(bol, "pick")) {
+	if (!prefixcmp(bol, "pick ") || !prefixcmp(bol, "pick\t")) {
 		item->action = REPLAY_PICK;
-		bol += strlen("pick");
-	} else if (!prefixcmp(bol, "revert")) {
+		bol += strlen("pick ");
+	} else if (!prefixcmp(bol, "revert ") || !prefixcmp(bol, "revert\t")) {
 		item->action = REPLAY_REVERT;
-		bol += strlen("revert");
-	} else
-		return -1;
+		bol += strlen("revert ");
+	} else {
+		error_len = eol - bol > 255 ? 255 : eol - bol;
+		return error(_("%s:%d: Unrecognized action: %.*s"),
+			todo_file, lineno, (int)error_len, bol);
+	}
 
 	/* Eat up extra spaces/ tabs before object name */
-	padding = strspn(bol, " \t");
-	if (!padding)
-		return -1;
-	bol += padding;
+	bol += strspn(bol, " \t");
 
 	end_of_object_name = bol + strcspn(bol, " \t\n");
 	saved = *end_of_object_name;
@@ -741,12 +744,18 @@ static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
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
@@ -761,8 +770,8 @@ static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
 
 	for (i = 1; *p; i++) {
 		char *eol = strchrnul(p, '\n');
-		if (parse_insn_line(p, eol, &item) < 0)
-			return error(_("Could not parse line %d."), i);
+		if (parse_insn_line(p, eol, &item, i) < 0)
+			return -1;
 		next = replay_insn_list_append(item.operand, item.action, next);
 		p = *eol ? eol + 1 : eol;
 	}
-- 
1.7.8.2
