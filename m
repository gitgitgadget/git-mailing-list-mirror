Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE3D1F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 07:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbeCZH2m (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 03:28:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:42870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750923AbeCZH2m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 03:28:42 -0400
Received: (qmail 3380 invoked by uid 109); 26 Mar 2018 07:28:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 07:28:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17403 invoked by uid 111); 26 Mar 2018 07:29:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 03:29:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 03:28:39 -0400
Date:   Mon, 26 Mar 2018 03:28:39 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: [PATCH 3/5] branch: deprecate "-l" option
Message-ID: <20180326072839.GC12530@sigill.intra.peff.net>
References: <20180326072505.GA12436@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180326072505.GA12436@sigill.intra.peff.net>
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

Let's deprecate "-l" in hopes of eventually dropping it
(it's a little too soon to repurpose it to "--list", but we
may even do that eventually).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-branch.txt |  3 ++-
 builtin/branch.c             | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b3084c99c1..b959df1cbf 100644
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
index 6d0cea9d4b..e50a5a1680 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -570,6 +570,15 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
+static int deprecated_reflog_option_cb(const struct option *opt,
+				       const char *arg, int unset)
+{
+	warning("the '-l' alias for '--create-reflog' is deprecated;");
+	warning("it will be removed in a future version of Git");
+	*(int *)opt->value = !unset;
+	return 0;
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
@@ -612,7 +621,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
-- 
2.17.0.rc1.509.g060626845b

