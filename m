From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 10/11] tag.c: implement '--format' option
Date: Tue,  4 Aug 2015 18:13:07 +0530
Message-ID: <1438692188-14367-10-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
 <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 14:43:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbZH-0004NU-B1
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 14:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281AbbHDMnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 08:43:39 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35199 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260AbbHDMnh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 08:43:37 -0400
Received: by pdrg1 with SMTP id g1so4137045pdr.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m3/XroZ4okAvex+YG6NWuUJBjhheGp41SejKCTV+iqE=;
        b=pnMC0KxD0JtGO9At2lSvllbawirrNgc+DNiJB/2jZqCsPrAjPVC4diigeL1VWQObht
         nJf9TU9kH5V0Z1I+Qye479+iDkpsEVVQrjWv96/MlBoUtGUQpWrhCsa9SEzSM7et2KY1
         vYOL3q0FKw3YyEdd4ne8Ozz97wgXzNRrg1RijHaunX7IFLWGyzvoql1XpQb2ApavEo8Y
         9UQxYktMw3McbQVKJiGEgq/v7NRnjeQJVMksU//PwaCZRseydWB4APrsSPzUEtVKfdph
         hBjYib56XD1jZarJXOG87pJgEtYm9LDOaKtVoGSwBDZ7xFTyheLtsElUGrxdtQyxhMtN
         CLGg==
X-Received: by 10.70.34.5 with SMTP id v5mr7456278pdi.147.1438692216651;
        Tue, 04 Aug 2015 05:43:36 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id m2sm1359951pdr.64.2015.08.04.05.43.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 05:43:36 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275259>

From: Karthik Nayak <karthik.188@gmail.com>

Implement the '--format' option provided by 'ref-filter'.
This lets the user list tags as per desired format similar
to the implementation in 'git for-each-ref'.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-tag.txt | 15 ++++++++++++++-
 builtin/tag.c             | 11 +++++++----
 t/t7004-tag.sh            | 16 ++++++++++++++++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 3ac4a96..75703c5 100644
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
@@ -158,6 +159,18 @@ This option is only applicable when listing tags without annotation lines.
 	The object that the new tag will refer to, usually a commit.
 	Defaults to HEAD.
 
+<format>::
+	A string that interpolates `%(fieldname)` from the object
+	pointed at by a ref being shown.  If `fieldname` is prefixed
+	with an asterisk (`*`) and the ref points at a tag object, the
+	value for the field in the object tag refers is used.  When
+	unspecified, defaults to `%(refname:short)`.  It also
+	interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
+	interpolates to character with hex code `xx`; for example
+	`%00` interpolates to `\0` (NUL), `%09` to `\t` (TAB) and
+	`%0a` to `\n` (LF).  The fields are same as those in `git
+	for-each-ref`.
+
 
 CONFIGURATION
 -------------
diff --git a/builtin/tag.c b/builtin/tag.c
index 829af6f..13c9579 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -30,10 +30,9 @@ static const char * const git_tag_usage[] = {
 
 static unsigned int colopts;
 
-static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
+static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
 	struct ref_array array;
-	char *format;
 	int i;
 
 	memset(&array, 0, sizeof(array));
@@ -43,7 +42,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
 
 	if (filter->lines)
 		format = "%(align:left,16)%(refname:short)";
-	else
+	else if (!format)
 		format = "%(refname:short)";
 
 	verify_ref_format(format);
@@ -327,6 +326,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -359,6 +359,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END()
 	};
 
@@ -398,8 +399,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			copts.padding = 2;
 			run_column_filter(colopts, &copts);
 		}
+		if (format && (filter.lines != -1))
+			die(_("--format and -n are incompatible"));
 		filter.name_patterns = argv;
-		ret = list_tags(&filter, sorting);
+		ret = list_tags(&filter, sorting, format);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1f066aa..1809011 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1519,4 +1519,20 @@ EOF"
 	test_cmp expect actual
 '
 
+test_expect_success '--format cannot be used with -n' '
+	test_must_fail git tag -l -n4 --format="%(refname)"
+'
+
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
