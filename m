From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v3] rev-parse --namespace
Date: Mon, 18 Jan 2010 11:51:36 +0200
Message-ID: <1263808296-30756-1-git-send-email-ilari.liusvaara@elisanet.fi>
References: <7vk4vfsv64.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 10:51:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWoH0-0006UR-8q
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 10:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab0ARJvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 04:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470Ab0ARJvp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 04:51:45 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:57197 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab0ARJvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 04:51:42 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 91E1118D55E;
	Mon, 18 Jan 2010 11:51:40 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A03D5054767; Mon, 18 Jan 2010 11:51:40 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 230BF41BE5;
	Mon, 18 Jan 2010 11:51:37 +0200 (EET)
X-Mailer: git-send-email 1.6.6.199.gff4b0
In-Reply-To: <7vk4vfsv64.fsf@alter.siamese.dyndns.org>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137379>

Add --namespace=<namespace> option to rev-parse and everything that
accepts its options. This option matches all refs in some subnamespace
of refs hierarchy.

Example:

'git log --branches --not --namespace=remotes/origin'

To show what you have that origin doesn't.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
Changes from v2:
- Actually include updated git log examples (oops).
- Get rid of for_each_namespace_request, use parameters instead.
- Get rid of extraneous comment.

 Documentation/git-log.txt          |    6 ++
 Documentation/git-rev-list.txt     |    1 +
 Documentation/git-rev-parse.txt    |    4 +
 Documentation/rev-list-options.txt |    6 ++
 builtin-rev-parse.c                |    5 ++
 refs.c                             |   16 +++++
 refs.h                             |    1 +
 revision.c                         |   16 +++++-
 t/t6018-rev-list-namespace.sh      |  112 ++++++++++++++++++++++++++++++++++++
 9 files changed, 165 insertions(+), 2 deletions(-)
 create mode 100755 t/t6018-rev-list-namespace.sh

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 3d79de1..d84660c 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -107,6 +107,12 @@ git log --follow builtin-rev-list.c::
 	those commits that occurred before the file was given its
 	present name.
 
+git log --branches --not --namespace=remotes/origin::
+
+	Shows all commits that are in any of local branches but not in
+	any of remote tracking branches for 'origin' (what you have that
+	origin doesn't).
+
 Discussion
 ----------
 
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
index 37d0233..34af347 100644
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
@@ -577,6 +578,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_tag_ref(show_reference, NULL);
 				continue;
 			}
+			if (!prefixcmp(arg, "--namespace=")) {
+				for_each_namespace_ref(show_reference, arg + 12, NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--remotes")) {
 				for_each_remote_ref(show_reference, NULL);
 				continue;
diff --git a/refs.c b/refs.c
index 3e73a0a..5583f4b 100644
--- a/refs.c
+++ b/refs.c
@@ -674,6 +674,22 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
 }
 
+int for_each_namespace_ref(each_ref_fn fn, const char *ns_name, void *cb_data)
+{
+	struct strbuf real_prefix = STRBUF_INIT;
+	int ret;
+
+	if (prefixcmp(ns_name, "refs/"))
+		strbuf_addstr(&real_prefix, "refs/");
+	strbuf_addstr(&real_prefix, ns_name);
+	if (real_prefix.buf[real_prefix.len - 1] != '/')
+		strbuf_addch(&real_prefix, '/');
+
+	ret = for_each_ref_in(real_prefix.buf, fn, cb_data);
+	strbuf_release(&real_prefix);
+	return ret;
+}
+
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref("refs/", fn, 0,
diff --git a/refs.h b/refs.h
index e141991..b26c3a8 100644
--- a/refs.h
+++ b/refs.h
@@ -25,6 +25,7 @@ extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
+extern int for_each_namespace_ref(each_ref_fn, const char* ns_name, void *);
 
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
diff --git a/revision.c b/revision.c
index 25fa14d..7328201 100644
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
+			if (!prefixcmp(arg, "--namespace=")) {
+				struct all_refs_cb cb;
+				init_all_refs_cb(&cb, revs, flags);
+				for_each_namespace_ref(handle_one_ref, arg + 12, &cb);
+				continue;
+			}
 			if (!strcmp(arg, "--reflog")) {
 				handle_reflog(revs, flags);
 				continue;
diff --git a/t/t6018-rev-list-namespace.sh b/t/t6018-rev-list-namespace.sh
new file mode 100755
index 0000000..6bb562a
--- /dev/null
+++ b/t/t6018-rev-list-namespace.sh
@@ -0,0 +1,112 @@
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
+compare () {
+	# Split arguments on whitespace.
+	git $1 $2 | sort >expected &&
+	git $1 $3 | sort >actual &&
+	cmp expected actual
+}
+
+test_expect_success 'setup' '
+
+	commit master &&
+	git checkout -b subspace/one master
+	commit one &&
+	git checkout -b subspace/two master
+	commit two &&
+	git checkout -b subspace-x master
+	commit subspace-x &&
+	git checkout -b other/three master
+	commit three &&
+	git checkout -b someref master
+	commit some &&
+	git checkout master &&
+	commit master2
+'
+
+test_expect_success 'rev-parse --namespace=refs/heads/subspace/' '
+
+	compare rev-parse "subspace/one subspace/two" "--namespace=refs/heads/subspace/"
+
+'
+
+test_expect_success 'rev-parse --namespace=refs/heads/subspace' '
+
+	compare rev-parse "subspace/one subspace/two" "--namespace=refs/heads/subspace"
+
+'
+
+test_expect_success 'rev-parse --namespace=heads/subspace' '
+
+	compare rev-parse "subspace/one subspace/two" "--namespace=heads/subspace"
+
+'
+
+test_expect_success 'rev-parse --namespace=heads/subspace --namespace=heads/other' '
+
+	compare rev-parse "subspace/one subspace/two other/three" "--namespace=heads/subspace --namespace=heads/other"
+
+'
+
+test_expect_success 'rev-parse --namespace=heads/someref master' '
+
+	compare rev-parse "master" "--namespace=heads/someref master"
+
+'
+
+test_expect_success 'rev-parse --namespace=heads' '
+
+	compare rev-parse "subspace/one subspace/two other/three subspace-x master someref" "--namespace=heads"
+
+'
+
+test_expect_success 'rev-list --namespace=refs/heads/subspace/' '
+
+	compare rev-list "subspace/one subspace/two" "--namespace=refs/heads/subspace/"
+
+'
+
+test_expect_success 'rev-list --namespace=refs/heads/subspace' '
+
+	compare rev-list "subspace/one subspace/two" "--namespace=refs/heads/subspace"
+
+'
+
+test_expect_success 'rev-list --namespace=heads/subspace' '
+
+	compare rev-list "subspace/one subspace/two" "--namespace=heads/subspace"
+
+'
+
+test_expect_success 'rev-list --namespace=heads/someref master' '
+
+	compare rev-parse "master" "--namespace=heads/someref master"
+
+'
+
+test_expect_success 'rev-list --namespace=heads/subspace --namespace=heads/other' '
+
+	compare rev-parse "subspace/one subspace/two other/three" "--namespace=heads/subspace --namespace=heads/other"
+
+'
+
+test_expect_success 'rev-list --namespace=heads' '
+
+	compare rev-parse "subspace/one subspace/two other/three subspace-x master someref" "--namespace=heads"
+
+'
+
+
+test_done
-- 
1.6.6.199.gff4b0
