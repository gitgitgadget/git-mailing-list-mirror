Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84C0C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiK2B25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiK2B0e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:26:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B05658D
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:26:08 -0800 (PST)
Received: (qmail 11389 invoked by uid 109); 29 Nov 2022 01:26:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Nov 2022 01:26:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13443 invoked by uid 111); 29 Nov 2022 01:26:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Nov 2022 20:26:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Nov 2022 20:26:06 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Message-ID: <Y4VfrsYwWkestQ05@coredump.intra.peff.net>
References: <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de>
 <xmqqv8mz5ras.fsf@gitster.g>
 <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
 <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
 <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
 <221128.865yezkule.gmgdl@evledraar.gmail.com>
 <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
 <2488058d-dc59-e8c1-0611-fbcaeb083d73@web.de>
 <221128.86o7sqkjcj.gmgdl@evledraar.gmail.com>
 <0b86ae8b-5523-3857-cdba-12275f727cde@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b86ae8b-5523-3857-cdba-12275f727cde@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 10:57:02PM +0100, René Scharfe wrote:

> >> diff --git a/revision.c b/revision.c
> >> index 439e34a7c5..6a51ef9418 100644
> >> --- a/revision.c
> >> +++ b/revision.c
> >> @@ -3055,6 +3055,7 @@ void release_revisions(struct rev_info *revs)
> >>  	release_revisions_mailmap(revs->mailmap);
> >>  	free_grep_patterns(&revs->grep_filter);
> >>  	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
> >> +	FREE_AND_NULL(revs->diffopt.parseopts);
> >>  	diff_free(&revs->pruning);
> >>  	reflog_walk_info_release(revs->reflog_info);
> >>  	release_revisions_topo_walk_info(revs->topo_walk_info);
> >
> > At this point I'm unclear on what & why this is needed? I.e. once we
> > narrowly fix the >1 "--filter" options what still fails?
> 
> As I wrote: A call to an initialization function followed by a call to a
> cleanup function and nothing else shouldn't leak.  There are examples of
> repo_init_revisions()+release_revisions() without setup_revisions() or
> diff_setup_done() beyond pack-objects.  I mentioned prune, but there are
> more, e.g. in sequencer.c.

I tend to agree with you; an init+release combo should release all
memory. We _can_ work around it in the caller here, but I think we are
better to correct the root cause.

I do think what Ævar is saying is: once we have fixed the bug, why are
more changes needed? I.e., why would we get rid of the lazy-init. IMHO
the answer is that the lazy-init is a more complex pattern, and requires
more boilerplate code (which can lead to more bugs, as we saw). So once
the bug is fixed, this is purely about cleanup/simplification (if one
ignores the C-standard issues), but I tend to think it is one worth
doing.

(Apologies to Ævar if I'm mis-stating your position).

> > But in general: I don't really think this sort of thing is worth
> > it. Here we're reaching into a member of "revs->diffopt" behind its back
> > rather than calling diff_free(). I think we should just focus on being
> > able to do do that safely.
> 
> Sure, but the FREE_AND_NULL call is simple and safe, while diff_free()
> is complicated and calling it one time too many can hurt.

Again, I'd agree with you here. In the long run, yes, we want
diff_free(). But if that is not ready yet, the FREE_AND_NULL() is a
stepping stone that takes us in the right direction and which we can do
immediately.

> > WIP patches I have in that direction, partially based on your previous
> > "is_dead" suggestion:
> >
> > 	https://github.com/avar/git/commit/e02a15f6206
> > 	https://github.com/avar/git/commit/c718f36566a
> 
> Copy-typed the interesting parts of the first patch like a medieval monk
> because there doesn't seem to be a download option. :-|

This is the actual reason I responded to your message. ;) Try:

  https://github.com/avar/git/commit/e02a15f6206.patch

etc. I don't think there's a "raw patch" link or similar in the
interface, though. You have to just know about it.

-Peff
