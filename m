From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/1] support -4 and -6 switches for remote operations
Date: Sat, 30 Jan 2016 20:13:14 -0500
Message-ID: <20160131011314.GA22855@sigill.intra.peff.net>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
 <20160130085056.GA20118@dcvr.yhbt.net>
 <20160130131353.GA20429@dcvr.yhbt.net>
 <56AD4887.3070207@web.de>
 <20160131000144.GA10117@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jan 31 02:13:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPgZv-0001AX-4p
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 02:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbcAaBNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 20:13:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:34980 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753256AbcAaBNS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 20:13:18 -0500
Received: (qmail 6363 invoked by uid 102); 31 Jan 2016 01:13:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 20:13:17 -0500
Received: (qmail 12556 invoked by uid 107); 31 Jan 2016 01:13:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 20:13:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jan 2016 20:13:14 -0500
Content-Disposition: inline
In-Reply-To: <20160131000144.GA10117@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285133>

On Sun, Jan 31, 2016 at 12:01:44AM +0000, Eric Wong wrote:

> > > --- a/builtin/clone.c
> > > +++ b/builtin/clone.c
> > > @@ -47,6 +47,7 @@ static const char *real_git_dir;
> > >  static char *option_upload_pack = "git-upload-pack";
> > >  static int option_verbosity;
> > >  static int option_progress = -1;
> > > +static int ipv4, ipv6;
> > Do we need 2 variables here ?
> 
> Yes, I'm not sure how else to use OPT_BOOL below...

If they're mutually exclusive, and saying "-6" cancels "-4", you
probably want something like:

  enum {
	USE_NET_ALL = 0,
	USE_NET_IPV4,
	USE_NET_IPV6,
  } use_net;

  ...

  OPT_SET_INT('4', "ipv4", &use_net,
              N_("resolve IPv4 addresses only"), USE_NET_IPV4),
  OPT_SET_INT('6', "ipv6", &use_net,
              N_("resolve IPv6 addresses only"), USE_NET_IPV6),

Using --no-ipv4 will set it back to USE_NET_ALL, which is probably OK.
It will cancel a previous "--ipv4", which is logically consistent,
though I guess some people might assume that "--no-ipv4" means "do not
use ipv4 addresses". Supporting that would be more complicated.

-Peff
