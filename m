Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24352202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 17:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbdJSRtj (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 13:49:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:57890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751842AbdJSRti (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 13:49:38 -0400
Received: (qmail 29202 invoked by uid 109); 19 Oct 2017 17:49:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:49:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10312 invoked by uid 111); 19 Oct 2017 17:49:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 13:49:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 13:49:36 -0400
Date:   Thu, 19 Oct 2017 13:49:36 -0400
From:   Jeff King <peff@peff.net>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
        l.s.r@web.de, avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: [PATCH 4/4] worktree: handle broken symrefs in find_shared_symref()
Message-ID: <20171019174936.izojvrh5w35s3adi@sigill.intra.peff.net>
References: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The refs_resolve_ref_unsafe() function may return NULL even
with a REF_ISSYMREF flag if a symref points to a broken ref.
As a result, it's possible for find_shared_symref() to
segfault when it passes NULL to strcmp().

This is hard to trigger for most code paths. We typically
pass HEAD to the function as the symref to resolve, and
programs like "git branch" will bail much earlier if HEAD
isn't valid.

I did manage to trigger it through one very obscure
sequence:

  # You have multiple notes refs which conflict.
  git notes add -m base
  git notes --ref refs/notes/foo add -m foo

  # There's left-over cruft in NOTES_MERGE_REF that
  # makes it a broken symref (in this case we point
  # to a syntactically invalid ref).
  echo "ref: refs/heads/master.lock" >.git/NOTES_MERGE_REF

  # You try to merge the notes. We read the broken value in
  # order to complain that another notes-merge is
  # in-progress, but we segfault in find_shared_symref().
  git notes merge refs/notes/foo

This is obviously silly and almost certainly impossible to
trigger accidentally, but it does show that the bug is
triggerable from at least one code path. In addition, it
would trigger if we saw a transient filesystem error when
resolving the pointed-to ref.

We can fix this by treating NULL the same as a non-matching
symref. Arguably we'd prefer to tell know if a symref points
to "refs/heads/foo", but "refs/heads/foo" is broken. But
refs_resolve_ref_unsafe() isn't capable of giving us that
information, so this is the best we can do.

Signed-off-by: Jeff King <peff@peff.net>
---
 worktree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index 70015629dc..f8c40f2f5f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -327,7 +327,8 @@ const struct worktree *find_shared_symref(const char *symref,
 		refs = get_worktree_ref_store(wt);
 		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
 							NULL, &flags);
-		if ((flags & REF_ISSYMREF) && !strcmp(symref_target, target)) {
+		if ((flags & REF_ISSYMREF) &&
+		    symref_target && !strcmp(symref_target, target)) {
 			existing = wt;
 			break;
 		}
-- 
2.15.0.rc1.560.g5f0609e481
