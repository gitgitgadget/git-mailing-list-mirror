Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3991F404
	for <e@80x24.org>; Wed, 29 Aug 2018 20:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeH3AEZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 20:04:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727605AbeH3AEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 20:04:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CF8740241C0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 20:05:56 +0000 (UTC)
Received: from max.home.com (ovpn-117-188.ams2.redhat.com [10.36.117.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58BB62166B41;
        Wed, 29 Aug 2018 20:05:55 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     git@vger.kernel.org
Cc:     rpeterso@redhat.com, Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC] revision: Don't let ^<rev> cancel out the default <rev>
Date:   Wed, 29 Aug 2018 22:05:53 +0200
Message-Id: <20180829200553.19379-1-agruenba@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 29 Aug 2018 20:05:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 29 Aug 2018 20:05:56 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'agruenba@redhat.com' RCPT:''
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some commands like 'log' default to HEAD if no other revisions are
specified on the command line or otherwise.  Unfortunately, excludes
(^<rev>) cancel out that default, so when a command only excludes
revisions (e.g., 'git log ^origin/master'), the command will not produce
any result.

If all the specified revisions are excludes, it seems more useful to
stick with the default revision instead.

This makes writing wrappers that exclude certain revisions much easier:
for example, a simple alias l='git log ^origin/master' will show the
revisions between origin/master and HEAD by default, and 'l foo' will
show the revisions between origin/master and foo, as you would usually
expect.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 revision.c     | 18 ++++++++++++++----
 t/t4202-log.sh |  6 ++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index de4dce600..c2c51bd5d 100644
--- a/revision.c
+++ b/revision.c
@@ -1158,6 +1158,18 @@ static void add_rev_cmdline(struct rev_info *revs,
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
@@ -2318,7 +2330,7 @@ static void NORETURN diagnose_missing_default(const char *def)
  */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *opt)
 {
-	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0, revarg_opt;
+	int i, flags, left, seen_dashdash, read_from_stdin, revarg_opt;
 	struct argv_array prune_data = ARGV_ARRAY_INIT;
 	const char *submodule = NULL;
 
@@ -2401,8 +2413,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			argv_array_pushv(&prune_data, argv + i);
 			break;
 		}
-		else
-			got_rev_arg = 1;
 	}
 
 	if (prune_data.argc) {
@@ -2431,7 +2441,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		opt->tweak(revs, opt);
 	if (revs->show_merge)
 		prepare_show_merge(revs);
-	if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
+	if (revs->def && !revs->rev_input_given && !has_interesting_revisions(revs)) {
 		struct object_id oid;
 		struct object *object;
 		struct object_context oc;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 153a50615..e6670859c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -213,6 +213,12 @@ test_expect_success 'git show <commits> leaves list of commits as given' '
 	test_cmp expect actual
 '
 
+printf "sixth\nfifth\n" > expect
+test_expect_success '^<rev>' '
+	git log --pretty="tformat:%s" ^HEAD~2 > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup case sensitivity tests' '
 	echo case >one &&
 	test_tick &&
-- 
2.17.1

