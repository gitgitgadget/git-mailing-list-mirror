Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D07D201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 12:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdB1MnY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 07:43:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:35593 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdB1MnX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 07:43:23 -0500
Received: (qmail 22637 invoked by uid 109); 28 Feb 2017 12:15:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 12:15:50 +0000
Received: (qmail 25395 invoked by uid 111); 28 Feb 2017 12:15:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 07:15:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 07:15:48 -0500
Date:   Tue, 28 Feb 2017 07:15:48 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: [PATCH 6/8] branch: restrict @-expansions when deleting
Message-ID: <20170228121548.qbcdh7rzxyressry@sigill.intra.peff.net>
References: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
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
 t/t3204-branch-name-interpretation.sh | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

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
index 2fe696ba6..c8fec5b8c 100755
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
@@ -103,7 +103,7 @@ test_expect_failure 'create branch named "@"' '
 	expect_branch refs/heads/@ one
 '
 
-test_expect_failure 'delete branch named "@"' '
+test_expect_success 'delete branch named "@"' '
 	git update-ref refs/heads/@ two &&
 	git branch -D @ &&
 	expect_deleted refs/heads/@
-- 
2.12.0.359.gd4c8c42e9

