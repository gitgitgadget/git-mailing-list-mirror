From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature
 verification
Date: Fri, 13 Jun 2014 07:09:01 -0400
Message-ID: <20140613110901.GB14066@sigill.intra.peff.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>
 <cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
 <20140613080229.GJ7908@sigill.intra.peff.net>
 <539ACA8A.90108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 13:09:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvPM5-0008PM-B3
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 13:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbaFMLJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 07:09:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:43380 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752348AbaFMLJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 07:09:04 -0400
Received: (qmail 21254 invoked by uid 102); 13 Jun 2014 11:09:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 06:09:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 07:09:01 -0400
Content-Disposition: inline
In-Reply-To: <539ACA8A.90108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251546>

On Fri, Jun 13, 2014 at 11:55:22AM +0200, Michael J Gruber wrote:

> > Did you give any thought to just having a "git verify" command, instead
> > of separate tag/verify commands?
> 
> Yes. (mathematician's answer)

Cute.

> You know not only the outcome but also why I refrained from doing so:
> compatibility. We would need to deprecate verify-tag.

Yes, we'd certainly leave verify-tag in place for compatibility. I don't
think that makes "git verify" a bad idea necessarily, if it is a better
interface. But...

> But there is also a more subtle reason: If you want to verify a signed
> commit, you want to be sure that it actually is a commit. "verify" could
> easily branch code paths based on the object type, but I'm not sure that
> is desirable, at least not by default.

Yes, I wasn't sure about that part. I think it really depends on what
people want to use it for. I was thinking more of a porcelain, anyway,
to just check whatever signatures are available. But I don't really sign
my commits right now anyway, so I'm somewhat guessing.

Even if we decide to do something like that, I suppose having
verify-commit isn't the end of the world. It could just remain the
plumbing interface, as verify-tag would. So I don't think my half-formed
thoughts are any reason to block your series.

> That is a general issue with verifying signatures: it can be automated
> only if you employ a strict trust model and a very limited keyring.
> "valid signature" means only as much as the signatures that your gpg
> accepts can be really trusted.
> 
> Comparing uid's really buys you nothing in the sense that everyone can
> have a key with uid "Jeff King <peff@peff.net> signed by some other
> keys.

Sort of. The crypto proves that the commit was signed by a particular
key, and then there are two mappings:

  1. What is the identity associated with that key?

  2. Is that identity somebody who "should" have signed the commit?

We assume that GPG takes care of the first one with the web of trust.
Even if you have the key and can check the signature, it will still
complain about an untrusted uid (and we reflect that with 'U' in the gpg
status). There is no point in looking at step 2 if step 1 did not check
out.

For the second one, I think it really depends on the project workflow,
and you may even want multiple policies within a project (e.g., perhaps
only some uids can merge to master). But one obvious check we can make
is "does the identity in the commit data match one of the uids?". True,
you don't _need_ that; you can always just use "%GS", and throw away the
committer and author headers. But we show those names in lots of output.
You could, for example, "verify" that each commit's author id matches
its gpg signature, and then use the regular tools to do further work
(e.g., running "git blame"), and be confident that the author you see
matches the signature.

This should definitely be optional. Even something as simple as "author
id matches the gpg key" would not always work (for example, in git.git
we pick patches from the list, which means only Junio can sign the
objects, but he is not the author). But just because it is optional does
not mean it would not be a useful tool for some workflows.

> On the other hand, it's perfectly OK to use different uids for git
> commits and signatures. The e-mail address I use for the git list and
> commits, for example, is clearly a "plus address", which helps me
> organize things; my personal key has the primary address as uid.
> 
> I really think all this is up to local policies for individual use cases.

Very much agreed. My suggestion was more about providing tools for
people to build those policies.

I realize this isn't really your itch to scratch. It's just that when I
see a description like "verify a commit", I wonder what exactly "verify"
means.

-Peff
