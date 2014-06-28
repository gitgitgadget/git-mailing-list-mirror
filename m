From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature
 verification
Date: Fri, 27 Jun 2014 20:32:46 -0400
Message-ID: <20140628003246.GA13228@sigill.intra.peff.net>
References: <20140613080229.GJ7908@sigill.intra.peff.net>
 <539ACA8A.90108@drmicha.warpmail.net>
 <20140613110901.GB14066@sigill.intra.peff.net>
 <xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
 <20140616195428.GB24376@sigill.intra.peff.net>
 <xmqqk38gpp9v.fsf@gitster.dls.corp.google.com>
 <20140616203956.GA3546@sigill.intra.peff.net>
 <53AD640A.9060006@drmicha.warpmail.net>
 <53AD685A.1030401@drmicha.warpmail.net>
 <xmqqwqc219og.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 02:32:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0gZZ-0000ch-Lp
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 02:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbaF1Act (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 20:32:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:52373 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753887AbaF1Acs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 20:32:48 -0400
Received: (qmail 23442 invoked by uid 102); 28 Jun 2014 00:32:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jun 2014 19:32:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jun 2014 20:32:46 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwqc219og.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252589>

On Fri, Jun 27, 2014 at 11:36:47AM -0700, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > A merge commit with embedded signed tag it is, then.
> >
> > The commit could carry it's own commit signature, couldn't it?
> 
> Yes, an integrator can choose to sign a merge he creates, merging
> the work by a contributor who gave him a pull-request for a tag
> signed by the contributor.  The resulting commit will embed the
> contributor's signature to let historians verify the second parent,
> as well as the integrator's signature to allow verification of the
> merge result.  The integrator does not need to keep the signed tag
> used as an implementation detail of transferring the signature of
> the contributor, and in general such a signed tag used only to
> request pulls is not available to the general public and historians
> after such a merge is created.
> 
> As these signatures are part of a commit object, "git verify-commit"
> would be the logical place to validate them, if we were to do so.

We already disagreed on this earlier in the discussion, but I have given
it some more thought, and somehow using "verify-commit" for mergetags
still feels wrong to me. Let me see if I can put it into words.

First off, I agree that "verify-tag" is probably not the right place.
There _is_ no tag object to verify anymore (the only reason it is a tag
at all is that the signature came out of what once was a tag).

Let us imagine that we have a "verify-commit" that verifies commit
signatures made by "commit -S". If I run "verify-commit foo", that
implies to me two things:

  1. I am verifying the signature over the contents of "foo".

     But the mergetag is _not_ a statement about "foo"; the person who
     signed it never saw "foo". It is a statement about foo^2 at best,
     or possibly about the whole history of foo^1..foo^2.

  2. I am verifying _only_ the contents of foo. That is, I expect people
     to use "commit -S" to cryptographically claim authorship of a
     commit. Whereas with tags, I think we have typically taken them to
     mean "I have signed the tip of a segment of history, and I am
     taking responsibility for the final state" (e.g., signing release
     tags).

     I realize that this claim is somewhat tenuous. It's not something
     inherent in the crypto, but rather in the social convention of what
     it means to sign a commit. One could easily say "signing a commit
     is about signing the whole tree state". But I would ask, then: what
     is the point of signing a commit versus signing a tag?  I think
     that people who wanted commit signatures wanted them to give a
     stronger guarantee of authorship of individual commits.

     Git has largely stayed agnostic about what such signatures mean.
     But if we accept that some projects _are_ going to make that
     distinction, I think conflating verification of the two within the
     same command leads to a potential for confusion.

So for that reason, I think I'd be in favor of simply treating mergetag
signatures as a separate, third entity. Give them their own
%G-specifiers, and give them a separate plumbing command. Let projects
work out how they want to use them, but do not create any particular
affiliation between mergetags and commit signatures (nor between tag
signatures and mergetag signatures).

-Peff
