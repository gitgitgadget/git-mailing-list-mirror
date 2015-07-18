From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 8/9] tag.c: implement '--format' option
Date: Sun, 19 Jul 2015 03:30:36 +0530
Message-ID: <1437256837-13378-2-git-send-email-Karthik.188@gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
 <1437256837-13378-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 00:00:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGaA4-0000S4-Tf
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 00:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbbGRWAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 18:00:43 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33105 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbbGRWAm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 18:00:42 -0400
Received: by pdbnt7 with SMTP id nt7so9652009pdb.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HMeD7RsZkiPk0G6ysrdlllQWeHOiIsQ20nZdeJ/Sexw=;
        b=qsG0lWmJ0+XPlqPQMrXBJojwAuWpohjCY1OBRW4AoMhmCQ2xwmf+8tkw/MuFgVFnW+
         ap/9iU+B+dr0qOpgD6+YDTLICjt6IeQm5eQcTgzUs2ZGnmcmEUPOQin9S4Tl+i4tYpgq
         CkynGpIanWq8eJUs3UZzukuMOVgqyRZ6iKe7+S415OmKyfQLCFG5axh2frevG0F+soKf
         pIiAijPR+kWMinvYc0AedanhBsGa+d31WP90YfOs4lDu8ph4TxXTsrogy0QgDgrXmqe6
         0+US/JkY1lkbX4MQAYiCmjJ0tDRSPVKaD2yMGQM8SvLRKL9hdWTM8ax3C36a8oRbhadC
         TicA==
X-Received: by 10.69.27.66 with SMTP id je2mr42670846pbd.72.1437256842116;
        Sat, 18 Jul 2015 15:00:42 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id he9sm15268969pbc.7.2015.07.18.15.00.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jul 2015 15:00:41 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437256837-13378-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274182>

From: Karthik Nayak <karthik.188@gmail.com>

Implement the '--format' option provided by 'ref-filter'.
This lets the user list tags as per desired format similar
to the implementation in 'git for-each-ref'.

Add tests and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-tag.txt | 16 +++++++++++++++-
 builtin/tag.c             | 11 +++++++----
 t/t7004-tag.sh            | 16 ++++++++++++++++
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 02fb363..16e396c 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
-	[--column[=<options>] | --no-column] [--sort=<key>] [<pattern>...]
+	[--column[=<options>] | --no-column] [--sort=<key>] [--format=<format>]
+	[<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -155,6 +156,19 @@ This option is only applicable when listing tags without annotation lines.
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
index 52a179e..cae113b 100644
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
 		format = "%(align:16)%(refname:short)";
-	else
+	else if (!format)
 		format = "%(refname:short)";
 
 	verify_ref_format(format);
@@ -328,6 +327,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
2.4.6
