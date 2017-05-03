Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7B72207F8
	for <e@80x24.org>; Wed,  3 May 2017 21:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753516AbdECVHv (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 17:07:51 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:15509 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751940AbdECVHt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 17:07:49 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 0332D2002E6;
        Wed,  3 May 2017 23:07:43 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     rashmipai36@gmail.com, Jean-Noel Avila <jn.avila@free.fr>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 2/3] read-tree -m: make error message for merging 0 trees less smart aleck
Date:   Wed,  3 May 2017 23:07:25 +0200
Message-Id: <20170503210726.24121-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170503210726.24121-1-jn.avila@free.fr>
References: <20170503162931.30721-1-jn.avila@free.fr>
 <20170503210726.24121-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git read-tree -m" requires a tree argument to name the tree to be
merged in.  Git uses a cutesy error message to say so and why:

    $ git read-tree -m
    warning: read-tree: emptying the index with no arguments is
    deprecated; use --empty
    fatal: just how do you expect me to merge 0 trees?
    $ git read-tree -m --empty
    fatal: just how do you expect me to merge 0 trees?

When lucky, that could produce an ah-hah moment for the user, but it's
more likely to irritate and distract them.

Instead, tell the user plainly that the tree argument is
required. Also document this requirement in the git-read-tree(1)
manpage where there is room to explain it in a more straightforward way.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-read-tree.txt | 8 ++++----
 builtin/read-tree.c             | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index ed9d63ef4..7cd9c6306 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -135,10 +135,10 @@ OPTIONS
 
 Merging
 -------
-If `-m` is specified, 'git read-tree' can perform 3 kinds of
-merge, a single tree merge if only 1 tree is given, a
-fast-forward merge with 2 trees, or a 3-way merge if 3 trees are
-provided.
+If `-m` is specified, at least one tree must be given on the command
+line. 'git read-tree' can perform 3 kinds of merge, a single tree
+merge if only 1 tree is given, a fast-forward merge with 2 trees, or a
+3-way merge if 3 trees are provided.
 
 
 Single Tree Merge
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 23e212ee8..68c5b0ca4 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -132,7 +132,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		OPT_BOOL(0, "empty", &read_empty,
 			    N_("only empty the index")),
 		OPT__VERBOSE(&opts.verbose_update, N_("be verbose")),
-		OPT_GROUP(N_("Merging")),
+		OPT_GROUP(N_("Merging (needs at least one tree-ish")),
 		OPT_BOOL('m', NULL, &opts.merge,
 			 N_("perform a merge in addition to a read")),
 		OPT_BOOL(0, "trivial", &opts.trivial_merges_only,
@@ -226,9 +226,10 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		setup_work_tree();
 
 	if (opts.merge) {
-		if (stage < 2)
-			die("just how do you expect me to merge %d trees?", stage-1);
 		switch (stage - 1) {
+		case 0:
+			die("you must specify at least one tree to merge");
+			break;
 		case 1:
 			opts.fn = opts.prefix ? bind_merge : oneway_merge;
 			break;
-- 
2.12.0

