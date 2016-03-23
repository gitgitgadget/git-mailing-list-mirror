From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Wed, 23 Mar 2016 16:23:41 -0700
Message-ID: <1458775426-2215-1-git-send-email-gitster@pobox.com>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 00:23:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ais82-0007yT-HB
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 00:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbcCWXXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 19:23:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750984AbcCWXXt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 19:23:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BCC750C0A;
	Wed, 23 Mar 2016 19:23:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gwkqHH/7pprH
	TbsDvqTM4jwPKwI=; b=dHEvQtame6ymx/H2sibvB/RyyqODXZCIVcpZZ689Y7rH
	d1s3W1VV4IlgYAoyjCuWXAr3mLtN6MYDFl4YlvqDkQvdHHiDhDGyU4mUU2mFFBXq
	BVQYTSnuCwU+pZKRjPW4MThLuBn12Ag9HT+I8C4xltM2SNvZ73HWAkiqh0cJZfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d7tazW
	rOik0lQr/O88GyPz8ie3G3MEs6JOHGxX2IytfXAVqACLy7G529g5w4a5fT+hhlCV
	WNDpKMtr5s4qCaNP8cN9lukdJzzZp8HGCeDpDL7biAFCIHgEwMnLeXRoGd33THf5
	WVcOFiayzeLO3cgUefGX7YDJxOSrgmAuRK4+g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6344550C08;
	Wed, 23 Mar 2016 19:23:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B6C7750C07;
	Wed, 23 Mar 2016 19:23:47 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-rc4-198-g3f6b64c
In-Reply-To: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 4B4B8012-F14E-11E5-9C64-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289694>

So here is the third try (previous round is found at $gmane/289166
and the very first one is at $gmane/288987).

The first three patches are essentially the same as v2.  The last
two updates how the tab-expansion is internally controlled:

 [4/5] adds a bit to pretty-commit-context that tells if tabs should
       be expanded.  Unlike v2 that tied this to pretty print format,
       this bit is orthogonal to the format, and theoretically it is
       possible to expand tabs even with --format=email.  Also,
       unlike v2, tabs are expanded not just in `medium` format, but
       also in `full` and `fuller` formats.

 [5/5] adds a new option --no-expand-tabs that controls the bit 4/5
       introduces, so that "git log [--pretty] --no-expand-tabs"
       would show the log message indented by 4 spaces, without tab
       expansion.

By the way, I have to say that I hate how pretty formatting and
revision machinery interact with each other.

pretty.c::commit_formats ought to be the authoritative source of how
each named format should work, but there are quite a many codepaths
that just assign CMIT_FMT_SOMETHING to revs->commit_format without
bothering with other fields in the cmt_fmt_map like is_tformat, and
I am not sure if they are working correctly even before this patch.

Junio C Hamano (4):
  pretty-print: simplify the interaction between pp_handle_indent() and its caller
  pretty-print: further abstract out pp_handle_indent()
  pretty-print: limit expand-tabs to selected --pretty formats
  pretty-print: teach "--no-expand-tabs" option to "git log"

Linus Torvalds (1):
  pretty-print: de-tabify indented logs to make things line up properly

 Documentation/pretty-options.txt |  6 +++
 commit.h                         |  1 +
 log-tree.c                       |  1 +
 pretty.c                         | 88 ++++++++++++++++++++++++++++++++++++----
 revision.c                       |  3 ++
 revision.h                       |  1 +
 t/t4201-shortlog.sh              |  2 +-
 7 files changed, 92 insertions(+), 10 deletions(-)

[References]

http://thread.gmane.org/gmane.comp.version-control.git/288987/focus=289166


Interdiff since v2 is shown below.

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 173b932..671cebd 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -39,16 +39,6 @@ This is designed to be as compact as possible.
 
 	      <title line>
 
-	      <full commit message, tab-expanded>
-
-* 'noexpand'
-
-	  commit <sha1>
-	  Author: <author>
-	  Date:   <author date>
-
-	      <title line>
-
 	      <full commit message>
 
 * 'full'
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 7032b1a..069b927 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -3,7 +3,7 @@
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'email', 'raw', 'noexpand', 'format:<string>'
+	'full', 'fuller', 'email', 'raw', 'format:<string>'
 	and 'tformat:<string>'.  When '<format>' is none of the above,
 	and has '%placeholder' in it, it acts as if
 	'--pretty=tformat:<format>' were given.
@@ -42,6 +42,12 @@ people using 80-column terminals.
 	verbatim; this means that invalid sequences in the original
 	commit may be copied to the output.
 
+--no-expand-tabs::
+	The formats that indent the log message by 4 spaces
+	(i.e. 'medium', 'full', and 'fuller') by default show tabs
+	in the log message expanded.  This option disables the
+	expansion.
+
 ifndef::git-rev-list[]
 --notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
diff --git a/commit.h b/commit.h
index d511c61..a7ef682 100644
--- a/commit.h
+++ b/commit.h
@@ -126,7 +126,6 @@ enum cmit_fmt {
 	CMIT_FMT_RAW,
 	CMIT_FMT_MEDIUM,
 	CMIT_FMT_DEFAULT = CMIT_FMT_MEDIUM,
-	CMIT_FMT_NOEXPAND,
 	CMIT_FMT_SHORT,
 	CMIT_FMT_FULL,
 	CMIT_FMT_FULLER,
@@ -148,6 +147,7 @@ struct pretty_print_context {
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
index 8b533dc..5a33b7e 100644
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
@@ -87,14 +88,13 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
 static void setup_commit_formats(void)
 {
 	struct cmt_fmt_map builtin_formats[] = {
-		{ "raw",	CMIT_FMT_RAW,		0 },
-		{ "medium",	CMIT_FMT_MEDIUM,	0 },
-		{ "noexpand",	CMIT_FMT_NOEXPAND,	0 },
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
@@ -173,6 +173,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 
 	rev->commit_format = commit_format->format;
 	rev->use_terminator = commit_format->is_tformat;
+	rev->expand_tabs_in_log = commit_format->expand_tabs_in_log;
 	if (commit_format->format == CMIT_FMT_USERFORMAT) {
 		save_user_format(rev, commit_format->user_format,
 				 commit_format->is_tformat);
@@ -1687,12 +1688,11 @@ static void strbuf_add_tabexpand(struct strbuf *sb,
  * de-tabifying.
  */
 static void pp_handle_indent(struct pretty_print_context *pp,
-			     struct strbuf *sb,
-			     int indent,
+			     struct strbuf *sb, int indent,
 			     const char *line, int linelen)
 {
 	strbuf_addchars(sb, ' ', indent);
-	if (pp->fmt == CMIT_FMT_MEDIUM)
+	if (pp->expand_tabs_in_log)
 		strbuf_add_tabexpand(sb, line, linelen);
 	else
 		strbuf_add(sb, line, linelen);
diff --git a/revision.c b/revision.c
index df56fce..b0d2a36 100644
--- a/revision.c
+++ b/revision.c
@@ -1412,6 +1412,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->skip_count = -1;
 	revs->max_count = -1;
 	revs->max_parents = -1;
+	revs->expand_tabs_in_log = 1;
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
@@ -1915,6 +1916,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
 		get_commit_format(arg+9, revs);
+	} else if (!strcmp(arg, "--no-expand-tabs")) {
+		revs->expand_tabs_in_log = 0;
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
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
index 34a9fed..2fec948 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -115,7 +115,7 @@ EOF
 '
 
 test_expect_success !MINGW 'shortlog from non-git directory' '
-	git log --pretty=noexpand HEAD >log &&
+	git log --no-expand-tabs HEAD >log &&
 	GIT_DIR=non-existing git shortlog -w <log >out &&
 	test_cmp expect out
 '
