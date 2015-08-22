From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v13 12/12] tag.c: implement '--merged' and '--no-merged' options
Date: Sat, 22 Aug 2015 09:09:48 +0530
Message-ID: <1440214788-1309-13-git-send-email-Karthik.188@gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 05:40:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSzfM-0002SD-0j
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 05:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbbHVDkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 23:40:17 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34738 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbbHVDkP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 23:40:15 -0400
Received: by padfo6 with SMTP id fo6so19595621pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 20:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CC1TIUkI6AaDmU40nH+huVTZefxfYNwVOnnyz8WQbkw=;
        b=rtH5kUvQnD8o7erzQ5PfXRgF3PDX7tudDEDr7CX6gwHeNtArXE66LY1WT8yNGUmSnp
         Y/Sq1+0zJ7EY/twtEJj6NWCe0pJq5uNo7MzVtplhY97UTS0fSl+LcTabTPmrm3saZvCb
         qxocEBRZfnxdaTfYK6P7nOlOyEOqPLMlP9lDAbJRX2OpfECS/FlIOEkmwhkdU6mij8og
         qsYYP/SfxOrrVqKl0SyJQBQuJ4fEp7Y+askW8cGDzDEDXpeNVuvO+yLmjKTBBfXkargy
         LwMZk6XFB0OZKHW6ETnEOiFlaiKNI/6Ti1RfTdAfC367SwSaPmJOebNzthbjbBUcMuVx
         FAMQ==
X-Received: by 10.66.119.201 with SMTP id kw9mr24041104pab.49.1440214815066;
        Fri, 21 Aug 2015 20:40:15 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id e4sm9393515pdd.45.2015.08.21.20.40.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 20:40:14 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276372>

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
index 0c7f4e6..3803bf7 100644
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
@@ -165,6 +165,11 @@ This option is only applicable when listing tags without annotation lines.
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:short)`.
 
+--[no-]merged [<commit>]::
+	Only list tags whose tips are reachable, or not reachable
+	if '--no-merged' is used, from the specified commit ('HEAD'
+	if not specified).
+
 CONFIGURATION
 -------------
 By default, 'git tag' in sign-with-default mode (-s) will use your
diff --git a/builtin/tag.c b/builtin/tag.c
index 4b8d6df..bbbcaed 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -23,7 +23,7 @@ static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
-		"\n\t\t[--format=<format>] [<pattern>...]"),
+		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
 	N_("git tag -v <tagname>..."),
 	NULL
 };
@@ -355,6 +355,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
index 8987fb1..3dd2f51 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1531,4 +1531,31 @@ test_expect_success '--format should list tags as per format given' '
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
