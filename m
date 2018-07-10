Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61CC1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 14:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933717AbeGJODO (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 10:03:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:53580 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933336AbeGJODM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 10:03:12 -0400
Received: (qmail 16895 invoked by uid 109); 10 Jul 2018 14:03:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 14:03:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23678 invoked by uid 111); 10 Jul 2018 14:03:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 10:03:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 10:03:10 -0400
Date:   Tue, 10 Jul 2018 10:03:10 -0400
From:   Jeff King <peff@peff.net>
To:     Perry Hutchison <perryh@pluto.rain.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org, paul@mad-scientist.net, dnj@google.com
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
Message-ID: <20180710140310.GA9246@sigill.intra.peff.net>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
 <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
 <20180709195822.GA9000@sigill.intra.peff.net>
 <20180710035635.GA13459@sigill.intra.peff.net>
 <5b445ca6.TkV9Dj8T2KFinxZP%perryh@pluto.rain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b445ca6.TkV9Dj8T2KFinxZP%perryh@pluto.rain.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 12:13:42AM -0700, Perry Hutchison wrote:

> Jeff King <peff@peff.net> wrote:
> 
> > If I understand correctly, the Linux implementation requires reading
> > from /proc. So an executable that only did RUNTIME_PREFIX (with no
> > fallback to static paths) would be unhappy inside a chroot or other
> > container that didn't mount /proc.
> 
> If we need /proc, wouldn't we _already_ be unhappy inside a chroot
> that didn't mount /proc, even _with_ fallback to static paths?
> Last I knew, the whole point of chroots/containers/jails/etc. was to
> prevent access, from a process running inside the container, to any
> part of the FS that's outside of the container.

My point is that aside from RUNTIME_PREFIX, we don't need /proc. So
somebody who currently builds Git with a static path like
"/usr/libexec/git-core" and runs it inside a chroot will be just fine as
long as /usr/libexec/git-core is available at that name inside the
chroot. But if the build starts relying on RUNTIME_PREFIX, it's going to
regress their case.

I'm not sure how hypothetical this is. A lot of Debian tools use chroots
to build packages for specific releases by basically installing the
distro inside the chroot. I don't know whether /proc is available in
those chroots or not. If not, then I suspect builds that rely on
installing Git inside the chroot are going to break.

+cc Jonathan, who maintains the Git package for Debian, and can probably
say immediately whether I am way off base. ;)

-Peff
