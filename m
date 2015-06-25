From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 8/9] tag.c: implement '--format' option
Date: Thu, 25 Jun 2015 18:33:15 +0530
Message-ID: <1435237395-6754-1-git-send-email-karthik.188@gmail.com>
References: <1435232596-27466-8-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 15:03:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z86oY-0002li-Fg
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 15:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbbFYND0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 09:03:26 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36460 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbFYNDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 09:03:25 -0400
Received: by paceq1 with SMTP id eq1so49538997pac.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4m2CQlUReIl0VrNgUi2owBNOorvj6iSVIy8aILF/Gt0=;
        b=u0bcdNl4/s2kuv0ETDwu2CX+as24FK0AErLH2BAC9LAeRmtH2R2axviuuSC0i2hDqW
         sA7YwROFwL4WghOl6fRE3+xXUjz54onB/5pK4qKr5pOkKmEhVUmig2wqjl6nmm5fMf9b
         J7Xif8gIuLqB/R67wAUKhqywzfSEEcSfbL3m6QROdD4c+mdvYL0TuNgnsZHGOWldQ1Bi
         rMrcuqS1SI7OXCoVLYtgMCZ8CrxXi1AmInj2Zp6gaQk9XTMEcc7JCQ+0m4w3hzxw+K1E
         iY2/3qraF39z1WD2NBSV1lorvALPFVfwKwM2ltRrsLVivCihR26i/Q1BxehCRo+nQROP
         whfw==
X-Received: by 10.67.23.3 with SMTP id hw3mr92843355pad.67.1435237404820;
        Thu, 25 Jun 2015 06:03:24 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id de2sm30125275pdb.15.2015.06.25.06.03.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 06:03:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435232596-27466-8-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272672>

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
index d80120e..257526b 100644
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
 		format = "%(refname:lalign16)";
-	else
+	else if (!format)
 		format = "%(refname:short)";
 
 	verify_ref_format(format);
@@ -324,6 +323,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -355,6 +355,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_END()
 	};
 
@@ -394,8 +395,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
