Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4281F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 03:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfJUDQM (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 23:16:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:53588 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726770AbfJUDQL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 23:16:11 -0400
Received: (qmail 28072 invoked by uid 109); 21 Oct 2019 03:16:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 Oct 2019 03:16:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5005 invoked by uid 111); 21 Oct 2019 03:19:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 20 Oct 2019 23:19:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 20 Oct 2019 23:16:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        GitList <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: Re: [PATCH v5] Doc: Bundle file usage
Message-ID: <20191021031610.GA13083@sigill.intra.peff.net>
References: <9e097bb2-ff3e-db5b-f0fd-0803e56b2cd6@iee.email>
 <20191020110306.1714-1-philipoakley@iee.email>
 <xmqq7e4yn793.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e4yn793.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 11:48:40AM +0900, Junio C Hamano wrote:

> > +`git clone` can use any bundle created without negative refspecs
> > +(e.g., `new`, but not `old..new`).
> 
> To be consistent with the phrasing of this particular document we
> saw earlier, you would have said "without basis", but I think the
> use of `basis` did not spread beyond "git bundle" documentation.  
> 
> If we were writing "git bundle" and its documentation from scratch
> using more modern lingo, we probably would say "negative revisions"
> here.  Note that the word `refspec` has no place in the context of
> this sentence; they are to specify the mapping of refs between the
> repository in which transferred objects originate and the repository
> that accept the objects.  Also note that `basis` discussed in 'git
> bundle' is a bit wider concept than `negative revisions`, so mere
> mechanical replacements would not be sufficient as a preliminary
> modernization/prepation step for this patch.

Sorry, this one is my fault. I said "negative revisions" in my earlier
mail[1], but somehow while writing example text my brain turned into
"refspecs", which is obviously nonsense. It should be "revisions".

I don't mind using "basis" either; it's not commonly used outside of
this page, but I think it does succinctly represent what we're trying to
say here.

[1] https://public-inbox.org/git/20191016210957.GA28981@sigill.intra.peff.net/

> > +If you want to match `git clone --mirror`, which would include your
> > +refs such as `refs/remotes/*`, use `--all`.
> > +If you want to provide the same set of refs that a clone directly
> > +from the source repository would get, use `--branches --tags` for
> > +the `<git-rev-list-args>`.
> 
> This is not wrong per-se, but may lead to confusion.  The readers
> must be able to learn:
> 
>  - "git clone --mirror full.bndl dst/" from a full bundle created
>    with "git bundle create full.bndl --all" can mimic creation of a
>    full mirror of the original.
> 
>  - "git clone full.bndl dst/" from such a bundle does *not* result
>    in creation of a mirror.
> 
>  - "git clone slim.bndl dst/" from a minimum bundle created wth "git
>    bundle create slim.bndl --branches --tags" would be sufficient to
>    obtain the same result as the above.
> 
>  - "git clone --mirror slim.bndl dst/" from such a minimum bundle
>    cannot mimic creation of a full mirror of the original.
> 
> I am not sure the second point is conveyed well with the new
> paragraph.  That is, "--all" must be used if the resulting bundle is
> meant to be usable to "--mirror" clone from, but it can still be
> used to clone normally.  If you do not intend to mirror-clone from,
> there is not much point in using "--all" to record extra refs.

I hoped maybe it would be obvious how the second and fourth cases would
behave, but maybe it is better to spell it out. Maybe it would be better
to talk about what the sender does, and then what the receiver can do
with the result. Something like:

  If you create a bundle using `--all` for `<git-rev-list-args>`, a
  recipient can clone the result using `git clone` or `git clone
  --mirror` and get the same result they would by cloning directly from
  the source repository. If you instead create it with `--branches
  --tags`, the resulting bundle may be smaller, and a non-mirror clone
  will behave the same (but a `clone --mirror` will obviously not
  receive any refs outside of the branches and tags).

That could probably be tightened up a bit.

-Peff
