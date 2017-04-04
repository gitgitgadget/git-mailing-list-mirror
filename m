Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36AD020966
	for <e@80x24.org>; Tue,  4 Apr 2017 08:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbdDDIe5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 04:34:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:56419 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbdDDIdp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 04:33:45 -0400
Received: (qmail 16401 invoked by uid 109); 4 Apr 2017 08:33:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 08:33:42 +0000
Received: (qmail 4837 invoked by uid 111); 4 Apr 2017 08:34:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 04:34:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Apr 2017 04:33:41 -0400
Date:   Tue, 4 Apr 2017 04:33:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 04, 2017 at 10:17:51AM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Apr 4, 2017 at 4:54 AM, Jeff King <peff@peff.net> wrote:
> > My feeling is that this is old enough to stop caring about. Which means
> > we can drop some of the #ifdefs that clutter the HTTP code (and there's
> > a patch at the end of this mail dropping support for everything older
> > than 7.11.1). But that made wonder: how old is too old? I think it's
> > nice that we don't force people to upgrade to the latest version of
> > curl. But at some point, if you are running a 13-year-old version of
> > libcurl, how likely are you to run a brand new version of Git? :)
> >
> > If we declared 7.16.0 as a cutoff, we could unconditionally define
> > USE_CURL_MULTI, which gets rid of quite a few messy ifdefs.
> 
> I don't object to this patch, but just as a general comment, in
> enterprise-y environments using an old OS (e.g. CentOS 5/6) & then
> compiling some selected packages like git based on OS libraries is
> quite common.
> 
> E.g. at work we're running git 2.12.0 compiled against CentOS 6
> libraries, which has curl 7.20.1, released on
> Apr 14 2010. Not so long ago we were still running CentOS 5 which
> comes with 7.15.5 released in Aug 7 2006 which would break with your
> patch.
> 
> Whether we support that is another question, I think it's reasonable
> to say that if you're compiling git on such an old system you also
> need to compile a libcurl instead of using the OS version. I just
> wanted to point out that this *does* happen, someone is going to be
> compiling new git releases on CentOS 5 & will be hit by this.

Thanks, that's a very useful bit of data. According to:

  https://access.redhat.com/support/policy/updates/errata

RHEL5 (which as I understand it basically the same as CentOS 5 in terms
of packages) ended its 10-year support cycle just a few days ago. That
would perhaps make 7.20.1 a reasonable cutoff.

I dunno. We could also just punt on the whole thing. It was nice to see
a bunch of #ifdefs go away, but the code they're protecting is actually
not that complicated. Most of them do not have an #else at all, and we
just silently skip features on old versions.

I think it might be nice to declare a "too old" version, though, just so
we can stop adding _new_ ifdefs. Maybe 7.11.1 is that version now, and
in another few years we can bump to 7.16.0. :)

-Peff
