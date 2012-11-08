From: Jeff King <peff@peff.net>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Thu, 8 Nov 2012 15:09:19 -0500
Message-ID: <20121108200919.GP15560@sigill.intra.peff.net>
References: <5093DC0C.5000603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 21:09:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWYPx-0000e2-7G
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 21:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597Ab2KHUJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 15:09:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36666 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501Ab2KHUJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 15:09:23 -0500
Received: (qmail 32365 invoked by uid 107); 8 Nov 2012 20:10:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 15:10:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 15:09:19 -0500
Content-Disposition: inline
In-Reply-To: <5093DC0C.5000603@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209187>

On Fri, Nov 02, 2012 at 03:43:24PM +0100, Michael J Gruber wrote:

> It seems that our fast-import is super picky with regards to author
> names. I've encountered author names like
> 
> Foo Bar<foo.bar@dev.null>
> Foo Bar <foo.bar@dev.null
> foo.bar@dev.null
> 
> in the self-hosting repo of some other dvcs, and the question is how to
> translate them faithfully into a git author name.

It is not just fast-import. Git's author field looks like an rfc822
address, but it's much simpler. It fundamentally does not allow angle
brackets in the "name" field, regardless of any quoting. As you noted in
your followup, we strip them out if you provide them via
GIT_AUTHOR_NAME.

I doubt this will change anytime soon due to the compatibility fallout.
So it is up to generators of fast-import streams to decide how to encode
what they get from another system (you could come up with an encoding
scheme that represents angle brackets).

> In general, we try to do
> 
> fullotherdvcsname <none@none>
> 
> if the other system's entry does not parse as a git author name, but
> fast-import does not accept either of
> 
> Foo Bar<foo.bar@dev.null> <none@none>
> "Foo Bar<foo.bar@dev.null>" <none@none>
> 
> because of the way it parses for <>. While the above could be easily
> turned into
> 
> Foo Bar <foo.bar@dev.null>
> 
> it would not be a faithful representation of the original commit in the
> other dvcs.

I'd think that if a remote system has names with angle brackets and
email-looking things inside them, we would do better to stick them in
the email field rather than putting in a useless <none@none>. The latter
should only be used for systems that lack the information.

But that is a quality-of-implementation issue for the import scripts
(and they may even want to have options, just like git-cvsimport allows
mapping cvs usernames into full identities).

-Peff
