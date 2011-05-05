From: Jeff King <peff@peff.net>
Subject: Re: How to efficiently find where a patch applies?
Date: Thu, 5 May 2011 15:55:56 -0400
Message-ID: <20110505195556.GA1770@sigill.intra.peff.net>
References: <20110505181741.GA27251@nwp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:56:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4ea-000200-Au
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab1EETz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:55:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35544
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab1EETz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:55:58 -0400
Received: (qmail 2435 invoked by uid 107); 5 May 2011 19:57:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 15:57:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 15:55:56 -0400
Content-Disposition: inline
In-Reply-To: <20110505181741.GA27251@nwp-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172894>

On Thu, May 05, 2011 at 01:17:41PM -0500, Nathan W. Panike wrote:

> In the past couple weeks, I have had several occasions where a collaborator has
> sent a patch, which does not have information about where the patch forked from
> master.  I wrote the following scripts to try to discover where the patch
> should be applied.  Is there a better way?

What you have is more or less the best way. As you probably realized,
there could be any number of commits that match the preimage of the diff
exactly. So you are not necessarily finding the fork point, but rather
an appropriate place to apply the patch.

I have to wonder, though, whether it is worth the trouble. If you apply
the patch to your tip, especially using "git am -3", then one of two
things will happen:

  1. The patch will apply cleanly. Either because your tip matched the
     preimage exactly, or because it was close enough and git was able
     to apply anyway.

  2. There are conflicts between what you did and what the patch does.
     In this case, though, what you are doing by searching for the fork
     point will recreate the history locally that your collaborator has.
     But when you go to merge their history, you will end up getting the
     exact same conflicts that you would if you applied to your tip now.

So what is the value in applying their patch to the original fork point?
It better represents the history of what happened. But if you care about
that, I wonder if you should just be pulling from them directly via git
(or if that isn't convenient for some reason, passing around bundles).

> To find the place where the patch applies, I then would run something like
> 
> git rev-list --all | \
> while read commit; do \
> 	git ls-tree -r $commit | \
> 	awk "$(perl ~/programs/git-hacks/create_awk.pl < <patch file>)" > /dev/null || \
> 	echo $commit; \
> done

Wow, dynamically generating awk using perl. That's a new one for me. :)

-Peff
