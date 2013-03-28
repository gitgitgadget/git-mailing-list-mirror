From: Jeff King <peff@peff.net>
Subject: Re: Bug in "git rev-parse --verify"
Date: Thu, 28 Mar 2013 10:05:10 -0400
Message-ID: <20130328140510.GB12898@sigill.intra.peff.net>
References: <51543FDB.9010109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 28 15:05:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULDSf-0004Ib-C2
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 15:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab3C1OFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 10:05:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42732 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922Ab3C1OFR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 10:05:17 -0400
Received: (qmail 24833 invoked by uid 107); 28 Mar 2013 14:07:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 10:07:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 10:05:10 -0400
Content-Disposition: inline
In-Reply-To: <51543FDB.9010109@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219398>

On Thu, Mar 28, 2013 at 02:04:27PM +0100, Michael Haggerty wrote:

> $ git rev-parse --verify 1111111111111111111111111111111111111111
> 1111111111111111111111111111111111111111
> $ echo $?
> 0
>
> [...]
>
> I believe that "git rev-parse --verify" is meant to verify that the
> argument is an actual object, and that it should reject fictional SHA1s.
>  (If not then the documentation should be clarified.)  The same problem
> also exists in 1.8.2 but I haven't checked how much older it is.

I think it is only about verifying the name of the object. I.e., that
you can resolve the argument to an object. It has always behaved this
way; I even just tested with git v0.99.

I can't think of any reason it would not be helpful to have it _also_
verify that we have the object in question. Most of the time that would
be a no-op, as any ref we resolve should point to a valid object, but it
would mean we could catch repository corruption (i.e., missing objects)
early.

Doing a has_sha1_file() check would be relatively quick. Doing a full
parse_object and checking the sha1 would be more robust, but would mean
that:

  blob=`git rev-parse --verify HEAD:some-large-file`

would become much more expensive (and presumably you are about to access
the object _anyway_, at which point you would notice problems, so it is
redundantly expensive).

-Peff
