From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] revert: report fine-grained errors from insn parser
Date: Thu, 29 Mar 2012 19:28:15 +0530
Message-ID: <1333029495-10034-5-git-send-email-artagnon@gmail.com>
References: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 15:59:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDFsT-0007Q4-RN
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 15:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986Ab2C2N6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 09:58:44 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57959 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759383Ab2C2N6h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 09:58:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so162702pbc.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 06:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MeniTPIONuzl0f5gXLuoTpoqczdtq6zw9pqSlCe4Xng=;
        b=T/zBDdIxbpZ8cc+KU1vniKbu3vIs8acDQQWWdSVAxFKZdEWaEZ58Chjl3c0kSZdO2Q
         h2Twx2H1sP28wYyGPDRJuKsbfO6xnNpHGS8B2/n/1Ms/L0Rf7p18p7V3Z1dEM5JGP6s2
         Q2FX4fgc/3vM4Kkm9XfoSZn+04PILkeBGEgx18OpPK6DNvPPd5yP/mBgjTFSFyCvmioL
         JxsLpvE9R32FQ3pbIsv+gEM94q3tcgjeTozibPKj4AW8I37b/ypN0B4+8NeFJnBcOiHK
         lTpRzB/nyt09rp/U1d2Yf9iorrbw8Dtg+bBELI2EZKeeH7PwUiGy15UstQlbXW7itDSk
         59dw==
Received: by 10.68.225.229 with SMTP id rn5mr147398pbc.115.1333029516180;
        Thu, 29 Mar 2012 06:58:36 -0700 (PDT)
Received: from localhost.localdomain ([122.174.77.58])
        by mx.google.com with ESMTPS id j3sm5090947pbb.29.2012.03.29.06.58.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 06:58:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194257>

The infrastructure that parses '.git/sequencer/todo' is meant to
handle arbitrary user input some day, so it can be used as the
implementation of 'git rebase --interactive' and 'git sequencer
--edit'.  It is currently sub-optimal for that purpose because the
parse error messages just say:

  error: Could not parse line 5.

This patch shifts responsibility to parse_insn_line(), which can come
up with a more detailed message like:

  error: .git/sequencer/todo:5: unrecognized action: frobnicate

Once the operator is allowed to edit the sequence, the message might
be adjusted to something like:

  error: <sequence you just gave me>:5: unrecognized action: frobnicate

instead of exposing an implementation detail.  Some day 'git sequencer
--edit' could even re-launch the editor with an error message in a
comment before the problematic line and the cursor pointing there.
For now, pointing to the explicit filename is useful since this should
only happen if there was filesystem corruption, tampering, or a git
bug.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sequencer.c |   45 +++++++++++++++++++++++++++++++++------------
 1 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 02e58ad..cb93ee8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -513,7 +513,22 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 	return 0;
 }
 
-static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *opts)
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
+int parse_insn_line(char *bol, char *eol, struct replay_opts *opts,
+		struct commit_list *list, int lineno)
 {
 	unsigned char commit_sha1[20];
 	enum replay_action action;
@@ -526,7 +541,8 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 		action = REPLAY_REVERT;
 		bol += strlen("revert");
 	} else
-		return NULL;
+		return parse_error(_("unrecognized action"),
+				git_path(SEQ_TODO_FILE), lineno, bol);
 
 	/* Eat up extra spaces/ tabs before object name */
 	bol += strspn(bol, " \t");
@@ -538,32 +554,36 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	if (action != opts->action) {
 		const char *action_str;
 		action_str = action == REPLAY_REVERT ? "revert" : "cherry-pick";
-		error(_("Cannot %s during a %s"), action_str, action_name(opts));
-		return NULL;
+		return parse_error(_("invalid action"),
+				git_path(SEQ_TODO_FILE), lineno, bol);
 	}
 
 	namelen = strcspn(bol, " \t\n");
 	if (getn_sha1(bol, namelen, commit_sha1))
-		return NULL;
-
-	return lookup_commit_reference(commit_sha1);
+		return parse_error(_("malformed object name"),
+				git_path(SEQ_TODO_FILE), lineno, bol);
+
+	list->item = lookup_commit_reference(commit_sha1);
+	if (!list->item)
+		return parse_error(_("not a valid commit"),
+				git_path(SEQ_TODO_FILE), lineno, bol);
+	list->next = NULL;
+	return 0;
 }
 
 static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 			struct replay_opts *opts)
 {
 	struct commit_list **next = todo_list;
-	struct commit *commit;
+	struct commit_list list;
 	char *p = buf;
 	int i;
 
 	for (i = 1; *p; i++) {
 		char *eol = strchrnul(p, '\n');
-		commit = parse_insn_line(p, eol, opts);
-		if (!commit)
-			return error(_("Could not parse line %d."), i);
-		next = commit_list_append(commit, next);
+		if (parse_insn_line(p, eol, opts, &list, i))
+			return -1;
+		next = commit_list_append(list.item, next);
 		p = *eol ? eol + 1 : eol;
 	}
 	if (!*todo_list)
-- 
1.7.8.1.362.g5d6df.dirty
