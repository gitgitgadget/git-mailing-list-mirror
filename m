From: Jeff King <peff@peff.net>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Wed, 19 Nov 2014 14:08:00 -0500
Message-ID: <20141119190800.GB9908@peff.net>
References: <6997784.RuzRO1AFsK@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Wed Nov 19 20:08:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrAbo-0006XM-2P
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 20:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749AbaKSTIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 14:08:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:42387 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754554AbaKSTID (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 14:08:03 -0500
Received: (qmail 25852 invoked by uid 102); 19 Nov 2014 19:08:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 13:08:02 -0600
Received: (qmail 6373 invoked by uid 107); 19 Nov 2014 19:08:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 14:08:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Nov 2014 14:08:00 -0500
Content-Disposition: inline
In-Reply-To: <6997784.RuzRO1AFsK@al>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 04:18:02PM +0100, Peter Wu wrote:

> git remote set-url knew about the '--push' option to update just the
> pushurl, but it does not have a similar option for "update fetch URL and
> leave whatever was in place for the push URL".

Isn't that what:

  git remote set-url foo new-fetch-url

does already? It affects only the "url" setting, which is the de-facto
fetch setting (it is _also_ the push setting if there is no pushurl
defined).

You gave this example:

>     git remote add gh git@github.com:Lekensteyn/git.git
>     # Avoid needing SSH for pulling from a repo, so change fetch URL
>     git remote set-url https://github.com/Lekensteyn/git.git
>     # Hmm, the fetch URL got changed too, let's fix that.
>     git remote add --push gh git@github.com:Lekensteyn/git.git

But here you do not have a pushurl defined in the first place. So I
guess this is really just a shortcut for swapping the two, like:

  git remote set-url --push gh $(git config remote.gh.url)
  git remote set-url gh new-fetch-url

I dunno. I guess that is more convenient, but it seems like a lot of
code for a very marginal use case. But more importantly, I'm a little
worried that the presence of --fetch creates confusion about what
set-url without a --fetch or --push does. That is, it implies to me
that:

  git remote add gh old-url
  git remote set-url gh --push push-url
  git remote set-url gh new-url

would replace both the "url" _and_ "pushurl" values in the third step,
since we did not specify --fetch.  But it is in fact identical whether
you run it with "--fetch" or not.  That is, it creates a weirdly
non-orthogonal interface.

-Peff
