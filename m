From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 10/10] tag.c: implement '--merged' and '--no-merged' options
Date: Sat, 25 Jul 2015 00:49:42 +0530
Message-ID: <1437765582-12537-3-git-send-email-Karthik.188@gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437765582-12537-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 21:19:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIiVe-0006kv-3Q
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbbGXTTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:19:48 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35952 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbbGXTTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:19:47 -0400
Received: by pachj5 with SMTP id hj5so18634253pac.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LwZ9juwTlPT/uQkhQmWTArW7QDM1irlnvUbgx39VKtg=;
        b=EKfmUY/1AmWq8GEOB9iKSSJR3J7OzyfYIS2L2cQKM9KQ2Q6P5kZlMtYvPRTIoxBxeN
         7JdBStHHW8GZgLVIoVc9hjIqQOqI1J9JVhz1BuDSdnuBAr/yQP3XihcJbfHoOdI7jBIK
         FNVvDlQt+LRC/2MOD/fvXFJU1pz/uh/XBR/45YAFGoipAe3pdae6u9k49ir0XC8EejmJ
         UZpJqJ+t7CpcXcjrEsu8d2dZ4aIIUSqTi7wgQ6wJdhvpJzc/AptM2I/1DjH8RF1KhtUZ
         tBAN4dcOzFnQTNDAPwcbfgCe54CIOg2swtgvszVu9gpwbUm7LqxNDJIsrDR0IFfQcb5R
         9mHw==
X-Received: by 10.70.1.102 with SMTP id 6mr34197200pdl.32.1437765586702;
        Fri, 24 Jul 2015 12:19:46 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id j4sm15941133pdg.64.2015.07.24.12.19.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jul 2015 12:19:46 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437765582-12537-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274588>

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
index 727d653..2a07d67 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
 	[--column[=<options>] | --no-column] [--sort=<key>] [--format=<format>]
-	[<pattern>...]
+	[--[no-]merged [<commit>]] [<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -168,6 +168,11 @@ This option is only applicable when listing tags without annotation lines.
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
index a8052b4..23256fc 100644
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
@@ -351,6 +351,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only tags that contain the commit")),
+		OPT_MERGED(&filter, N_("print only tags that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
 		{
@@ -411,6 +413,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("--contains option is only allowed with -l."));
 	if (filter.points_at.nr)
 		die(_("--points-at option is only allowed with -l."));
+	if (filter.merge_commit)
+		die(_("--merged and --no-merged option are only allowed with -l"));
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag);
 	if (cmdmode == 'v')
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 884c0d3..e154a32 100755
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
