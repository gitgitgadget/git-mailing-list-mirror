Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE1C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD67520674
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHRRlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:41:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:34570 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRRlS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 13:41:18 -0400
Received: (qmail 16135 invoked by uid 109); 18 Aug 2020 17:41:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Aug 2020 17:41:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31615 invoked by uid 111); 18 Aug 2020 17:41:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Aug 2020 13:41:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Aug 2020 13:41:16 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
Message-ID: <20200818174116.GA2473110@coredump.intra.peff.net>
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
 <20200815002509.2467645-3-jacob.e.keller@intel.com>
 <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
 <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 05:04:00PM -0700, Jacob Keller wrote:

> > > +     /* apply any negative refspecs now to prune the list of refs */
> > > +     ref_map = apply_negative_refspecs(ref_map, rs);
> > > +
> > >       ref_map = ref_remove_duplicates(ref_map);
> >
> > How was the ordering here decided?  Should it result the same set if
> > negative ones are excluded after duplicates are removed?
> 
> Good question. This was what was done in peff's original patch. I need
> to understand a bit more about what ref_remove_duplicates does to
> really figure this out.

The relevant commit is 2467a4fa03 (Remove duplicate ref matches in
fetch, 2007-10-08), I think. We may end up with multiple refspecs
requesting a particular ref. E.g.:

  git fetch origin refs/heads/master refs/heads/*

I don't think the order should matter. If we apply negative refspecs
first, then we'd either remove both copies or leave both untouched (and
if the latter, then de-dup to a single). If we apply negative refspecs
after de-duping, then we'd either remove the single or leave it in
place. But the result is the same either way.

> > > @@ -1441,6 +1445,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
> > >               string_list_clear(&src_ref_index, 0);
> > >       }
> > >
> > > +     *dst = apply_negative_refspecs(*dst, rs);
> > > +
> >
> > The block of code whose tail is shown in the pre-context has
> > prepared "delete these refs because we no longer have them" to the
> > other side under MATCH_REFS_PRUNE but that was done based on the
> > *dst list before we applied the negative refspec.  Is the ordering
> > of these two correct, or should we filter the dst list with negative
> > ones and use the resulting one in pruning operation?
> 
> I think we need to swap the order here. I'll take a closer look.

Hmm. I think the behavior we'd want is something like:

  # make sure the other side has three refs
  git branch prune/one HEAD
  git branch prune/two HEAD
  git branch prune/three HEAD
  git push dst.git refs/heads/prune/*

  # now drop two of ours, which are eligible for pruning
  git branch -d prune/one
  git branch -d prune/two

  # push with pruning, omitting "two"
  git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two

  # we should leave "two" but still deleted "one"
  test_write_lines one three >expect
  git -C dst.git for-each-ref --format='%(refname:lstrip=3)' refs/heads/prune/ >actual
  test_cmp expect actual

I.e., the negative refspec shrinks the space we're considering pruning.
And we'd probably want a similar test for "fetch --prune".

I just tried that, though, and got an interesting result. The push
actually complains:

  $ git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two
  error: src refspec refs/heads/prune/two does not match any
  error: failed to push some refs to 'dst.git'

For negative refspecs, would we want to loosen the "must-exist" check?
Or really, is this getting into the "are we negative on the src or dst"
thing you brought up earlier? Especially with --prune, what I really
want to say is "do not touch the remote refs/heads/two".

We can get work around it by using a wildcard:

  $ git push --prune dst.git refs/heads/prune/* ^refs/heads/prune/two*
  To dst.git
   - [deleted]         prune/one

So it works as I'd expect already with your patch. But I do wonder if
there are corner cases around the src/dst thing that might not behave
sensibly.

-Peff
