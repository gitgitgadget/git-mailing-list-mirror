Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5E81F461
	for <e@80x24.org>; Fri, 28 Jun 2019 10:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfF1KLe (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 06:11:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:53796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726519AbfF1KLe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 06:11:34 -0400
Received: (qmail 14556 invoked by uid 109); 28 Jun 2019 10:11:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 10:11:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16421 invoked by uid 111); 28 Jun 2019 10:12:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 06:12:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 06:11:31 -0400
Date:   Fri, 28 Jun 2019 06:11:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] check_everything_connected: assume alternate ref tips are
 valid
Message-ID: <20190628101131.GA22862@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we receive a remote ref update to sha1 "X", we want to check that
we have all of the objects needed by "X". We can assume that our
repository is not currently corrupted, and therefore if we have a ref
pointing at "Y", we have all of its objects. So we can stop our
traversal from "X" as soon as we hit "Y".

If we make the same non-corruption assumption about any repositories we
use to store alternates, then we can also use their ref tips to shorten
the traversal.

This is especially useful when cloning with "--reference", as we
otherwise do not have any local refs to check against, and have to
traverse the whole history, even though the other side may have sent us
few or no objects. Here are results for the included perf test (which
shows off more or less the maximal savings, getting one new commit and
sharing the whole history):

Test                        HEAD^             HEAD
--------------------------------------------------------------------
[on git.git]
5600.3: clone --reference   2.94(2.86+0.08)   0.09(0.08+0.01) -96.9%
[on linux.git]
5600.3: clone --reference   45.74(45.34+0.41)   0.36(0.30+0.08) -99.2%

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt |  8 ++++
 connected.c                        |  1 +
 revision.c                         | 30 +++++++++++++++
 t/perf/p5600-clone-reference.sh    | 27 ++++++++++++++
 t/t5618-alternate-refs.sh          | 60 ++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+)
 create mode 100755 t/perf/p5600-clone-reference.sh
 create mode 100755 t/t5618-alternate-refs.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 71a1fcc093..90a2c027ea 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -182,6 +182,14 @@ explicitly.
 	Pretend as if all objects mentioned by reflogs are listed on the
 	command line as `<commit>`.
 
+--alternate-refs::
+	Pretend as if all objects mentioned as ref tips of alternate
+	repositories were listed on the command line. An alternate
+	repository is any repository whose object directory is specified
+	in `objects/info/alternates`.  The set of included objects may
+	be modified by `core.alternateRefsCommand`, etc. See
+	linkgit:git-config[1].
+
 --single-worktree::
 	By default, all working trees will be examined by the
 	following options when there are more than one (see
diff --git a/connected.c b/connected.c
index 1ab481fed6..cd9b324afa 100644
--- a/connected.c
+++ b/connected.c
@@ -80,6 +80,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		argv_array_push(&rev_list.args, "--all");
 	}
 	argv_array_push(&rev_list.args, "--quiet");
+	argv_array_push(&rev_list.args, "--alternate-refs");
 	if (opt->progress)
 		argv_array_pushf(&rev_list.args, "--progress=%s",
 				 _("Checking connectivity"));
diff --git a/revision.c b/revision.c
index 621feb9df7..b9be08e9df 100644
--- a/revision.c
+++ b/revision.c
@@ -28,6 +28,7 @@
 #include "commit-graph.h"
 #include "prio-queue.h"
 #include "hashmap.h"
+#include "transport.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1554,6 +1555,32 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	free_worktrees(worktrees);
 }
 
+struct add_alternate_refs_data {
+	struct rev_info *revs;
+	unsigned int flags;
+};
+
+static void add_one_alternate_ref(const struct object_id *oid,
+				  void *vdata)
+{
+	const char *name = ".alternate";
+	struct add_alternate_refs_data *data = vdata;
+	struct object *obj;
+
+	obj = get_reference(data->revs, name, oid, data->flags);
+	add_rev_cmdline(data->revs, obj, name, REV_CMD_REV, data->flags);
+	add_pending_object(data->revs, obj, name);
+}
+
+static void add_alternate_refs_to_pending(struct rev_info *revs,
+					  unsigned int flags)
+{
+	struct add_alternate_refs_data data;
+	data.revs = revs;
+	data.flags = flags;
+	for_each_alternate_ref(add_one_alternate_ref, &data);
+}
+
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 			    int exclude_parent)
 {
@@ -1956,6 +1983,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk") ||
 	    !strcmp(arg, "--bisect") || starts_with(arg, "--glob=") ||
 	    !strcmp(arg, "--indexed-objects") ||
+	    !strcmp(arg, "--alternate-refs") ||
 	    starts_with(arg, "--exclude=") ||
 	    starts_with(arg, "--branches=") || starts_with(arg, "--tags=") ||
 	    starts_with(arg, "--remotes=") || starts_with(arg, "--no-walk="))
@@ -2442,6 +2470,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
 		add_index_objects_to_pending(revs, *flags);
+	} else if (!strcmp(arg, "--alternate-refs")) {
+		add_alternate_refs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^= UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
diff --git a/t/perf/p5600-clone-reference.sh b/t/perf/p5600-clone-reference.sh
new file mode 100755
index 0000000000..68fed66347
--- /dev/null
+++ b/t/perf/p5600-clone-reference.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='speed of clone --reference'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'create shareable repository' '
+	git clone --bare . shared.git
+'
+
+test_expect_success 'advance base repository' '
+	# Do not use test_commit here; its test_tick will
+	# use some ancient hard-coded date. The resulting clock
+	# skew will cause pack-objects to traverse in a very
+	# sub-optimal order, skewing the results.
+	echo content >new-file-that-does-not-exist &&
+	git add new-file-that-does-not-exist &&
+	git commit -m "new commit"
+'
+
+test_perf 'clone --reference' '
+	rm -rf dst.git &&
+	git clone --no-local --bare --reference shared.git . dst.git
+'
+
+test_done
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
new file mode 100755
index 0000000000..3353216f09
--- /dev/null
+++ b/t/t5618-alternate-refs.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='test handling of --alternate-refs traversal'
+. ./test-lib.sh
+
+# Avoid test_commit because we want a specific and known set of refs:
+#
+#  base -- one
+#      \      \
+#       two -- merged
+#
+# where "one" and "two" are on separate refs, and "merged" is available only in
+# the dependent child repository.
+test_expect_success 'set up local refs' '
+	git checkout -b one &&
+	test_tick &&
+	git commit --allow-empty -m base &&
+	test_tick &&
+	git commit --allow-empty -m one &&
+	git checkout -b two HEAD^ &&
+	test_tick &&
+	git commit --allow-empty -m two
+'
+
+# We'll enter the child repository after it's set up since that's where
+# all of the subsequent tests will want to run (and it's easy to forget a
+# "-C child" and get nonsense results).
+test_expect_success 'set up shared clone' '
+	git clone -s . child &&
+	cd child &&
+	git merge origin/one
+'
+
+test_expect_success 'rev-list --alternate-refs' '
+	git rev-list --remotes=origin >expect &&
+	git rev-list --alternate-refs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --not --alternate-refs' '
+	git rev-parse HEAD >expect &&
+	git rev-list HEAD --not --alternate-refs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'limiting with alternateRefsPrefixes' '
+	test_config core.alternateRefsPrefixes refs/heads/one &&
+	git rev-list origin/one >expect &&
+	git rev-list --alternate-refs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --source shows .alternate marker' '
+	git log --oneline --source --remotes=origin >expect.orig &&
+	sed "s/origin.* /.alternate /" <expect.orig >expect &&
+	git log --oneline --source --alternate-refs >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.22.0.775.g4ba9815492
