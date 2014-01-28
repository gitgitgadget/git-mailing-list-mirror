From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Added get sendmail from .mailrc
Date: Mon, 27 Jan 2014 20:04:59 -0500
Message-ID: <20140128010459.GA17945@sigill.intra.peff.net>
References: <1390643210-5748-1-git-send-email-brilliantov@inbox.ru>
 <20140125223721.GA2684@dcvr.yhbt.net>
 <20140126073438.GA3858@kirill.netbynet.ru>
 <20140126091709.GA31073@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jan 28 02:05:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7x6y-0003SM-QB
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 02:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbaA1BFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 20:05:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:39993 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753334AbaA1BFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 20:05:01 -0500
Received: (qmail 30711 invoked by uid 102); 28 Jan 2014 01:05:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Jan 2014 19:05:01 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jan 2014 20:04:59 -0500
Content-Disposition: inline
In-Reply-To: <20140126091709.GA31073@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241174>

On Sun, Jan 26, 2014 at 09:17:09AM +0000, Eric Wong wrote:

> > > > +use File::HomeDir;
> > > 
> > > We should probably avoid a new dependency and also remain consistent
> > > with the rest of git handles home directories.
> > > 
> > > Unfortunately, expand_user_path()/git_config_pathname() isn't currently
> > > exposed to scripters right now...
> > 
> > Ok, if new dependency is not allowed I see next ways:
> 
> Not saying it's not allowed.  I meant we should probably expose
> expand_user_path()/git_config_pathname() C functions to script helpers
> (so git-config or git-rev-parse can provide them to sh or perl scripts).

I do not think we need anything so complex. Most of the logic in
expand_user_path is about handling "~" and "~user". But here we _just_
want to know the current user's home directory, and for that
expand_user_path always just looks in $HOME.

So I think $ENV{HOME} would be fine to match what git does. My
understanding is that File::HomeDir does some magic that may work better
on non-Unix platforms. I do not know if we even care for this feature,
since .mailrc is presumably a Unix thing. But if we do, I think our
usual strategy with such things is to optionally use the dependency if
available, and fall back to something sane. Like:

  sub homedir {
        if (eval { require File::HomeDir; 1 }) {
                return File::HomeDir->my_home;
        }
        return $ENV{HOME};
  }

Whichever code path is followed, you should probably also check the
result for "undef", which the original patch did not do.

-Peff
