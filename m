Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80F120259
	for <e@80x24.org>; Thu,  8 Dec 2016 13:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbcLHNug (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 08:50:36 -0500
Received: from continuum.iocl.org ([217.140.74.2]:54609 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbcLHNuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 08:50:35 -0500
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id uB8DoUe17311;
        Thu, 8 Dec 2016 14:50:30 +0100
Date:   Thu, 8 Dec 2016 14:50:29 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] commit: make --only --allow-empty work without paths
Message-ID: <20161208135029.GA16292@inner.h.apk.li>
References: <20161202221513.GA5370@inner.h.apk.li> <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net> <xmqqd1h63xqn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1h63xqn.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--only is implied when paths are present, and required
them unless --amend. But with --allow-empty it should
be allowed as well - it is the only way to create an
empty commit in the presence of staged changes.

Also remove the post-fact cleverness indication;
it's in the man page anyway.

Signed-off-by: Andreas Krey <a.krey@gmx.de>
---

Ok, I've removed the clever message, as Junio suggested.
I don't know what else to do to make it acceptable. :-)
We're going to deploy it internally anyway, but I think
it belongs in git.git as well (aka 'Can I has "will queue"?').

 Documentation/git-commit.txt | 3 ++-
 builtin/commit.c             | 4 +---
 t/t7501-commit.sh            | 9 +++++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

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
index 8976c3d29..276c74034 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1206,10 +1206,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
-	if (argc == 0 && (also || (only && !amend)))
+	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
-	if (argc == 0 && only && amend)
-		only_include_assumed = _("Clever... amending the last one with dirty index.");
 	if (argc > 0 && !also && !only)
 		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
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
2.11.0.10.g1e1b186.dirty

