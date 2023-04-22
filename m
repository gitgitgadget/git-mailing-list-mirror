Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5FBC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 13:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDVNzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 09:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDVNzp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 09:55:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F571BF2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 06:55:44 -0700 (PDT)
Received: (qmail 13694 invoked by uid 109); 22 Apr 2023 13:55:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 13:55:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29043 invoked by uid 111); 22 Apr 2023 13:55:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 09:55:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 09:55:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 1/2] notes: clean up confusing NULL checks in init_notes()
Message-ID: <20230422135543.GA3942829@coredump.intra.peff.net>
References: <20230422135455.GA3942740@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230422135455.GA3942740@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coverity complains that we check whether "notes_ref" is NULL, but it was
already implied to be non-NULL earlier in the function. And this is
true; since b9342b3fd63 (refs: add array of ref namespaces, 2022-08-05),
we call xstrdup(notes_ref) unconditionally, which would segfault if it
was NULL.

But that commit is actually doing the right thing. Even if NULL is
passed into the function, we'll use default_notes_ref() as a fallback,
which will never return NULL (it tries a few options, but its last
resort is a string literal). Ironically, the "!notes_ref" check was
added by the same commit that added the fallback: 709f79b0894 (Notes
API: init_notes(): Initialize the notes tree from the given notes ref,
2010-02-13). So this check never did anything.

Signed-off-by: Jeff King <peff@peff.net>
---
 notes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes.c b/notes.c
index 45fb7f22d1..cadb435056 100644
--- a/notes.c
+++ b/notes.c
@@ -1019,13 +1019,13 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->root = (struct int_node *) xcalloc(1, sizeof(struct int_node));
 	t->first_non_note = NULL;
 	t->prev_non_note = NULL;
-	t->ref = xstrdup_or_null(notes_ref);
+	t->ref = xstrdup(notes_ref);
 	t->update_ref = (flags & NOTES_INIT_WRITABLE) ? t->ref : NULL;
 	t->combine_notes = combine_notes;
 	t->initialized = 1;
 	t->dirty = 0;
 
-	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
+	if (flags & NOTES_INIT_EMPTY ||
 	    repo_get_oid_treeish(the_repository, notes_ref, &object_oid))
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
-- 
2.40.0.653.g15ca972062

