From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 8/9] tag.c: implement '--format' option
Date: Thu, 25 Jun 2015 17:13:15 +0530
Message-ID: <1435232596-27466-8-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 13:44:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z85Zx-0006dH-3C
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 13:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbbFYLoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 07:44:18 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36151 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbFYLoN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 07:44:13 -0400
Received: by pdcu2 with SMTP id u2so52010431pdc.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 04:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v4RoxPPU2UjO6ImMC9GJt6r+OGRMdbItGeOOMrZyCTg=;
        b=jVrCk5OlUKq3g2Oe+7SP3Yn2pCQRTXuhlGg41DQmzxfp+APMttY8UExbKaaus2joap
         yq+zc6wBV2fC734HxM8SqbwLvb+DqWCR8GsgV49iyuUI7hcSqXJ9tw+kqxGlPkKjiReu
         LEgRYL5QK4BFCO+4YuGz4YI/RqE+Kuz+A7gRkHgDeP1J8vYRFs1GpVJpeW6klKR4SN+k
         6qhXoF/Q8O4XBcQ8Qn+LU1Hyn8A0AvSvWo5slhvmMf4g1ai4BJX5E7WcjTLuCvL5JL9Y
         z5GnqfvKLOAQTgtQOG+XJLnTzBjtg7N91MRlbCZY4qaPhtfk/r5QnmJeb5q5+CEOcXgE
         lrHQ==
X-Received: by 10.68.141.232 with SMTP id rr8mr54395825pbb.7.1435232652211;
        Thu, 25 Jun 2015 04:44:12 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id xn2sm11575446pbc.44.2015.06.25.04.44.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 04:44:11 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272665>

Implement the '--format' option provided by 'ref-filter'.
This lets the user list tags as per desired format similar
to the implementation in 'git for-each-ref'.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-tag.txt | 15 ++++++++++++++-
 builtin/tag.c             | 14 ++++++++++----
 t/t7004-tag.sh            | 16 ++++++++++++++++
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 1950d94..16e396c 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
-	[--column[=<options>] | --no-column] [--sort=<key>] [<pattern>...]
+	[--column[=<options>] | --no-column] [--sort=<key>] [--format=<format>]
 	[<pattern>...]
 'git tag' -v <tagname>...
 
@@ -156,6 +156,19 @@ This option is only applicable when listing tags without annotation lines.
 	The object that the new tag will refer to, usually a commit.
 	Defaults to HEAD.
 
+<format>::
+	A string that interpolates `%(fieldname)` from the
+	object pointed at by a ref being shown.  If `fieldname`
+	is prefixed with an asterisk (`*`) and the ref points
+	at a tag object, the value for the field in the object
+	tag refers is used.  When unspecified, defaults to
+	`%(objectname) SPC %(objecttype) TAB %(refname)`.
+	It also interpolates `%%` to `%`, and `%xx` where `xx`
+	are hex digits interpolates to character with hex code
+	`xx`; for example `%00` interpolates to `\0` (NUL),
+	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
+	The fields are same as those in `git for-each-ref`.
+
 
 CONFIGURATION
 -------------
diff --git a/builtin/tag.c b/builtin/tag.c
index d80120e..91356c9 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -30,12 +30,14 @@ static const char * const git_tag_usage[] = {
 
 static unsigned int colopts;
 
-static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
+static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
 	struct ref_array array;
-	char *format;
 	int i;
 
+	if (!format)
+		check_format = 1;
+
 	memset(&array, 0, sizeof(array));
 
 	if (filter->lines == -1)
@@ -43,7 +45,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
 
 	if (filter->lines)
 		format = "%(refname:lalign16)";
-	else
+	else if (!format)
 		format = "%(refname:short)";
 
 	verify_ref_format(format);
@@ -324,6 +326,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -355,6 +358,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END()
 	};
 
@@ -394,8 +398,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
index 51a233f..e8cebb6 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1507,4 +1507,20 @@ EOF"
 	test_cmp expect actual
 '
 
+test_expect_success '--format cannot be used with -n' '
+	test_must_fail git tag -l -n4 --format="%(refname)"
+'
+
+test_expect_success '--format should list tags as per format given' '
+	cat >expect <<-\EOF &&
+	foo1.10
+	foo1.3
+	foo1.6
+	foo1.6-rc1
+	foo1.6-rc2
+	EOF
+	git tag -l --format="%(refname)" "foo*" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.4
