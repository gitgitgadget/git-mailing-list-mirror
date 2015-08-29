From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v14 12/13] tag.c: implement '--format' option
Date: Sat, 29 Aug 2015 19:42:16 +0530
Message-ID: <1440857537-13968-13-git-send-email-Karthik.188@gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 16:13:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVgsQ-00046T-2z
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 16:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbbH2OMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 10:12:44 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33144 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbbH2OMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 10:12:43 -0400
Received: by pacgr6 with SMTP id gr6so4984228pac.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YEvYEGeRVuUWUO2eHcICSS7+s33OGi3/sqdV7A2/kcw=;
        b=MMxB7S3z1LI3kPhMajJqJLtxzohF/mFj6CC+zLzEupQRRb3u3y/ZRPsYp3yPt4pCcx
         CJTUHtlWZLWoC3K5VoQs6qpMK1+109rfufH4ZSOLgBdv3Gazbxo2nqMj/t97s5/pP0y3
         sG+SR6uBmxr0qOjjbf65t1IKR8+NdZCXtbqjnw+eEZT1i7X/E0pqgX3av2uCdCmgmXQb
         P5Ac/vjwxOj5HFM/pD8zlMldY6STWyGROlxst5c6RqOtU3NG5IdJr81no3ladOumot7L
         UJjx1x/BKCMudTiwDWcBVrnMN33EEtRXi8yCtJjPD/eZGAQUazPXhDPExlnjElXRWM3a
         gGuw==
X-Received: by 10.68.226.73 with SMTP id rq9mr7413430pbc.60.1440857562623;
        Sat, 29 Aug 2015 07:12:42 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id hy5sm8876807pac.22.2015.08.29.07.12.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Aug 2015 07:12:41 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276789>

Implement the '--format' option provided by 'ref-filter'.
This lets the user list tags as per desired format similar
to the implementation in 'git for-each-ref'.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-tag.txt |  8 +++++++-
 builtin/tag.c             | 22 +++++++++++++---------
 t/t7004-tag.sh            | 12 ++++++++++++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 3ac4a96..0c7f4e6 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
-	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>] [<pattern>...]
+	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
+	[--format=<format>] [<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -158,6 +159,11 @@ This option is only applicable when listing tags without annotation lines.
 	The object that the new tag will refer to, usually a commit.
 	Defaults to HEAD.
 
+<format>::
+	A string that interpolates `%(fieldname)` from the object
+	pointed at by a ref being shown.  The format is the same as
+	that of linkgit:git-for-each-ref[1].  When unspecified,
+	defaults to `%(refname:short)`.
 
 CONFIGURATION
 -------------
diff --git a/builtin/tag.c b/builtin/tag.c
index 2d348f4..dc4494d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -23,17 +23,17 @@ static const char * const git_tag_usage[] = {
 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
-		"\n\t\t[<pattern>...]"),
+		"\n\t\t[--format=<format>] [<pattern>...]"),
 	N_("git tag -v <tagname>..."),
 	NULL
 };
 
 static unsigned int colopts;
 
-static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
+static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
 	struct ref_array array;
-	char *format, *to_free = NULL;
+	char *to_free = NULL;
 	int i;
 
 	memset(&array, 0, sizeof(array));
@@ -41,11 +41,13 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
 	if (filter->lines == -1)
 		filter->lines = 0;
 
-	if (filter->lines)
-		format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
-					   filter->lines);
-	else
-		format = "%(refname:short)";
+	if (!format) {
+		if (filter->lines)
+			format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
+						   filter->lines);
+		else
+			format = "%(refname:short)";
+	}
 
 	verify_ref_format(format);
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
@@ -329,6 +331,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -361,6 +364,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END()
 	};
 
@@ -401,7 +405,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			run_column_filter(colopts, &copts);
 		}
 		filter.name_patterns = argv;
-		ret = list_tags(&filter, sorting);
+		ret = list_tags(&filter, sorting, format);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 84153ef..8987fb1 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1519,4 +1519,16 @@ EOF"
 	test_cmp expect actual
 '
 
+test_expect_success '--format should list tags as per format given' '
+	cat >expect <<-\EOF &&
+	refname : refs/tags/foo1.10
+	refname : refs/tags/foo1.3
+	refname : refs/tags/foo1.6
+	refname : refs/tags/foo1.6-rc1
+	refname : refs/tags/foo1.6-rc2
+	EOF
+	git tag -l --format="refname : %(refname)" "foo*" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.0
