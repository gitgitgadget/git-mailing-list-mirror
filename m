From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Fri, 30 Mar 2012 17:53:44 -0400
Message-ID: <20120330215344.GD20734@sigill.intra.peff.net>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <20120330210112.GA20734@sigill.intra.peff.net>
 <7vzkaxkccg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 23:53:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDjlc-0002Ae-PE
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 23:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761385Ab2C3Vxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 17:53:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41444
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760698Ab2C3Vxq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 17:53:46 -0400
Received: (qmail 20862 invoked by uid 107); 30 Mar 2012 21:53:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 17:53:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 17:53:44 -0400
Content-Disposition: inline
In-Reply-To: <7vzkaxkccg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194414>

On Fri, Mar 30, 2012 at 02:28:31PM -0700, Junio C Hamano wrote:

> In either case, you seem to be assuming (and it is a correct assumption,
> even though we may not use such a workflow) that the resulting branch, if
> long lived, will be rebasing on top of origin/master.  And the reason why
> you do that is because...
> 
> Because you would eventually want to get it integrated into origin's
> master.  Otherwise you can stay apart from origin/master and keep your
> foundation solidly anchored to where you started.
> 
> So in that sense, in both cases, pushing back to origin/master is likely
> to be what the user expected in the first place.

OK, I can agree with that (although I can come up with some corner
cases, like a long-running branch that gets updates from master but is
never intended to be merged back in, I think we can safely say those are
advanced issues and not likely to be a problem for new git users).

So let's assume that you eventually plan for "topic" to go back into
"master", and focus on a more concrete issue: _when_ to merge. You fork
a topic branch from origin/master and make some commits. You then run
"git push". Did you mean:

  1. I am ready for this work to go back to origin/master.

  2. I am ready to publish my topic branch for others to review.

I think it's ambiguous. And getting it wrong is potentially hard to
retract (because you've published commits to what is probably supposed
to be a stable, non-rewinding branch).

> > I feel like the concept of "upstream"
> > is very loosely specified, and can mean many things.
> 
> ...I tend to agree with it.  But I am not sure if that leads to "we should
> default to 'current' because 'upstream' is too messy and blurry".  At
> least, not yet.

I tend to think "upstream" is hopelessly blurry, and must remain so
because there are too many similar concepts. That is, to fix it, you
would need to split it into several sub-concepts.

For example, I generally base all of my git.git topics on origin/master
(where "origin" is your repo). But when I push them, they go to my
publishing point. So there are two things I am interested in asking
about:

  1. Where is my work compared to master? This is useful for enumerating
     which commits are part of my topic, and for rebasing on top of
     master.

  2. What do my local branches have compared to their published
     versions?  This is useful for knowing that I have work to be
     published, or for realizing that I published work from another
     machine that does not exist on the current machine.

Those are two very different notions of upstream, and I want to use them
with different commands. I set @{u} to origin/master to handle (1). And
I do (2) by matching names. But I would never want git-push to look at
@{u}, because it is a totally different concept. Pushing is always about
(2) for me.

Yes, this is a more complex workflow than many beginning git users will
have. But I think it is at the heart of the upstream confusion: just
because you are based on some branch, and just because you ultimately
want to merge with it, does not mean that it is a good push destination.
_Sometimes_ it is, and that is why the "upstream" push.default exists.

> But then I am afraid that you may be inviting teachers to blindly teach
> beginners to first set push.default to upstream, just like they do today
> where the default is matching, as most of them do know that upstream works
> fairly well with the way how _they_ work, without having an understanding
> these gotchas in upstream you are (validly) raising as possible issues
> here.  So in the end, we would have to clarify whatever 'upstream' does
> anyway, no?

Yes, and we should make upstream better, no matter what the default is.
But I hoped that it would not be "blindly teach" but rather "teach what
upstream is". Perhaps that is naive. But I feel like at least we will
have done the best we can by giving the user an opportunity to read the
documentation or have somebody instruct them before setting "upstream",
and not simply shipping it out of the box.

-Peff
