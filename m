From: Marcus Karlsson <mk@acc.umu.se>
Subject: [PATCH/RFC] grep: optionally show only the match
Date: Sun,  9 Sep 2012 23:58:25 +0200
Message-ID: <1347227905-2398-1-git-send-email-mk@acc.umu.se>
Cc: gitster@pobox.com, Marcus Karlsson <mk@acc.umu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 00:09:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TApgd-0001BM-87
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 00:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab2IIWI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 18:08:27 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:33868 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754919Ab2IIWI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 18:08:26 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Sep 2012 18:08:26 EDT
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id A870D1C2;
	Sun,  9 Sep 2012 23:58:49 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from kennedy.acc.umu.se (kennedy.acc.umu.se [130.239.18.157])
	by mail.acc.umu.se (Postfix) with ESMTP id D9C051C1;
	Sun,  9 Sep 2012 23:58:48 +0200 (MEST)
Received: by kennedy.acc.umu.se (Postfix, from userid 24678)
	id B5AF89C; Sun,  9 Sep 2012 23:58:48 +0200 (MEST)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205103>

Make git-grep optionally omit the parts of the line before and after the
match.

Signed-off-by: Marcus Karlsson <mk@acc.umu.se>
---
 Documentation/git-grep.txt | 8 +++++++-
 builtin/grep.c             | 2 ++
 grep.c                     | 7 +++++--
 grep.h                     | 1 +
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index cfecf84..6ef22cb 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -20,7 +20,8 @@ SYNOPSIS
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
 	   [--color[=<when>] | --no-color]
-	   [--break] [--heading] [-p | --show-function]
+	   [--break] [--heading] [-o | --only-matching]
+	   [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
@@ -183,6 +184,11 @@ OPTIONS
 	Show the filename above the matches in that file instead of
 	at the start of each shown line.
 
+-o::
+--only-matching::
+	Show only the part of the matching line that matched the
+	pattern.
+
 -p::
 --show-function::
 	Show the preceding line that contains the function name of
diff --git a/builtin/grep.c b/builtin/grep.c
index 09ca4c9..56aba7b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -782,6 +782,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("print empty line between matches from different files")),
 		OPT_BOOLEAN(0, "heading", &opt.heading,
 			N_("show filename only once above matches from same file")),
+		OPT_BOOLEAN('o', "only-matching", &opt.only_matching,
+			N_("show only the matching part of a matched line")),
 		OPT_GROUP(""),
 		OPT_CALLBACK('C', "context", &opt, N_("n"),
 			N_("show <n> context lines before and after matches"),
diff --git a/grep.c b/grep.c
index 04e3ec6..9fc888e 100644
--- a/grep.c
+++ b/grep.c
@@ -827,7 +827,9 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 			if (match.rm_so == match.rm_eo)
 				break;
 
-			output_color(opt, bol, match.rm_so, line_color);
+			if (opt->only_matching == 0)
+				output_color(opt, bol, match.rm_so,
+					     line_color);
 			output_color(opt, bol + match.rm_so,
 				     match.rm_eo - match.rm_so,
 				     opt->color_match);
@@ -837,7 +839,8 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		}
 		*eol = ch;
 	}
-	output_color(opt, bol, rest, line_color);
+	if (opt->only_matching == 0)
+		output_color(opt, bol, rest, line_color);
 	opt->output(opt, "\n", 1);
 }
 
diff --git a/grep.h b/grep.h
index 75afb7b..4163102 100644
--- a/grep.h
+++ b/grep.h
@@ -127,6 +127,7 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
+	int only_matching;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
-- 
1.7.12.289.g0ce9864.dirty
