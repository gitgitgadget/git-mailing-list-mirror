Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CD8C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 21:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D259611CA
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhJEVnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 17:43:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33414 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235957AbhJEVnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 17:43:04 -0400
Received: (qmail 17754 invoked by uid 109); 5 Oct 2021 21:41:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Oct 2021 21:41:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8166 invoked by uid 111); 5 Oct 2021 21:41:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Oct 2021 17:41:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Oct 2021 17:41:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
Message-ID: <YVzGeE1T/Kp8DDZD@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <YVy2DNd+XemykKE0@coredump.intra.peff.net>
 <877derjia9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877derjia9.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 05, 2021 at 11:02:38PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> > index 4eb0421b3f..6467707c6e 100644
> > --- a/Documentation/git-cat-file.txt
> > +++ b/Documentation/git-cat-file.txt
> > @@ -94,8 +94,9 @@ OPTIONS
> >  	Instead of reading a list of objects on stdin, perform the
> >  	requested batch operation on all objects in the repository and
> >  	any alternate object stores (not just reachable objects).
> > -	Requires `--batch` or `--batch-check` be specified. Note that
> > -	the objects are visited in order sorted by their hashes.
> > +	Requires `--batch` or `--batch-check` be specified. By default,
> > +	the objects are visited in order sorted by their hashes; see
> > +	also `--unordered` below.
> >  
> >  --buffer::
> >  	Normally batch output is flushed after each object is output, so
> 
> Since you're doing while-you're-at-it anyway: Isn't the --unordered
> documentation also incorrect to reference --batch, which I take as it
> lazily using as a shorthand for --batch-all-objects.

I don't think so. It says:

--unordered::
        When `--batch-all-objects` is in use, visit objects in an
        order which may be more efficient for accessing the object
        contents than hash order. The exact details of the order are
        unspecified, but if you do not require a specific order, this
        should generally result in faster output, especially with
        `--batch`.  Note that `cat-file` will still show each object
        only once, even if it is stored multiple times in the
        repository.

So it correctly mentions that it is affecting --batch-all-objects in the
first sentence. The "especially with --batch" is correct, too. The
ordering has more of an effect if you are accessing the full object,
since there we are increasing the locality which the delta-base cache
relies on.  Whereas with --batch-check, even with size or type, that
locality is much less important (it might help disk or even RAM caches a
bit, but we are examining each object independently, even if it's a
delta, and not caching the intermediate results in any way ourselves).

Does that answer your question, or were you thinking of something else?

-Peff
