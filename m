From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/3] pretty: allow tweaking tabwidth in --expand-tabs
Date: Tue, 29 Mar 2016 16:15:09 -0700
Message-ID: <1459293309-25195-4-git-send-email-gitster@pobox.com>
References: <1458775426-2215-1-git-send-email-gitster@pobox.com>
 <1459293309-25195-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 01:15:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2rG-0005Qn-Ip
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758533AbcC2XPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:15:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758491AbcC2XPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:15:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76D2850FB7;
	Tue, 29 Mar 2016 19:15:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QLl8
	TbmZ4kry54MheyQ9fNPppgE=; b=jfgakyDvUMJgY+eFi0NzxIGSqJ/f9iQB0+LR
	NRFnty54bThm2sFt4Sb3fk+ArIqLiruWzFrYaBgVgcrhOuTVkAvSqoY+W/nX8vkJ
	1vCqHWWR+74yAzQtxv1QMF2zSzHhtC50MfcJX/ZYBO0GlCINZa5LxmFbMbUO3dlq
	pEYzXiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Gh2fRfD5UV0kPF8qwik4wos0rD7ff/OwIcGRsjezIBYJEvBfhSYM2CvGY8eIe77e
	yB4YQInfqRW28UBjb+GawdcVaxXdYccE11qbHcX3k10iPWdYz9yTVShIfvWW1B9c
	Rt5XxnDbECSjPLHxNBsrTzxL1uC6r99RZXMBZZNGJrM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F94850FB6;
	Tue, 29 Mar 2016 19:15:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AD45B50FB4;
	Tue, 29 Mar 2016 19:15:15 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-gd29a7d9
In-Reply-To: <1459293309-25195-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1892280A-F604-11E5-8461-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290224>

When the local convention of the project is to use tab width that is
not 8, it may make sense to allow "git log --expand-tabs=<n>" to
tweak the output to match it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pretty-options.txt | 10 ++++++----
 commit.h                         |  2 +-
 pretty.c                         | 12 ++++++------
 revision.c                       |  9 +++++++--
 revision.h                       |  3 +--
 5 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 23967b6..8a944b1 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -42,17 +42,19 @@ people using 80-column terminals.
 	verbatim; this means that invalid sequences in the original
 	commit may be copied to the output.
 
+--expand-tabs=<n>::
 --expand-tabs::
 --no-expand-tabs::
 	Perform a tab expansion (replace each tab with enough number
 	of spaces to fill to the next display column that is
-	multiple of 8) in the log message before using the message
-	to show in the output.
+	multiple of '<n>') in the log message before using the message
+	to show in the output.  `--expand-tabs` is a short-hand for
+	`--expand-tabs=8`, and `--no-expand-tabs` is a short-hand for
+	`--expand-tabs=0`, which disables tab expansion.
 +
 By default, tabs are expanded in pretty formats that indent the log
 message by 4 spaces (i.e.  'medium', which is the default, 'full',
-and "fuller').  `--no-expand-tabs` option can be used to disable
-this.
+and "fuller').
 
 ifndef::git-rev-list[]
 --notes[=<ref>]::
diff --git a/commit.h b/commit.h
index a7ef682..2185c8d 100644
--- a/commit.h
+++ b/commit.h
@@ -147,7 +147,7 @@ struct pretty_print_context {
 	int preserve_subject;
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
-	unsigned expand_tabs_in_log:1;
+	unsigned expand_tabs_in_log;
 	int need_8bit_cte;
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
diff --git a/pretty.c b/pretty.c
index de22a8c..b340ecd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -89,11 +89,11 @@ static void setup_commit_formats(void)
 {
 	struct cmt_fmt_map builtin_formats[] = {
 		{ "raw",	CMIT_FMT_RAW,		0,	0 },
-		{ "medium",	CMIT_FMT_MEDIUM,	0,	1 },
+		{ "medium",	CMIT_FMT_MEDIUM,	0,	8 },
 		{ "short",	CMIT_FMT_SHORT,		0,	0 },
 		{ "email",	CMIT_FMT_EMAIL,		0,	0 },
-		{ "fuller",	CMIT_FMT_FULLER,	0,	1 },
-		{ "full",	CMIT_FMT_FULL,		0,	1 },
+		{ "fuller",	CMIT_FMT_FULLER,	0,	8 },
+		{ "full",	CMIT_FMT_FULL,		0,	8 },
 		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
 	};
 	commit_formats_len = ARRAY_SIZE(builtin_formats);
@@ -1645,7 +1645,7 @@ static int pp_utf8_width(const char *start, const char *end)
 	return width;
 }
 
-static void strbuf_add_tabexpand(struct strbuf *sb,
+static void strbuf_add_tabexpand(struct strbuf *sb, int tabwidth,
 				 const char *line, int linelen)
 {
 	const char *tab;
@@ -1666,7 +1666,7 @@ static void strbuf_add_tabexpand(struct strbuf *sb,
 		strbuf_add(sb, line, tab - line);
 
 		/* .. and the de-tabified tab */
-		strbuf_addchars(sb, ' ', 8 - (width % 8));
+		strbuf_addchars(sb, ' ', tabwidth - (width % tabwidth));
 
 		/* Skip over the printed part .. */
 		linelen -= tab + 1 - line;
@@ -1692,7 +1692,7 @@ static void pp_handle_indent(struct pretty_print_context *pp,
 {
 	strbuf_addchars(sb, ' ', indent);
 	if (pp->expand_tabs_in_log)
-		strbuf_add_tabexpand(sb, line, linelen);
+		strbuf_add_tabexpand(sb, pp->expand_tabs_in_log, line, linelen);
 	else
 		strbuf_add(sb, line, linelen);
 }
diff --git a/revision.c b/revision.c
index b1d767a..4f9ecbe 100644
--- a/revision.c
+++ b/revision.c
@@ -1412,7 +1412,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->skip_count = -1;
 	revs->max_count = -1;
 	revs->max_parents = -1;
-	revs->expand_tabs_in_log = 1;
+	revs->expand_tabs_in_log = 8;
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
@@ -1917,9 +1917,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->pretty_given = 1;
 		get_commit_format(arg+9, revs);
 	} else if (!strcmp(arg, "--expand-tabs")) {
-		revs->expand_tabs_in_log = 1;
+		revs->expand_tabs_in_log = 8;
 	} else if (!strcmp(arg, "--no-expand-tabs")) {
 		revs->expand_tabs_in_log = 0;
+	} else if (skip_prefix(arg, "--expand-tabs=", &arg)) {
+		int val;
+		if (strtol_i(arg, 10, &val) < 0 || val < 0)
+			die("'%s': not a non-negative integer", arg);
+		revs->expand_tabs_in_log = val;
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
diff --git a/revision.h b/revision.h
index 4079753..cf6615a 100644
--- a/revision.h
+++ b/revision.h
@@ -133,7 +133,6 @@ struct rev_info {
 			show_notes_given:1,
 			show_signature:1,
 			pretty_given:1,
-			expand_tabs_in_log:1,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
 			zero_commit:1,
@@ -149,7 +148,7 @@ struct rev_info {
 			linear:1;
 
 	struct date_mode date_mode;
-
+	unsigned int	expand_tabs_in_log;
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
 	struct log_info *loginfo;
-- 
2.8.0-215-gd29a7d9
