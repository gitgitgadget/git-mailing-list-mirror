From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] push: introduce REJECT_FETCH_FIRST and
 REJECT_NEEDS_FORCE
Date: Thu, 24 Jan 2013 01:58:42 -0500
Message-ID: <20130124065842.GC610@sigill.intra.peff.net>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358978130-12216-1-git-send-email-gitster@pobox.com>
 <1358978130-12216-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 07:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyGmB-0000vx-Kq
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 07:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab3AXG6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 01:58:47 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45793 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab3AXG6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 01:58:45 -0500
Received: (qmail 12293 invoked by uid 107); 24 Jan 2013 07:00:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 02:00:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 01:58:42 -0500
Content-Disposition: inline
In-Reply-To: <1358978130-12216-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214399>

On Wed, Jan 23, 2013 at 01:55:30PM -0800, Junio C Hamano wrote:

> If we do not have the current object at the tip of the remote, we do
> not even know that object, when fetched, is something that can be
> merged.  In such a case, suggesting to pull first just like
> non-fast-forward case may not be technically correct, but in
> practice, most such failures are seen when you try to push your work
> to a branch without knowing that somebody else already pushed to
> update the same branch since you forked, so "pull first" would work
> as a suggestion most of the time.
> 
> In these cases, the current code already rejects such a push on the
> client end, but we used the same error and advice messages as the
> ones used when rejecting a non-fast-forward push, i.e. pull from
> there and integrate before pushing again.  Introduce new
> rejection reasons and reword the messages appropriately.

So obviously from our previous discussion, I agree with the general
behavior of this patch. Let me get nit-picky on the message itself,
though:

> +static const char message_advice_ref_fetch_first[] =
> +	N_("Updates were rejected because you do not have the object at the tip\n"
> +	   "of the remote. You may want to first merge the remote changes (e.g.\n"
> +	   " 'git pull') before pushing again.\n"
> +	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
> +

The condition that triggers this message is going to come up fairly
often for new git users (e.g., anyone using a central repo model), which
I think is why the original message_advice_pull_before_push has gotten
so much attention.  And in most cases, users will be seeing this message
now instead of "pull before push", because the common triggering cause
is somebody else pushing unrelated work.

The existing message says:

  Updates were rejected because a pushed branch tip is behind its remote
  counterpart. Check out this branch and merge the remote changes
  (e.g. 'git pull') before pushing again.

I wonder: will the new message be as comprehensible to a new user as the
old?

They are quite similar, but something about the presence of the word
"behind" in the latter makes me think it helps explain what is going on
a bit more. When I read the new one, my first question is "why don't I
have that object?". Of course, saying "behind" in this case would not be
strictly accurate, because we do not even know the remote has a commit.

I wonder if we can reword it to explain more about why we do not have
the object, without getting too inaccurate. Something like:

  Updates were rejected because the remote contains objects that you do
  not have locally. This is usually caused by another repository pushing
  to the same ref. You may want to first merge the remote changes (e.g.,
  'git pull') before pushing again.

I was also tempted to s/objects/work/, which is more vague, but is less
jargon-y for new users who do not know how git works.

Also, how should this interact with the checkout-then-pull-then-push
advice? We make a distinction for the non-fastforward case between HEAD
and other refs. Should we be making the same distinction here?

-Peff
