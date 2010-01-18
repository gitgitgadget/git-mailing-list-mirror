From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH v2] rev-parse --namespace
Date: Mon, 18 Jan 2010 09:15:52 +0200
Message-ID: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 08:16:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWlqI-0008Nf-F5
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 08:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab0ARHP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 02:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633Ab0ARHP5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 02:15:57 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:52107 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab0ARHP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 02:15:56 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id CF00BEF61D
	for <git@vger.kernel.org>; Mon, 18 Jan 2010 09:15:54 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01052C0F8E; Mon, 18 Jan 2010 09:15:54 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 8A301E51B2
	for <git@vger.kernel.org>; Mon, 18 Jan 2010 09:15:53 +0200 (EET)
X-Mailer: git-send-email 1.6.6.199.gff4b0
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137374>

Add --namespace=<namespace> option to rev-parse and everything that
accepts its options. This option matches all refs in some subnamespace
of refs hierarchy.

Example:

'git log --branches --not --namespace=remotes/origin'

To show what you have that origin doesn't.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
Changes from v1:
- Get rid of global variable for namespace.
- Use strbuf API to build the namespace
- Test rev-list/rev-parse outputs up to permutation, not just line
  count.
- Add example to commit message and to git log manual page.

I left renaming the option (more opinions on that?) and changing the
description in manpage (the other similar entries should be fixed too
then) for later iteration (if these are to be done).

 Documentation/git-rev-list.txt     |    1 +
 Documentation/git-rev-parse.txt    |    4 +
 Documentation/rev-list-options.txt |    6 ++
 builtin-rev-parse.c                |    8 +++
 refs.c                             |   18 ++++++
 refs.h                             |   13 ++++
 revision.c                         |   20 ++++++-
 t/t6018-rev-list-namespace.sh      |  112 ++++++++++++++++++++++++++++++++++++
 8 files changed, 180 insertions(+), 2 deletions(-)
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
index 37d0233..255191d 100644
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
@@ -577,6 +578,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_tag_ref(show_reference, NULL);
 				continue;
 			}
+			if (!prefixcmp(arg, "--namespace=")) {
+				struct for_each_namespace_request req;
+				req.req_namespace = arg + 12;
+				req.req_opaque = NULL;
+				for_each_namespace_ref(show_reference, &req);
+				continue;
+			}
 			if (!strcmp(arg, "--remotes")) {
 				for_each_remote_ref(show_reference, NULL);
 				continue;
diff --git a/refs.c b/refs.c
index 3e73a0a..c7162d1 100644
--- a/refs.c
+++ b/refs.c
@@ -7,6 +7,7 @@
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
 
+/* Current prefix namespace in use. NULL means none. */
 struct ref_list {
 	struct ref_list *next;
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
@@ -674,6 +675,23 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
 }
 
+int for_each_namespace_ref(each_ref_fn fn, void *cb_data)
+{
+	struct for_each_namespace_request *req = cb_data;
+	struct strbuf real_prefix = STRBUF_INIT;
+	int ret;
+
+	if (prefixcmp(req->req_namespace, "refs/"))
+		strbuf_addstr(&real_prefix, "refs/");
+	strbuf_addstr(&real_prefix, req->req_namespace);
+	if (real_prefix.buf[real_prefix.len - 1] != '/')
+		strbuf_addch(&real_prefix, '/');
+
+	ret = for_each_ref_in(real_prefix.buf, fn, req->req_opaque);
+	strbuf_release(&real_prefix);
+	return ret;
+}
+
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref("refs/", fn, 0,
diff --git a/refs.h b/refs.h
index e141991..4bb63b0 100644
--- a/refs.h
+++ b/refs.h
@@ -13,6 +13,18 @@ struct ref_lock {
 #define REF_ISSYMREF 01
 #define REF_ISPACKED 02
 
+/* Opaque request for for_each_namespace_ref */
+struct for_each_namespace_request
+{
+	/*
+	 * The limiting namespace. 'refs/' and '/' are autoprepended /
+	 * autoappended if missing.
+	 */
+	const char *req_namespace;
+	/* The real opaque data for callback function. */
+	void *req_opaque;
+};
+
 /*
  * Calls the specified function for each ref file until it returns nonzero,
  * and returns the value
@@ -25,6 +37,7 @@ extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
+extern int for_each_namespace_ref(each_ref_fn, void *);
 
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
diff --git a/revision.c b/revision.c
index 25fa14d..ff9484f 100644
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
 
@@ -1352,6 +1358,16 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_refs(revs, flags, for_each_remote_ref);
 				continue;
 			}
+			if (!prefixcmp(arg, "--namespace=")) {
+				struct for_each_namespace_request req;
+				struct all_refs_cb cb;
+
+				init_all_refs_cb(&cb, revs, flags);
+				req.req_namespace = arg + 12;
+				req.req_opaque = &cb;
+				for_each_namespace_ref(handle_one_ref, &req);
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
