From: Jeff King <peff@peff.net>
Subject: Re: False positive from orphaned_commit_warning() ?
Date: Wed, 25 Jul 2012 18:31:59 -0400
Message-ID: <20120725223159.GA31134@sigill.intra.peff.net>
References: <20120725185343.GA6937@windriver.com>
 <7va9ynbj9l.fsf@alter.siamese.dyndns.org>
 <20120725215730.GA30966@sigill.intra.peff.net>
 <7v629bbio9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:32:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuA7l-0006f4-6M
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 00:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab2GYWcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 18:32:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34062 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795Ab2GYWcC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 18:32:02 -0400
Received: (qmail 1028 invoked by uid 107); 25 Jul 2012 22:32:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jul 2012 18:32:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jul 2012 18:31:59 -0400
Content-Disposition: inline
In-Reply-To: <7v629bbio9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202211>

On Wed, Jul 25, 2012 at 03:05:42PM -0700, Junio C Hamano wrote:

> > I've just been hunting the same bug and came up with the same answer.
> > Here's a commit message. Feel free to apply or steal text for your
> > commit.
> 
> Heh, let's try not to waste duplicated efforts by being silent next
> time, OK?  Winning such a race by 5 minutes does not buy us much.

I usually do, but this bug was surprisingly easy to find once I
bisected. I don't think it took more than 5 minutes total. :)

> I wish we had some type safe way to say "This uint and the other
> uint are to hold different kinds of flag bits; do not mix them by
> bitwise operators".

I believe that bitwise operations are defined for enums, but I might be
misremembering my C89.

> > However, it confused the "flags" parameter to the
> > each_ref_fn clalback, which is about the flags we found
> > while looking up the ref (e.g., REF_ISSYMREF) with the
> > object flag (UNINTERESTING), leading to unpredictable
> 
> s/UNINTERESTING/SEEN/; I think.
> 
> What was happening was that the remotes/origin/HEAD symref happened
> to point at the same commit as "master", and ^master that was in the
> pending array was not transferred to the commit list used by the
> revision traversal.

Yeah, I that was my guess, too, but I didn't investigate exactly which
bits were twiddled. By mentioning UNINTERESTING, I meant "this is the
flag we actually _care_ about, but we are setting other random ones
depending on the ref flags".

> What's interesting still is that
> 
> 	git checkout master~
>         git checkout master
> 
> does not exhibit this problem in the same repository.

Perhaps we still look at and mark the parents of a SEEN commit during
our traversal (but not any further). I suspect it is that
mark_parents_uninteresting does so, but does not bother to parse the
parent. I didn't check carefully. It may be that we have an
over-conservative off-by-one at the boundaries of our traversal in some
cases, but I doubt it is worth the effort to optimize.

-Peff
