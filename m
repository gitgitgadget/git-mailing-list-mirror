From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v12 13/13] tag.c: implement '--merged' and '--no-merged' options
Date: Wed, 19 Aug 2015 00:07:32 +0530
Message-ID: <1439923052-7373-14-git-send-email-Karthik.188@gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 20:38:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRlm4-0000Cc-Kt
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 20:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbbHRSiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 14:38:07 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36802 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbbHRSiD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 14:38:03 -0400
Received: by pawq9 with SMTP id q9so41148699paw.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OCtKSuLJgU7m2/X8NlfJANReed6TkU2VaAuG3mFH/jM=;
        b=IdHyXaRYKOxd7S4mJX6voNNzeMsmNrs5qXjssabG7DW26g8cMNpyxIeScgUszt6/kI
         FkQQsE0Yx+jnQq+Erm63uvIU+fLdOlgTfI4xjNVJFaL2JAce91ut9EG9FYffvcKlX1Mn
         VScPgl9jL8+d7FaZG0Zw665MfaQ2xykoUZlh6y92Y5nx5ea97C5pqNPkcf+Jfg2ZuCTJ
         no2z4WifaYd3g7dNVm886aRbtZ4RctN7YORVRj0y7O5n3oJoIC5DCkSOA4jjdG4NxTgy
         SnGPXsvdD3cq0Rl/aGxjg9VdFIfbPJwE7FifnP6CS5GgThAYutJ1y4jJRN7OBfK2NyoW
         3QVA==
X-Received: by 10.66.131.6 with SMTP id oi6mr15977546pab.121.1439923083246;
        Tue, 18 Aug 2015 11:38:03 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id i9sm18858190pbq.44.2015.08.18.11.38.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 11:38:02 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276144>

From: Karthik Nayak <karthik.188@gmail.com>

Use 'ref-filter' APIs to implement the '--merged' and '--no-merged'
options into 'tag.c'. The '--merged' option lets the user to only list
tags merged into the named commit. The '--no-merged' option lets the
user to only list tags not merged into the named commit.  If no object
is provided it assumes HEAD as the object.

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
index 69997a4..781d3e5 100644
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
index 26670e0..335396e 100755
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
2.5.0
