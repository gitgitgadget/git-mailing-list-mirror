From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 2/4] pretty: enable --expand-tabs by default for selected pretty formats
Date: Mon,  4 Apr 2016 17:58:35 -0700
Message-ID: <1459817917-32078-3-git-send-email-gitster@pobox.com>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
 <1459817917-32078-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 02:58:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anFKX-0002QT-J8
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 02:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbcDEA6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 20:58:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752404AbcDEA6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 20:58:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D4C35308A;
	Mon,  4 Apr 2016 20:58:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DfR0
	D+QkuW91E7EbkIWzd7xkrnA=; b=QXOFdeoIf2hujUawYoklOLOf5Y32vz3i9BiQ
	0YrZrSV923EYSxg7HCv7x9VQ/upPzDKVzCyn5BhtiSl02YsuD3pekqDxL4c6JAAu
	4jC4zPoLRUhnCnyvDUqf2aHinT4RWV0G5/AEVtrFxSEofWsQp8tW187noZSTFG7b
	0mckKIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	s0qhrsxh3KCuR8VK7izy+u059J7Tio+aKf4O49K3iOsheqBOuRzreqHt28Gm+Xji
	T5RE7QUl93bVyqdgFhH1yJeM3BO14VFH+CSM/c2VIs161wlM4nfUVNMoLB2VE+Gs
	jB0egEHw9utSjHAAmVsj2aI7ocwmz6eyZbOpjvkMMxI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 93C2953089;
	Mon,  4 Apr 2016 20:58:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 02BCB53085;
	Mon,  4 Apr 2016 20:58:41 -0400 (EDT)
X-Mailer: git-send-email 2.8.1-251-g9997610
In-Reply-To: <1459817917-32078-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8A4BD9CC-FAC9-11E5-8B11-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290742>

"git log --pretty={medium,full,fuller}" and "git log" by default
prepend 4 spaces to the log message, so it makes sense to enable
the new "expand-tabs" facility by default for these formats.
Add --no-expand-tabs option to override the new default.

The change alone breaks a test in t4201 that runs "git shortlog"
on the output from "git log", and expects that the output from
"git log" does not do such a tab expansion.  Adjust the test to
explicitly disable expand-tabs with --no-expand-tabs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pretty-options.txt |  6 ++++++
 builtin/log.c                    |  1 +
 pretty.c                         | 18 +++++++++++-------
 revision.c                       |  7 +++++++
 revision.h                       |  3 ++-
 t/t4201-shortlog.sh              |  2 +-
 6 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index d820653..edbb02f 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -43,9 +43,15 @@ people using 80-column terminals.
 	commit may be copied to the output.
 
 --expand-tabs::
+--no-expand-tabs::
 	Perform a tab expansion (replace each tab with enough spaces
 	to fill to the next display column that is multiple of 8)
 	in the log message before showing it in the output.
++
+By default, tabs are expanded in pretty formats that indent the log
+message by 4 spaces (i.e.  'medium', which is the default, 'full',
+and 'fuller').  `--no-expand-tabs` option can be used to disable
+this.
 
 ifndef::git-rev-list[]
 --notes[=<ref>]::
diff --git a/builtin/log.c b/builtin/log.c
index e00cea7..e5775ae 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1281,6 +1281,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
+	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
 	rev.diff = 1;
 	rev.max_parents = 1;
diff --git a/pretty.c b/pretty.c
index c8b075d..b7938e0 100644
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
+	rev->expand_tabs_in_log_default = commit_format->expand_tabs_in_log;
 	if (commit_format->format == CMIT_FMT_USERFORMAT) {
 		save_user_format(rev, commit_format->user_format,
 				 commit_format->is_tformat);
@@ -1720,6 +1722,8 @@ void pp_remainder(struct pretty_print_context *pp,
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent)
 			pp_handle_indent(pp, sb, indent, line, linelen);
+		else if (pp->expand_tabs_in_log)
+			strbuf_add_tabexpand(sb, line, linelen);
 		else
 			strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
diff --git a/revision.c b/revision.c
index e662230..da53b6c 100644
--- a/revision.c
+++ b/revision.c
@@ -1412,8 +1412,10 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->skip_count = -1;
 	revs->max_count = -1;
 	revs->max_parents = -1;
+	revs->expand_tabs_in_log = -1;
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
+	revs->expand_tabs_in_log_default = 1;
 
 	init_grep_defaults();
 	grep_init(&revs->grep_filter, prefix);
@@ -1917,6 +1919,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		get_commit_format(arg+9, revs);
 	} else if (!strcmp(arg, "--expand-tabs")) {
 		revs->expand_tabs_in_log = 1;
+	} else if (!strcmp(arg, "--no-expand-tabs")) {
+		revs->expand_tabs_in_log = 0;
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
@@ -2390,6 +2394,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->first_parent_only && revs->bisect)
 		die(_("--first-parent is incompatible with --bisect"));
 
+	if (revs->expand_tabs_in_log < 0)
+		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
+
 	return left;
 }
 
diff --git a/revision.h b/revision.h
index 4079753..6cc36b4 100644
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
@@ -149,6 +148,8 @@ struct rev_info {
 			linear:1;
 
 	struct date_mode date_mode;
+	int		expand_tabs_in_log; /* unset if negative */
+	int		expand_tabs_in_log_default;
 
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 7600a3e..2fec948 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -115,7 +115,7 @@ EOF
 '
 
 test_expect_success !MINGW 'shortlog from non-git directory' '
-	git log HEAD >log &&
+	git log --no-expand-tabs HEAD >log &&
 	GIT_DIR=non-existing git shortlog -w <log >out &&
 	test_cmp expect out
 '
-- 
2.8.1-251-g9997610
