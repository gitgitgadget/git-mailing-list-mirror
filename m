Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA7F201A7
	for <e@80x24.org>; Fri, 12 May 2017 13:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbdELNDZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 09:03:25 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:63258 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932207AbdELNDY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 09:03:24 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 63F482003ED;
        Fri, 12 May 2017 15:03:21 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH v4 2/3] read-tree -m: make error message for merging 0 trees less smart aleck
Date:   Fri, 12 May 2017 15:03:16 +0200
Message-Id: <20170512130317.25832-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170512130317.25832-1-jn.avila@free.fr>
References: <20170503162931.30721-1-jn.avila@free.fr>
 <20170512130317.25832-1-jn.avila@free.fr>
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
required. Also document that more than 3 trees can be merged.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 Documentation/git-read-tree.txt | 7 +++----
 builtin/read-tree.c             | 5 +++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index ed9d63ef4..7e20b0c21 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -135,10 +135,9 @@ OPTIONS
 
 Merging
 -------
-If `-m` is specified, 'git read-tree' can perform 3 kinds of
-merge, a single tree merge if only 1 tree is given, a
-fast-forward merge with 2 trees, or a 3-way merge if 3 trees are
-provided.
+If `-m` is specified, 'git read-tree' can perform 3 kinds of merge, a
+single tree merge if only 1 tree is given, a fast-forward merge with 2
+trees, or a 3-way merge if 3 or more trees are provided.
 
 
 Single Tree Merge
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 23e212ee8..383442567 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
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
2.13.0

