From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 3/4] grep: allow to use textconv filters
Date: Wed, 6 Feb 2013 17:23:44 -0500
Message-ID: <20130206222344.GE27507@sigill.intra.peff.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <da8c01b918c94c84ab61859b1b1453885bff5b06.1360162813.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:24:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3DPW-0003On-WB
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165Ab3BFWXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:23:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37156 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932131Ab3BFWXr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:23:47 -0500
Received: (qmail 11336 invoked by uid 107); 6 Feb 2013 22:25:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 17:25:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 17:23:44 -0500
Content-Disposition: inline
In-Reply-To: <da8c01b918c94c84ab61859b1b1453885bff5b06.1360162813.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215653>

On Wed, Feb 06, 2013 at 04:08:52PM +0100, Michael J Gruber wrote:

> From: Jeff King <peff@peff.net>
> 
> Recently and not so recently, we made sure that log/grep type operations
> use textconv filters when a userfacing diff would do the same:
> 
> ef90ab6 (pickaxe: use textconv for -S counting, 2012-10-28)
> b1c2f57 (diff_grep: use textconv buffers for add/deleted files, 2012-10-28)
> 0508fe5 (combine-diff: respect textconv attributes, 2011-05-23)
> 
> "git grep" currently does not use textconv filters at all, that is
> neither for displaying the match and context nor for the actual grepping.
> 
> Introduce an option "--textconv" which makes git grep use any configured
> textconv filters for grepping and output purposes. It is off by default.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Signed-off-by: Jeff King <peff@peff.net>

I'd really love to see the refactoring I talked about in my earlier
message. But as I'm not willing to devote the time to do it right now,
and I do not think this patch has any particular bugs, I think it is OK
as it gets the job done, and does not make the later refactoring any
harder.

The one ugliness that still remains is:

> +	if (opt->allow_textconv) {
> +		grep_source_load_driver(gs);
> +		/*
> +		 * We might set up the shared textconv cache data here, which
> +		 * is not thread-safe.
> +		 */
> +		grep_attr_lock();
> +		textconv = userdiff_get_textconv(gs->driver);
> +		grep_attr_unlock();
> +	}

We lock/unlock the grep_attr_lock twice here: once in
grep_source_load_driver, and then immediately again to call
userdiff_get_textconv. I don't know if it is worth doing the two under
the same lock or not (I guess it should not increase lock contention,
since we do the same amount of work, so it is really just the extra lock
instructions).

-Peff
