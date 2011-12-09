From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 8/9] revert: report fine-grained error messages from insn parser
Date: Fri,  9 Dec 2011 21:12:05 +0530
Message-ID: <1323445326-24637-9-git-send-email-artagnon@gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:43:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ2c1-0001Cs-AE
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558Ab1LIPnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:43:42 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45239 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab1LIPnj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:43:39 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so4391329iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GSqzqQBEX4ojqdkGNHaOw33fodB+a0tJT07PveTG0hc=;
        b=JQlnA3Q+XdcN183S77UPJPVwLCfOPVuw+rV64nwU2ABvrKlHadlOmLm5P62NTt5782
         cfEDhFhZAonyIeIjGLnJchrnU58fafqrVLwpCFOftouHp0D0DO3GjgE/t8xJOs2yAHnB
         veq9UBG1OcClU6UUxHtMw0aaLhnDEriLW1C/A=
Received: by 10.43.47.135 with SMTP id us7mr606508icb.31.1323445418829;
        Fri, 09 Dec 2011 07:43:38 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id a2sm18298821igj.7.2011.12.09.07.43.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 07:43:37 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186646>

Three kinds of errors can arise from parsing '.git/sequencer/todo':
1. Unrecognized action
2. Malformed object name
3. Object name does not refer to a valid commit

Since we would like to make the instruction sheet user-editable in the
future (much like the 'rebase -i' sheet), report more fine-grained
parse errors prefixed with the filename and line number.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index cc55823..e2355d8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -719,8 +719,10 @@ static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
 	return 0;
 }
 
-static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
+static int parse_insn_line(char *bol, char *eol,
+			struct replay_insn_list *item, int lineno)
 {
+	const char *todo_file = git_path(SEQ_TODO_FILE);
 	unsigned char commit_sha1[20];
 	char *end_of_object_name;
 	int saved, status;
@@ -731,8 +733,13 @@ static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
 	} else if (!prefixcmp(bol, "revert ")) {
 		item->action = REPLAY_REVERT;
 		bol += strlen("revert ");
-	} else
-		return -1;
+	} else {
+		size_t len = eol - bol;
+		if (len > 255)
+			len = 255;
+		return error(_("%s:%d: Unrecognized action: %.*s"),
+			todo_file, lineno, (int)len, bol);
+	}
 
 	/* Eat up extra spaces/ tabs before object name */
 	while (*bol == ' ' || *bol == '\t')
@@ -745,11 +752,13 @@ static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
 	*end_of_object_name = saved;
 
 	if (status < 0)
-		return -1;
+		return error(_("%s:%d: Malformed object name: %s"),
+			todo_file, lineno, bol);
 
 	item->operand = lookup_commit_reference(commit_sha1);
 	if (!item->operand)
-		return -1;
+		return error(_("%s:%d: Not a valid commit: %s"),
+			todo_file, lineno, bol);
 
 	item->next = NULL;
 	return 0;
@@ -764,8 +773,8 @@ static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
 
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
1.7.7.3
