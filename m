Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB197202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 22:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936619AbdKQWCO (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 17:02:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:32954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933170AbdKQWCM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 17:02:12 -0500
Received: (qmail 8903 invoked by uid 109); 17 Nov 2017 22:02:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Nov 2017 22:02:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28849 invoked by uid 111); 17 Nov 2017 22:02:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 17 Nov 2017 17:02:26 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Nov 2017 17:02:10 -0500
Date:   Fri, 17 Nov 2017 17:02:10 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
Message-ID: <20171117220210.6xqi26mabbyvxc2m@sigill.intra.peff.net>
References: <20171115125200.17006-1-chriscool@tuxfamily.org>
 <xmqqbmk3xaxg.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD1hcFLMvNsXONPNbxZhTbHVzSMdRgCB9m=ZGeSTpMsYew@mail.gmail.com>
 <20171117174258.GP3693@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171117174258.GP3693@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 17, 2017 at 12:42:58PM -0500, Todd Zullinger wrote:

> > I'd rather add a separate check for msgfmt than mixing the 2 issues,
> > because I think that unless it has been explicitly told to do so, Git
> > should not try to build git-gui and gitk in the first place if there is
> > a big chance that those tools will not work.
> 
> If that's a motivation, wouldn't a check in the gitk and git-gui scripts
> handle it?  That would provide an error at run time to the user.  This
> change is about helping the user who builds their own git and then runs it,
> so if they built git without wish installed and then ran git-gui, they'd get
> a clear error that wish is missing and could easily install it.  It's not
> needed for the build, so they wouldn't need to rebuild anything.

I think the message is already OK:

  $ ./gitk
  ./gitk: 3: exec: wish: not found

The question is whether we would want to catch this at build time. And I
think Junio's point is that we don't _know_ it's an error at build time.
We could be building gitk for use on a system that isn't quite like the
build system, so any "solution" here is going to have to make an
assumption either way.

It's also not foolproof. You could build when wish is present, and then
later uninstall it and receive the same error message.

I also think all of this is largely orthogonal to gettext. It just so
happens that if you don't have gettext installed, we'll try to run wish
as part of the build process, but detecting broken tcl setups was
definitely not part of the intent there.

And the failure actually runs the other way, too. If you have neither
gettext nor tcl, you get this confusing output:

  $ make NO_GETTEXT=1
  ...
  MSGFMT po/pt_pt.msg     MSGFMT    po/hu.msg Makefile:252: recipe for target 'po/pt_pt.msg' failed
  make[1]: *** [po/pt_pt.msg] Error 127

(the problem is not msgfmt, but our tcl substitute which cannot run).

I'm actually tempted to say that we should not be building the tcl parts
by default. IOW, instead of NO_TCLTK we should have USE_TCLTK. That
would also require an adjustment by package builders, but it would
hopefully be a really obvious one. And once the user has told our
Makefile that they definitely want to build the tcl parts, we'd
presumably just trust that the tcl path they give us is sane.

But it's possible I'm underestimating how many people actually use the
tcl scripts. Certainly I don't, and git-gui seems fairly primitive to me
these days compared to 3rd party tools. But then I don't use any of them
either. ;)

-Peff
