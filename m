From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: don't confuse prefixes with leading directories
Date: Tue, 10 Jan 2012 13:21:40 -0500
Message-ID: <20120110182140.GB15273@sigill.intra.peff.net>
References: <20120110070300.GA17086@sigill.intra.peff.net>
 <4F0BFE6E.6080904@alum.mit.edu>
 <20120110171100.GA18962@sigill.intra.peff.net>
 <20120110180820.GA15273@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:21:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkgKS-0000ew-TU
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 19:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926Ab2AJSVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 13:21:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33777
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311Ab2AJSVm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 13:21:42 -0500
Received: (qmail 12208 invoked by uid 107); 10 Jan 2012 18:28:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 13:28:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 13:21:40 -0500
Content-Disposition: inline
In-Reply-To: <20120110180820.GA15273@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188273>

On Tue, Jan 10, 2012 at 01:08:21PM -0500, Jeff King wrote:

> diff --git a/attr.c b/attr.c
> index 76b079f..fa975da 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -582,7 +582,8 @@ static void prepare_attr_stack(const char *path)
>  
>  		elem = attr_stack;
>  		if (namelen <= dirlen &&
> -		    !strncmp(elem->origin, path, namelen))
> +		    !strncmp(elem->origin, path, namelen) &&
> +		    (!namelen || path[namelen] == '/'))
>  			break;

Side note. One thing that confused me about this code is that
prepare_attr_stack does a popping loop like this:

  while (attr_stack && attr_stack->origin) {
          if (/* attr_stack->origin is a prefix */)
                  break;
          /* otherwise, pop */
          elem = attr_stack;
          attr_stack = elem->prev;
          free(elem);
  }

  /* now push our new ones */
  ...
  len = strlen(attr_stack->origin);

IOW, our loop breaks out when attr_stack is NULL, but then we go on to
assume that attr_stack is _not_ NULL. This isn't a bug, because it turns
out that we always leave something in the attr_stack: the root
gitattributes file (and the builtins).  But it is slightly confusing to
a reader because of the useless loop condition.

I'm not sure if the right solution is to change the popping loop to:

  /* we will never run out of stack, because we always have the root */
  while (attr_stack->origin) {
          ...

Or to be extra defensive and put:

  if (!attr_stack)
          die("BUG: we ran out of attr stack!?");

after the loop, or to somehow handle the case of an empty attr stack
below (which is hard to do, because it can't be triggered, so I have no
idea what it would mean).

-Peff
