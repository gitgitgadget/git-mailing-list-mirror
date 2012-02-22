From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv3 3/5] tag --exclude option
Date: Tue, 21 Feb 2012 17:28:48 -0800
Message-ID: <1329874130-16818-4-git-send-email-tmgrennan@gmail.com>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:29:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0118-0004C9-1m
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 02:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab2BVB3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 20:29:09 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:56034 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab2BVB3H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 20:29:07 -0500
Received: by mail-qw0-f53.google.com with SMTP id k1so7771133qaf.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 17:29:07 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.229.102.134 as permitted sender) client-ip=10.229.102.134;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.229.102.134 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.229.102.134])
        by 10.229.102.134 with SMTP id g6mr21435860qco.21.1329874147072 (num_hops = 1);
        Tue, 21 Feb 2012 17:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=/ZqSW/QmVbHErmdfjbB8YhnbsiIJqctYP6Jta9dWDP8=;
        b=Sf8S4mH4Jmbj5VowPgkTwEnIvy8qbdWrK4kPYCfyTF9m1U31HkvJa34dAomDTQPSlL
         yH2KWPJckgehHPnaULoHiD4MjN9xLcg34mbfkQ821T5Ytt7qzyEkLdaEO6WXlV0jcmsw
         6mdo1GyxRDuDZUOKpBrpzLC+k/eAaCpqS336A=
Received: by 10.229.102.134 with SMTP id g6mr18133295qco.21.1329874146954;
        Tue, 21 Feb 2012 17:29:06 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n8sm2148026qan.12.2012.02.21.17.29.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 17:29:06 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120211190856.GB4903@tgrennan-laptop>
References: <20120211190856.GB4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191211>

Example,
  $ git tag -l --exclude "*-rc?" "v1.7.8*"
  v1.7.8
  v1.7.8.1
  v1.7.8.2
  v1.7.8.3
  v1.7.8.4

Which is equivalent to,
  $ git tag -l "v1.7.8*" | grep -v \\-rc.
  v1.7.8
  v1.7.8.1
  v1.7.8.2
  v1.7.8.3
  v1.7.8.4

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 Documentation/git-tag.txt |    6 ++++-
 builtin/tag.c             |   17 ++++++++++---
 t/t7004-tag.sh            |   56 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 8d32b9a..470bd80 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
-	[<pattern>...]
+	[--exclude <pattern>] [<pattern>...]
 'git tag' -v <tagname>...
 
 DESCRIPTION
@@ -90,6 +90,10 @@ OPTIONS
 --points-at <object>::
 	Only list tags of the given object.
 
+--exclude <pattern>::
+	Don't list tags matching the given pattern.  This has precedence
+	over any other match pattern arguments.
+
 -m <msg>::
 --message=<msg>::
 	Use the given tag message (instead of prompting).
diff --git a/builtin/tag.c b/builtin/tag.c
index 4a016d5..547f97d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -21,7 +21,7 @@ static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git tag -d <tagname>...",
 	"git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>] "
-		"\n\t\t[<pattern>...]",
+		"\n\t\t[--exclude <pattern>] [<pattern>...]",
 	"git tag -v <tagname>...",
 	NULL
 };
@@ -30,6 +30,7 @@ struct tag_filter {
 	const char **patterns;
 	int lines;
 	struct commit_list *with_commit;
+	struct string_list *exclude;
 };
 
 static struct sha1_array points_at;
@@ -138,7 +139,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 {
 	struct tag_filter *filter = cb_data;
 
-	if (match_pattern(refname, filter->patterns, NULL, 0)) {
+	if (match_pattern(refname, filter->patterns, filter->exclude, 0)) {
 		if (filter->with_commit) {
 			struct commit *commit;
 
@@ -165,13 +166,15 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 }
 
 static int list_tags(const char **patterns, int lines,
-			struct commit_list *with_commit)
+		     struct commit_list *with_commit,
+		     struct string_list *exclude)
 {
 	struct tag_filter filter;
 
 	filter.patterns = patterns;
 	filter.lines = lines;
 	filter.with_commit = with_commit;
+	filter.exclude = exclude;
 
 	for_each_tag_ref(show_reference, (void *) &filter);
 
@@ -428,6 +431,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
+	struct string_list exclude = STRING_LIST_INIT_NODUP;
 	struct option options[] = {
 		OPT_BOOLEAN('l', "list", &list, "list tag names"),
 		{ OPTION_INTEGER, 'n', NULL, &lines, "n",
@@ -459,6 +463,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "points-at", NULL, "object",
 			     "print only tags of the object",
 			     parse_opt_points_at),
+		OPT_CALLBACK(0, "exclude", &exclude, "pattern",
+			     "ignore pattern matching tags",
+			     parse_opt_string_list),
 		OPT_END()
 	};
 
@@ -485,13 +492,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_tag_usage, options);
 	if (list)
 		return list_tags(argv, lines == -1 ? 0 : lines,
-				 with_commit);
+				 with_commit, &exclude);
 	if (lines != -1)
 		die(_("-n option is only allowed with -l."));
 	if (with_commit)
 		die(_("--contains option is only allowed with -l."));
 	if (points_at.nr)
 		die(_("--points-at option is only allowed with -l."));
+	if (exclude.nr)
+		die(_("--exclude option is only allowed with -l."));
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f8c247a..4f1cf48 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -82,6 +82,10 @@ test_expect_success \
 	'listing tags using a non-matching pattern should output nothing' \
 	'test `git tag -l xxx | wc -l` -eq 0'
 
+test_expect_success \
+	'listing tags excluding "mytag" should output nothing' \
+	'test `git tag -l --exclude mytag | wc -l` -eq 0'
+
 # special cases for creating tags:
 
 test_expect_success \
@@ -202,6 +206,15 @@ test_expect_success \
 '
 
 cat >expect <<EOF
+v0.2.1
+EOF
+test_expect_success \
+	'listing tags with a suffix as pattern and prefix exclusion' '
+	git tag -l --exclude "v1.*" "*.1" > actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
 t210
 t211
 EOF
@@ -212,6 +225,15 @@ test_expect_success \
 '
 
 cat >expect <<EOF
+t210
+EOF
+test_expect_success \
+	'listing tags with a prefix as pattern and suffix exclusion' '
+	git tag -l --exclude "*1" "t21*" > actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
 a1
 EOF
 test_expect_success \
@@ -239,6 +261,15 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+cat >expect <<EOF
+v1.0.1
+EOF
+test_expect_success \
+	'listing tags with ? in the pattern and exclusion' '
+	git tag -l --exclude "v1.?.3" "v1.?.?" > actual &&
+	test_cmp expect actual
+'
+
 >expect
 test_expect_success \
 	'listing tags using v.* should print nothing because none have v.' '
@@ -263,6 +294,31 @@ test_expect_success 'tag -l can accept multiple patterns' '
 	test_cmp expect actual
 '
 
+test_expect_success 'tag -l can cancel exclusions' '
+	git tag -l --exclude "v*.3" --no-exclude "v1*" "v0*" >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
+v0.2.1
+v1.0.1
+EOF
+test_expect_success 'tag -l can accept multiple patterns and exclusions' '
+	git tag -l --exclude "v*.3" --exclude "v1.0" "v1*" "v0*" >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
+v0.2.1
+v1.0.1
+v1.1.3
+EOF
+test_expect_success \
+	'tag -l can cancel then reapply exclusions' '
+	git tag -l --exclude "v*.3" --no-exclude --exclude "v1.0" \
+		"v1*" "v0*" >actual &&
+	test_cmp expect actual
+'
 # creating and verifying lightweight tags:
 
 test_expect_success \
-- 
1.7.8
