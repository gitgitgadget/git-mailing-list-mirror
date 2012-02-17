From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 3/3] push: add 'prune' option
Date: Fri, 17 Feb 2012 17:25:07 -0500
Message-ID: <20120217222507.GA31830@sigill.intra.peff.net>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
 <1329505957-24595-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 23:25:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyWEv-0006bT-Co
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 23:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab2BQWZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 17:25:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41246
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab2BQWZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 17:25:09 -0500
Received: (qmail 12735 invoked by uid 107); 17 Feb 2012 22:25:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Feb 2012 17:25:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2012 17:25:07 -0500
Content-Disposition: inline
In-Reply-To: <1329505957-24595-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190980>

On Fri, Feb 17, 2012 at 09:12:37PM +0200, Felipe Contreras wrote:

> This will allow us to remove refs from the remote that have been removed
> locally.
> 
> It's useful to conveniently synchronize all the local branches to
> certain remote.

Thanks for picking up this topic again.

There's one subtlety in the motivation above that you may find helpful
when you end up writing the documentation: "push --mirror" already does
this sort of pruning, but it _also_ implies that we are pushing
"refs/*:refs/*".  So this is really about giving access to the pruning
half, but still being able to use custom refspecs. So the features
together might end up being explained something like:

  --prune::
    ... prune things that no longer exist locally ...

  --mirror::
    ... turn on --prune, and also match all refs ...

At least that is my understanding of how the code is meant to work.

>  builtin/push.c |    2 ++
>  remote.c       |   29 ++++++++++++++++++++++++++---
>  remote.h       |    3 ++-
>  transport.c    |    2 ++
>  transport.h    |    1 +
>  5 files changed, 33 insertions(+), 4 deletions(-)

I've just given a quick read to the patches so far, but I did notice
this:

>  static char *check_pattern_match(const struct refspec *rs, int rs_nr, struct ref *ref,
> -		int send_mirror, const struct refspec **ret_pat)
> +		int send_mirror, int dir, const struct refspec **ret_pat)

The "dir" flag looks like it is meant to be short for "direction". But
the callers only pass 0 or 1.  I'm not clear which direction is which.
Either symbolic constants for directions, or perhaps giving it a more
boolean name like "match_to_dst" might make it more clear.

I'll try to take a closer look later tonight.

-Peff
