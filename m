Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C601F453
	for <e@80x24.org>; Tue, 16 Oct 2018 21:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJQFRA (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 01:17:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbeJQFRA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 01:17:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85A0130832CA;
        Tue, 16 Oct 2018 21:24:42 +0000 (UTC)
Received: from max.home.com (ovpn-116-82.ams2.redhat.com [10.36.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0967019480;
        Tue, 16 Oct 2018 21:24:40 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     git@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, rpeterso@redhat.com,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [RFC] revision: Add --sticky-default option
Date:   Tue, 16 Oct 2018 23:24:38 +0200
Message-Id: <20181016212438.30176-1-agruenba@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 16 Oct 2018 21:24:42 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

here's a long-overdue update of my proposal from August 29:

  [RFC] revision: Don't let ^<rev> cancel out the default <rev>

Does this look more acceptable that my first shot?

Thanks,
Andreas

--

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
 revision.c     | 31 +++++++++++++++++++++++++++----
 revision.h     |  1 +
 t/t4202-log.sh |  6 ++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index e18bd530e..6c93ec74b 100644
--- a/revision.c
+++ b/revision.c
@@ -1159,6 +1159,25 @@ static void add_rev_cmdline(struct rev_info *revs,
 	info->nr++;
 }
 
+static int has_revisions(struct rev_info *revs)
+{
+	struct rev_cmdline_info *info = &revs->cmdline;
+
+	return info->nr != 0;
+}
+
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
@@ -2132,6 +2151,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--children")) {
 		revs->children.name = "children";
 		revs->limited = 1;
+	} else if (!strcmp(arg, "--sticky-default")) {
+		revs->sticky_default = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
 	} else if (!strcmp(arg, "--exclude-promisor-objects")) {
@@ -2319,7 +2340,8 @@ static void NORETURN diagnose_missing_default(const char *def)
  */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *opt)
 {
-	int i, flags, left, seen_dashdash, got_rev_arg = 0, revarg_opt;
+	int i, flags, left, seen_dashdash, revarg_opt;
+	int cancel_default;
 	struct argv_array prune_data = ARGV_ARRAY_INIT;
 	const char *submodule = NULL;
 
@@ -2401,8 +2423,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			argv_array_pushv(&prune_data, argv + i);
 			break;
 		}
-		else
-			got_rev_arg = 1;
 	}
 
 	if (prune_data.argc) {
@@ -2431,7 +2451,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		opt->tweak(revs, opt);
 	if (revs->show_merge)
 		prepare_show_merge(revs);
-	if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
+	cancel_default = revs->sticky_default ?
+			 has_interesting_revisions(revs) :
+			 has_revisions(revs);
+	if (revs->def && !revs->rev_input_given && !cancel_default) {
 		struct object_id oid;
 		struct object *object;
 		struct object_context oc;
diff --git a/revision.h b/revision.h
index 2b30ac270..570fa1a6d 100644
--- a/revision.h
+++ b/revision.h
@@ -92,6 +92,7 @@ struct rev_info {
 
 	unsigned int early_output;
 
+	unsigned int	sticky_default:1;
 	unsigned int	ignore_missing:1,
 			ignore_missing_links:1;
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 153a50615..9517a65da 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -213,6 +213,12 @@ test_expect_success 'git show <commits> leaves list of commits as given' '
 	test_cmp expect actual
 '
 
+printf "sixth\nfifth\n" > expect
+test_expect_success '--sticky-default ^<rev>' '
+	git log --pretty="tformat:%s" --sticky-default ^HEAD~2 > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup case sensitivity tests' '
 	echo case >one &&
 	test_tick &&
-- 
2.17.2

