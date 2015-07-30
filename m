From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 11/11] tag.c: implement '--merged' and '--no-merged' options
Date: Thu, 30 Jul 2015 21:18:52 +0530
Message-ID: <1438271332-10615-11-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
 <1438271332-10615-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:49:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKq5L-0003XJ-LM
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbbG3PtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:49:24 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36804 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbbG3PtS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:49:18 -0400
Received: by pdjr16 with SMTP id r16so27056765pdj.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h7Y9AFmeyRW3FHMBtdGZE73QuVbjf+5oYBOEv/4wvro=;
        b=Nt1uWyfLei5QnJMaGKk08IM7Myz8GHUU78e1PLzAH6GoUy+jB6o8o7q58iOhl6Ve5b
         GSwtawRT6Q0hoFaG0SjPgtAmOlYbUGpvDGUau8To2qqfcpiNvCIxzJusy/TX8MWO6h+A
         dOMykV+WtkXxx3QTR967A8HSclhZTzxCNife6WPZkOTKZVLGxHKC/su0iWK8pQn0c1Cd
         BRGhv8YokogVhr84mRkwzeXDr7PZPJ74+vGeMAtYIebkVOQXQoVL8F+wNFZuEl1hkJwC
         /81IAD+7uwrBj9OZqDO3FSff2uorZpPQ89Adb5wOqE4FYgKHBW4RhAOmJFsA8t7otJ36
         zFrQ==
X-Received: by 10.70.109.162 with SMTP id ht2mr106755610pdb.101.1438271358323;
        Thu, 30 Jul 2015 08:49:18 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id cz1sm2875338pdb.44.2015.07.30.08.49.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 08:49:17 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438271332-10615-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275011>

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
