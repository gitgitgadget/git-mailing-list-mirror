From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 9/9] tag.c: implement '--merged' and '--no-merged' options
Date: Sun, 19 Jul 2015 03:30:37 +0530
Message-ID: <1437256837-13378-3-git-send-email-Karthik.188@gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
 <1437256837-13378-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 00:00:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGaA9-0000Ua-KS
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 00:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbbGRWAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 18:00:49 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33142 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbbGRWAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 18:00:48 -0400
Received: by pdbnt7 with SMTP id nt7so9653001pdb.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CMny9WDVlbtA4h+Ak4biamMqjvkkA/4QKCtDWVxu5ng=;
        b=F1YOloYJHrIh/U+vnyeJrK+40M15AaQC97W9zAfSu2LJDhl20L2yy2NMgnc8HDCL0d
         WLgH3O60kb8WtjqnfgK3bZWTAajB+euKu6SudpAZaIiIXya4VEyd7UR30lHOd5Y5k4N6
         GIAd2kHS7IRdgXNVWExEiT9ikmOZChq4ijGjx2CzWUGd1BcGydPRrWCkDdsZnfOk5EWB
         gkBz1qQO7BHayvrsBMaP2vYefARo1pRvRQHb9qbrK4jXSkcJLRmqmieKxwoAruiGmemw
         WikzlkNBZNHJFdnU3wuBJezqoJ8bbLmnDIXJKuCsySr4nJ/NMCfl0P2qXmm6ctGVNuLZ
         YcOw==
X-Received: by 10.68.78.36 with SMTP id y4mr42452762pbw.106.1437256848283;
        Sat, 18 Jul 2015 15:00:48 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id he9sm15268969pbc.7.2015.07.18.15.00.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jul 2015 15:00:47 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437256837-13378-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274183>

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
 Documentation/git-tag.txt | 10 +++++++++-
 builtin/tag.c             |  6 +++++-
 t/t7004-tag.sh            | 27 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 16e396c..74ed157 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
 	[--column[=<options>] | --no-column] [--sort=<key>] [--format=<format>]
-	[<pattern>...]
+	[(--merged | --no-merged) [<commit>]] [<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -169,6 +169,14 @@ This option is only applicable when listing tags without annotation lines.
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 	The fields are same as those in `git for-each-ref`.
 
+--merged [<commit>]::
+	Only list tags whose tips are reachable from the
+	specified commit (HEAD if not specified).
+
+--no-merged [<commit>]::
+	Only list tags whose tips are not reachable from the
+	specified commit (HEAD if not specified).
+
 
 CONFIGURATION
 -------------
diff --git a/builtin/tag.c b/builtin/tag.c
index cae113b..0fa1d31 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -23,7 +23,7 @@ static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
-		"\n\t\t[<pattern>...]"),
+		"\n\t\t[--merged [<commit>]] [--no-merged [<commit>]] [<pattern>...]"),
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
index e8cebb6..873aad3 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1523,4 +1523,31 @@ test_expect_success '--format should list tags as per format given' '
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
