From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 09/10] tag.c: implement '--format' option
Date: Thu, 9 Jul 2015 16:29:46 +0530
Message-ID: <559E5422.4070802@gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 13:00:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD9Yn-0001Dq-0F
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 13:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbbGIK76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 06:59:58 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34598 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbbGIK7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 06:59:46 -0400
Received: by pdbep18 with SMTP id ep18so163318506pdb.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=3006WlNkMvB4OUhbj6rDUDz2Oq2ImmCx4Hkh4QGR4LI=;
        b=ZBuzgPWc/6qVj8ixHkQ3O+P5eN6+hvkIZlBha6t/2mNMavf9zx93NY2wqyz1CFn0eN
         yc+gfcqcDQrmDFi3vZ9Z0SR/sAH0ifkViRuueBsweNKtjQ0+O33u1b7CkSH5JVZ0IzDO
         D1rjWN2hvr7bAOG1qmvRkEGg/QJU0kWi4nxpD5ZX6RIFjHDdcIdz5qDOEmvIcAr+BNOr
         9MEzoQEpVg9+MTHoFwC0r7q33+n2QdVziQyPg0OWbEh9MpVbShWKxOootAPsXYAEhCLT
         lGWI/ORVnk7kPnM349Fz0KWtnQRkpYNmKZqidsiwdl5jE6Ycb/Wme/bKXKvpyr821VEw
         P6/g==
X-Received: by 10.70.130.161 with SMTP id of1mr30425750pdb.31.1436439585884;
        Thu, 09 Jul 2015 03:59:45 -0700 (PDT)
Received: from [192.168.43.24] ([49.203.67.70])
        by smtp.googlemail.com with ESMTPSA id j4sm5572423pdg.64.2015.07.09.03.59.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 03:59:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273741>

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
@@ -155,6 +156,19 @@ This option is only applicable when listing tags 
without annotation lines.
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
index 36f8019..601b293 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -30,10 +30,9 @@ static const char * const git_tag_usage[] = {

  static unsigned int colopts;

-static int list_tags(struct ref_filter *filter, struct ref_sorting 
*sorting)
+static int list_tags(struct ref_filter *filter, struct ref_sorting 
*sorting, const char *format)
  {
  	struct ref_array array;
-	char *format;
  	int i;

  	memset(&array, 0, sizeof(array));
@@ -43,7 +42,7 @@ static int list_tags(struct ref_filter *filter, struct 
ref_sorting *sorting)

  	if (filter->lines)
  		format = "%(refname:shortalign=16)";
-	else
+	else if (!format)
  		format = "%(refname:short)";

  	verify_ref_format(format);
@@ -325,6 +324,7 @@ int cmd_tag(int argc, const char **argv, const char 
*prefix)
  	struct strbuf err = STRBUF_INIT;
  	struct ref_filter filter;
  	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	const char *format = NULL;
  	struct option options[] = {
  		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
  		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -356,6 +356,7 @@ int cmd_tag(int argc, const char **argv, const char 
*prefix)
  			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
  			N_("print only tags of the object"), 0, parse_opt_object_name
  		},
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use 
for the output")),
  		OPT_END()
  	};

@@ -395,8 +396,10 @@ int cmd_tag(int argc, const char **argv, const char 
*prefix)
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
2.4.5
