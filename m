From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] format-patch: add format.cover-letter configuration
Date: Sat,  6 Apr 2013 03:03:32 -0600
Message-ID: <1365239012-15079-3-git-send-email-felipe.contreras@gmail.com>
References: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:48:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWTG-0001b9-C7
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849Ab3DFJEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 05:04:46 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:63676 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932834Ab3DFJEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 05:04:44 -0400
Received: by mail-ob0-f175.google.com with SMTP id va7so4341813obc.6
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 02:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=cgOuG1CQRu133+fdYzytrwsZsMpcmak7tIBrHDI+IXU=;
        b=dIU2uCHFVL2m9/inPmrj9GvLWYbTkIGCPlDe/r7jS0bjlxu8FgRkFvUyLvsUs8QUsL
         FvAIMycSRyM+/ZaB0SRgzYk24ylXstM3T1H1UmneqD4sjNQZRKcYCSpAjqoMI+sSwh5s
         ZvAIFooH8Y/HE4AlBJmpHCl281pmGUmaHTI03mh8Mill/XN6J7AGcQXdZV7yiNPpLLb8
         Y9YDsi5iY3TQI7/ZkTMGGhqnM88W4TJDZzyf2FbdRpQc3lGunyHeZxH43+VeQ304pdKy
         MendvUFpG1tP8hayCEwN4aIagSL5oU0oJxxjD1UJNigImaCoTVQoPgNzWnIsDpMRYOS5
         I8bQ==
X-Received: by 10.182.2.132 with SMTP id 4mr10582381obu.42.1365239082773;
        Sat, 06 Apr 2013 02:04:42 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a10sm15939164oez.1.2013.04.06.02.04.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Apr 2013 02:04:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220235>

Also, add a new option: 'auto', so if there's more than one patch, the
cover letter is generated, otherwise it's not.

This has the slight disadvantage that a piece of code will always be run
even if the user doesn't want a cover letter, and thus waste a few
cycles. But the convenience is well worth it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt           |  6 +++++
 Documentation/git-format-patch.txt |  5 ++--
 builtin/log.c                      | 55 +++++++++++++++++++++++---------------
 3 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c8e2178..c10195c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1092,6 +1092,12 @@ format.signoff::
     the rights to submit this work under the same open source license.
     Please see the 'SubmittingPatches' document for further discussion.
 
+format.cover-letter::
+	Allows to configure the --cover-letter option of format-patch by
+	default. In addition, you can set it to 'auto' to automatically
+	determine based on the number of patches (generate if there's more than
+	one).
+
 filter.<driver>.clean::
 	The command which is used to convert the content of a worktree
 	file to a blob upon checkin.  See linkgit:gitattributes[5] for
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3a62f50..e1f5730 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 		   [--ignore-if-in-upstream]
 		   [--subject-prefix=Subject-Prefix] [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
-		   [--cover-letter] [--quiet] [--notes[=<ref>]]
+		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
@@ -195,7 +195,7 @@ will want to ensure that threading is disabled for `git send-email`.
 	`Cc:`, and custom) headers added so far from config or command
 	line.
 
---cover-letter::
+--[no-]cover-letter::
 	In addition to the patches, generate a cover letter file
 	containing the shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
@@ -260,6 +260,7 @@ attachments, and sign off patches with configuration variables.
 	cc = <email>
 	attach [ = mime-boundary-string ]
 	signoff = true
+	cover-letter = auto
 ------------
 
 
diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..ed89c10 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -618,6 +618,7 @@ static void add_header(const char *value)
 #define THREAD_DEEP 2
 static int thread;
 static int do_signoff;
+static int cover_letter;
 static const char *signature = git_version_string;
 
 static int git_format_config(const char *var, const char *value, void *cb)
@@ -680,6 +681,17 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.signature"))
 		return git_config_string(&signature, var, value);
+	if (!strcmp(var, "format.cover-letter")) {
+		if (cover_letter != -1)
+			/* user overrode it */
+			return 0;
+		if (value && !strcasecmp(value, "auto")) {
+			cover_letter = -1;
+			return 0;
+		}
+		cover_letter = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1080,7 +1092,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int start_number = -1;
 	int just_numbers = 0;
 	int ignore_if_in_upstream = 0;
-	int cover_letter = 0;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	struct commit *origin = NULL, *head = NULL;
@@ -1318,28 +1329,26 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	 */
 	rev.show_root_diff = 1;
 
-	if (cover_letter) {
-		/*
-		 * NEEDSWORK:randomly pick one positive commit to show
-		 * diffstat; this is often the tip and the command
-		 * happens to do the right thing in most cases, but a
-		 * complex command like "--cover-letter a b c ^bottom"
-		 * picks "c" and shows diffstat between bottom..c
-		 * which may not match what the series represents at
-		 * all and totally broken.
-		 */
-		int i;
-		for (i = 0; i < rev.pending.nr; i++) {
-			struct object *o = rev.pending.objects[i].item;
-			if (!(o->flags & UNINTERESTING))
-				head = (struct commit *)o;
-		}
-		/* There is nothing to show; it is not an error, though. */
-		if (!head)
-			return 0;
-		if (!branch_name)
-			branch_name = find_branch_name(&rev);
+	/*
+	 * NEEDSWORK:randomly pick one positive commit to show
+	 * diffstat; this is often the tip and the command
+	 * happens to do the right thing in most cases, but a
+	 * complex command like "--cover-letter a b c ^bottom"
+	 * picks "c" and shows diffstat between bottom..c
+	 * which may not match what the series represents at
+	 * all and totally broken.
+	 */
+	for (i = 0; i < rev.pending.nr; i++) {
+		struct object *o = rev.pending.objects[i].item;
+		if (!(o->flags & UNINTERESTING))
+			head = (struct commit *)o;
 	}
+	/* There is nothing to show; it is not an error, though. */
+	if (!head)
+		return 0;
+
+	if (!branch_name)
+		branch_name = find_branch_name(&rev);
 
 	if (ignore_if_in_upstream) {
 		/* Don't say anything if head and upstream are the same. */
@@ -1377,6 +1386,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		numbered = 1;
 	if (numbered)
 		rev.total = total + start_number - 1;
+	if (cover_letter == -1)
+		cover_letter = (total > 1);
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
-- 
1.8.2
