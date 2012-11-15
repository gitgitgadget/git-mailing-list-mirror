From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: don't segfault when given --path with a missing
 value
Date: Thu, 15 Nov 2012 08:11:50 -0800
Message-ID: <20121115161149.GB6157@sigill.intra.peff.net>
References: <1352868604-20459-1-git-send-email-cmn@elego.de>
 <20121115160847.GA6157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:12:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ22y-0008Qq-DW
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 17:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768369Ab2KOQLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 11:11:54 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49504 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768347Ab2KOQLy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 11:11:54 -0500
Received: (qmail 17510 invoked by uid 107); 15 Nov 2012 16:12:43 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 11:12:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 08:11:50 -0800
Content-Disposition: inline
In-Reply-To: <20121115160847.GA6157@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209823>

On Thu, Nov 15, 2012 at 08:08:49AM -0800, Jeff King wrote:

> That is definitely the right thing to do. But do we also need to take
> note of the error for later? After this code:
> 
> >  	} else if (types == TYPE_PATH) {
> > -		git_config_pathname(&vptr, key_, value_);
> > -		must_free_vptr = 1;
> > +		must_free_vptr = !git_config_pathname(&vptr, key_, value_);
> 
> We don't have any clue that nothing got written into vptr. Which means
> it still points at the stack buffer "value", which contains
> uninitialized bytes. We will later try to print it, thinking it has the
> expanded path in it.
> 
> Do we need something like:
> 
>   if (!git_config_pathname(&vptr, key_, value_))
>           must_free_vptr = 1;
>   else
>           vptr = "";

Hmm, actually, we should probably propagate the error (I was thinking
for some reason this was in the listing code, but it is really about
getting a specific variable, and that variable does not have a sane
format. We'll already have printed the non-bool error, so we should
probably die. So more like:

  if (git_config_pathname(&vptr, key_, value_) < 0)
          return -1;
  must_free_vptr = 1;

-Peff
