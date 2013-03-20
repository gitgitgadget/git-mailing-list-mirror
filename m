From: Jeff King <peff@peff.net>
Subject: Re: USE_NSEC bug?
Date: Wed, 20 Mar 2013 03:53:44 -0400
Message-ID: <20130320075344.GA8159@sigill.intra.peff.net>
References: <CABFQKmP6=Thhph4Ug+4LOBmzsVK42qBQYW2QHw87QD3019n+Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Rodland <andrew@cleverdomain.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 08:54:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIDqk-0002Sd-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 08:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab3CTHxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 03:53:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59796 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab3CTHxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 03:53:51 -0400
Received: (qmail 5913 invoked by uid 107); 20 Mar 2013 07:55:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 03:55:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 03:53:44 -0400
Content-Disposition: inline
In-Reply-To: <CABFQKmP6=Thhph4Ug+4LOBmzsVK42qBQYW2QHw87QD3019n+Kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218575>

On Wed, Mar 20, 2013 at 02:36:32AM -0400, Andrew Rodland wrote:

> While investigating this StackOverflow question:
> http://stackoverflow.com/questions/15516168/how-to-cross-compile-git-for-arm
> I found that fetch-pack.c uses ST_MTIME_NSEC outside of the protection
> of #ifdef USE_NSEC. This results in a broken build if
> !defined(USE_NSEC) && !defined(NO_NSEC) and the target system doesn't
> happen to be recent glibc.

Right; the point of NO_NSEC is to tell git that your libc does not have
those fields. If it's not set, then it is a bug in your config.mak (or
in the autoconf script, if you are using it).

That being said, I really don't see the point of having both USE_NSEC
and NO_NSEC. If you do not set USE_NSEC (which most people do not; it is
off by default), what is the point of not setting NO_NSEC? As far as I
can tell, it means we will copy stat information out "struct st" into
the index, but we will not actually _use_ it for anything.

Should there just be a single option USE_NSEC that defaults to off? And
if it is not set, we do not even bother caring whether libc provides
nsec fields, since we are not going to use them for anything (i.e., we
just do the equivalent of NO_NSEC now).

Which I think is the direction you are proposing with your patches
below, but the rationale should be "why bother requiring users to use
the NO_NSEC knob explicitly when we know we do not care about its value
anyway".

But maybe there is some subtle reason I'm missing for having the two
options separate. Or maybe it's just a historical accident that we ended
up here.

-Peff
