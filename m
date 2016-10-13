Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1F520989
	for <e@80x24.org>; Thu, 13 Oct 2016 16:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756422AbcJMQTb (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 12:19:31 -0400
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:55539 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756300AbcJMQT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 12:19:29 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1buiPr-0007ub-2O; Thu, 13 Oct 2016 17:59:31 +0200
Date:   Thu, 13 Oct 2016 17:59:29 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org, Jens.Lehmann@web.de,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 3/3] batch check whether submodule needs pushing into
 one call
Message-ID: <20161013155929.GB29710@book.hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net>
 <cover.1475851621.git.hvoigt@hvoigt.net>
 <67d4c48dc0129f20041c88d27a49c7a21188c882.1475851621.git.hvoigt@hvoigt.net>
 <xmqqlgxvbype.fsf@gitster.mtv.corp.google.com>
 <20161012133338.GD84247@book.hvoigt.net>
 <xmqqwphd4gf6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwphd4gf6.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 10:37:33AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >> If we do not even have these commits locally, then there is no point
> >> attempting to push, so returning 0 (i.e. it is not "needs pushing"
> >> situation) is correct but it is a but subtle.  It's not "we know
> >> they already have them", but it is "even if we tried to push, it
> >> won't do us or the other side any good."  A single-liner in-code
> >> comment may help.
> >
> > First the naming part. How about:
> >
> > 	submodule_has_commits()
> 
> Nice.

Ok will use that. And while I am at it: I will also rename all the
'hashes' variables to commits because that makes the code way clearer I
think.

> > Returning 0 here means: "No push needed" but the correct answer would
> > be: "We do not know". 
> 
> Is it?  Perhaps I am misreading the "submodule-has-commits"; I
> thought it was "the remote may or may not need updating, but we
> ourselves don't have what they may need to have commits in their
> submodule that are referenced by their superproject, so it would not
> help them even if we pushed our submodule to them".  It indeed is
> different from "No push needed" (rather, "our pushing would be
> pointless").

Yes you could also rephrase/see it that way. But the question is: If we
do not have what the remote needs would the user expect us to tell him
that fact and stop or does he usually not care?

> > So how about:
> >
> >
> > 	if (!submodule_has_hashes(path, hashes))
> > 		/* NEEDSWORK: The correct answer here is "We do not
> > 		 * know" instead of "No". We currently proceed pushing
> > 		 * here as if the submodules commits are available on a
> > 		 * remote, which is not always correct. */
> > 		return 0;
> 
> I am not sure.  
> 
> What should happen in this scenario?
> 
>  * We have two remotes, A and B, for our superproject.
> 
>  * We are not interested in one submodule at path X.  Our repository
>    is primarily used to work on the superproject and possibly other
>    submodules but not the one at path X.
> 
>  * We pulled from A to update ourselves.  They were actively working
>    on the submodule we are not interested in, and path X in the
>    superproject records a new commit that we do not have.
> 
>  * We are now trying to push to B.

I am not sure if this is a typical scenario? Well, if you are updating
your main branch from someone else and then push it to your own fork
maybe. You could specify --no-recurse-submodules for this case though.
The proper solution for this case would probably be something along the
lines of 'submodule.<name>.fetchRecurseSubmodules' but for push so we
can mark certain submodules as uninteresting by default.

I like to be more protective to the user here. Its usually more
annoying for possibly many others when you push out things that have
missing things compared to one person not being able to push because his
submodule is not up-to-date/initialized.

> Should different things happen in these two subcases?
> 
>  - We are not interested in submodule at path X, so we haven't even
>    done "submodule init" on it.
> 
>  - We are not interested in submodule at path X, so even though we
>    do have a rather stale clone of it, we do not usually bother
>    updating what is checked out at path X and commit our changes
>    outside that area.
> 
> I tend to think that in these two cases the same thing should
> happen.  I am not sure if that same thing should be rejection
> (i.e. "you do not know for sure that the commit at path X of the
> superproject you are pushing exists in the submodule repository at
> the receiving end, so I'd refuse to push the superproject"), as it
> makes the only remedy for the situation is for you to make a full
> clone of the submodule you are not interested in and you have never
> touched yourself in either of these two subcases.

I also think in both situations the same thing should happen. A decision
that something different should happen should be made explicitly instead
of implicitly just because some submodule is not initialized. That might
be by accident or because a certain submodule is new so here the choice
should be made deliberately by the user, IMO.

Cheers Heiko
