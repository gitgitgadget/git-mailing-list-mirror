Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4271F4B6
	for <e@80x24.org>; Sun, 12 May 2019 04:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfELEI2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 00:08:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:55030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725913AbfELEI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 May 2019 00:08:28 -0400
Received: (qmail 27303 invoked by uid 109); 12 May 2019 04:08:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 May 2019 04:08:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29067 invoked by uid 111); 12 May 2019 04:09:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 12 May 2019 00:09:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 May 2019 00:08:26 -0400
Date:   Sun, 12 May 2019 00:08:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
Message-ID: <20190512040825.GA25370@sigill.intra.peff.net>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9ygwoj0.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 12, 2019 at 01:37:55AM +0200, Ævar Arnfjörð Bjarmason wrote:

> This way of doing it just seems so weirdly convoluted. Read them one at
> a time, compute the SHA-1, just to see if they're different. Why not
> something closer to a plain memcmp():

FWIW, I had the exact same thought on reading the patch. Checking sizes
seems like an easy optimization and I don't mind it, but computing
hashes when we could just compare the bytes seems pointless. I'd have
expected to stream 4k blocks as we go.

> I.e. optimze for code simplicity with something close to a dumb "cmp
> --silent". I'm going to make the bold claim that nobody using "dumb
> http" is going to be impacted by the performance of reading their
> for-each-ref or for-each-pack dump, hence opting for not even bothing to
> stat() to get the size before reading.

You're probably right (especially because we'd just spent O(n) work
generating the candidate file). But note that I have seen pathological
cases where info/refs was gigabytes.

> >  /*
> >   * Create the file "path" by writing to a temporary file and renaming
> >   * it into place. The contents of the file come from "generate", which
> >   * should return non-zero if it encounters an error.
> >   */
> > -static int update_info_file(char *path, int (*generate)(FILE *))
> > +static int update_info_file(char *path, int (*generate)(FILE *), int force)
> >  {
> >  	char *tmp = mkpathdup("%s_XXXXXX", path);
> 
> Unrelated to this, patch, but I hadn't thought about this nasty race
> condition. We recommend users run this from the "post-update" (or
> "post-receive") hook, and don't juggle the lock along with the ref
> update, thus due to the vagaries of scheduling you can end up with two
> concurrent ref updates where the "old" one wins.
> 
> But I guess that brings me back to something close to "nobody with that
> sort of update rate is using 'dumb http'" :)
> 
> For this to work properly we'd need to take some sort of global "ref
> update/pack update" lock, and I guess at that point this "cmp" case
> would be a helper similar to commit_lock_file_to(),
> i.e. a commit_lock_file_to_if_different().

I don't think our usual dot-locking is great here. What does the
race-loser do when it can't take the lock? It can't just skip its
update, since it needs to make sure that its new pack is mentioned.

So it has to wait and poll until the other process finishes. I guess
maybe that isn't the end of the world.

> Then in b3223761c8 ("update_info_refs(): drop unused force parameter",
> 2019-04-05) Jeff removed the unused-for-a-decade "force" param.
> 
> So having gone through the history I think we're better off just
> dropping the --force argument entirely, or at least changing the
> docs.
> 
> Before this change the only thing it was doing was pruning stuff we
> haven't written since 2005-ish (see 3e15c67c90 ("server-info: throw away
> T computation as well.", 2005-12-04)), rather than "detect if useless"
> we should just write out the file again, and then skip if changed
> (i.e. this logic).

Yeah, my commit only ripped out the useless force parameter for
info/refs. For info/packs, there's still that weird "is is stale"
computation (which I fixed several bugs in). It's not entirely clear to
me if that can just go away, but I agree that if we can it's simpler and
more desirable to just generate the candidate result and see if it's
bit-for-bit identical or not.

I'm not entirely sure of all of the magic that "stale" check is trying
to accomplish. I think there's some bits in there that try to preserve
the existing ordering, but I don't know why anyone would care (and there
are so many cases where the ordering gets thrown out that I think
anybody who does care is likely to get disappointed).

-Peff
