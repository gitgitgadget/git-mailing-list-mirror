Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07621F516
	for <e@80x24.org>; Fri, 22 Jun 2018 09:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbeFVJYR (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 05:24:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:51784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751285AbeFVJYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 05:24:16 -0400
Received: (qmail 3904 invoked by uid 109); 22 Jun 2018 09:24:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Jun 2018 09:24:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16683 invoked by uid 111); 22 Jun 2018 09:24:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Jun 2018 05:24:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jun 2018 05:24:14 -0400
Date:   Fri, 22 Jun 2018 05:24:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 3/4] branch: deprecate "-l" option
Message-ID: <20180622092414.GC13573@sigill.intra.peff.net>
References: <20180622092327.GA8361@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622092327.GA8361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "-l" option is short for "--create-reflog". This has
caused much confusion over the years. Most people expect it
to work as "--list", because that would match the other
"mode" options like -d/--delete and -m/--move, as well as
the similar -l/--list option of git-tag.

Adding to the confusion, using "-l" _appears_ to work as
"--list" in some cases:

  $ git branch -l
  * master

because the branch command defaults to listing (so even
trying to specify --list in the command above is redundant).
But that may bite the user later when they add a pattern,
like:

  $ git branch -l foo

which does not return an empty list, but in fact creates a
new branch (with a reflog, naturally) called "foo".

It's also probably quite uncommon for people to actually use
"-l" to create a reflog. Since 0bee591869 (Enable reflogs by
default in any repository with a working directory.,
2006-12-14), this is the default in non-bare repositories.
So it's rather unfortunate that the feature squats on the
short-and-sweet "-l" (which was only added in 3a4b3f269c
(Create/delete branch ref logs., 2006-05-19), meaning there
were only 7 months where it was actually useful).

Let's deprecate "-l" in hopes of eventually re-purposing it
to "--list".

Note that we issue the warning only when we're not in list
mode. This means that people for whom it works as a happy
accident, namely:

  $ git branch -l
  master

won't see the warning at all. And when we eventually switch
to it meaning "--list", that will just continue to work.

We do the issue the warning for these important cases:

  - when we are actually creating a branch, in case the user
    really did mean it as "--create-reflog"

  - when we are in some _other_ mode, like deletion. There
    the "-l" is a noop for now, but it will eventually
    conflict with any other mode request, and the user
    should be told that this is changing.

Signed-off-by: Jeff King <peff@peff.net>
---
This one has the interesting changes in this re-roll.

 Documentation/git-branch.txt |  3 ++-
 builtin/branch.c             | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 02eccbb931..1072ca0eb6 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -91,7 +91,6 @@ OPTIONS
 -D::
 	Shortcut for `--delete --force`.
 
--l::
 --create-reflog::
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
@@ -101,6 +100,8 @@ OPTIONS
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
 	`core.logAllRefUpdates`.
++
+The `-l` option is a deprecated synonym for `--create-reflog`.
 
 -f::
 --force::
diff --git a/builtin/branch.c b/builtin/branch.c
index 5217ba3bde..ed4c093747 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -36,6 +36,7 @@ static const char * const builtin_branch_usage[] = {
 
 static const char *head;
 static struct object_id head_oid;
+static int used_deprecated_reflog_option;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -573,6 +574,14 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
+static int deprecated_reflog_option_cb(const struct option *opt,
+				       const char *arg, int unset)
+{
+	used_deprecated_reflog_option = 1;
+	*(int *)opt->value = !unset;
+	return 0;
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
@@ -615,7 +624,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL(0, "list", &list, N_("list branch names")),
-		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
+		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
+		{
+			OPTION_CALLBACK, 'l', NULL, &reflog, NULL,
+			N_("deprecated synonym for --create-reflog"),
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
+			deprecated_reflog_option_cb
+		},
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
@@ -688,6 +703,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (list)
 		setup_auto_pager("branch", 1);
 
+	if (used_deprecated_reflog_option && !list) {
+		warning("the '-l' alias for '--create-reflog' is deprecated;");
+		warning("it will be removed in a future version of Git");
+	}
+
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-- 
2.18.0.539.gcf23d6d4f1

