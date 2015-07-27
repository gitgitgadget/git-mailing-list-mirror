From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 11/11] tag.c: implement '--merged' and '--no-merged' options
Date: Mon, 27 Jul 2015 12:57:15 +0530
Message-ID: <1437982035-6658-11-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 09:27:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJcp9-0000wS-Gi
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 09:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbbG0H1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 03:27:42 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33926 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbbG0H1k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 03:27:40 -0400
Received: by pdbbh15 with SMTP id bh15so47359353pdb.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 00:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h7Y9AFmeyRW3FHMBtdGZE73QuVbjf+5oYBOEv/4wvro=;
        b=xYBTERBlt518CO0au9xfoVAOwUvP7i8IG+cB6Al9nnGzrpBmcjS0OQvTUZ+O6eIkC7
         K6FcTizvFR3BkO/KrzxBRymUb6Vd+PJtmqY4+7snNEdVu++rgVsz7BdF00PfWawux0l0
         s5BU1/XEC/ppPSYMrr0Jk59D3x01SkGdoiCjifZYXZGL6JzLsjUiIS5CmEqaglJPpQNC
         9XbhXHLAJFxRFX/r+vjY909rBQ65q2msHW4ZH+GrEX9AuYhBwmZTh6uEmLRHxxbQv+uL
         TdRyJVYoVQjH2xU1ArO4dxEG0QeBwvB7YU3gc6NLj0+ylyRUQ4giMaLJR1pMb12RL5m9
         eJHg==
X-Received: by 10.70.34.171 with SMTP id a11mr64788703pdj.18.1437982059799;
        Mon, 27 Jul 2015 00:27:39 -0700 (PDT)
Received: from ashley.localdomain ([106.51.241.234])
        by smtp.gmail.com with ESMTPSA id wv4sm27732769pac.2.2015.07.27.00.27.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 00:27:38 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274659>

From: Karthik Nayak <karthik.188@gmail.com>

Using 'ref-filter' APIs implement the '--merged' and '--no-merged'
options into 'tag.c'. The '--merged' option lets the user to only
list tags merged into the named commit. The '--no-merged' option
lets the user to only list tags not merged into the named commit.
If no object is provided it assumes HEAD as the object.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-tag.txt |  7 ++++++-
 builtin/tag.c             |  6 +++++-
 t/t7004-tag.sh            | 27 +++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 75703c5..c2785d9 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
 	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
-	[--format=<format>] [<pattern>...]
+	[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -171,6 +171,11 @@ This option is only applicable when listing tags without annotation lines.
 	`%0a` to `\n` (LF).  The fields are same as those in `git
 	for-each-ref`.
 
+--[no-]merged [<commit>]::
+	Only list tags whose tips are reachable, or not reachable
+	if '--no-merged' is used, from the specified commit ('HEAD'
+	if not specified).
+
 
 CONFIGURATION
 -------------
diff --git a/builtin/tag.c b/builtin/tag.c
index 7de49c4..fc01117 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -23,7 +23,7 @@ static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
-		"\n\t\t[<pattern>...]"),
+		"\n\t\t[--[no-]merged [<commit>]] [<pattern>...]"),
 	N_("git tag -v <tagname>..."),
 	NULL
 };
@@ -353,6 +353,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only tags that contain the commit")),
+		OPT_MERGED(&filter, N_("print only tags that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
 		{
@@ -413,6 +415,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("--contains option is only allowed with -l."));
 	if (filter.points_at.nr)
 		die(_("--points-at option is only allowed with -l."));
+	if (filter.merge_commit)
+		die(_("--merged and --no-merged option are only allowed with -l"));
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag);
 	if (cmdmode == 'v')
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1809011..5b73539 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1535,4 +1535,31 @@ test_expect_success '--format should list tags as per format given' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup --merged test tags' '
+	git tag mergetest-1 HEAD~2 &&
+	git tag mergetest-2 HEAD~1 &&
+	git tag mergetest-3 HEAD
+'
+
+test_expect_success '--merged cannot be used in non-list mode' '
+	test_must_fail git tag --merged=mergetest-2 foo
+'
+
+test_expect_success '--merged shows merged tags' '
+	cat >expect <<-\EOF &&
+	mergetest-1
+	mergetest-2
+	EOF
+	git tag -l --merged=mergetest-2 mergetest-* >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-merged show unmerged tags' '
+	cat >expect <<-\EOF &&
+	mergetest-3
+	EOF
+	git tag -l --no-merged=mergetest-2 mergetest-* >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.6
