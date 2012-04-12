From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Thu, 12 Apr 2012 01:52:17 -0400
Message-ID: <20120412055216.GC27369@sigill.intra.peff.net>
References: <1334154569-26124-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Thu Apr 12 07:52:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SICxE-00010n-Va
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 07:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807Ab2DLFwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 01:52:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58292
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756773Ab2DLFwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 01:52:19 -0400
Received: (qmail 22802 invoked by uid 107); 12 Apr 2012 05:52:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 01:52:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 01:52:17 -0400
Content-Disposition: inline
In-Reply-To: <1334154569-26124-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195298>

On Wed, Apr 11, 2012 at 10:29:29AM -0400, marcnarc@xiplink.com wrote:

>  builtin/fetch.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 65f5f9b..57be58a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -298,8 +298,13 @@ static int update_local_ref(struct ref *ref,
>  			what = _("[new tag]");
>  		}
>  		else {
> -			msg = "storing head";
> -			what = _("[new branch]");
> +			if (!prefixcmp(ref->name, "refs/heads/")) {
> +				msg = "storing head";
> +				what = _("[new branch]");
> +			} else {
> +				msg = "storing ref";
> +				what = _("[new ref]");
> +			}
>  			if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
>  			    (recurse_submodules != RECURSE_SUBMODULES_ON))
>  				check_for_new_submodule_commits(ref->new_sha1);

It looks like you kept the behavior the same with respect to
recurse_submodules, which will continue to run for everything except
tags. Which is probably a good choice, since your patch only wanted to
deal with the status message, but I am left to wonder: if submodules
were intended to be recursed for branches but not tags, what should
happen for other types of refs? Was it intentional that they fell into
the "branch" category here, or were they following the same failure to
distinguish that the message-writing code had?

This code block handles only new refs.  If you look at the code below,
updates of existing refs (forced or not) will happen for all refs,
including tags.

Jens, can you double-check the intended logic?

-Peff
