Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27852018E
	for <e@80x24.org>; Thu, 11 Aug 2016 05:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbcHKFC5 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 01:02:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:53389 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751143AbcHKFC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 01:02:57 -0400
Received: (qmail 18121 invoked by uid 109); 11 Aug 2016 05:02:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 05:02:55 +0000
Received: (qmail 6789 invoked by uid 111); 11 Aug 2016 05:02:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 01:02:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 01:02:52 -0400
Date:	Thu, 11 Aug 2016 01:02:52 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 1/2] pack-objects: break delta cycles before
 delta-search phase
Message-ID: <20160811050252.g3iusy7bp3j6tzte@sigill.intra.peff.net>
References: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
 <20160810120248.i2hvm2q6ag3rvsk4@sigill.intra.peff.net>
 <xmqqr39w4bvx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr39w4bvx.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 01:17:22PM -0700, Junio C Hamano wrote:

> > Actually, skimming the sha1_file code, I am not 100% sure that we detect
> > cycles in OBJ_REF_DELTA (you cannot have cycles in OBJ_OFS_DELTA since
> > they always point backwards in the pack). But if that is the case, then
> > I think we should fix that, not worry about special-casing it here.
> 
> Yes, but sha1_file.c?  It is the reading side and it is too late if
> we notice a problem, I would think.

We already are covered on the writing side. That is what your code in
write_one() does. The reason to warn is on the reading side ("I fixed
this for you, but by the way, your existing packs were bogus").

But of more concern is whether read_sha1_file() would recurse
infinitely, which would be bad (though I do not think it would be a
feasible attack vector; index-pack already rejects such packs before
they are admitted to the repository).

> > + *   2. Updating our size; check_object() will have filled in the size of our
> > + *      delta, but a non-delta object needs it true size.
> 
> Excellent point.

I was not clever enough to think of it; the pack-objects code is filled
with nice assertions (Thanks, Nico!) that help out when you are stupid. :)

One thing to be careful of is that there are more things this
drop_reused_delta() should be doing. But I looked through the rest of
check_object() and could not find anything else.

> > +	case DFS_ACTIVE:
> > +		/*
> > +		 * We found a cycle that needs broken. It would be correct to
> > +		 * break any link in the chain, but it's convenient to
> > +		 * break this one.
> > +		 */
> > +		drop_reused_delta(entry);
> > +		break;
> > +	}
> > +}
> 
> Do we need to do anything to the DFS state of an entry when
> drop_reused_delta() resets its other fields?

Good catch. It should be marked DONE after we have broken the delta. It
doesn't matter in practice, because...

> If we later find D that is directly based on A, wouldn't we end up
> visiting A and attempt to drop it again?  drop_reused_delta() is
> idempotent so there will be no data structure corruption, I think,
> but we can safely declare that the entry is now DONE after calling
> drop_reused_delta() on it (either in the function or in the caller
> after it calls the function), no?

I think the idempotency of drop_reused_delta() doesn't matter. When we
visit A again later, its "delta" field will be NULL, so we'll hit the
condition at the top of the function: this is a base object, mark DONE
and don't recurse.

So it's correct as-is, but I agree it feels weird that the DFS would end
with some objects potentially marked ACTIVE. Everything should be DONE
at the end.

> > +# Create a pack containing the the tree $1 and blob $1:file, with
> > +# the latter stored as a delta against $2:file.
> > +#
> > +# We convince pack-objects to make the delta in the direction of our choosing
> > +# by marking $2 as a preferred-base edge. That results in $1:file as a thin
> > +# delta, and index-pack completes it by adding $2:file as a base.
> 
> Tricky but clever and correct ;-)

Thanks, it took a long time to think up. ;)

I actually wish we had better tools for making fake packs. Something
where you could say "add A, then add B as a delta of A, then...".
Because you often have to jump through quite a few hoops to convince
pack-objects to generate the pack you want, and even some things are
impossible (for example, I would like to make a chain of 10 deltas; how
do I convince the delta search to put my objects in the right order?).

I tried briefly yesterday to convince pack-objects to just take a list
of objects and their deltas, but it got ugly very quickly.  I think we'd
be better off writing a new tool that happens to reuse some of the
formatting functions from pack-objects. But even then, we've got to
write an .idx, which means going through index-pack (which will complain
if we are writing bogus packs for testing odd situations), or we have to
keep a valid list of "struct object_entry" to feed to the idx writer.

So even that approach is not quite trivial.

> > +make_pack () {
> > +	 {
> > +		 echo "-$(git rev-parse $2)"
> 
> Is everybody's 'echo' happy with dash followed by unknown string?

I'd assume so because it will be "-<sha1>", and I think echoes which
take options are careful about that.

Still, it would not be hard to tweak.

> > +		 echo "$(git rev-parse $1:dummy) dummy"
> > +		 echo "$(git rev-parse $1:file) file"
> > +	 } |
> > +	 git pack-objects --stdout |
> > +	 git index-pack --stdin --fix-thin
> 
> An alternative
> 
> 	git pack-objects --stdout <<-EOF |
> 	-$(git rev-parse $2)
>         $(git rev-parse $1:dummy) dummy
>         $(git rev-parse $1:file) file
> 	EOF
>         git index-pack --stdin --fix-thin
> 
> looks somewhat ugly, though.

Yeah, I think we would be better to just switch to printf if we want to
be careful.

I'll follow-up with a patch.

-Peff
