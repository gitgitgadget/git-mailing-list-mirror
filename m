From: Jake Goulding <goulding@vivisimo.com>
Subject: [PATCH 3/3] Add --contains flag to git tag
Date: Mon, 26 Jan 2009 09:13:25 -0500
Message-ID: <1232979205-17161-3-git-send-email-goulding@vivisimo.com>
References: <1232979205-17161-1-git-send-email-goulding@vivisimo.com>
 <1232979205-17161-2-git-send-email-goulding@vivisimo.com>
Cc: gitster@pobox.com, Jake Goulding <goulding@vivisimo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 15:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRSEu-0001XV-FP
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 15:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbZAZONf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 09:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbZAZONe
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 09:13:34 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:43827 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbZAZONa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 09:13:30 -0500
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id 11018852951;
	Mon, 26 Jan 2009 09:13:29 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id E0C152E68D0;
	Mon, 26 Jan 2009 09:13:28 -0500 (EST)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (mail.office.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LVOBGVr4vaDC; Mon, 26 Jan 2009 09:13:28 -0500 (EST)
Received: from localhost.localdomain (jpg-melchior.vivisimo.com [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 817212E68D1;
	Mon, 26 Jan 2009 09:13:28 -0500 (EST)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1232979205-17161-2-git-send-email-goulding@vivisimo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107213>

This functions similar to git branch --contains - it will show all
tags that contain the specified commit. Indeed, it uses the same
lookup mechanisms as git branch.

Also adding documentation and tests for new option.

Signed-off-by: Jake Goulding <goulding@vivisimo.com>
---

Updated error semantics as suggested by Junio.

 Documentation/git-tag.txt |    5 ++-
 builtin-tag.c             |   30 +++++++++++-
 t/t7004-tag.sh            |  115 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index e44f543..533d18b 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<name> [<commit> | <object>]
 'git tag' -d <name>...
-'git tag' [-n[<num>]] -l [<pattern>]
+'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
 'git tag' -v <name>...
 
 DESCRIPTION
@@ -68,6 +68,9 @@ OPTIONS
 	List tags with names that match the given pattern (or all if no pattern is given).
 	Typing "git tag" without arguments, also lists all tags.
 
+--contains <commit>::
+	Only list tags which contain the specified commit.
+
 -m <msg>::
 	Use the given tag message (instead of prompting).
 	If multiple `-m` options are given, their values are
diff --git a/builtin-tag.c b/builtin-tag.c
index a398499..17082de 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -26,6 +26,7 @@ static char signingkey[1000];
 struct tag_filter {
 	const char *pattern;
 	int lines;
+	struct commit_list *with_commit;
 };
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
@@ -42,6 +43,17 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		char *buf, *sp, *eol;
 		size_t len;
 
+		if (filter->with_commit) {
+			struct commit *commit;
+
+			commit = lookup_commit_reference_gently(sha1, 1);
+			if (!commit)
+				return 0;
+			if (!commit_has_any_in_commit_list(commit,
+							   filter->with_commit))
+				return 0;
+		}
+
 		if (!filter->lines) {
 			printf("%s\n", refname);
 			return 0;
@@ -79,7 +91,8 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static int list_tags(const char *pattern, int lines)
+static int list_tags(const char *pattern, int lines,
+			struct commit_list *with_commit)
 {
 	struct tag_filter filter;
 
@@ -88,6 +101,7 @@ static int list_tags(const char *pattern, int lines)
 
 	filter.pattern = pattern;
 	filter.lines = lines;
+	filter.with_commit = with_commit;
 
 	for_each_tag_ref(show_reference, (void *) &filter);
 
@@ -360,6 +374,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		list = 0, delete = 0, verify = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
+	struct commit_list *with_commit = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN('l', NULL, &list, "list tag names"),
 		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
@@ -378,6 +393,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_STRING('u', NULL, &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT_BOOLEAN('f', NULL, &force, "replace the tag if exists"),
+
+		OPT_GROUP("Tag listing options"),
+		{
+			OPTION_CALLBACK, 0, "contains", &with_commit, "commit",
+			"print only tags that contain the commit",
+			PARSE_OPT_LASTARG_DEFAULT,
+			parse_opt_with_commit, (intptr_t)"HEAD",
+		},
 		OPT_END()
 	};
 
@@ -402,9 +425,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (list + delete + verify > 1)
 		usage_with_options(git_tag_usage, options);
 	if (list)
-		return list_tags(argv[0], lines == -1 ? 0 : lines);
+		return list_tags(argv[0], lines == -1 ? 0 : lines,
+				 with_commit);
 	if (lines != -1)
 		die("-n option is only allowed with -l.");
+	if (with_commit)
+		die("--contains option is only allowed with -l.");
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f377fea..69501e2 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1090,6 +1090,121 @@ test_expect_success 'filename for the message is relative to cwd' '
 	git cat-file tag tag-from-subdir-2 | grep "in sub directory"
 '
 
+# create a few more commits to test --contains
+
+hash1=$(git rev-parse HEAD)
+
+test_expect_success 'creating second commit and tag' '
+	echo foo-2.0 >foo &&
+	git add foo &&
+	git commit -m second
+	git tag v2.0
+'
+
+hash2=$(git rev-parse HEAD)
+
+test_expect_success 'creating third commit without tag' '
+	echo foo-dev >foo &&
+	git add foo &&
+	git commit -m third
+'
+
+hash3=$(git rev-parse HEAD)
+
+# simple linear checks of --continue
+
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+EOF
+
+test_expect_success 'checking that first commit is in all tags (hash)' "
+	git tag -l --contains $hash1 v* >actual
+	test_cmp expected actual
+"
+
+# other ways of specifying the commit
+test_expect_success 'checking that first commit is in all tags (tag)' "
+	git tag -l --contains v1.0 v* >actual
+	test_cmp expected actual
+"
+
+test_expect_success 'checking that first commit is in all tags (relative)' "
+	git tag -l --contains HEAD~2 v* >actual
+	test_cmp expected actual
+"
+
+cat > expected <<EOF
+v2.0
+EOF
+
+test_expect_success 'checking that second commit only has one tag' "
+	git tag -l --contains $hash2 v* >actual
+	test_cmp expected actual
+"
+
+
+cat > expected <<EOF
+EOF
+
+test_expect_success 'checking that third commit has no tags' "
+	git tag -l --contains $hash3 v* >actual
+	test_cmp expected actual
+"
+
+# how about a simple merge?
+
+test_expect_success 'creating simple branch' '
+	git branch stable v2.0 &&
+        git checkout stable &&
+	echo foo-3.0 > foo &&
+	git commit foo -m fourth
+	git tag v3.0
+'
+
+hash4=$(git rev-parse HEAD)
+
+cat > expected <<EOF
+v3.0
+EOF
+
+test_expect_success 'checking that branch head only has one tag' "
+	git tag -l --contains $hash4 v* >actual
+	test_cmp expected actual
+"
+
+test_expect_success 'merging original branch into this branch' '
+	git merge --strategy=ours master &&
+        git tag v4.0
+'
+
+cat > expected <<EOF
+v4.0
+EOF
+
+test_expect_success 'checking that original branch head has one tag now' "
+	git tag -l --contains $hash3 v* >actual
+	test_cmp expected actual
+"
+
+cat > expected <<EOF
+v0.2.1
+v1.0
+v1.0.1
+v1.1.3
+v2.0
+v3.0
+v4.0
+EOF
+
+test_expect_success 'checking that initial commit is in all tags' "
+	git tag -l --contains $hash1 v* >actual
+	test_cmp expected actual
+"
+
 # mixing modes and options:
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
-- 
1.6.0.6
