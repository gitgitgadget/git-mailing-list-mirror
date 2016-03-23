From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/5] pretty-print: limit expand-tabs to selected --pretty formats
Date: Wed, 23 Mar 2016 16:23:45 -0700
Message-ID: <1458775426-2215-5-git-send-email-gitster@pobox.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
 <1458775426-2215-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 00:24:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ais8A-00083p-3G
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 00:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbcCWXX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 19:23:57 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753186AbcCWXX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 19:23:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38FBE50C1D;
	Wed, 23 Mar 2016 19:23:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Kdij
	gPzSTgz/Q1sj6HdRmZEqZik=; b=eVq7nvP/IGNMAMrQ8VeunJg3QgS0s4ZqtRDJ
	c7qTMPLnVzebAL/zvbe1dTawI2vkxT1xVjhS/TtK8VNhf3Sk0pj3pA7msurhywnt
	GzGMcyNgzWlR/9YnS+2Je+s+I958m/zb6V7r58l1c0qAlDHsVji2TA0dqtFuA76r
	ZevKD8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	b3uxBugiqQj7attp0RyxM8gbMHzpxYcUr1BpYIjAKi+NLKK0K8saiDkhdI1QJCBC
	DzLiexQeHSJKecdI9bUilv0ahKjuVetSa6H+44hQJO1Gd6b1OHy877rV8ctCYN40
	1s+fTNRdVaZGFawYhhXQbFmqQYeSmbFmWaHbuaoLUOg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3000650C1C;
	Wed, 23 Mar 2016 19:23:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8C6D950C1A;
	Wed, 23 Mar 2016 19:23:54 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-rc4-198-g3f6b64c
In-Reply-To: <1458775426-2215-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4F5CA492-F14E-11E5-BFBD-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289696>

Make sure that "git log" (by default, it uses --pretty=medium)
and "git log --pretty={full,fuller}" are the only ones that trigger
the new "expand tabs in the log message" behaviour.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h            |  1 +
 log-tree.c          |  1 +
 pretty.c            | 26 ++++++++++++++++----------
 revision.c          |  1 +
 revision.h          |  1 +
 t/t4201-shortlog.sh |  2 +-
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/commit.h b/commit.h
index 5d58be0..a7ef682 100644
--- a/commit.h
+++ b/commit.h
@@ -147,6 +147,7 @@ struct pretty_print_context {
 	int preserve_subject;
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
+	unsigned expand_tabs_in_log:1;
 	int need_8bit_cte;
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
diff --git a/log-tree.c b/log-tree.c
index 60f9839..78a5381 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -683,6 +683,7 @@ void show_log(struct rev_info *opt)
 	ctx.fmt = opt->commit_format;
 	ctx.mailmap = opt->mailmap;
 	ctx.color = opt->diffopt.use_color;
+	ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
 	ctx.output_encoding = get_log_output_encoding();
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
diff --git a/pretty.c b/pretty.c
index 717ceed..5a33b7e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -16,6 +16,7 @@ static struct cmt_fmt_map {
 	const char *name;
 	enum cmit_fmt format;
 	int is_tformat;
+	int expand_tabs_in_log;
 	int is_alias;
 	const char *user_format;
 } *commit_formats;
@@ -87,13 +88,13 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
 static void setup_commit_formats(void)
 {
 	struct cmt_fmt_map builtin_formats[] = {
-		{ "raw",	CMIT_FMT_RAW,		0 },
-		{ "medium",	CMIT_FMT_MEDIUM,	0 },
-		{ "short",	CMIT_FMT_SHORT,		0 },
-		{ "email",	CMIT_FMT_EMAIL,		0 },
-		{ "fuller",	CMIT_FMT_FULLER,	0 },
-		{ "full",	CMIT_FMT_FULL,		0 },
-		{ "oneline",	CMIT_FMT_ONELINE,	1 }
+		{ "raw",	CMIT_FMT_RAW,		0,	0 },
+		{ "medium",	CMIT_FMT_MEDIUM,	0,	1 },
+		{ "short",	CMIT_FMT_SHORT,		0,	0 },
+		{ "email",	CMIT_FMT_EMAIL,		0,	0 },
+		{ "fuller",	CMIT_FMT_FULLER,	0,	1 },
+		{ "full",	CMIT_FMT_FULL,		0,	1 },
+		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
 	};
 	commit_formats_len = ARRAY_SIZE(builtin_formats);
 	builtin_formats_len = commit_formats_len;
@@ -172,6 +173,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 
 	rev->commit_format = commit_format->format;
 	rev->use_terminator = commit_format->is_tformat;
+	rev->expand_tabs_in_log = commit_format->expand_tabs_in_log;
 	if (commit_format->format == CMIT_FMT_USERFORMAT) {
 		save_user_format(rev, commit_format->user_format,
 				 commit_format->is_tformat);
@@ -1685,11 +1687,15 @@ static void strbuf_add_tabexpand(struct strbuf *sb,
  * the whole line (without the final newline), after
  * de-tabifying.
  */
-static void pp_handle_indent(struct strbuf *sb, int indent,
+static void pp_handle_indent(struct pretty_print_context *pp,
+			     struct strbuf *sb, int indent,
 			     const char *line, int linelen)
 {
 	strbuf_addchars(sb, ' ', indent);
-	strbuf_add_tabexpand(sb, line, linelen);
+	if (pp->expand_tabs_in_log)
+		strbuf_add_tabexpand(sb, line, linelen);
+	else
+		strbuf_add(sb, line, linelen);
 }
 
 void pp_remainder(struct pretty_print_context *pp,
@@ -1716,7 +1722,7 @@ void pp_remainder(struct pretty_print_context *pp,
 
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent)
-			pp_handle_indent(sb, indent, line, linelen);
+			pp_handle_indent(pp, sb, indent, line, linelen);
 		else
 			strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
diff --git a/revision.c b/revision.c
index df56fce..8827d9f 100644
--- a/revision.c
+++ b/revision.c
@@ -1412,6 +1412,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->skip_count = -1;
 	revs->max_count = -1;
 	revs->max_parents = -1;
+	revs->expand_tabs_in_log = 1;
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
diff --git a/revision.h b/revision.h
index 23857c0..0bbfe0e 100644
--- a/revision.h
+++ b/revision.h
@@ -137,6 +137,7 @@ struct rev_info {
 			abbrev_commit_given:1,
 			zero_commit:1,
 			use_terminator:1,
+			expand_tabs_in_log:1,
 			missing_newline:1,
 			date_mode_explicit:1,
 			preserve_subject:1;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 987b708..d1e8259 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -93,7 +93,7 @@ test_expect_success 'output from user-defined format is re-wrapped' '
 	test_cmp expect log.predictable
 '
 
-test_expect_failure !MINGW 'shortlog wrapping' '
+test_expect_success !MINGW 'shortlog wrapping' '
 	cat >expect <<\EOF &&
 A U Thor (5):
       Test
-- 
2.8.0-rc4-198-g3f6b64c
