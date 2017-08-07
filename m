Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5570D2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdHGTnA (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:43:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:59526 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751589AbdHGTm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:42:59 -0400
Received: (qmail 27016 invoked by uid 109); 7 Aug 2017 19:42:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Aug 2017 19:42:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9831 invoked by uid 111); 7 Aug 2017 19:43:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Aug 2017 15:43:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Aug 2017 15:42:57 -0400
Date:   Mon, 7 Aug 2017 15:42:57 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] imap-send: add wrapper to get server credentials if
 needed
Message-ID: <20170807194257.jrdmpvoseauz37uc@sigill.intra.peff.net>
References: <9687e182-1e23-f84d-3fad-83fdf15dba4c@morey-chaisemartin.com>
 <CAN0heSoA_Xm+14V49hjJBMT7PS_ge0wyhmuvKiw-MHD99rApYQ@mail.gmail.com>
 <fdd74c52-7d9a-b12e-2e1f-524479201701@morey-chaisemartin.com>
 <CAN0heSqVmrFwP7LdjDJmH0JivoCc+DhGtUiTSBs=8nTppzG79A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqVmrFwP7LdjDJmH0JivoCc+DhGtUiTSBs=8nTppzG79A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2017 at 07:18:32PM +0200, Martin Ågren wrote:

> >> "cred.username" is checked further down, but now it will always be NULL,
> >> no?
> >
> > You're right I missed this.
> > Not sure if this is needed though.
> > From what I understand this means the username/password are store for the next access to credential. but in the current state, there is only one.
> > Maybe the credential_approved can be dropped ?
> 
> I'm no credentials-expert, but api-credentials.txt says this:
> 
> "Credential helpers are programs executed by Git to fetch or save
> credentials from and to long-term storage (where "long-term" is simply
> longer than a single Git process; e.g., credentials may be stored
> in-memory for a few minutes, or indefinitely on disk)."
> 
> So the calls to approve/reject probably do matter in some scenarios.

Right, this is important. credential_fill() may actually prompt the
user, and we'd want to then pass along that credential for storage. Or
the user may have changed their password, and the credential_reject() is
the only thing that prevents us from trying an out-dated password over
and over.

> The current code is a bit non-obvious as we just discovered since it
> duplicates the strings (for good reasons, I believe) and then still
> refers to the originals (also for good reasons, I believe). I suppose
> your new function could be called like
> 
> server_fill_credential(&cred, srvc);
> 
> That should limit the impact of the change, but I'm not sure it's a
> brilliant interface. Just my 2c.

That would work. I'm also tempted to say that imap_server_conf could
just store the "struct credential" inside it. We could even potentially
drop its parallel user/pass fields to minimize confusion.

Once upon a time imap-send was a fork of another program, which is why
most of its code isn't well-integrated with Git. But I think at this
point there's very little chance of merging changes back and forth
between the two.

On the other hand, if we're hoping to get rid of this code in favor of
the curl-based approach, then it's not worth spending time on
cosmetic refactoring, as long as it still behaves correctly in the
interim.

-Peff
