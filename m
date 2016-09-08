Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1B3020705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932882AbcIHSyP (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:54:15 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42499 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932787AbcIHSyP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:54:15 -0400
Received: from mfilter47-d.gandi.net (mfilter47-d.gandi.net [217.70.178.178])
        by relay6-d.mail.gandi.net (Postfix) with ESMTP id 20242FB887;
        Thu,  8 Sep 2016 20:54:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter47-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
        by mfilter47-d.gandi.net (mfilter47-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id i0tYs6U1x64g; Thu,  8 Sep 2016 20:54:11 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7B774FB8BF;
        Thu,  8 Sep 2016 20:54:10 +0200 (CEST)
Date:   Thu, 8 Sep 2016 11:54:08 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before
 email signature
Message-ID: <20160908185408.5qtfnztjbastlrtw@x>
References: <20160908011200.qzvbdt4wjwiji4h5@x>
 <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 11:34:15AM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > Any text below the "-- " for the email signature gets treated as part of
> > the signature, and many mail clients will trim it from the quoted text
> > for a reply.  Move it above the signature, so people can reply to it
> > more easily.
> >
> > Add tests for the exact format of the email signature, and add tests to
> > ensure the email signature appears last.
> >
> > (Patch by Junio Hamano; tests by Josh Triplett.)
> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> > ---
> >
> > Does the above seem reasonable, for a patch that incorporates the
> > proposed patch from Message-Id
> > xmqqh99rpud4.fsf@gitster.mtv.corp.google.com and adds tests?
> 
> Other than that I'd probably retitle it,

Ah, true, I should have titled it "format-patch: move base commit ...".

> your problem description
> looks perfect.  I am still not sure if the code does a reasonable
> thing in MIME case, though.

It *looks* correct to me.

> Thanks for tying the loose ends anyway.
> 
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index b0579dd..a4af275 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -754,9 +754,22 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
> >  	git format-patch --ignore-if-in-upstream HEAD
> >  '
> >  
> > +git_version="$(git --version | sed "s/.* //")"
> > +
> > +signature() {
> > +	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
> > +}
> 
> Hmph.  I would actually have expected that you would force a fixed
> and an easily noticeable string via format.signature for the purpose
> of the test,

One of the git tests already did that.  I just modified that test to
test the exact signature format and that it appears at the end, rather
than just grepping to check that the signature string appears somewhere.
Then when doing so, I realized that I should check the default case too
(at which point that test change probably should have gone in a separate
patch).

> but I guess this test covers a lot more than what the
> purpose of the main part of the patch does (i.e. enforces that the
> default signature must be made from the version string of Git).  It
> is not a bad thing to test, but it probably does not belong to this
> change.  If you _were_ to split the patch in two, that is where I
> probably would split, i.e. "we didn't test what the default signature
> looks like, or we didn't make sure --signature option overrides the
> default signature, so let's test it" as the preliminary preparation,
> followed by "having base info after sig is inconvenient, let's move
> it and make sure base info stays before sig with additional test" as
> the second (and primary) patch.
>
> But a single patch is fine.
> 
> Thanks.

If any other change ends up being necessary, I'll split the patch in v2.

- Josh Triplett
