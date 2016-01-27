From: Jeff King <peff@peff.net>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Wed, 27 Jan 2016 02:33:58 -0500
Message-ID: <20160127073357.GA7066@sigill.intra.peff.net>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net>
 <20160126152941.GA31951@LykOS>
 <20160126202651.GA1090@sigill.intra.peff.net>
 <56A87056.2010309@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santiago Torres <santiago@nyu.edu>, Git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 08:34:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOKc9-0007Rm-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbcA0HeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:34:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:32957 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752487AbcA0HeA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:34:00 -0500
Received: (qmail 10282 invoked by uid 102); 27 Jan 2016 07:34:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jan 2016 02:34:00 -0500
Received: (qmail 7773 invoked by uid 107); 27 Jan 2016 07:34:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jan 2016 02:34:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jan 2016 02:33:58 -0500
Content-Disposition: inline
In-Reply-To: <56A87056.2010309@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284890>

On Wed, Jan 27, 2016 at 08:23:02AM +0100, Michael J Gruber wrote:

> > Tag objects already have a "tag" header, which is part of the signed
> > content. If you use "git verify-tag -v", you can check both that the
> > signature is valid and that the tag is the one you are expecting.
> 
> Yes, that's what I described in my last paragraph, using the term
> (embedded) tag "name" which is technically wrong (it's not the tag
> object's name, which would be a sha1) but the natural term for users.

Indeed. I should have read further back in the quoting. :)

> > Git pretty much punts on all of these issues and assumes either a human
> > or a smarter tool is looking at the verification output. But I don't
> > think it would hurt to build in some features to let git automatically
> > check some things, if only to avoid callers duplicating work to
> > implement the checks themselves.
> 
> That is really a can of worms for several reasons:
> [...]
> So, for those who shy away from for-each-ref and such, we may add the
> header check to verify-tag, with a big warning about the marginal gain
> in security (or the requirements for an actual gain).

Yeah, definitely. My thinking was that `verify-tag` could learn a series
of optional consistency checks, enabled by command line options, and
verifying programs (or humans) could turn them on to avoid having to
replicate them manually. So something like:

  git verify-tag \
    --verify-tagger-matches-key \
    --verify-tag-matches-ref \ # or --verify-tag-matches=v2.0.0
    v2.0.0

or to implement more specific policy, maybe an option to check for a
_specific_ tagger, either by email (as provided by gpg) or even key-id.

Those are all things that are not _too_ hard to do if you're willing to
parse gpg or git output, but we could make life easier for our callers.
And hopefully by asking for specific, concrete checks, it doesn't
introduce a false sense of security. I.e., we're not making a foolproof
tool; we're making building blocks that one could use for a more
foolproof tool.

-Peff
