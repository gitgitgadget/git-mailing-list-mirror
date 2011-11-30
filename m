From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] honour GIT_ASKPASS for querying username in git-svn
Date: Wed, 30 Nov 2011 01:44:01 -0500
Message-ID: <20111130064401.GC5317@sigill.intra.peff.net>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Wed Nov 30 07:44:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVdtq-0004BR-Hn
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 07:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab1K3GoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 01:44:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55996
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab1K3GoE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 01:44:04 -0500
Received: (qmail 7747 invoked by uid 107); 30 Nov 2011 06:50:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Nov 2011 01:50:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2011 01:44:01 -0500
Content-Disposition: inline
In-Reply-To: <4ED0CE8B.70205@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186108>

On Sat, Nov 26, 2011 at 12:33:31PM +0100, Sven Strickroth wrote:

> diff --git a/git-svn.perl b/git-svn.perl
> index e30df22..d7aeb11 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -4361,7 +4361,14 @@ prompt:
>  	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
>  	      "(R)eject or accept (t)emporarily? ";
>  	STDERR->flush;
> -	$choice = lc(substr(<STDIN> || 'R', 0, 1));
> +	if (exists $ENV{GIT_ASKPASS}) {
> +		print STDERR "\n";
> +		open(PH, "-|", $ENV{GIT_ASKPASS}, "Certificate unknown");
> +		$choice = lc(substr(<PH> || 'R', 0, 1));
> +		close(PH);
> +	} else {
> +		$choice = lc(substr(<STDIN> || 'R', 0, 1));
> +	}

Why is the prompt simply "Certificate unknown"? Shouldn't it mention
that the right answers are "(R)eject, accept (t)emporarily, ..."?

That aside, I think this is an improvement over the current code. But
having just been looking at regular git's askpass code, I notice there
are some subtle differences:

  1. Regular git will also respect SSH_ASKPASS

  2. Regular git will ignore an askpass variable that is set but empty.

Perhaps git-svn should be refactored to have a reusable "prompt"
function that respects askpass and tries to behave like C git? It could
even go into the Git perl module.

-Peff
