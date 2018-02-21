Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838AF1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeBUXNl (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:13:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:60108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751017AbeBUXNk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:13:40 -0500
Received: (qmail 20732 invoked by uid 109); 21 Feb 2018 23:13:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Feb 2018 23:13:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28957 invoked by uid 111); 21 Feb 2018 23:14:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Feb 2018 18:14:27 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Feb 2018 18:13:38 -0500
Date:   Wed, 21 Feb 2018 18:13:38 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: drop uses of get_cached_commit_buffer()
Message-ID: <20180221231338.GC7944@sigill.intra.peff.net>
References: <20180221185204.GA8476@sigill.intra.peff.net>
 <1519240631-221761-1-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519240631-221761-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 02:17:11PM -0500, Derrick Stolee wrote:

> The get_cached_commit_buffer() method provides access to the buffer
> loaded for a struct commit, if it was ever loadead and was not freed.
> 
> Two places use this to inform how to output information about commits.
> 
> log-tree.c uses this method to short-circuit the output of commit
> information when the buffer is not cached. However, this leads to
> incorrect output in 'git log --oneline' where the short-OID is written
> but then the rest of the commit information is dropped and the next
> commit is written on the same line.
> 
> rev-list uses this method for two reasons:
> 
> - First, if the revision walk visits a commit twice, the buffer was
>   freed by rev-list in the first write. The output then does not
>   match the format expectations, since the OID is written without the
>   rest of the content.

I'm not sure after my earlier digging if there is even a way to trigger
this (and if so, it is probably accidental, since those lines were added
explicitly for --show-all).

And actually after re-reading the commit message for 3131b7130 again, I
think the current behavior is definitely not something that was
carefully planned. So I'd propose a commit message like below.

-- >8 --
Subject: [PATCH] commit: drop uses of get_cached_commit_buffer()

The "--show-all" revision option shows UNINTERESTING
commits. Some of these commits may be unparsed when we try
to show them (since we may or may not need to walk their
parents to fulfill the request).

Commit 3131b71301 (Add "--show-all" revision walker flag for
debugging, 2008-02-09) resolved this by just skipping
pretty-printing for commits without their object contents
cached, saying:

  Because we now end up listing commits we may not even have been parsed
  at all "show_log" and "show_commit" need to protect against commits
  that don't have a commit buffer entry.

That was the easy fix to avoid the pretty-printer segfaulting,
but:

  1. It doesn't work for all formats. E.g., --oneline
     prints the oid for each such commit but not a trailing
     newline, leading to jumbled output.

  2. It only affects some commits, depending on whether we
     happened to parse them or not (so if they were at the
     tip of an UNINTERESTING starting point, or if we
     happened to traverse over them, you'd see more data).

  3. It unncessarily ties the decision to show the verbose
     header to whether the commit buffer was cached. That
     makes it harder to change the logic around caching
     (e.g., if we could traverse without actually loading
     the full commit objects).

These days it's safe to feed such a commit to the
pretty-print code. Since be5c9fb904 (logmsg_reencode: lazily
load missing commit buffers, 2013-01-26), we'll load it on
demand in such a case. So let's just always show the verbose
headers.

This does change the behavior of plumbing, but:

  a. The --show-all option was explicitly introduced as a
     debugging aid, and was never documented (and has rarely
     even been mentioned on the list by git devs).

  b. Avoiding the commits was already not deterministic due
     to (2) above. So the caller might have seen full
     headers for these commits anyway, and would need to be
     prepared for it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c | 2 +-
 log-tree.c         | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 48300d9e11..d320b6f1e3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -134,7 +134,7 @@ static void show_commit(struct commit *commit, void *data)
 	else
 		putchar('\n');
 
-	if (revs->verbose_header && get_cached_commit_buffer(commit, NULL)) {
+	if (revs->verbose_header) {
 		struct strbuf buf = STRBUF_INIT;
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
diff --git a/log-tree.c b/log-tree.c
index fc0cc0d6d1..22b2fb6c58 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -659,9 +659,6 @@ void show_log(struct rev_info *opt)
 		show_mergetag(opt, commit);
 	}
 
-	if (!get_cached_commit_buffer(commit, NULL))
-		return;
-
 	if (opt->show_notes) {
 		int raw;
 		struct strbuf notebuf = STRBUF_INIT;
-- 
2.16.2.555.g885a024879

