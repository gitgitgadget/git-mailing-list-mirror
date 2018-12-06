Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4BD211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 07:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeLFHU1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 02:20:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:60704 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728939AbeLFHU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 02:20:27 -0500
Received: (qmail 4562 invoked by uid 109); 6 Dec 2018 07:20:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Dec 2018 07:20:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6991 invoked by uid 111); 6 Dec 2018 07:19:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Dec 2018 02:19:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2018 02:20:03 -0500
Date:   Thu, 6 Dec 2018 02:20:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Coiner, John" <John.Coiner@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
Message-ID: <20181206072002.GA29787@sigill.intra.peff.net>
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
 <20181205210104.GC19936@sigill.intra.peff.net>
 <xmqqwoona2c6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwoona2c6.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 06, 2018 at 10:08:57AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In my opinion this feature is so contrary to Git's general assumptions
> > that it's likely to create a ton of information leaks of the supposedly
> > protected data.
> > ...
> 
> Yup, with s/implemented/designed/, I agree all you said here
> (snipped).

Heh, yeah, I actually scratched my head over what word to use. I think
Git _could_ be written in a way that is both compatible with existing
repositories (i.e., is still recognizably Git) and is careful about
object access control. But either way, what we have now is not close to
that.

> > Sorry I don't have a more positive response. What you want to do is
> > perfectly reasonable, but I just think it's a mismatch with how Git
> > works (and because of the security impact, one missed corner case
> > renders the whole thing useless).
> 
> Yup, again.
> 
> Storing source files encrypted and decrypting with smudge filter
> upon checkout (and those without the access won't get keys and will
> likely to use sparse checkout to exclude these priviledged sources)
> is probably the only workaround that does not involve submodules.
> Viewing "diff" and "log -p" would still be a challenge, which
> probably could use the same filter as smudge for textconv.

I suspect there are going to be some funny corner cases there. I use:

  [diff "gpg"]
  textconv = gpg -qd --no-tty

which works pretty well, but it's for files which are _never_ decrypted
by Git. So they're encrypted in the working tree too, and I don't use
clean/smudge filters.

If the files are already decrypted in the working tree, then running
them through gpg again would be the wrong thing. I guess for a diff
against the working tree, we would always do a "clean" operation to
produce the encrypted text, and then decrypt the result using textconv.
Which would work, but is rather slow.

> I wonder (and this is the primary reason why I am responding to you)
> if it is common enough wish to use the same filter for smudge and
> textconv?  So far, our stance (which can be judged from the way the
> clean/smudge filters are named) has been that the in-repo
> representation is the canonical, and the representation used in the
> checkout is ephemeral, and that is why we run "diff", "grep",
> etc. over the in-repo representation, but the "encrypted in repo,
> decrypted in checkout" abuse would be helped by an option to do the
> reverse---find changes and look substrings in the representation
> used in the checkout.  I am not sure if there are other use cases
> that is helped by such an option.

Hmm. Yeah, I agree with your line of reasoning here. I'm not sure how
common it is. This is the first I can recall it. And personally, I have
never really used clean/smudge filters myself, beyond some toy
experiments.

The other major user of that feature I can think of is LFS. There Git
ends up diffing the LFS pointers, not the big files. Which arguably is
the wrong thing (you'd prefer to see the actual file contents diffed),
but I think nobody cares in practice because large files generally don't
have readable diffs anyway.

-Peff
