Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93DB41F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeBUSsP (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:48:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:59532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752094AbeBUSsO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:48:14 -0500
Received: (qmail 7296 invoked by uid 109); 21 Feb 2018 18:48:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Feb 2018 18:48:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23597 invoked by uid 111); 21 Feb 2018 18:49:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Feb 2018 13:49:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Feb 2018 13:48:12 -0500
Date:   Wed, 21 Feb 2018 13:48:12 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about get_cached_commit_buffer()
Message-ID: <20180221184811.GD4333@sigill.intra.peff.net>
References: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
 <20180220225726.GA17496@sigill.intra.peff.net>
 <22169205-8020-c816-0968-f6293e8d40bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22169205-8020-c816-0968-f6293e8d40bc@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 09:13:22AM -0500, Derrick Stolee wrote:

> > So there it is. It does show commits multiple times, but suppresses the
> > verbose header after the first showing. If we do something like this:
> > 
> >    git rev-list --show-all --pretty --boundary c93150cfb0^-
> > 
> > you'll see some boundary commits that _don't_ have their pretty headers
> > shown. And with your proposed patch, we'd show them again. To keep the
> > same behavior we need to store that "we've already seen this" boolean
> > somewhere else (e.g., in an object flag; possibly SEEN, but that might
> > run afoul of other logic).
> 
> What confuses me about this behavior is that the OID is still shown on the
> repeat (and in the case of `git log --oneline` will not actually have a line
> break between two short-OIDs). I don't believe this behavior is something to
> preserve.

I think that repeating the oid is intentional; the point is to dump how
the traversal code is hitting the endpoints, even if we do so multiple
times.

The --oneline behavior just looks like a bug. I think --format is broken
with --show-all, too (it does not show anything!).

> Unless I am misunderstanding, the current behavior on a repeated commit is
> already incorrect: some amount of output occurs before checking the buffer,
> so the output includes repeated records but with formatting that violates
> the expectation. By doing the simple change of swapping
> get_cached_commit_buffer() with get_commit_buffer(), we correct that format
> violation but have duplicate copies.

Yeah, I'd agree with that assessment.

> The most-correct thing to do (in my opinion) is to put the requirement of
> "no repeats" into the revision walk logic and stop having the formatting
> methods expect them. Then, however we change this boolean setting of "we
> have seen this before" it will not require the formatting methods to change.

But then you wouldn't show repeats at all. If I'm understanding you
correctly.

TBH, I do not think it is worth spending a lot of effort on this
--show-all feature. It seems mostly like forgotten debugging cruft to
me. That's why I'd be OK with showing the whole header as the simplest
fix (i.e., just removing those calls entirely, not even converting them
to get_commit_buffer).

> I can start working on a patch to move the duplicate-removal logic into
> revision.c instead of these three callers:
> 
> builtin/rev-list.c:     if (revs->verbose_header &&
> get_cached_commit_buffer(commit, NULL)) {
> log-tree.c:     if (!get_cached_commit_buffer(commit, NULL))
> object.c:                       if (!get_cached_commit_buffer(commit, NULL))

Those first two are duplicate detection. The third one in object.c
should stay, though. We've been fed a commit buffer to parse, and we
want to know whether we should attach it as the cached buffer for that
commit. But if we already have a cached buffer, there's no point in
doing so. And that's what we're checking there.

Though I think it would be equally correct to have set_commit_buffer()
just throw away the existing cache entry and replace it with this one. I
don't think there's a real reason to prefer the old to the new. And that
might be worth doing if it would let us drop get_cached_commit_buffer()
as a public function. But...

> But this caller seems pretty important in pretty.c:
> 
>         /*
>          * Otherwise, we still want to munge the encoding header in the
>          * result, which will be done by modifying the buffer. If we
>          * are using a fresh copy, we can reuse it. But if we are using
>          * the cached copy from get_commit_buffer, we need to duplicate it
>          * to avoid munging the cached copy.
>          */
>         if (msg == get_cached_commit_buffer(commit, NULL))
>                 out = xstrdup(msg);
>         else
>                 out = (char *)msg

Like the one in object.c, this really does want to know about the cached
entry. And it should be unaffected by your patch, since we will have
called get_commit_buffer() at the top of that function.

If we wanted to write this one without get_cached_commit_buffer(), we'd
really need a function to ask "did this pointer come from the cache, or
was it freshly allocated?". That's the same thing we do for
unuse_commit_buffer(). So in theory we could have a boolean function
that would check that, and that would let us make
get_cached_commit_buffer() private.

In my opinion it's not really worth trying to make it private. The
confusion you're fixing in the first two calls is not due to a bad API,
but due to some subtly confusing logic in that code's use of the API. ;)

So I'd probably do this:

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d94062bc84..3af56921c8 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -150,7 +150,7 @@ static void show_commit(struct commit *commit, void *data)
 	else
 		putchar('\n');
 
-	if (revs->verbose_header && get_cached_commit_buffer(commit, NULL)) {
+	if (revs->verbose_header) {
 		struct strbuf buf = STRBUF_INIT;
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
diff --git a/log-tree.c b/log-tree.c
index cab9353f45..cb2dab8a1c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -690,9 +690,6 @@ void show_log(struct rev_info *opt)
 		show_mergetag(opt, commit);
 	}
 
-	if (!get_cached_commit_buffer(commit, NULL))
-		return;
-
 	if (opt->show_notes) {
 		int raw;
 		struct strbuf notebuf = STRBUF_INIT;

with the rationale that:

  1. Nobody really cares about this verbose-output suppression anyway.

  2. The code is confusing and fragile, since it uses the cached commit
     buffer as an implicit boolean for "did we show the commit already".

  3. It's broken for --oneline and user-formats, and this fixes it.

-Peff
