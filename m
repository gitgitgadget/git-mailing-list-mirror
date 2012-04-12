From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] Be more specific if upstream branch is not fetched
Date: Thu, 12 Apr 2012 01:30:17 -0400
Message-ID: <20120412053017.GA27369@sigill.intra.peff.net>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
 <1334161035-26355-5-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:30:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SICby-0006BN-VE
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 07:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab2DLFaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 01:30:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58268
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756512Ab2DLFaV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 01:30:21 -0400
Received: (qmail 22553 invoked by uid 107); 12 Apr 2012 05:30:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 01:30:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 01:30:17 -0400
Content-Disposition: inline
In-Reply-To: <1334161035-26355-5-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195293>

On Wed, Apr 11, 2012 at 06:17:14PM +0200, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> If the branch configured as upstream was missing from
> remote.<remote>.fetch, git said "Upstream branch not found".
> We can be more helpful, and separate the cases when upstream
> is not configured, and when it is configured, but specific
> branch is not fetched.

I very much like the direction of this series, but I found this one a
little confusing. If you have upstream config, but the configured merge
branch is not part of the remote's refspecs, what does it mean? You
would be able to "git pull", but you would not have a remote tracking
branch representing what the remote has. So this message:

> -		return error("No upstream branch found for '%s'", upstream->name);
> +		if (!upstream->merge)
> +			return error("No upstream configured for branch '%s'",
> +				     upstream->name);
> +		return error("Upstream branch '%s' not fetched from remote '%s'",
> +			     upstream->merge[0]->src, upstream->remote_name);

doesn't seem right to me. The upstream branch can be fetched just fine;
it is simply that we do not maintain a tracking branch for it.

Having worked it out in my head, I think that is maybe even what you
meant, but reading the message the first time left me very confused.
I'm not sure what a better wording would be, though. I was thinking
something like:

  Upstream branch '%s' is not stored as a remote-tracking branch.

or something, but I know we have had trouble with the term "tracking
branch" in the past. Maybe there is a less loaded term.

-Peff
