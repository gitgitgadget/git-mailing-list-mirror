From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/8] revert: report fine-grained errors from insn parser
Date: Tue, 10 Jan 2012 21:43:56 +0530
Message-ID: <1326212039-13806-6-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 17:16:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkeN7-0005XL-Ji
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 17:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230Ab2AJQQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 11:16:03 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47391 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab2AJQQB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 11:16:01 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so1076194iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LV5rS80EOjNnp6qGxs0pG4NhNRIAbGeg2p6hKkoK1BY=;
        b=NTdkGTByBxOwPrNf/CQxvs6O5Do3m/cH0Le26U0oGD7GpaVBsCvpJqizoQmyERp8lo
         /CKzi1phRJbjQfnNKxlNVda1ITaRbBJY1v5X9oaXTbOtPemdaJvUiBkXutlW64U4pOIA
         cfjB9gjODB1TVjz0YwWY4EX838OhXgM0jx2ro=
Received: by 10.50.180.138 with SMTP id do10mr2890877igc.20.1326212160788;
        Tue, 10 Jan 2012 08:16:00 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id lu10sm129662851igc.0.2012.01.10.08.15.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 08:15:58 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188261>

The infrastructure that parses '.git/sequencer/todo' is meant to
handle arbitrary user input some day, so it can be used as the
implementation of 'git rebase --interactive' and 'git sequence
--edit'.  It is currently sub-optimal for that purpose because the
parse error messages just say:

  error: Could not parse line 5.

This patch shifts responsibility to parse_insn_line(), which can come
up with a more detailed message like:

  error: .git/sequencer/todo:5: unrecognized action: frobnicate

Once the operator is allowed to edit the sequence, the message might
be adjusted to something like:

  error: <sequence you just gave me>:5: unrecognized action: frobnicate

instead of exposing an implementation detail. Some day "git sequence
--edit" could even re-launch the editor with an error message in a
comment before the problematic line and the cursor pointing there.
For now, pointing to the explicit filename is useful since this should
only happen if there was filesystem corruption, tampering, or a git
bug.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 9a09471..0954d22 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -732,7 +732,22 @@ static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
 	return 0;
 }
 
-static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
+static int parse_error(const char *message, const char *file,
+		int lineno, char *error_line)
+{
+	const char *suffix = "";
+	int error_len = strcspn(error_line, " \t\n");
+
+	if (error_len > 20) {
+		error_len = 20;
+		suffix = "...";
+	}
+	return error(_("%s:%d: %s: %.*s%s"), file, lineno, message,
+		error_len, error_line, suffix);
+}
+
+static int parse_insn_line(char *bol, char *eol,
+			struct replay_insn_list *item, int lineno)
 {
 	unsigned char commit_sha1[20];
 	char *end_of_object_name;
@@ -745,7 +760,8 @@ static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
 		item->action = REPLAY_REVERT;
 		bol += strlen("revert ");
 	} else
-		return -1;
+		return parse_error(_("unrecognized action"),
+				git_path(SEQ_TODO_FILE), lineno, bol);
 
 	/* Eat up extra spaces/ tabs before object name */
 	bol += strspn(bol, " \t");
@@ -757,11 +773,13 @@ static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
 	*end_of_object_name = saved;
 
 	if (status < 0)
-		return -1;
+		return parse_error(_("malformed object name"),
+				git_path(SEQ_TODO_FILE), lineno, bol);
 
 	item->operand = lookup_commit_reference(commit_sha1);
 	if (!item->operand)
-		return -1;
+		return parse_error(_("not a valid commit"),
+				git_path(SEQ_TODO_FILE), lineno, bol);
 
 	item->next = NULL;
 	return 0;
@@ -776,8 +794,8 @@ static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
 
 	for (i = 1; *p; i++) {
 		char *eol = strchrnul(p, '\n');
-		if (parse_insn_line(p, eol, &item))
-			return error(_("Could not parse line %d."), i);
+		if (parse_insn_line(p, eol, &item, i))
+			return -1;
 		next = replay_insn_list_append(item.operand, item.action, next);
 		p = *eol ? eol + 1 : eol;
 	}
-- 
1.7.8.2
