From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 10/10] tag.c: implement '--merged' and '--no-merged'
 options
Date: Thu, 9 Jul 2015 16:30:30 +0530
Message-ID: <559E544E.2060508@gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 13:00:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD9ZF-0001Z8-9l
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 13:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbbGILAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 07:00:33 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33556 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbGILAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 07:00:31 -0400
Received: by pdbqm3 with SMTP id qm3so19880256pdb.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=7BICrXqDnKV+dnakp2CTwN6rMZX6BXDlHBuTrGHOLSw=;
        b=xXC1Hk+N/x3Mf4wH6LFrGhqj8qi7CjlThzz1wyt88X7Mcv8ZMoDLIA/oqIJyrd4NxP
         7BVgF/L3Tsc0aJ59gf/677H+uxnqg3oqSlvW+TWs4MDOEIMGXDqlHi/g6gd5HF03+mP+
         t/AW+x2VbWWht70JUjqu0dcwoTVzyOWjsmxcoqc7NNfBXq/CrsmO4IhIzBT3rMJH0UIu
         N8tUlZBKAw5GrPpBdhe9pWtyZhDRrUe2wSY6It8z+c2if1oVgZyMBJKQ2Ke6LeN+NLCM
         3i6LWTTQL0F3iWTCwkkcWXRIWi21l55zBT4hBje36EXEokPfHE94InEjEcCqu4/5Fcc5
         sX0g==
X-Received: by 10.66.139.41 with SMTP id qv9mr30172093pab.35.1436439631375;
        Thu, 09 Jul 2015 04:00:31 -0700 (PDT)
Received: from [192.168.43.24] ([49.203.67.70])
        by smtp.googlemail.com with ESMTPSA id qo1sm5542959pbc.89.2015.07.09.04.00.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 04:00:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273742>

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
@@ -169,6 +169,14 @@ This option is only applicable when listing tags 
without annotation lines.
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
index 601b293..abd42a0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -23,7 +23,7 @@ static const char * const git_tag_usage[] = {
  	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] 
<tagname> [<head>]"),
  	N_("git tag -d <tagname>..."),
  	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
-		"\n\t\t[<pattern>...]"),
+		"\n\t\t[--merged [<commit>]] [--no-merged [<commit>]] [<pattern>...]"),
  	N_("git tag -v <tagname>..."),
  	NULL
  };
@@ -350,6 +350,8 @@ int cmd_tag(int argc, const char **argv, const char 
*prefix)
  		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
  		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain 
the commit")),
  		OPT_WITH(&filter.with_commit, N_("print only tags that contain the 
commit")),
+		OPT_MERGED(&filter, N_("print only tags that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
  		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
  			     N_("field name to sort on"), &parse_opt_ref_sorting),
  		{
@@ -410,6 +412,8 @@ int cmd_tag(int argc, const char **argv, const char 
*prefix)
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
@@ -1523,4 +1523,31 @@ test_expect_success '--format should list tags as 
per format given' '
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
2.4.5
