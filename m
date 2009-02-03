From: Jake Goulding <goulding@vivisimo.com>
Subject: [RFC PATCH 1/1] git-tag: Add --regex option
Date: Tue,  3 Feb 2009 11:11:52 -0500
Message-ID: <1233677512-1846-1-git-send-email-goulding@vivisimo.com>
Cc: Jake Goulding <goulding@vivisimo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 17:13:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUNtz-0006x9-Fv
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 17:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbZBCQMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 11:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbZBCQMD
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 11:12:03 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:57738 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbZBCQMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 11:12:01 -0500
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id BC2EE8533DB
	for <git@vger.kernel.org>; Tue,  3 Feb 2009 11:12:00 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 942032E68D0
	for <git@vger.kernel.org>; Tue,  3 Feb 2009 11:12:00 -0500 (EST)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (mail.office.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oITqNqJBmmUp; Tue,  3 Feb 2009 11:11:55 -0500 (EST)
Received: from localhost.localdomain (jpg-melchior.vivisimo.com [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 5EF292E68CF;
	Tue,  3 Feb 2009 11:11:55 -0500 (EST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108205>

Allows the tag pattern to be expressed as a regular expression.

Signed-off-by: Jake Goulding <goulding@vivisimo.com>
---
 Documentation/git-tag.txt |    5 ++++-
 builtin-tag.c             |   34 ++++++++++++++++++++++++++++++----
 t/t7004-tag.sh            |   26 ++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 533d18b..5c08a45 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<name> [<commit> | <object>]
 'git tag' -d <name>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
+'git tag' [-n[<num>]] -l [--contains <commit>] [--regex] [<pattern>]
 'git tag' -v <name>...
 
 DESCRIPTION
@@ -71,6 +71,9 @@ OPTIONS
 --contains <commit>::
 	Only list tags which contain the specified commit.
 
+--regex::
+	Treat the pattern as a regular expression, instead of a shell wildcard pattern.
+
 -m <msg>::
 	Use the given tag message (instead of prompting).
 	If multiple `-m` options are given, their values are
diff --git a/builtin-tag.c b/builtin-tag.c
index 01e7374..dad4e53 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -27,6 +27,8 @@ struct tag_filter {
 	const char *pattern;
 	int lines;
 	struct commit_list *with_commit;
+	int use_regex;
+	regex_t tag_regex;
 };
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
@@ -35,8 +37,14 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
 	struct tag_filter *filter = cb_data;
+	int matched = 0;
 
-	if (!fnmatch(filter->pattern, refname, 0)) {
+	if (filter->use_regex)
+		matched = !regexec(&filter->tag_regex, refname, 0, NULL, 0);
+	else
+		matched = !fnmatch(filter->pattern, refname, 0);
+
+	if (matched) {
 		int i;
 		unsigned long size;
 		enum object_type type;
@@ -91,7 +99,7 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 }
 
 static int list_tags(const char *pattern, int lines,
-			struct commit_list *with_commit)
+			struct commit_list *with_commit, int use_regex)
 {
 	struct tag_filter filter;
 
@@ -101,9 +109,24 @@ static int list_tags(const char *pattern, int lines,
 	filter.pattern = pattern;
 	filter.lines = lines;
 	filter.with_commit = with_commit;
+	filter.use_regex = use_regex;
+	if (use_regex) {
+		int regex_errcode;
+
+		regex_errcode = regcomp(&filter.tag_regex, pattern, 0);
+		if (regex_errcode) {
+			char regex_error[1024];
+
+			regerror(regex_errcode, &filter.tag_regex, regex_error, 1024);
+			return error("Invalid tag pattern \"%s\": %s\n", pattern, regex_error);
+		}
+	}
 
 	for_each_tag_ref(show_reference, (void *) &filter);
 
+	if (use_regex)
+		regfree(&filter.tag_regex);
+
 	return 0;
 }
 
@@ -370,7 +393,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_lock *lock;
 
 	int annotate = 0, sign = 0, force = 0, lines = -1,
-		list = 0, delete = 0, verify = 0;
+		list = 0, delete = 0, verify = 0, use_regex = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -400,6 +423,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
+		OPT_BOOLEAN(0, "regex", &use_regex, "use regex matching"),
 		OPT_END()
 	};
 
@@ -425,11 +449,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_tag_usage, options);
 	if (list)
 		return list_tags(argv[0], lines == -1 ? 0 : lines,
-				 with_commit);
+				 with_commit, use_regex);
 	if (lines != -1)
 		die("-n option is only allowed with -l.");
 	if (with_commit)
 		die("--contains option is only allowed with -l.");
+	if (use_regex)
+		die("--regex option is only allowed with -l.");
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 69501e2..a93de89 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -256,6 +256,32 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+# regex pattern matching:
+
+test_expect_success 'listing a tag using a matching regex pattern should succeed' \
+	'git tag -l --regex "^aa1$"'
+
+test_expect_success 'listing a tag using a nonmatching regex pattern should succeed' \
+	'git tag -l --regex "^xxxxxxxxxxxxx$"'
+
+test_expect_success \
+	'listing a tag using a matching regex pattern should output that tag' \
+	'test `git tag -l --regex "^aa1$"` = aa1'
+
+test_expect_success \
+	'listing tags using a matching regex pattern should output those tags' \
+	'test `git tag -l --regex "^v1.[[:digit:]]$"` = "v1.0"'
+
+cat > expected <<EOF
+v1.0.1
+v1.1.3
+EOF
+
+test_expect_success \
+	'listing a tag using a matching regex pattern should output that tag' \
+	'git tag -l --regex "^v1.[[:digit:]].[[:digit:]]$" > actual &&
+         test_cmp expected actual'
+
 # creating and verifying lightweight tags:
 
 test_expect_success \
-- 
1.6.0.6
