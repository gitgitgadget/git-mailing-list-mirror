From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 1/2] rev-parse --glob
Date: Wed, 20 Jan 2010 11:48:25 +0200
Message-ID: <1263980906-11058-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 10:48:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXXBJ-0000E6-U0
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 10:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab0ATJse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 04:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720Ab0ATJsd
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 04:48:33 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:38008 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab0ATJs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 04:48:29 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id F041EEBE29
	for <git@vger.kernel.org>; Wed, 20 Jan 2010 11:48:27 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A071FDEB4A2; Wed, 20 Jan 2010 11:48:27 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id B027AE51A2
	for <git@vger.kernel.org>; Wed, 20 Jan 2010 11:48:26 +0200 (EET)
X-Mailer: git-send-email 1.6.6.199.gff4b0
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137532>

Add --glob=<glob-pattern> option to rev-parse and everything that
accepts its options. This option matches all refs that match given
shell glob pattern (complete with some DWIM logic).

Example:

'git log --branches --not --glob=remotes/origin'

To show what you have that origin doesn't.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
--glob can do everything --namespace did and more (in fact, what
was valid for --namespace is valid for --glob and even means the same
thing). Built on top of master.

 Documentation/git-log.txt          |   11 +++
 Documentation/git-rev-list.txt     |    1 +
 Documentation/git-rev-parse.txt    |    5 ++
 Documentation/rev-list-options.txt |    7 ++
 builtin-rev-parse.c                |    5 ++
 refs.c                             |   46 ++++++++++++
 refs.h                             |    1 +
 revision.c                         |   16 ++++-
 t/t6018-rev-list-glob.sh           |  136 ++++++++++++++++++++++++++++++++++++
 9 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100755 t/t6018-rev-list-glob.sh

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 3d79de1..0b874e3 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -107,6 +107,17 @@ git log --follow builtin-rev-list.c::
 	those commits that occurred before the file was given its
 	present name.
 
+git log --branches --not --glob=remotes/origin/*::
+
+	Shows all commits that are in any of local branches but not in
+	any of remote tracking branches for 'origin' (what you have that
+	origin doesn't).
+
+git log master --not --glob=remotes/*/master::
+
+	Shows all commits that are in local master but not in any remote
+	repository master branches.
+
 Discussion
 ----------
 
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 3341d1b..33122a3 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -24,6 +24,7 @@ SYNOPSIS
 	     [ \--branches ]
 	     [ \--tags ]
 	     [ \--remotes ]
+	     [ \--glob=glob-pattern ]
 	     [ \--stdin ]
 	     [ \--quiet ]
 	     [ \--topo-order ]
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 82045a2..6eb8c14 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -112,6 +112,11 @@ OPTIONS
 --remotes::
 	Show tag refs found in `$GIT_DIR/refs/remotes`.
 
+--glob=glob-pattern::
+	Show refs matching shell glob pattern `glob-pattern`. If pattern
+	specified lacks leading 'refs/', it is automatically prepended.
+	If pattern lacks '?', '*', or '[', '/*' at the end is impiled.
+
 --show-prefix::
 	When the command is invoked from a subdirectory, show the
 	path of the current directory relative to the top-level
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1f57aed..6d03c17 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -243,6 +243,13 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `$GIT_DIR/refs/remotes` are listed
 	on the command line as '<commit>'.
 
+--glob=glob-pattern::
+	Pretend as if all the refs matching shell glob `glob-pattern`
+	are listed on the command line as '<commit>'. Leading 'refs/',
+	is automatically prepended if missing. If pattern lacks '?', '*',
+	or '[', '/*' at the end is impiled.
+
+
 ifndef::git-rev-list[]
 --bisect::
 
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 37d0233..a635dde 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -52,6 +52,7 @@ static int is_rev_argument(const char *arg)
 		"--parents",
 		"--pretty",
 		"--remotes",
+		"--glob=",
 		"--sparse",
 		"--tags",
 		"--topo-order",
@@ -577,6 +578,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_tag_ref(show_reference, NULL);
 				continue;
 			}
+			if (!prefixcmp(arg, "--glob=")) {
+				for_each_glob_ref(show_reference, arg + 7, NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--remotes")) {
 				for_each_remote_ref(show_reference, NULL);
 				continue;
diff --git a/refs.c b/refs.c
index 3e73a0a..5adf69c 100644
--- a/refs.c
+++ b/refs.c
@@ -519,6 +519,14 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 	return ref;
 }
 
+/* The argument to filter_refs */
+struct ref_filter
+{
+	const char *pattern;
+	each_ref_fn *fn;
+	void *cb_data;
+};
+
 int read_ref(const char *ref, unsigned char *sha1)
 {
 	if (resolve_ref(ref, sha1, 1, NULL))
@@ -545,6 +553,15 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
 }
 
+static int filter_refs(const char* ref, const unsigned char *sha, int flags,
+	void* data)
+{
+	struct ref_filter *filter = (struct ref_filter*)data;
+	if (fnmatch(filter->pattern, ref, 0))
+		return 0;
+	return filter->fn(ref, sha, flags, filter->cb_data);
+}
+
 int peel_ref(const char *ref, unsigned char *sha1)
 {
 	int flag;
@@ -674,6 +691,35 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
 }
 
+int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
+{
+	struct strbuf real_pattern = STRBUF_INIT;
+	struct ref_filter filter;
+	const char *has_glob_specials;
+	int ret;
+
+	if (prefixcmp(pattern, "refs/"))
+		strbuf_addstr(&real_pattern, "refs/");
+	strbuf_addstr(&real_pattern, pattern);
+
+	has_glob_specials = strpbrk(pattern, "?*[");
+	if (!has_glob_specials) {
+		/* Append impiled '/' '*' if not present. */
+		if (real_pattern.buf[real_pattern.len - 1] != '/')
+			strbuf_addch(&real_pattern, '/');
+		/* No need to check for '*', there is none. */
+		strbuf_addch(&real_pattern, '*');
+	}
+
+	filter.pattern = real_pattern.buf;
+	filter.fn = fn;
+	filter.cb_data = cb_data;
+	ret = for_each_ref(filter_refs, &filter);
+
+	strbuf_release(&real_pattern);
+	return ret;
+}
+
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref("refs/", fn, 0,
diff --git a/refs.h b/refs.h
index e141991..78ad173 100644
--- a/refs.h
+++ b/refs.h
@@ -25,6 +25,7 @@ extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
+extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
 
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
diff --git a/revision.c b/revision.c
index 25fa14d..162b182 100644
--- a/revision.c
+++ b/revision.c
@@ -699,12 +699,18 @@ static int handle_one_ref(const char *path, const unsigned char *sha1, int flag,
 	return 0;
 }
 
+static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
+	unsigned flags)
+{
+	cb->all_revs = revs;
+	cb->all_flags = flags;
+}
+
 static void handle_refs(struct rev_info *revs, unsigned flags,
 		int (*for_each)(each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
-	cb.all_revs = revs;
-	cb.all_flags = flags;
+	init_all_refs_cb(&cb, revs, flags);
 	for_each(handle_one_ref, &cb);
 }
 
@@ -1352,6 +1358,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_refs(revs, flags, for_each_remote_ref);
 				continue;
 			}
+			if (!prefixcmp(arg, "--glob=")) {
+				struct all_refs_cb cb;
+				init_all_refs_cb(&cb, revs, flags);
+				for_each_glob_ref(handle_one_ref, arg + 7, &cb);
+				continue;
+			}
 			if (!strcmp(arg, "--reflog")) {
 				handle_reflog(revs, flags);
 				continue;
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
new file mode 100755
index 0000000..0d7e4bc
--- /dev/null
+++ b/t/t6018-rev-list-glob.sh
@@ -0,0 +1,136 @@
+#!/bin/sh
+
+test_description='rev-list/rev-parse --glob'
+
+. ./test-lib.sh
+
+
+commit () {
+	test_tick &&
+	echo $1 > foo &&
+	git add foo &&
+	git commit -m "$1"
+}
+
+compare () {
+	# Split arguments on whitespace.
+	git $1 $2 >expected &&
+	git $1 $3 >actual &&
+	test_cmp expected actual
+}
+
+test_expect_success 'setup' '
+
+	commit master &&
+	git checkout -b subspace/one master &&
+	commit one &&
+	git checkout -b subspace/two master &&
+	commit two &&
+	git checkout -b subspace-x master &&
+	commit subspace-x &&
+	git checkout -b other/three master &&
+	commit three &&
+	git checkout -b someref master &&
+	commit some &&
+	git checkout master &&
+	commit master2
+'
+
+test_expect_success 'rev-parse --glob=refs/heads/subspace/*' '
+
+	compare rev-parse "subspace/one subspace/two" "--glob=refs/heads/subspace/*"
+
+'
+
+test_expect_success 'rev-parse --glob=heads/subspace/*' '
+
+	compare rev-parse "subspace/one subspace/two" "--glob=heads/subspace/*"
+
+'
+
+test_expect_success 'rev-parse --glob=refs/heads/subspace/' '
+
+	compare rev-parse "subspace/one subspace/two" "--glob=refs/heads/subspace/"
+
+'
+
+test_expect_success 'rev-parse --glob=heads/subspace/' '
+
+	compare rev-parse "subspace/one subspace/two" "--glob=heads/subspace/"
+
+'
+
+test_expect_success 'rev-parse --glob=heads/subspace' '
+
+	compare rev-parse "subspace/one subspace/two" "--glob=heads/subspace"
+
+'
+
+test_expect_success 'rev-parse --glob=heads/subspace/* --glob=heads/other/*' '
+
+	compare rev-parse "subspace/one subspace/two other/three" "--glob=heads/subspace/* --glob=heads/other/*"
+
+'
+
+test_expect_success 'rev-parse --glob=heads/someref/* master' '
+
+	compare rev-parse "master" "--glob=heads/someref/* master"
+
+'
+
+test_expect_success 'rev-parse --glob=heads/*' '
+
+	compare rev-parse "master other/three someref subspace-x subspace/one subspace/two" "--glob=heads/*"
+
+'
+
+test_expect_success 'rev-list --glob=refs/heads/subspace/*' '
+
+	compare rev-list "subspace/one subspace/two" "--glob=refs/heads/subspace/*"
+
+'
+
+test_expect_success 'rev-list --glob=heads/subspace/*' '
+
+	compare rev-list "subspace/one subspace/two" "--glob=heads/subspace/*"
+
+'
+
+test_expect_success 'rev-list --glob=refs/heads/subspace/' '
+
+	compare rev-list "subspace/one subspace/two" "--glob=refs/heads/subspace/"
+
+'
+
+test_expect_success 'rev-list --glob=heads/subspace/' '
+
+	compare rev-list "subspace/one subspace/two" "--glob=heads/subspace/"
+
+'
+
+test_expect_success 'rev-list --glob=heads/subspace' '
+
+	compare rev-list "subspace/one subspace/two" "--glob=heads/subspace"
+
+'
+
+test_expect_success 'rev-list --glob=heads/someref/* master' '
+
+	compare rev-list "master" "--glob=heads/someref/* master"
+
+'
+
+test_expect_success 'rev-list --glob=heads/subspace/* --glob=heads/other/*' '
+
+	compare rev-list "subspace/one subspace/two other/three" "--glob=heads/subspace/* --glob=heads/other/*"
+
+'
+
+test_expect_success 'rev-list --glob=heads/*' '
+
+	compare rev-list "master other/three someref subspace-x subspace/one subspace/two" "--glob=heads/*"
+
+'
+
+
+test_done
-- 
1.6.6.199.gff4b0
