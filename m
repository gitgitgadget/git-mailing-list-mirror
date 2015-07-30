From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 10/11] tag.c: implement '--format' option
Date: Thu, 30 Jul 2015 21:18:51 +0530
Message-ID: <1438271332-10615-10-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
 <1438271332-10615-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:49:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKq5L-0003XJ-2Q
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbbG3PtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:49:18 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34255 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbbG3PtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:49:16 -0400
Received: by pdbbh15 with SMTP id bh15so26347288pdb.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mQUJfH9N4rRWfMjajXmqH+YdOjuTY4yFqr8BfPYXGqQ=;
        b=uM/s/ICBkYPE7OZRiEYl1NGA7ePQFPsEPrs8Otm/pXvLbtVdR95hMLiQ16ABDMJOYA
         lPTONPNQOqrI9SlV7JuEook5XDV01ybbkjc1q2zRD6Fyq/4grzd8lAP6C7iWq/MTiqlz
         /cTm0oeuQwbcd3Q2Ny7/GKOFd0njOTSMO+P8TdddrFN5kfMCupLkkzqvgT0jmI9O4qpK
         Iec0aAjRvj2YEI0dzia2aP+RcwM4fiw4p8Bge5loYaxYCoxe7BosSeB0CmCcTf9b+eS3
         VHWxIr3PhZOuJNBEFKeknOAasKWOdgIWf3h4fqn917z4pShWhnGOaKHWInn4YMxHCNk/
         /yng==
X-Received: by 10.70.51.8 with SMTP id g8mr106050949pdo.50.1438271355688;
        Thu, 30 Jul 2015 08:49:15 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id cz1sm2875338pdb.44.2015.07.30.08.49.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 08:49:15 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438271332-10615-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275010>

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
index 1e8d1b2..7de49c4 100644
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
 		format = "%(padright:16)%(refname:short)";
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
2.4.6
