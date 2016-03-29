From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/3] pretty: enable --expand-tabs by default for selected pretty formats
Date: Tue, 29 Mar 2016 16:15:08 -0700
Message-ID: <1459293309-25195-3-git-send-email-gitster@pobox.com>
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
	id 1al2rG-0005Qn-0A
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758525AbcC2XPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:15:19 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758515AbcC2XPP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:15:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7DBF050FAD;
	Tue, 29 Mar 2016 19:15:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3X6E
	DuTPj4/ceqnoIoh3hnB5tO4=; b=hLP6wC7WwonIls2ne77yjUwRDI5NCk0yJarA
	vmN1yh8QwF+nvwf1lMfNO71VEx31PWtOUG3UooKziRtXd77ygYkhsB9/4Xj3KHV0
	FMN30DbRxp3sGN3IfGa2gxWGZSHzkKsVhUucX4shl0tXW/CeQL8ia1kuhlUGW2Bo
	sTa0GZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	YV/UoOXfHSZCJolkXNDGpF5+sTjS5fgf+0vMOwUz5nqW1Vf4fdZ9fbQj/AlYhe3D
	d9TJCX1Jgw3FVs0f9PsoMiYWE32Q9wbyzPdZ7jIUS3DMCdeyMZjDIyceeYoo0y5/
	mzF7qphrojWuP5tJl9X6OyagA5KWLAipJdOBS2ma9II=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C80550FAC;
	Tue, 29 Mar 2016 19:15:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E5F5050FAB;
	Tue, 29 Mar 2016 19:15:13 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-gd29a7d9
In-Reply-To: <1459293309-25195-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1784A00A-F604-11E5-8A89-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290223>

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
 pretty.c                         | 16 +++++++++-------
 revision.c                       |  3 +++
 t/t4201-shortlog.sh              |  2 +-
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 4fb5c76..23967b6 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -43,10 +43,16 @@ people using 80-column terminals.
 	commit may be copied to the output.
 
 --expand-tabs::
+--no-expand-tabs::
 	Perform a tab expansion (replace each tab with enough number
 	of spaces to fill to the next display column that is
 	multiple of 8) in the log message before using the message
 	to show in the output.
++
+By default, tabs are expanded in pretty formats that indent the log
+message by 4 spaces (i.e.  'medium', which is the default, 'full',
+and "fuller').  `--no-expand-tabs` option can be used to disable
+this.
 
 ifndef::git-rev-list[]
 --notes[=<ref>]::
diff --git a/pretty.c b/pretty.c
index c8b075d..de22a8c 100644
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
diff --git a/revision.c b/revision.c
index e662230..b1d767a 100644
--- a/revision.c
+++ b/revision.c
@@ -1412,6 +1412,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->skip_count = -1;
 	revs->max_count = -1;
 	revs->max_parents = -1;
+	revs->expand_tabs_in_log = 1;
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
@@ -1917,6 +1918,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		get_commit_format(arg+9, revs);
 	} else if (!strcmp(arg, "--expand-tabs")) {
 		revs->expand_tabs_in_log = 1;
+	} else if (!strcmp(arg, "--no-expand-tabs")) {
+		revs->expand_tabs_in_log = 0;
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
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
2.8.0-215-gd29a7d9
