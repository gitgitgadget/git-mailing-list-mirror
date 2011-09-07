From: Jeff King <peff@peff.net>
Subject: Re: Pushing with --mirror over HTTP?
Date: Wed, 7 Sep 2011 17:39:50 -0400
Message-ID: <20110907213950.GI13364@sigill.intra.peff.net>
References: <20068.19089.303108.950233@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:40:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Pqm-0006It-VA
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757244Ab1IGVjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:39:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34791
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757179Ab1IGVjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:39:52 -0400
Received: (qmail 6381 invoked by uid 107); 7 Sep 2011 21:40:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 17:40:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 17:39:50 -0400
Content-Disposition: inline
In-Reply-To: <20068.19089.303108.950233@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180917>

On Mon, Sep 05, 2011 at 12:05:37AM -0400, Eli Barzilay wrote:

> Is there anything broken with pushing with mirror over HTTP?  I'm
> trying that with a github url, and I get a broken-looking error
> message:
> 
>   remote part of refspec is not a valid name in :.have

It's probably nothing to do with http, but rather with alternate object
databases on the server (which GitHub uses heavily). The server hands
out fake ".have" refs telling you it has some other branch tips to base
packs off of. So I suspect the "push --mirror" code is simply wrong for
trying to update those refs (it may be exacerbated by using http,
though, as the remote helper code seems to have some extra checks).

> and with the google code, I get:
> 
>   error: unable to push to unqualified destination: HEAD
> 
> Pushing to both of these work fine without `--mirror'.

This one, I'm not sure. It may be related.

> (BTW, as a workaround, I'm using
>   push --force --tags <url> :
> is this achieving the same effect for a repo without weird refs?)

Not quite. I think:

  git push --force <url> refs/*:refs/*

would be closer. But even that's not quite right.  I believe that
"--mirror" will also delete any remote refs that don't exist locally
(which is why you are seeing the ":.have" refspec above, which attempts
to delete it).

-Peff
