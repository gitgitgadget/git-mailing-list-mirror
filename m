Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03C51FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 22:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbcLBWPR (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 17:15:17 -0500
Received: from continuum.iocl.org ([217.140.74.2]:50654 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbcLBWPR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 17:15:17 -0500
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id uB2MFDF05921;
        Fri, 2 Dec 2016 23:15:13 +0100
Date:   Fri, 2 Dec 2016 23:15:13 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH] commit: make --only --allow-empty work without paths
Message-ID: <20161202221513.GA5370@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--only is implied when paths are present, and required
them unless --amend. But with --allow-empty it should
be allowed as well - it is the only way to create an
empty commit in the presence of staged changes.

Signed-off-by: Andreas Krey <a.krey@gmx.de>
---

I stumbled over this omission trying
to create an empty commit while changes
are staged. (We use such empty commits as
workaround when devs forgot to put issues
into the actual commits. And one had
staged changes at that point.)

Arguably, requiring paths with --only is
pointless anyway because it is implicit
in that case, but I'm happy when it works
like in this patch.

(The interdepence of the tests is a strange thing;
making --run=N somewhat pointless.)

(And I hope that the patch in commit.c is
actually sufficient for this, but have
not found indications to the contrary.)

 Documentation/git-commit.txt | 3 ++-
 builtin/commit.c             | 2 +-
 t/t7501-commit.sh            | 9 +++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f2ab0ee2e..4f8f20a36 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -265,7 +265,8 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	If this option is specified together with `--amend`, then
 	no paths need to be specified, which can be used to amend
 	the last commit without committing changes that have
-	already been staged.
+	already been staged. If used together with `--allow-empty`
+	paths are also not required, and an empty commit will be created.
 
 -u[<mode>]::
 --untracked-files[=<mode>]::
diff --git a/builtin/commit.c b/builtin/commit.c
index 8976c3d29..89b66816f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1206,7 +1206,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
-	if (argc == 0 && (also || (only && !amend)))
+	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
 	if (argc == 0 && only && amend)
 		only_include_assumed = _("Clever... amending the last one with dirty index.");
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index d84897a67..0d8d89309 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -155,6 +155,15 @@ test_expect_success 'amend --only ignores staged contents' '
 	git diff --exit-code
 '
 
+test_expect_success 'allow-empty --only ignores staged contents' '
+	echo changed-again >file &&
+	git add file &&
+	git commit --allow-empty --only -m "empty" &&
+	git cat-file blob HEAD:file >file.actual &&
+	test_cmp file.expect file.actual &&
+	git diff --exit-code
+'
+
 test_expect_success 'set up editor' '
 	cat >editor <<-\EOF &&
 	#!/bin/sh
-- 
2.11.0.10.g1e1b186

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
