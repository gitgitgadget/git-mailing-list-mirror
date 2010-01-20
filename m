From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 2/2] rev-parse --branches/--tags/--remotes=pattern
Date: Wed, 20 Jan 2010 11:48:26 +0200
Message-ID: <1263980906-11058-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 10:48:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXXBK-0000E6-KB
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 10:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab0ATJsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 04:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739Ab0ATJsc
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 04:48:32 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:43846 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab0ATJsb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 04:48:31 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 592368C64B
	for <git@vger.kernel.org>; Wed, 20 Jan 2010 11:48:29 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0746D53095; Wed, 20 Jan 2010 11:48:29 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 12B24E51A2
	for <git@vger.kernel.org>; Wed, 20 Jan 2010 11:48:28 +0200 (EET)
X-Mailer: git-send-email 1.6.6.199.gff4b0
In-Reply-To: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137531>

Since local branch, tags and remote tracking branch namespaces are
most often used, add shortcut notations for globbing those in
manner similar to --glob option.

With this, one can express the "what I have but origin doesn't?"
as:

'git log --branches --not --remotes=origin'

Original-idea-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
Builds on top of --glob patch.

 Documentation/git-log.txt          |    4 +-
 Documentation/git-rev-list.txt     |    6 ++--
 Documentation/git-rev-parse.txt    |   19 +++++++---
 Documentation/rev-list-options.txt |   18 +++++++---
 builtin-rev-parse.c                |   18 ++++++++++
 refs.c                             |   12 ++++++-
 refs.h                             |    1 +
 revision.c                         |   18 ++++++++++
 t/t6018-rev-list-glob.sh           |   62 +++++++++++++++++++++++++++++++++++-
 9 files changed, 138 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0b874e3..0acd526 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -107,13 +107,13 @@ git log --follow builtin-rev-list.c::
 	those commits that occurred before the file was given its
 	present name.
 
-git log --branches --not --glob=remotes/origin/*::
+git log --branches --not --remotes=origin::
 
 	Shows all commits that are in any of local branches but not in
 	any of remote tracking branches for 'origin' (what you have that
 	origin doesn't).
 
-git log master --not --glob=remotes/*/master::
+git log master --not --remotes=*/master::
 
 	Shows all commits that are in local master but not in any remote
 	repository master branches.
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 33122a3..f857116 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -21,9 +21,9 @@ SYNOPSIS
 	     [ \--full-history ]
 	     [ \--not ]
 	     [ \--all ]
-	     [ \--branches ]
-	     [ \--tags ]
-	     [ \--remotes ]
+	     [ \--branches[=pattern] ]
+	     [ \--tags=[pattern] ]
+	     [ \--remotes=[pattern] ]
 	     [ \--glob=glob-pattern ]
 	     [ \--stdin ]
 	     [ \--quiet ]
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 6eb8c14..afe8699 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -103,14 +103,21 @@ OPTIONS
 --all::
 	Show all refs found in `$GIT_DIR/refs`.
 
---branches::
-	Show branch refs found in `$GIT_DIR/refs/heads`.
+--branches[=pattern]::
+	Show branch refs found in `$GIT_DIR/refs/heads`. If `pattern`
+	is given, only branches matching given shell glob are shown.
+	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
 
---tags::
-	Show tag refs found in `$GIT_DIR/refs/tags`.
+--tags[=pattern]::
+	Show tag refs found in `$GIT_DIR/refs/tags`. If `pattern`
+	is given, only tags matching given shell glob are shown.
+	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
 
---remotes::
-	Show tag refs found in `$GIT_DIR/refs/remotes`.
+--remotes[=pattern]::
+	Show tag refs found in `$GIT_DIR/refs/remotes`. If `pattern`
+	is given, only remote tracking branches matching given shell glob
+	are shown. If pattern lacks '?', '*', or '[', '/*' at the end is
+	impiled.
 
 --glob=glob-pattern::
 	Show refs matching shell glob pattern `glob-pattern`. If pattern
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 6d03c17..3ef7117 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -228,20 +228,26 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `$GIT_DIR/refs/` are listed on the
 	command line as '<commit>'.
 
---branches::
+--branches[=pattern]::
 
 	Pretend as if all the refs in `$GIT_DIR/refs/heads` are listed
-	on the command line as '<commit>'.
+	on the command line as '<commit>'. If `pattern` is given, limit
+	branches to ones matching given shell glob. If pattern lacks '?',
+	'*', or '[', '/*' at the end is impiled.
 
---tags::
+--tags[=pattern]::
 
 	Pretend as if all the refs in `$GIT_DIR/refs/tags` are listed
-	on the command line as '<commit>'.
+	on the command line as '<commit>'. If `pattern` is given, limit
+	tags to ones matching given shell glob. If pattern lacks '?', '*',
+	or '[', '/*' at the end is impiled.
 
---remotes::
+--remotes[=pattern]::
 
 	Pretend as if all the refs in `$GIT_DIR/refs/remotes` are listed
-	on the command line as '<commit>'.
+	on the command line as '<commit>'. If `pattern`is given, limit
+	remote tracking branches to ones matching given shell glob.
+	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
 
 --glob=glob-pattern::
 	Pretend as if all the refs matching shell glob `glob-pattern`
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a635dde..d14fe20 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -41,6 +41,7 @@ static int is_rev_argument(const char *arg)
 		"--all",
 		"--bisect",
 		"--dense",
+		"--branches=",
 		"--branches",
 		"--header",
 		"--max-age=",
@@ -51,9 +52,11 @@ static int is_rev_argument(const char *arg)
 		"--objects-edge",
 		"--parents",
 		"--pretty",
+		"--remotes=",
 		"--remotes",
 		"--glob=",
 		"--sparse",
+		"--tags=",
 		"--tags",
 		"--topo-order",
 		"--date-order",
@@ -570,10 +573,20 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
+			if (!prefixcmp(arg, "--branches=")) {
+				for_each_glob_ref_in(show_reference, arg + 11,
+					"refs/heads/", NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--branches")) {
 				for_each_branch_ref(show_reference, NULL);
 				continue;
 			}
+			if (!prefixcmp(arg, "--tags=")) {
+				for_each_glob_ref_in(show_reference, arg + 7,
+					"refs/tags/", NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--tags")) {
 				for_each_tag_ref(show_reference, NULL);
 				continue;
@@ -582,6 +595,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_glob_ref(show_reference, arg + 7, NULL);
 				continue;
 			}
+			if (!prefixcmp(arg, "--remotes=")) {
+				for_each_glob_ref_in(show_reference, arg + 10,
+					"refs/remotes/", NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--remotes")) {
 				for_each_remote_ref(show_reference, NULL);
 				continue;
diff --git a/refs.c b/refs.c
index 5adf69c..af78c31 100644
--- a/refs.c
+++ b/refs.c
@@ -691,15 +691,18 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
 }
 
-int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
+int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+	const char *prefix, void *cb_data)
 {
 	struct strbuf real_pattern = STRBUF_INIT;
 	struct ref_filter filter;
 	const char *has_glob_specials;
 	int ret;
 
-	if (prefixcmp(pattern, "refs/"))
+	if (!prefix && prefixcmp(pattern, "refs/"))
 		strbuf_addstr(&real_pattern, "refs/");
+	else if (prefix)
+		strbuf_addstr(&real_pattern, prefix);
 	strbuf_addstr(&real_pattern, pattern);
 
 	has_glob_specials = strpbrk(pattern, "?*[");
@@ -720,6 +723,11 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 	return ret;
 }
 
+int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
+{
+	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
+}
+
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref("refs/", fn, 0,
diff --git a/refs.h b/refs.h
index 78ad173..f7648b9 100644
--- a/refs.h
+++ b/refs.h
@@ -26,6 +26,7 @@ extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
 extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
+extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
 
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
diff --git a/revision.c b/revision.c
index 162b182..1e9277d 100644
--- a/revision.c
+++ b/revision.c
@@ -1364,6 +1364,24 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				for_each_glob_ref(handle_one_ref, arg + 7, &cb);
 				continue;
 			}
+			if (!prefixcmp(arg, "--branches=")) {
+				struct all_refs_cb cb;
+				init_all_refs_cb(&cb, revs, flags);
+				for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+				continue;
+			}
+			if (!prefixcmp(arg, "--tags=")) {
+				struct all_refs_cb cb;
+				init_all_refs_cb(&cb, revs, flags);
+				for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+				continue;
+			}
+			if (!prefixcmp(arg, "--remotes=")) {
+				struct all_refs_cb cb;
+				init_all_refs_cb(&cb, revs, flags);
+				for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
+				continue;
+			}
 			if (!strcmp(arg, "--reflog")) {
 				handle_reflog(revs, flags);
 				continue;
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 0d7e4bc..bf85e0c 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -33,7 +33,9 @@ test_expect_success 'setup' '
 	git checkout -b someref master &&
 	commit some &&
 	git checkout master &&
-	commit master2
+	commit master2 &&
+	git tag foo/bar master &&
+	git update-ref refs/remotes/foo/baz master
 '
 
 test_expect_success 'rev-parse --glob=refs/heads/subspace/*' '
@@ -66,6 +68,24 @@ test_expect_success 'rev-parse --glob=heads/subspace' '
 
 '
 
+test_expect_success 'rev-parse --branches=subspace/*' '
+
+	compare rev-parse "subspace/one subspace/two" "--branches=subspace/*"
+
+'
+
+test_expect_success 'rev-parse --branches=subspace/' '
+
+	compare rev-parse "subspace/one subspace/two" "--branches=subspace/"
+
+'
+
+test_expect_success 'rev-parse --branches=subspace' '
+
+	compare rev-parse "subspace/one subspace/two" "--branches=subspace"
+
+'
+
 test_expect_success 'rev-parse --glob=heads/subspace/* --glob=heads/other/*' '
 
 	compare rev-parse "subspace/one subspace/two other/three" "--glob=heads/subspace/* --glob=heads/other/*"
@@ -84,6 +104,18 @@ test_expect_success 'rev-parse --glob=heads/*' '
 
 '
 
+test_expect_success 'rev-parse --tags=foo' '
+
+	compare rev-parse "foo/bar" "--tags=foo"
+
+'
+
+test_expect_success 'rev-parse --remotes=foo' '
+
+	compare rev-parse "foo/baz" "--remotes=foo"
+
+'
+
 test_expect_success 'rev-list --glob=refs/heads/subspace/*' '
 
 	compare rev-list "subspace/one subspace/two" "--glob=refs/heads/subspace/*"
@@ -114,6 +146,23 @@ test_expect_success 'rev-list --glob=heads/subspace' '
 
 '
 
+test_expect_success 'rev-list --branches=subspace/*' '
+
+	compare rev-list "subspace/one subspace/two" "--branches=subspace/*"
+
+'
+
+test_expect_success 'rev-list --branches=subspace/' '
+
+	compare rev-list "subspace/one subspace/two" "--branches=subspace/"
+
+'
+
+test_expect_success 'rev-list --branches=subspace' '
+
+	compare rev-list "subspace/one subspace/two" "--branches=subspace"
+
+'
 test_expect_success 'rev-list --glob=heads/someref/* master' '
 
 	compare rev-list "master" "--glob=heads/someref/* master"
@@ -132,5 +181,16 @@ test_expect_success 'rev-list --glob=heads/*' '
 
 '
 
+test_expect_success 'rev-list --tags=foo' '
+
+	compare rev-list "foo/bar" "--tags=foo"
+
+'
+
+test_expect_success 'rev-list --remotes=foo' '
+
+	compare rev-list "foo/baz" "--remotes=foo"
+
+'
 
 test_done
-- 
1.6.6.199.gff4b0
