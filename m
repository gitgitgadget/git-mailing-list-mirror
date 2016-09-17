Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE5D207DF
	for <e@80x24.org>; Sat, 17 Sep 2016 04:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbcIQEUW (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 00:20:22 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47280 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbcIQEUU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 00:20:20 -0400
Received: from mfilter17-d.gandi.net (mfilter17-d.gandi.net [217.70.178.145])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id 7F52AC5A50;
        Sat, 17 Sep 2016 06:20:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter17-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter17-d.gandi.net (mfilter17-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id ZRXiK5J9ryK7; Sat, 17 Sep 2016 06:20:14 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id ED5A8C5A43;
        Sat, 17 Sep 2016 06:20:12 +0200 (CEST)
Date:   Fri, 16 Sep 2016 21:20:11 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH] format-patch: Add --rfc for the common case of [RFC
 PATCH]
Message-ID: <20160917042010.xm3amjk7cqocorxh@x>
References: <28c5d2c59851279858df22e844c6ff7c09f33199.1474046573.git-series.josh@joshtriplett.org>
 <20160917004922.rd6g3bqajyt4iyjm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160917004922.rd6g3bqajyt4iyjm@sigill.intra.peff.net>
User-Agent: NeoMutt/20160910 (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 05:49:22PM -0700, Jeff King wrote:
> On Fri, Sep 16, 2016 at 10:27:45AM -0700, Josh Triplett wrote:
> 
> > By far, the most common subject-prefix I've seen other than "PATCH" is
> > "RFC PATCH" (or occasionally "PATCH RFC").  Seems worth optimizing for
> > the common case, to avoid having to spell it out the long way as
> > --subject-prefix='RFC PATCH'.
> 
> "RFC" is the most common one for me, too. And if it ends here, I'm OK
> with it. But I'm a little worried with ending up with a proliferation of
> options.

I haven't seen a significant number of variations on subject prefixes; I
can't think of any other prefix I've seen often enough to suggest an
option.

> If we had a short-option for --subject-prefix, then:
> 
>   -P RFC
> 
> is not so bad compared to "--rfc". But if you want to spell it as "RFC
> PATCH" that's getting a bit longer. We could have a short option for
> "tag this in the subject prefix _in addition_ to writing PATCH". And
> then you could do:
> 
>   -T RFC
> 
> I dunno. One other thing to consider is that format-patch takes
> arbitrary diff options, so we'd want to avoid stomping on them with any
> short options (which is why I used "-T" instead of "-t", though I find
> it unlikely that many people use the latter with format-patch). That's a
> point in favor of --rfc, I think.

I agree; the short option space seems more contentious.  And in any
case, I find --rfc more ergonomic than "-T RFC". :)

> >  builtin/log.c           | 10 ++++++++++
> >  t/t4014-format-patch.sh |  9 +++++++++
> >  2 files changed, 19 insertions(+), 0 deletions(-)
> 
> Documentation?

Oops, thanks.  I'll send v2 shortly.

> > +static int rfc_callback(const struct option *opt, const char *arg, int unset)
> > +{
> > +	subject_prefix = 1;
> > +	((struct rev_info *)opt->value)->subject_prefix = xstrdup("RFC PATCH");
> > +	return 0;
> > +}
> 
> I was going to complain that you don't free() the previous value, but
> actually the other callers do not xstrdup() in the first place (and we
> do not need to do so here, either, as it's a string literal). We
> actually _do_ allocate a new copy when reading the value from config,
> but it's probably not a big deal in practice to leak that.
> 
> I also wonder if you could implement this as just:
> 
>   return subject_prefix_callback(opt, "RFC PATCH", unset);
> 
> And then if you write the documentation as:
> 
>   --rfc::
> 	Behave as if --subject-prefix="RFC PATCH" was specified.
> 
> then it will be trivially correct. :)

Nice idea; will do.

> > +cat >expect <<'EOF'
> > +Subject: [RFC PATCH 1/1] header with . in it
> > +EOF
> > +test_expect_success '--rfc' '
> > +	git format-patch -n -1 --stdout --rfc >patch &&
> > +	grep ^Subject: patch >actual &&
> > +	test_cmp expect actual
> > +'
> 
> Our usual style these days is to set up expectations inside the test
> blocks (and use "<<-" to get nice indentation; we also typically use
> "\EOF" but that's purely style).

I copied this from a test immediately above it. :)

I can change it easily enough, though.

- Josh Triplett
