From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as
	errors.
Date: Sat, 28 Jun 2008 00:33:38 -0400
Message-ID: <20080628043338.GC9451@sigill.intra.peff.net>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org> <20080619133747.GA31209@sigill.intra.peff.net> <20080619135159.GA19560@artemis.madism.org> <20080619151110.GA31654@sigill.intra.peff.net> <20080626075036.GA25770@sigill.intra.peff.net> <7vfxr0sj61.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 06:34:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCS90-00024v-Ft
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 06:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbYF1Edm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 00:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbYF1Edm
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 00:33:42 -0400
Received: from peff.net ([208.65.91.99]:2427 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbYF1Edl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 00:33:41 -0400
Received: (qmail 8534 invoked by uid 111); 28 Jun 2008 04:33:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 28 Jun 2008 00:33:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jun 2008 00:33:38 -0400
Content-Disposition: inline
In-Reply-To: <7vfxr0sj61.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86702>

On Thu, Jun 26, 2008 at 01:19:02AM -0700, Junio C Hamano wrote:

> That "strict rewind" workaround alone made me so disgusted beyond words.

Heh.

> And if you do not want to trigger "what you are pushing is not up to
> date", the solution is simple.  You do not push them.
> 
> I however think what Pierre wanted to do is different, and you do not have
> to solve "force this strict rewind" problem to solve it.
> 
> What we need is (with a configuration option) to change the meaning of
> "matching refs" from the current definition "branches with the same name
> between here and there" to "branches with the same name between here and
> there, but excluding the ones that do not fast forward (or strictly
> behind)".  So if you have tons of stale branches you checked out but
> haven't touched most of them, your "matching push" won't even try to push
> what you haven't touched.

OK. Isn't this basically just another way of restating my third
"solution"? Mine marks strict rewinds as "up to date" instead of
"matching", but in either case, the result is that there is nothing to
even try pushing. And the proposal I gave was "allow -f to force a
strict rewind [which would be as it is now] but only if the refspec is
mentioned explicitly on the command line, and not part of an automatic
match."

So I think the behavior is the same, but the difference is the mental
model.

And not counting stale branches as matching doesn't seem like quite the
right mental model. The matching is about the ref _names_, not about
their contents. So I think the better mental model is that these
branches are simply "up to date" already -- the remote has everything we
have, and more.

Not to mention that ref matching can affect _other_ refs, too, can it
not? I think there are some checks for having two refspec srcs pushing
to the same dest.

> I do not think we would ever want to allow a configuration that disables
> the exit status from push upon a push failure when somebody explicitly
> says "git push $there $this" and $this is not non-fast-forward.  If you
> asked $this to be pushed, and if $this cannot be pushed, we _should_ error
> out.

We do this already for refs that have no changes to push. IOW, we are
not masking an error so much as saying "this condition is _not_ an
error" (and letting the user say that with a config option).

>  (1) when you say "git push" to trigger the "matching refs" push, with the
>      new configuration, you do not error out nor even try to push out
>      things that do not fast forward.  Pretend that you did not even
>      attempt to push them, and do not error out.  This may result in not
>      pushing anything out, but that is what the people who have such a
>      configuration is asking for.
> 
>      If you have configured which branches are pushed when you are on your
>      current branch, and that branch --- most likely it is that current
>      branch --- does not fast forward, it is your problem.
> 
>  (2) even with such a configuration, you can "git push $there $this" and
>      "git push $there +$this" to explicitly ask refs to be pushed.  Such a
>      push won't be interfered by the new configuration and correctly fail
>      (or force).

I think (1) should be implemented not as "this src ref and this dst ref
do not match" but rather "this pair is up to date". And given that, I
think that is basically the same as my proposal, except that the
"push.rewindIsUpToDate" config variable would only be respected for a
"matching refs" push. Which does feel a little inconsistent, as I noted
in my previous mail, but I think it DWYM.

-Peff
