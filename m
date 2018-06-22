Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E25E1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 09:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeFVJZC (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 05:25:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:51796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751258AbeFVJZB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 05:25:01 -0400
Received: (qmail 3924 invoked by uid 109); 22 Jun 2018 09:25:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Jun 2018 09:25:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16702 invoked by uid 111); 22 Jun 2018 09:25:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Jun 2018 05:25:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jun 2018 05:24:59 -0400
Date:   Fri, 22 Jun 2018 05:24:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 4/4] branch: make "-l" a synonym for "--list"
Message-ID: <20180622092459.GD13573@sigill.intra.peff.net>
References: <20180622092327.GA8361@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622092327.GA8361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The other "mode" options of git-branch have short-option
aliases that are easy to type (e.g., "-d" and "-m"). Let's
give "--list" the same treatment.

This also makes it consistent with the similar "git tag -l"
option.

We didn't do this originally because "--create-reflog" was
squatting on the "-l" option. Now that we've deprecated that
use for long enough, we can make the switch.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is mostly a squash of the remove/reincarnate steps from the
previous iteration. I also noticed that my original forgot to update the
documentation, which this patch does.

 Documentation/git-branch.txt |  3 +--
 builtin/branch.c             | 22 +---------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1072ca0eb6..fc88e984e1 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -100,8 +100,6 @@ OPTIONS
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
 	`core.logAllRefUpdates`.
-+
-The `-l` option is a deprecated synonym for `--create-reflog`.
 
 -f::
 --force::
@@ -156,6 +154,7 @@ This option is only applicable in non-verbose mode.
 --all::
 	List both remote-tracking branches and local branches.
 
+-l::
 --list::
 	List branches.  With optional `<pattern>...`, e.g. `git
 	branch --list 'maint-*'`, list only the branches that match
diff --git a/builtin/branch.c b/builtin/branch.c
index ed4c093747..c1662e3db3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -36,7 +36,6 @@ static const char * const builtin_branch_usage[] = {
 
 static const char *head;
 static struct object_id head_oid;
-static int used_deprecated_reflog_option;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -574,14 +573,6 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
-static int deprecated_reflog_option_cb(const struct option *opt,
-				       const char *arg, int unset)
-{
-	used_deprecated_reflog_option = 1;
-	*(int *)opt->value = !unset;
-	return 0;
-}
-
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
@@ -623,14 +614,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
-		OPT_BOOL(0, "list", &list, N_("list branch names")),
+		OPT_BOOL('l', "list", &list, N_("list branch names")),
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
-		{
-			OPTION_CALLBACK, 'l', NULL, &reflog, NULL,
-			N_("deprecated synonym for --create-reflog"),
-			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
-			deprecated_reflog_option_cb
-		},
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
@@ -703,11 +688,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (list)
 		setup_auto_pager("branch", 1);
 
-	if (used_deprecated_reflog_option && !list) {
-		warning("the '-l' alias for '--create-reflog' is deprecated;");
-		warning("it will be removed in a future version of Git");
-	}
-
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-- 
2.18.0.539.gcf23d6d4f1
