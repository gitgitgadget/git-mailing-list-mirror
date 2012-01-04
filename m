From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for
 prompting passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Wed, 4 Jan 2012 08:34:59 -0500
Message-ID: <20120104133459.GA6564@sigill.intra.peff.net>
References: <4EF9ED58.8080205@tu-clausthal.de>
 <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org>
 <4EFA5EB3.4000802@tu-clausthal.de>
 <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com>
 <7vboqks8la.fsf@alter.siamese.dyndns.org>
 <4F038EC8.505@tu-clausthal.de>
 <7v39bws4xi.fsf@alter.siamese.dyndns.org>
 <4F0405D4.9090102@tu-clausthal.de>
 <4F040E46.5030001@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Wed Jan 04 14:35:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiQzn-0004U3-5R
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 14:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab2ADNfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 08:35:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55821
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234Ab2ADNfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 08:35:03 -0500
Received: (qmail 16110 invoked by uid 107); 4 Jan 2012 13:41:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Jan 2012 08:41:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jan 2012 08:34:59 -0500
Content-Disposition: inline
In-Reply-To: <4F040E46.5030001@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187921>

On Wed, Jan 04, 2012 at 09:31:02AM +0100, Sven Strickroth wrote:

> diff --git a/prompt.c b/prompt.c
> index 72ab9de..e791619 100644
> --- a/prompt.c
> +++ b/prompt.c
> @@ -52,9 +52,17 @@ char *git_prompt(const char *prompt, int flags)
>  	}
> 
>  	r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
> -	if (!r)
> -		die_errno("could not read '%s'", prompt);
> -	return r;
> +	if (r)
> +		return r;
> +
> +	if (flags & PROMPT_ASKPASS) {
> +		const char *askpass;
> +		askpass = getenv("SSH_ASKPASS");
> +		if (askpass && *askpass)
> +			return do_askpass(askpass, prompt);
> +	}
> +
> +	die_errno("could not read '%s'", prompt);
>  }

Wouldn't you also have to drop checking of SSH_ASKPASS in the block
right before calling git_terminal_prompt (right before the context in
your patch)?

-Peff
