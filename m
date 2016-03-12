From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 14/17] status: use rebase_todo_list
Date: Sat, 12 Mar 2016 18:46:34 +0800
Message-ID: <1457779597-6918-15-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh5K-0006B3-N2
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbcCLKro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:44 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34298 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbcCLKrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:39 -0500
Received: by mail-pf0-f179.google.com with SMTP id x3so7831589pfb.1
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TNdg8OPxZPR+Fg3yo5YhCnYgrey+Q2lefr8UWQti+Gw=;
        b=ifBkzPFDKB7cwZwrFCbgKJsvm8ss6L62doCBNFAqugEuGQfu/HHJti2odPt3JcbDcR
         y1R68m6jgPQY+asx+j3TYVfiX4ExEvRBoWqVkeL/1cjIhKxgRo2XsiOUYAmZ+g+zORbu
         4SxDrzziH57RumF/MDp/D/TmZXUF9eCFItDoJcBCzrMZqtDhdc716ycwbkZoC0471sEq
         xTjXC/XSqRfjrbFKrNqcEPCtXeXQdOabC6GHyCwTHQNJavcMppsqMw4OUMVbj80z0p4h
         neu2TKv1RU5rNbtFB0K/HSZz0ru00cOiy0lk8y5YCVo6+vh79n4TXz6tpfc4LptXOYG9
         Tr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TNdg8OPxZPR+Fg3yo5YhCnYgrey+Q2lefr8UWQti+Gw=;
        b=XBYtMT8QWaPtWtF6Bvra804L7KTSCDJQ7eW462MmqDyOTbD9OCi4t/Hzbvz1u7ufUO
         xmbNb/N2ZyiumGwZng799jIj6wIXxOyBO0wqziOo3lmccihIAqDgez3KujlAUKOtk4au
         pStmU28Q/x/ty/Egd2ccfMpqoP/t0d+8tEAkRUaeizeV70R0DA+Fij+EeQBHAUCyskhy
         Pj+RGB0lySG7yv4AECtT+q1nKCMjQwRMvb4vSr/h/DlcLZ6fZro1roXrbbAmoTSys++9
         /Nzizbv6HrfjhNEx+AdOXMHzTSg1A+IwZzygGxX9hpaGzIPIUQteA+v2ThAwb5lg9ZRf
         A3ag==
X-Gm-Message-State: AD7BkJKY3Q42K1GpaIGrIOvx9XYsj+1XO3/9YlVXuwTMXAxG10PG9p1HrdX0PEQt9Sr0qQ==
X-Received: by 10.98.71.91 with SMTP id u88mr14918830pfa.161.1457779658197;
        Sat, 12 Mar 2016 02:47:38 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:37 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288746>

Since 84e6fb9 (status: give more information during rebase -i,
2015-07-06), git status during an interactive rebase will show the list
of commands that are done and yet to be done. It implemented its own
hand-rolled parser in order to achieve this.

Now that we are able to fully parse interactive rebase's todo lists with
rebase_todo_list_parse(), use it in wt-status.c to reduce the amount of
code needed to implement this feature.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

This patch is just an illustration, and is not quite right as it does not strip
comments and blank lines like the original did.

 wt-status.c | 100 +++++++++++++++---------------------------------------------
 1 file changed, 25 insertions(+), 75 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ab4f80d..96b82ef 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -15,6 +15,7 @@
 #include "column.h"
 #include "strbuf.h"
 #include "utf8.h"
+#include "rebase-todo.h"
 
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
@@ -1026,94 +1027,39 @@ static int split_commit_in_progress(struct wt_status *s)
 	return split_in_progress;
 }
 
-/*
- * Turn
- * "pick d6a2f0303e897ec257dd0e0a39a5ccb709bc2047 some message"
- * into
- * "pick d6a2f03 some message"
- *
- * The function assumes that the line does not contain useless spaces
- * before or after the command.
- */
-static void abbrev_sha1_in_line(struct strbuf *line)
-{
-	struct strbuf **split;
-	int i;
-
-	if (starts_with(line->buf, "exec ") ||
-	    starts_with(line->buf, "x "))
-		return;
-
-	split = strbuf_split_max(line, ' ', 3);
-	if (split[0] && split[1]) {
-		unsigned char sha1[20];
-		const char *abbrev;
-
-		/*
-		 * strbuf_split_max left a space. Trim it and re-add
-		 * it after abbreviation.
-		 */
-		strbuf_trim(split[1]);
-		if (!get_sha1(split[1]->buf, sha1)) {
-			abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
-			strbuf_reset(split[1]);
-			strbuf_addf(split[1], "%s ", abbrev);
-			strbuf_reset(line);
-			for (i = 0; split[i]; i++)
-				strbuf_addf(line, "%s", split[i]->buf);
-		}
-	}
-	for (i = 0; split[i]; i++)
-		strbuf_release(split[i]);
-
-}
-
-static void read_rebase_todolist(const char *fname, struct string_list *lines)
-{
-	struct strbuf line = STRBUF_INIT;
-	FILE *f = fopen(git_path("%s", fname), "r");
-
-	if (!f)
-		die_errno("Could not open file %s for reading",
-			  git_path("%s", fname));
-	while (!strbuf_getline_lf(&line, f)) {
-		if (line.len && line.buf[0] == comment_line_char)
-			continue;
-		strbuf_trim(&line);
-		if (!line.len)
-			continue;
-		abbrev_sha1_in_line(&line);
-		string_list_append(lines, line.buf);
-	}
-}
-
 static void show_rebase_information(struct wt_status *s,
 					struct wt_status_state *state,
 					const char *color)
 {
 	if (state->rebase_interactive_in_progress) {
-		int i;
-		int nr_lines_to_show = 2;
+		unsigned int i;
+		unsigned int nr_lines_to_show = 2;
+		struct strbuf sb = STRBUF_INIT;
 
-		struct string_list have_done = STRING_LIST_INIT_DUP;
-		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
+		struct rebase_todo_list have_done = REBASE_TODO_LIST_INIT;
+		struct rebase_todo_list yet_to_do = REBASE_TODO_LIST_INIT;
 
-		read_rebase_todolist("rebase-merge/done", &have_done);
-		read_rebase_todolist("rebase-merge/git-rebase-todo", &yet_to_do);
+		if (rebase_todo_list_load(&have_done, git_path("rebase-merge/done"), 1) < 0)
+			return;
+		if (rebase_todo_list_load(&yet_to_do, git_path("rebase-merge/git-rebase-todo"), 1) < 0)
+			return;
 
 		if (have_done.nr == 0)
 			status_printf_ln(s, color, _("No commands done."));
 		else {
 			status_printf_ln(s, color,
-				Q_("Last command done (%d command done):",
-					"Last commands done (%d commands done):",
+				Q_("Last command done (%u command done):",
+					"Last commands done (%u commands done):",
 					have_done.nr),
 				have_done.nr);
 			for (i = (have_done.nr > nr_lines_to_show)
 				? have_done.nr - nr_lines_to_show : 0;
 				i < have_done.nr;
-				i++)
-				status_printf_ln(s, color, "   %s", have_done.items[i].string);
+				i++) {
+				strbuf_reset(&sb);
+				strbuf_add_rebase_todo_item(&sb, &have_done.items[i], 1);
+				status_printf(s, color, "   %s", sb.buf);
+			}
 			if (have_done.nr > nr_lines_to_show && s->hints)
 				status_printf_ln(s, color,
 					_("  (see more in file %s)"), git_path("rebase-merge/done"));
@@ -1128,14 +1074,18 @@ static void show_rebase_information(struct wt_status *s,
 					"Next commands to do (%d remaining commands):",
 					yet_to_do.nr),
 				yet_to_do.nr);
-			for (i = 0; i < nr_lines_to_show && i < yet_to_do.nr; i++)
-				status_printf_ln(s, color, "   %s", yet_to_do.items[i].string);
+			for (i = 0; i < nr_lines_to_show && i < yet_to_do.nr; i++) {
+				strbuf_reset(&sb);
+				strbuf_add_rebase_todo_item(&sb, &yet_to_do.items[i], 1);
+				status_printf(s, color, "   %s", sb.buf);
+			}
 			if (s->hints)
 				status_printf_ln(s, color,
 					_("  (use \"git rebase --edit-todo\" to view and edit)"));
 		}
-		string_list_clear(&yet_to_do, 0);
-		string_list_clear(&have_done, 0);
+		rebase_todo_list_clear(&yet_to_do);
+		rebase_todo_list_clear(&have_done);
+		strbuf_release(&sb);
 	}
 }
 
-- 
2.7.0
