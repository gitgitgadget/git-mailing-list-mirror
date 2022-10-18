Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60037C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 16:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJRQD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiJRQD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 12:03:27 -0400
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 09:03:25 PDT
Received: from mail.strova.dk (mail.strova.dk [83.169.38.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD156E2FA
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 09:03:25 -0700 (PDT)
Received: from apus (net-2-37-164-163.cust.vodafonedsl.it [2.37.164.163])
        by mail.strova.dk (Postfix) with ESMTPSA id EDA876B361;
        Tue, 18 Oct 2022 17:55:31 +0200 (CEST)
Date:   Tue, 18 Oct 2022 17:55:30 +0200
From:   Mathias Rav <m@git.strova.dk>
To:     git@vger.kernel.org
Cc:     peff@peff.net, pwagland@gmail.com
Subject: [PATCH] revision: ignore non-existent objects in resolve-undo list
Message-ID: <20221018175530.086c8c74@apus>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garbage collection could inadvertently prune blobs mentioned only in the
resolve-undo extension prior to the bugfix in 5a5ea141e7
("revision: mark blobs needed for resolve-undo as reachable", 2022-06-09).

If a repository is affected by this bug, an obscure error can occur in
`git gc` after updating to a version of git that has the bugfix:

	$ git gc
	Enumerating objects: 327687, done.
	Counting objects: 100% (327687/327687), done.
	Delta compression using up to 8 threads
	Compressing objects: 100% (70883/70883), done.
	fatal: unable to read 616c8d17f4625f227708aae480e71233f7f58dce
	fatal: failed to run repack

A similar error occurs in `git rev-list --objects --indexed-objects`.

Fix the error by emitting a warning when the resolve-undo list mentions
objects that do not exist and then ignoring the nonexistent object.

The bugfix 5a5ea141e7 already contained code to emit this warning,
but since the code used lookup_blob() (and not parse_object()),
it would only warn in the unlikely scenario where the resolve-undo list
mentions an existing object that is not a blob.

I have encountered this error on two different clones of a large
mono-repository in checkouts with dozens of worktrees that see frequent
rebasing (causing a lot of git gc churn) and frequent merge conflicts
during rebasing, leading to resolve-undo lists in the index.
Somehow it seems the resolve-undo lists in the index persist after the
merge conflicts are resolved, which makes the error more frequent than
if the resolve-undo lists were only populated during the merge conflict.

Signed-off-by: Mathias Rav <m@git.strova.dk>
Fixes: 5a5ea141e7
Reported-by: Paul Wagland <pwagland@gmail.com>
---
 revision.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 36e31942ce..03bc45bef1 100644
--- a/revision.c
+++ b/revision.c
@@ -1720,18 +1720,18 @@ static void add_resolve_undo_to_pending(struct index_state *istate, struct rev_i
 		if (!ru)
 			continue;
 		for (i = 0; i < 3; i++) {
-			struct blob *blob;
+			struct object *obj;
 
 			if (!ru->mode[i] || !S_ISREG(ru->mode[i]))
 				continue;
 
-			blob = lookup_blob(revs->repo, &ru->oid[i]);
-			if (!blob) {
+			obj = parse_object(revs->repo, &ru->oid[i]);
+			if (!obj) {
 				warning(_("resolve-undo records `%s` which is missing"),
 					oid_to_hex(&ru->oid[i]));
 				continue;
 			}
-			add_pending_object_with_path(revs, &blob->object, "",
+			add_pending_object_with_path(revs, obj, "",
 						     ru->mode[i], path);
 		}
 	}
-- 
2.38.0

