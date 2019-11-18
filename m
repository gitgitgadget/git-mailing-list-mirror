Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76AA71F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 12:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKRMDQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 07:03:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:49992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726490AbfKRMDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 07:03:16 -0500
Received: (qmail 15726 invoked by uid 109); 18 Nov 2019 12:03:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Nov 2019 12:03:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13432 invoked by uid 111); 18 Nov 2019 12:06:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2019 07:06:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Nov 2019 07:03:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: rev-list and "ambiguous" IDs
Message-ID: <20191118120315.GB12766@sigill.intra.peff.net>
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
 <20191114055906.GA10643@sigill.intra.peff.net>
 <ab4dcc9c-4416-aef8-c8c4-38bb5ec97990@virtuell-zuhause.de>
 <20191115034941.GB20863@sigill.intra.peff.net>
 <917e2664-6059-c190-30fd-02f3cf7aa5dc@virtuell-zuhause.de>
 <xmqqmucw4h4n.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmucw4h4n.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 16, 2019 at 12:47:20PM +0900, Junio C Hamano wrote:

> > I would have expected that git log did just tell me that it could not
> > find something commitish, instead it told me that there are multiple
> > candidates, all of them being no commit.
> 
> With this, I 100% agree with.   The latter should instead say
> 
>     $ git log abcd2 [--]
>     error: bad revision 'abcd2'
> 
> just like the case where no object has abcd2 as prefix.
> 
> When we ask for commit-ish or any specific type in general, there
> are a few possible cases.
> 
>  - There is only one such object that has the prefix and is
>    compatible with the type.  We handle this correctly---yield that
>    object and do not complain about ambiguity.
> 
>  - There are two or more such objects, or there is no such object.
>    We show all objects that share the prefix, regardless of the
>    type, which is way suboptimal.
> 
> An improvement can be localized to sha1-name.c::get_short_oid(), I
> would think.  We know what type we want (e.g. GET_OID_COMMITTISH)
> in the function, so we should be able to teach collect_ambiguous() 
> to discard an object with the given prefix but of a wrong type.

I think that changes the meaning of GET_OID_COMMITTISH, though. Right
now it means "if disambiguating, prefer a committish", but not "I can
only accept a commit". So we would still happily return an unambiguous
object that does not match that type. And that is why "git -c
core.disambiguate=committish show $short_blob" works, for example.

If you adjust your first case above to "only one such object...and the
type does not matter" then I think it is OK. I.e., the logic in
get_short_oid() becomes:

  - if there is only one, return it

  - if there is more than one, and only one matches the disambiguator,
    return it

  - otherwise, _do not_ print the ambiguous list, and return an error
    (and no object at all), letting the caller complain

where the third part is the new behavior. I think that helps in some
ways (you do not get a list of non-commits for a context that only takes
commits). But it might also hurt, because it gives the user less
information. E.g., imagine the user feeds a short sha1 that they know to
be a blob to a command expecting a committish and is told "no, that
short sha1 does not exist", even though the actual problem is that there
are two such blobs.

I think it's a bit simpler for a command which doesn't expect
non-commits at all, like "git log". But it would need to communicate
that to get_short_oid() with more than just GET_OID_COMMITTISH, so that
the latter can tell it apart from contexts which merely prefer a
committish.

I'm also not entirely sure that even that case doesn't suffer from
telling the user less information. If I say "git log 1234" knowing that
"1234" is a blob, that's a mistake. But Git may guide me in correcting
that mistake by saying "yes, we know about 1234, but it's ambiguous"
rather than "1234 is not something we know about".

Perhaps a simple fix would just be for get_short_oid()'s error message
to mention the disambiguation rule. E.g., something like:

   $ git show abcd2
   error: short SHA1 abcd2 is ambiguous
   hint: We would have preferred a commit or tag pointing to a commit,
   hint: but none were found. The candidates are:
   hint:   abcd22f55e tree
   hint:   abcd238df0 tree
   hint:   abcd2b1cc8 blob

or

  $ git show abcd2
  error: short SHA1 abcd2 is ambiguous
  hint: We preferred a commit or tag pointing to a commit to other
  hint: object types, but two candidates were found:
  hint:   abcd22f55e commit
  hint:   abcd238df0 commit
  hint:   abcd2b1cc8 blob

(optionally the second one could even not mention the blob, though I
think with the lead-in sentence it's OK).

The verbiage there isn't great (I was trying to avoid the jargon
"committish"), but hopefully you get the point.

-Peff
