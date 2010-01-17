From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH] rev-parse --namespace
Date: Sun, 17 Jan 2010 15:45:31 +0200
Message-ID: <1263735931-20227-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 14:45:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWVRy-0004H8-VX
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 14:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806Ab0AQNpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 08:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747Ab0AQNps
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 08:45:48 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:59680 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab0AQNpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 08:45:47 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 934F0EF42B
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 15:45:45 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00AB164183; Sun, 17 Jan 2010 15:45:45 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 53B831C638F
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 15:45:44 +0200 (EET)
X-Mailer: git-send-email 1.6.6.199.gff4b0
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137296>

Add --namespace=<namespace> option to rev-parse and everything that
accepts its options. This option matches all refs in some subnamespace
of refs hierarchy, and is useful for selecting everything reachable from
one or few, but not all remotes (--namespace=remotes/foo).

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
Another one from my todo list. Based on master branch.

 Documentation/git-rev-list.txt     |    1 +
 Documentation/git-rev-parse.txt    |    4 ++
 Documentation/rev-list-options.txt |    6 ++
 builtin-rev-parse.c                |    6 ++
 refs.c                             |   33 +++++++++++
 refs.h                             |    9 +++
 revision.c                         |    5 ++
 t/t6018-rev-list-namespace.sh      |  103 ++++++++++++++++++++++++++++++++++++
 8 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100755 t/t6018-rev-list-namespace.sh

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 3341d1b..a8f8f22 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -24,6 +24,7 @@ SYNOPSIS
 	     [ \--branches ]
 	     [ \--tags ]
 	     [ \--remotes ]
+	     [ \--namespace=namespace-prefix ]
 	     [ \--stdin ]
 	     [ \--quiet ]
 	     [ \--topo-order ]
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 82045a2..af4605a 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -112,6 +112,10 @@ OPTIONS
 --remotes::
 	Show tag refs found in `$GIT_DIR/refs/remotes`.
 
+--namespace=namespace-prefix::
+	Show refs found in `$GIT_DIR/namespace-prefix`. If namespace
+	specified lacks leading 'refs/', it is automatically prepended.
+
 --show-prefix::
 	When the command is invoked from a subdirectory, show the
 	path of the current directory relative to the top-level
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1f57aed..c824a7b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -243,6 +243,12 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `$GIT_DIR/refs/remotes` are listed
 	on the command line as '<commit>'.
 
+--namespace=namespace-prefix::
+	Pretend as if all the refs in `$GIT_DIR/namespace-prefix` are
+	listed on the command line as '<commit>'. Leading 'refs/', it
+	is automatically prepended if missing.
+
+
 ifndef::git-rev-list[]
 --bisect::
 
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 37d0233..d7cb3c1 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -52,6 +52,7 @@ static int is_rev_argument(const char *arg)
 		"--parents",
 		"--pretty",
 		"--remotes",
+		"--namespace=",
 		"--sparse",
 		"--tags",
 		"--topo-order",
@@ -577,6 +578,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_tag_ref(show_reference, NULL);
 				continue;
 			}
+			if (!prefixcmp(arg, "--namespace=")) {
+				set_for_each_namespace(arg + 12);
+				for_each_namespace_ref(show_reference, NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--remotes")) {
 				for_each_remote_ref(show_reference, NULL);
 				continue;
diff --git a/refs.c b/refs.c
index 3e73a0a..ae3f1a4 100644
--- a/refs.c
+++ b/refs.c
@@ -7,6 +7,9 @@
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
 
+/* Current prefix namespace in use. NULL means none. */
+static char* prefix_namespace = NULL;
+
 struct ref_list {
 	struct ref_list *next;
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
@@ -674,6 +677,36 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
 }
 
+void set_for_each_namespace(const char *ref_namespace)
+{
+	size_t alloclen, origlen;
+	if (prefix_namespace)
+		free(prefix_namespace);
+
+	/* Compute the length of true prefix. */
+	origlen = alloclen = strlen(ref_namespace);
+	if (*ref_namespace && ref_namespace[origlen - 1] != '/')
+		alloclen++;
+	if (prefixcmp(ref_namespace, "refs/"))
+		alloclen += 5;		/* 'refs/' */
+
+	/* Allocate and build it (assume alloclen is "small") */
+	prefix_namespace = xmalloc(alloclen + 1);
+	*prefix_namespace = 0;
+	if (prefixcmp(ref_namespace, "refs/"))
+		strcat(prefix_namespace, "refs/");
+	strcat(prefix_namespace, ref_namespace);
+	if (*ref_namespace && ref_namespace[origlen - 1] != '/')
+		strcat(prefix_namespace, "/");
+}
+
+int for_each_namespace_ref(each_ref_fn fn, void *cb_data)
+{
+	if (!prefix_namespace)
+		die("BUG: Call set_for_each_namespace() before for_each_namespace_ref()!");
+	return for_each_ref_in(prefix_namespace, fn, cb_data);
+}
+
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref("refs/", fn, 0,
diff --git a/refs.h b/refs.h
index e141991..be493ca 100644
--- a/refs.h
+++ b/refs.h
@@ -25,6 +25,15 @@ extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
+extern int for_each_namespace_ref(each_ref_fn, void *);
+
+/*
+ * Set namespace for_each_namespace_ref() operates in. Must be called before
+ * calling that function. Autoprepends 'refs/' if it is missing. Autoappends
+ * '/' if it is missing.
+ */
+void set_for_each_namespace(const char *ref_namespace);
+
 
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
diff --git a/revision.c b/revision.c
index 25fa14d..9e1d960 100644
--- a/revision.c
+++ b/revision.c
@@ -1352,6 +1352,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_refs(revs, flags, for_each_remote_ref);
 				continue;
 			}
+			if (!prefixcmp(arg, "--namespace=")) {
+				set_for_each_namespace(arg + 12);
+				handle_refs(revs, flags, for_each_namespace_ref);
+				continue;
+			}
 			if (!strcmp(arg, "--reflog")) {
 				handle_reflog(revs, flags);
 				continue;
diff --git a/t/t6018-rev-list-namespace.sh b/t/t6018-rev-list-namespace.sh
new file mode 100755
index 0000000..f04bde1
--- /dev/null
+++ b/t/t6018-rev-list-namespace.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+
+test_description='rev-list/rev-parse --namespace'
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
+test_expect_success 'setup' '
+
+	commit master &&
+	git checkout -b subspace/one master
+	commit one &&
+	git checkout -b subspace/two master
+	commit two &&
+	git checkout -b other/three master
+	commit three &&
+	git checkout -b someref master
+	commit some &&
+	git checkout master
+	commit master2
+'
+
+test_expect_success 'rev-parse --namespace=refs/heads/subspace/' '
+
+	test 2 = $(git rev-parse --namespace=refs/heads/subspace/ | wc -l)
+
+'
+
+test_expect_success 'rev-parse --namespace=refs/heads/subspace' '
+
+	test 2 = $(git rev-parse --namespace=refs/heads/subspace | wc -l)
+
+'
+
+test_expect_success 'rev-parse --namespace=heads/subspace' '
+
+	test 2 = $(git rev-parse --namespace=heads/subspace | wc -l)
+
+'
+
+test_expect_success 'rev-parse --namespace=heads/subspace --namespace=heads/other' '
+
+	test 3 = $(git rev-parse --namespace=heads/subspace --namespace=heads/other | wc -l)
+
+'
+
+test_expect_success 'rev-parse --namespace=heads/someref master' '
+
+	test 1 = $(git rev-parse --namespace=heads/someref master | wc -l)
+
+'
+
+test_expect_success 'rev-parse --namespace=heads' '
+
+	test 4 = $(git rev-parse --namespace=heads | wc -l)
+
+'
+
+test_expect_success 'rev-list --namespace=refs/heads/subspace/' '
+
+	test 3 = $(git rev-list --namespace=refs/heads/subspace/ | wc -l)
+
+'
+
+test_expect_success 'rev-list --namespace=refs/heads/subspace' '
+
+	test 3 = $(git rev-list --namespace=refs/heads/subspace | wc -l)
+
+'
+
+test_expect_success 'rev-list --namespace=heads/subspace' '
+
+	test 3 = $(git rev-list --namespace=heads/subspace | wc -l)
+
+'
+
+test_expect_success 'rev-list --namespace=heads/someref master' '
+
+	test 2 = $(git rev-list --namespace=heads/someref master | wc -l)
+
+'
+
+test_expect_success 'rev-list --namespace=heads/subspace --namespace=heads/other' '
+
+	test 4 = $(git rev-list --namespace=heads/subspace --namespace=heads/other | wc -l)
+
+'
+
+test_expect_success 'rev-list --namespace=heads' '
+
+	test 5 = $(git rev-list --namespace=heads | wc -l)
+
+'
+
+
+test_done
-- 
1.6.6.199.gff4b0
