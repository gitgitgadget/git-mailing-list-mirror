Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12C062047F
	for <e@80x24.org>; Fri,  4 Aug 2017 20:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbdHDUSj (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 16:18:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:58084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751268AbdHDUSj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 16:18:39 -0400
Received: (qmail 15353 invoked by uid 109); 4 Aug 2017 20:18:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Aug 2017 20:18:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28576 invoked by uid 111); 4 Aug 2017 20:18:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Aug 2017 16:18:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Aug 2017 16:18:36 -0400
Date:   Fri, 4 Aug 2017 16:18:36 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        git@vger.kernel.org
Subject: Re: [RFC] imap-send: escape backslash in password
Message-ID: <20170804201836.3t5fp7v5xfwz64h4@sigill.intra.peff.net>
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
 <20170804200643.gq5pqeoeje3xii57@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170804200643.gq5pqeoeje3xii57@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 04, 2017 at 08:06:43PM +0000, brian m. carlson wrote:

> On Fri, Aug 04, 2017 at 06:16:53PM +0200, Nicolas Morey-Chaisemartin wrote:
> >  static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *folder)
> >  {
> >  	struct credential cred = CREDENTIAL_INIT;
> > @@ -1090,7 +1116,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
> >  			if (!srvc->user)
> >  				srvc->user = xstrdup(cred.username);
> >  			if (!srvc->pass)
> > -				srvc->pass = xstrdup(cred.password);
> > +				srvc->pass = imap_escape_password(cred.password);
> >  		}
> >  
> >  		if (srvc->auth_method) {
> 
> I'm not sure if this is correct.  It looks like this username and
> password are used by whatever authentication method we use, whether
> that's LOGIN or CRAM-MD5.  I don't think we'd want to encode the
> password here before sending it through the CRAM-MD5 authenticator.

Yeah. This is an on-the-wire encoding issue, and should happen as part
of forming the protocol string to send. So:

  imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass)

is probably where it needs to happen.

It looks like this issue is present in a lot of other places, too. Just
a few lines below I see:

  imap_exec(ctx, NULL, "CREATE \"%s\"", ctx->name)

As an aside, these are all potential injection vulnerabilities, too.
E.g., if I specify my folder as

  foo"\n. DELETE "bar

then we'd issue an accidental deletion. I doubt it's a big deal in
practice, as it's not common to feed attacker-controlled strings to
imap-send. But we should probably fix it anyway.

The right interface is probably to teach imap_exec() to take a
NULL-terminated list of items (rather than a format string) and then
quote each one appropriately.

-Peff
