From: Jeff King <peff@peff.net>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Wed, 27 Jan 2016 03:09:02 -0500
Message-ID: <20160127080901.GA7651@sigill.intra.peff.net>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net>
 <20160126152941.GA31951@LykOS>
 <20160126202651.GA1090@sigill.intra.peff.net>
 <56A87056.2010309@drmicha.warpmail.net>
 <20160127073357.GA7066@sigill.intra.peff.net>
 <56A87764.9070101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santiago Torres <santiago@nyu.edu>, Git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 09:09:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOLAA-000547-Vz
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 09:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbcA0IJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 03:09:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:32972 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751765AbcA0IJF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 03:09:05 -0500
Received: (qmail 11751 invoked by uid 102); 27 Jan 2016 08:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jan 2016 03:09:04 -0500
Received: (qmail 7976 invoked by uid 107); 27 Jan 2016 08:09:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jan 2016 03:09:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jan 2016 03:09:02 -0500
Content-Disposition: inline
In-Reply-To: <56A87764.9070101@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284893>

On Wed, Jan 27, 2016 at 08:53:08AM +0100, Michael J Gruber wrote:

> > Yeah, definitely. My thinking was that `verify-tag` could learn a series
> > of optional consistency checks, enabled by command line options, and
> > verifying programs (or humans) could turn them on to avoid having to
> > replicate them manually. So something like:
> > 
> >   git verify-tag \
> >     --verify-tagger-matches-key \
> >     --verify-tag-matches-ref \ # or --verify-tag-matches=v2.0.0
> >     v2.0.0
> > 
> > or to implement more specific policy, maybe an option to check for a
> > _specific_ tagger, either by email (as provided by gpg) or even key-id.
> > 
> > Those are all things that are not _too_ hard to do if you're willing to
> > parse gpg or git output, but we could make life easier for our callers.
> > And hopefully by asking for specific, concrete checks, it doesn't
> > introduce a false sense of security. I.e., we're not making a foolproof
> > tool; we're making building blocks that one could use for a more
> > foolproof tool.
> 
> OK, let's make a tool that helps fooling as well as proofing :)
> 
> I'll look into the tag header check. Maybe "--check-tagname"? "check"
> seems to imply less than "verify".

Yeah, I think that is fine (I actually wrote --check originally; I'm not
quite sure why I decided to change it).

> As for the gpg related stuff: We provide the full diagnostic output from
> gpg on request. But I think a mismatch between the signing key's uid and
> the taggers' name/email is more common than not,

Is it? I'd think if you are using that name with a signed tag, you would
bother to issue (and get people to sign) the matching uid. Certainly it
is the case for git and linux signatures, but I admit that it a pretty
small sampling size.

The bigger issue is that gpg seems to give us only _one_ uid, when there
may be several. E.g., Junio's v2.7.0 is signed by 96AFE6CB, which is a
sub-key that has several uids associated with it. The one that "git
verify-tag --raw" shows from gpg is gitster@pobox.com, which is good,
but I think that's just because it happens to be the first uid. Or maybe
there is some gpg arcana going on that I don't know about.

> and on the other hand a
> signature by a key identified by its uid is meaningless unless you keep
> your keyring tidy... We could punt on that and let users identify the
> key by any means that gpg allows, of course, and check that the
> signature comes from whatever "gpg --list-key <userspecified>" gives as
> long as it's unique.

Right, I think it's an open question whether people actually participate
in the web of trust. I don't have a good signature path to Junio's key,
but I happen to know what it is based on past interaction.

But then, I also do not really verify tags. Why would I? I routinely
fetch and run "make" on the result, and there is no cryptographic
protection there at all. Verifying tag signatures after a release seems
all but pointless. :)

I think for any of this to be useful, it has to be part of some tool
that is very opinionated on policy. E.g., imagine a post-fetch hook that
validated that each incoming commit was signed, and that the signer was
part of a whitelisted group of keys that you "somehow" got hold of
out-of-band for your project. That is not that useful for an open-source
project, but I could see the appeal for a proprietary development
environment.

-Peff
