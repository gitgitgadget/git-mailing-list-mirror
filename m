Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2F820133
	for <e@80x24.org>; Thu,  2 Mar 2017 08:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754179AbdCBI3z (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 03:29:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:37057 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdCBI3y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 03:29:54 -0500
Received: (qmail 22707 invoked by uid 109); 2 Mar 2017 08:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 08:23:12 +0000
Received: (qmail 15227 invoked by uid 111); 2 Mar 2017 08:23:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 03:23:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 03:23:10 -0500
Date:   Thu, 2 Mar 2017 03:23:10 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 6/8] branch: restrict @-expansions when deleting
Message-ID: <20170302082310.y24ex3ado4st7onw@sigill.intra.peff.net>
References: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use strbuf_branchname() to expand the branch name from
the command line, so you can delete the branch given by
@{-1}, for example.  However, we allow other nonsense like
"@", and we do not respect our "-r" flag (so we may end up
deleting an oddly-named local ref instead of a remote one).

We can fix this by passing the appropriate "allowed" flag to
strbuf_branchname().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c                      | 5 ++++-
 t/t3204-branch-name-interpretation.sh | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index cf0ece55d..291fe90de 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -191,17 +191,20 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	int ret = 0;
 	int remote_branch = 0;
 	struct strbuf bname = STRBUF_INIT;
+	unsigned allowed_interpret;
 
 	switch (kinds) {
 	case FILTER_REFS_REMOTES:
 		fmt = "refs/remotes/%s";
 		/* For subsequent UI messages */
 		remote_branch = 1;
+		allowed_interpret = INTERPRET_BRANCH_REMOTE;
 
 		force = 1;
 		break;
 	case FILTER_REFS_BRANCHES:
 		fmt = "refs/heads/%s";
+		allowed_interpret = INTERPRET_BRANCH_LOCAL;
 		break;
 	default:
 		die(_("cannot use -a with -d"));
@@ -216,7 +219,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *target = NULL;
 		int flags = 0;
 
-		strbuf_branchname(&bname, argv[i], 0);
+		strbuf_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
 
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index e671a7a64..4f4af1fb4 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -83,7 +83,7 @@ test_expect_success 'delete branch via remote @{upstream}' '
 # Note that we create two oddly named local branches here. We want to make
 # sure that we do not accidentally delete either of them, even if
 # shorten_unambiguous_ref() tweaks the name to avoid ambiguity.
-test_expect_failure 'delete @{upstream} expansion matches -r option' '
+test_expect_success 'delete @{upstream} expansion matches -r option' '
 	git update-ref refs/remotes/origin/remote-del two &&
 	git branch --set-upstream-to=origin/remote-del &&
 	git update-ref refs/heads/origin/remote-del two &&
@@ -94,7 +94,7 @@ test_expect_failure 'delete @{upstream} expansion matches -r option' '
 	expect_branch refs/heads/remotes/origin/remote-del two
 '
 
-test_expect_failure 'disallow deleting remote branch via @{-1}' '
+test_expect_success 'disallow deleting remote branch via @{-1}' '
 	git update-ref refs/remotes/origin/previous one &&
 
 	git checkout -b origin/previous two &&
@@ -114,7 +114,7 @@ test_expect_failure 'create branch named "@"' '
 	expect_branch refs/heads/@ one
 '
 
-test_expect_failure 'delete branch named "@"' '
+test_expect_success 'delete branch named "@"' '
 	git update-ref refs/heads/@ two &&
 	git branch -D @ &&
 	expect_deleted refs/heads/@
-- 
2.12.0.367.gb23790f66

