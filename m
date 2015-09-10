From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v17 14/14] tag.c: implement '--merged' and '--no-merged' options
Date: Thu, 10 Sep 2015 21:52:49 +0530
Message-ID: <1441902169-9891-3-git-send-email-Karthik.188@gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 18:23:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za4cq-0004ji-28
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 18:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbbIJQWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 12:22:52 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34153 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbbIJQWt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 12:22:49 -0400
Received: by padhy16 with SMTP id hy16so47252139pad.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Pu3zPLTHPiBmihO2/Zur6qoPavyCPTpqxGWimyKvoA=;
        b=Fn9evJ2oUYemJ+8JTL6v3Izogbh6huMMmR6OVzKq8bIGuysfLk1906anAPanZkwKIK
         g6LhycfHs6d2SzYe2BEZFJKF9a37Pua/LYnpFltnxyLH7zXvUI619cGJTguyL4AxpYGE
         rUYIyISjY+nNJ0ZYhoGiMNodNnL72CwINkrofeAhw+OXPsxjZKe9RqCix3GSx+pNjfUi
         W/uGIJ2ANaYDrWcZfwASEXSuYhDinQQXzzII18s4LUaL51UlYSm8vy8kP+6bOddQuEN5
         7OJF2DGnvN/MXguihn0arra281yDSmnV3h7QRoi5Ggzazde0vrwKqa4w2+WPDi6Ss+GZ
         DTGw==
X-Received: by 10.66.219.195 with SMTP id pq3mr28686167pac.98.1441902166851;
        Thu, 10 Sep 2015 09:22:46 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id qp5sm12910843pbc.0.2015.09.10.09.22.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Sep 2015 09:22:46 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277599>

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
index 075d90b..081fe84 100644
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
@@ -359,6 +359,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only tags that contain the commit")),
+		OPT_MERGED(&filter, N_("print only tags that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
 		{
@@ -417,6 +419,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
2.5.1
