From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/2] Add support for sending additional HTTP headers
Date: Wed, 4 May 2016 03:45:59 -0400
Message-ID: <20160504074559.GA3077@sigill.intra.peff.net>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
 <cover.1462342213.git.johannes.schindelin@gmx.de>
 <20160504062618.GA9849@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 09:46:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axrVX-0000w9-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 09:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756934AbcEDHqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 03:46:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:33724 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751256AbcEDHqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 03:46:03 -0400
Received: (qmail 27314 invoked by uid 102); 4 May 2016 07:46:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 03:46:02 -0400
Received: (qmail 7693 invoked by uid 107); 4 May 2016 07:46:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 03:46:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 03:45:59 -0400
Content-Disposition: inline
In-Reply-To: <20160504062618.GA9849@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293508>

On Wed, May 04, 2016 at 02:26:18AM -0400, Jeff King wrote:

> >   submodule: pass on http.extraheader config settings
> 
> IMHO this should come on top of jk/submodule-config-sanitize-fix (I was
> surprised at first that your test worked at all, but that is because it
> is using "clone", which is the one code path that works).
> 
> But I think we are waiting on going one of two paths:
> 
>   1. drop sanitizing entirely
> 
>   2. fix sanitizing and add more variables to it
> 
> If we go the route of (2), then we'd want my fix topic and this patch.
> And if not, then we don't need any of it (just a patch dropping the
> filtering, which AFAIK nobody has written yet).

Actually, I think this last bit is not quite true. If we want to go back
to "nothing gets passed to submodules", we can drop all of my patches,
but I don't think anybody wants to do that.

But if we want "everything gets passed to submodules", then we do need
something like my patch series, because every use of local_repo_env
needs to be come "local_repo_env excluding GIT_CONFIG_PARAMETERS". I
don't think we want to simply drop that variable from local_repo_env
(which would also mean that it would be propagated to a local
git-upload-pack, for example, along with any third-party scripts that
use rev-parse --local-env-vars).

So I think we'd actually want my series as a preliminary fix, followed
by dropping the whitelist entirely on top of that, and then probably
simplifying the shell sanitize_submodule_env() on top of that (it would
be correct without the whitelist, but you can also trivially implement
it without having to call submodule--helper at all).

-Peff
