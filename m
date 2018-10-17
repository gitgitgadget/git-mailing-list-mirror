Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853AA1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 13:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeJQVpk (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 17:45:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJQVpk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 17:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADCD47F41A;
        Wed, 17 Oct 2018 13:49:52 +0000 (UTC)
Received: from max.home.com (ovpn-116-82.ams2.redhat.com [10.36.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2B4E7FCA3;
        Wed, 17 Oct 2018 13:49:49 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     git@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, rpeterso@redhat.com,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [RFC v2] revision: Add --sticky-default option
Date:   Wed, 17 Oct 2018 15:49:47 +0200
Message-Id: <20181017134947.12571-1-agruenba@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 17 Oct 2018 13:49:52 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some commands like 'log' default to HEAD if no other revisions are
specified on the command line or otherwise.  Currently, excludes
(^<rev>) cancel out that default, so when a command only excludes
revisions (e.g., 'git log ^origin/master'), it will produce no output.

With the --sticky-default option, the default becomes more "sticky" and
is no longer canceled out by excludes.

This is useful in wrappers that exclude certain revisions: for example,
a simple alias l='git log --sticky-default ^origin/master' will show the
revisions between origin/master and HEAD when invoked without arguments,
and 'l foo' will show the revisions between origin/master and foo.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 Documentation/rev-list-options.txt | 10 ++++++++++
 revision.c                         | 21 ++++++++++++++++++++-
 revision.h                         |  1 +
 t/t4202-log.sh                     |  6 ++++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7b273635d..46fab2b42 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -210,6 +210,16 @@ endif::git-rev-list[]
 	seen, stop reading commits and start reading paths to limit the
 	result.
 
+--default=<rev>::
+	Instead of `HEAD`, use '<rev>' when no revisions are specified.
+
+--sticky-default:
+	By default, excludes ('^<rev>') override the default revision (i.e.
+	`HEAD` or the revision specified with `--default`).  This option causes
+	excludes to no longer override the default revision, so commands like
+	`git log --sticky-default ^origin/master` will continue to operate on
+	the default revision as long as no other revisions are specified.
+
 ifdef::git-rev-list[]
 --quiet::
 	Don't print anything to standard output.  This form
diff --git a/revision.c b/revision.c
index e18bd530e..e61f28b92 100644
--- a/revision.c
+++ b/revision.c
@@ -1159,6 +1159,18 @@ static void add_rev_cmdline(struct rev_info *revs,
 	info->nr++;
 }
 
+static int has_interesting_revisions(struct rev_info *revs)
+{
+	struct rev_cmdline_info *info = &revs->cmdline;
+	unsigned int n;
+
+	for (n = 0; n < info->nr; n++) {
+		if (!(info->rev[n].flags & UNINTERESTING))
+			return 1;
+	}
+	return 0;
+}
+
 static void add_rev_cmdline_list(struct rev_info *revs,
 				 struct commit_list *commit_list,
 				 int whence,
@@ -2132,6 +2144,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--children")) {
 		revs->children.name = "children";
 		revs->limited = 1;
+	} else if (!strcmp(arg, "--sticky-default")) {
+		revs->sticky_default = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
 	} else if (!strcmp(arg, "--exclude-promisor-objects")) {
@@ -2320,6 +2334,7 @@ static void NORETURN diagnose_missing_default(const char *def)
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *opt)
 {
 	int i, flags, left, seen_dashdash, got_rev_arg = 0, revarg_opt;
+	int cancel_default;
 	struct argv_array prune_data = ARGV_ARRAY_INIT;
 	const char *submodule = NULL;
 
@@ -2431,7 +2446,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		opt->tweak(revs, opt);
 	if (revs->show_merge)
 		prepare_show_merge(revs);
-	if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
+	if (revs->sticky_default)
+		cancel_default = has_interesting_revisions();
+	else
+		cancel_default = got_rev_arg;
+	if (revs->def && !revs->rev_input_given && !cancel_default) {
 		struct object_id oid;
 		struct object *object;
 		struct object_context oc;
diff --git a/revision.h b/revision.h
index 2b30ac270..6498ba263 100644
--- a/revision.h
+++ b/revision.h
@@ -73,6 +73,7 @@ struct rev_info {
 	/* Basic information */
 	const char *prefix;
 	const char *def;
+	unsigned int sticky_default:1;
 	struct pathspec prune_data;
 
 	/*
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 153a50615..5ac93f5ec 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -213,6 +213,12 @@ test_expect_success 'git show <commits> leaves list of commits as given' '
 	test_cmp expect actual
 '
 
+test_expect_success '--sticky-default ^<rev>' '
+	test_write_lines sixth fifth > expect &&
+	git log --pretty="tformat:%s" --sticky-default ^HEAD~2 > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup case sensitivity tests' '
 	echo case >one &&
 	test_tick &&
-- 
2.17.2

