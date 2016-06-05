From: Eric Wong <e@80x24.org>
Subject: [PATCH v2 1/3] pretty: support "mboxrd" output format
Date: Sun,  5 Jun 2016 04:46:39 +0000
Message-ID: <20160605044641.9221-2-e@80x24.org>
References: <20160605044641.9221-1-e@80x24.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 06:46:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9Pxg-0006df-Mp
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 06:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbcFEEqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 00:46:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35402 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbcFEEqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 00:46:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757711FE50;
	Sun,  5 Jun 2016 04:46:45 +0000 (UTC)
In-Reply-To: <20160605044641.9221-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296463>

This output format prevents format-patch output from breaking
readers if somebody copy+pasted an mbox into a commit message.

Unlike the traditional "mboxo" format, "mboxrd" is designed to
be fully-reversible.  "mboxrd" also gracefully degrades to
showing extra ">" in existing "mboxo" readers.

This degradation is preferable to breaking message splitting
completely, a problem I've seen in "mboxcl" due to having
multiple, non-existent, or inaccurate Content-Length headers.

"mboxcl2" is a non-starter since it's inherits the problems
of "mboxcl" while being completely incompatible with existing
tooling based around mailsplit.

ref: http://homepage.ntlworld.com/jonathan.deboynepollard/FGA/mail-mbox-formats.html

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/log.c           |  2 +-
 commit.h                |  6 ++++++
 log-tree.c              |  4 ++--
 pretty.c                | 33 +++++++++++++++++++++++++--------
 t/t4014-format-patch.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 099f4f7..6d6f368 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -953,7 +953,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	struct pretty_print_context pp = {0};
 	struct commit *head = list[0];
 
-	if (rev->commit_format != CMIT_FMT_EMAIL)
+	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("Cover letter needs email format"));
 
 	committer = git_committer_info(0);
diff --git a/commit.h b/commit.h
index b06db4d..1e04d3a 100644
--- a/commit.h
+++ b/commit.h
@@ -131,11 +131,17 @@ enum cmit_fmt {
 	CMIT_FMT_FULLER,
 	CMIT_FMT_ONELINE,
 	CMIT_FMT_EMAIL,
+	CMIT_FMT_MBOXRD,
 	CMIT_FMT_USERFORMAT,
 
 	CMIT_FMT_UNSPECIFIED
 };
 
+static inline int cmit_fmt_is_mail(enum cmit_fmt fmt)
+{
+	return (fmt == CMIT_FMT_EMAIL || fmt == CMIT_FMT_MBOXRD);
+}
+
 struct pretty_print_context {
 	/*
 	 * Callers should tweak these to change the behavior of pp_* functions.
diff --git a/log-tree.c b/log-tree.c
index 78a5381..48daf84 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -603,7 +603,7 @@ void show_log(struct rev_info *opt)
 	 * Print header line of header..
 	 */
 
-	if (opt->commit_format == CMIT_FMT_EMAIL) {
+	if (cmit_fmt_is_mail(opt->commit_format)) {
 		log_write_email_headers(opt, commit, &ctx.subject, &extra_headers,
 					&ctx.need_8bit_cte);
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
@@ -694,7 +694,7 @@ void show_log(struct rev_info *opt)
 
 	if ((ctx.fmt != CMIT_FMT_USERFORMAT) &&
 	    ctx.notes_message && *ctx.notes_message) {
-		if (ctx.fmt == CMIT_FMT_EMAIL) {
+		if (cmit_fmt_is_mail(ctx.fmt)) {
 			strbuf_addstr(&msgbuf, "---\n");
 			opt->shown_dashes = 1;
 		}
diff --git a/pretty.c b/pretty.c
index 87c4497..6abd8a1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -92,6 +92,7 @@ static void setup_commit_formats(void)
 		{ "medium",	CMIT_FMT_MEDIUM,	0,	8 },
 		{ "short",	CMIT_FMT_SHORT,		0,	0 },
 		{ "email",	CMIT_FMT_EMAIL,		0,	0 },
+		{ "mboxrd",	CMIT_FMT_MBOXRD,	0,	0 },
 		{ "fuller",	CMIT_FMT_FULLER,	0,	8 },
 		{ "full",	CMIT_FMT_FULL,		0,	8 },
 		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
@@ -444,7 +445,7 @@ void pp_user_info(struct pretty_print_context *pp,
 	if (pp->mailmap)
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
 
-	if (pp->fmt == CMIT_FMT_EMAIL) {
+	if (cmit_fmt_is_mail(pp->fmt)) {
 		if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
 			struct strbuf buf = STRBUF_INIT;
 
@@ -494,6 +495,7 @@ void pp_user_info(struct pretty_print_context *pp,
 			    show_ident_date(&ident, &pp->date_mode));
 		break;
 	case CMIT_FMT_EMAIL:
+	case CMIT_FMT_MBOXRD:
 		strbuf_addf(sb, "Date: %s\n",
 			    show_ident_date(&ident, DATE_MODE(RFC2822)));
 		break;
@@ -535,7 +537,7 @@ static void add_merge_info(const struct pretty_print_context *pp,
 {
 	struct commit_list *parent = commit->parents;
 
-	if ((pp->fmt == CMIT_FMT_ONELINE) || (pp->fmt == CMIT_FMT_EMAIL) ||
+	if ((pp->fmt == CMIT_FMT_ONELINE) || (cmit_fmt_is_mail(pp->fmt)) ||
 	    !parent || !parent->next)
 		return;
 
@@ -1614,7 +1616,7 @@ void pp_title_line(struct pretty_print_context *pp,
 	if (pp->after_subject) {
 		strbuf_addstr(sb, pp->after_subject);
 	}
-	if (pp->fmt == CMIT_FMT_EMAIL) {
+	if (cmit_fmt_is_mail(pp->fmt)) {
 		strbuf_addch(sb, '\n');
 	}
 
@@ -1697,6 +1699,16 @@ static void pp_handle_indent(struct pretty_print_context *pp,
 		strbuf_add(sb, line, linelen);
 }
 
+static int is_mboxrd_from(const char *line, int len)
+{
+	/*
+	 * a line matching /^From $/ here would only have len == 4
+	 * at this point because is_empty_line would've trimmed all
+	 * trailing space
+	 */
+	return len > 4 && starts_with(line + strspn(line, ">"), "From ");
+}
+
 void pp_remainder(struct pretty_print_context *pp,
 		  const char **msg_p,
 		  struct strbuf *sb,
@@ -1725,8 +1737,13 @@ void pp_remainder(struct pretty_print_context *pp,
 		else if (pp->expand_tabs_in_log)
 			strbuf_add_tabexpand(sb, pp->expand_tabs_in_log,
 					     line, linelen);
-		else
+		else {
+			if (pp->fmt == CMIT_FMT_MBOXRD &&
+					is_mboxrd_from(line, linelen))
+				strbuf_addch(sb, '>');
+
 			strbuf_add(sb, line, linelen);
+		}
 		strbuf_addch(sb, '\n');
 	}
 }
@@ -1750,14 +1767,14 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	encoding = get_log_output_encoding();
 	msg = reencoded = logmsg_reencode(commit, NULL, encoding);
 
-	if (pp->fmt == CMIT_FMT_ONELINE || pp->fmt == CMIT_FMT_EMAIL)
+	if (pp->fmt == CMIT_FMT_ONELINE || cmit_fmt_is_mail(pp->fmt))
 		indent = 0;
 
 	/*
 	 * We need to check and emit Content-type: to mark it
 	 * as 8-bit if we haven't done so.
 	 */
-	if (pp->fmt == CMIT_FMT_EMAIL && need_8bit_cte == 0) {
+	if (cmit_fmt_is_mail(pp->fmt) && need_8bit_cte == 0) {
 		int i, ch, in_body;
 
 		for (in_body = i = 0; (ch = msg[i]); i++) {
@@ -1785,7 +1802,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	msg = skip_empty_lines(msg);
 
 	/* These formats treat the title line specially. */
-	if (pp->fmt == CMIT_FMT_ONELINE || pp->fmt == CMIT_FMT_EMAIL)
+	if (pp->fmt == CMIT_FMT_ONELINE || cmit_fmt_is_mail(pp->fmt))
 		pp_title_line(pp, &msg, sb, encoding, need_8bit_cte);
 
 	beginning_of_body = sb->len;
@@ -1802,7 +1819,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	 * format.  Make sure we did not strip the blank line
 	 * between the header and the body.
 	 */
-	if (pp->fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
+	if (cmit_fmt_is_mail(pp->fmt) && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
 	unuse_commit_buffer(commit, reencoded);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 8049cad..8a1cab5 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1565,4 +1565,45 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
 	test_cmp expected actual
 '
 
+test_expect_success 'format-patch --pretty=mboxrd' '
+	sp=" " &&
+	cat >msg <<-INPUT_END &&
+	mboxrd should escape the body
+
+	From could trip up a loose mbox parser
+	>From extra escape for reversibility
+	>>From extra escape for reversibility 2
+	from lower case not escaped
+	Fromm bad speling not escaped
+	 From with leading space not escaped
+
+	F
+	From
+	From$sp
+	From    $sp
+	From	$sp
+	INPUT_END
+
+	cat >expect <<-INPUT_END &&
+	>From could trip up a loose mbox parser
+	>>From extra escape for reversibility
+	>>>From extra escape for reversibility 2
+	from lower case not escaped
+	Fromm bad speling not escaped
+	 From with leading space not escaped
+
+	F
+	From
+	From
+	From
+	From
+	INPUT_END
+
+	C=$(git commit-tree HEAD^^{tree} -p HEAD <msg) &&
+	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >patch &&
+	git grep -h --no-index -A11 \
+		"^>From could trip up a loose mbox parser" patch >actual &&
+	test_cmp expect actual
+'
+
 test_done
