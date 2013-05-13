From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] sha1_name.c: signal if @{-N} was a true branch
 nameor a detached head
Date: Mon, 13 May 2013 14:04:58 +0200
Message-ID: <20130513120456.GA4000@sigill.intra.peff.net>
References: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org>
 <20130509064607.GA11985@sigill.intra.peff.net>
 <7vhaicaxo7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 14:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbrV6-0000wG-Qs
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 14:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770Ab3EMMFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 08:05:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:47608 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340Ab3EMMFC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 08:05:02 -0400
Received: (qmail 28048 invoked by uid 102); 13 May 2013 12:05:28 -0000
Received: from m915736d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.87.145)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 May 2013 07:05:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 May 2013 14:04:58 +0200
Content-Disposition: inline
In-Reply-To: <7vhaicaxo7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224124>

On Thu, May 09, 2013 at 10:08:24AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Since the point of marking the detached HEAD is to turn off things like
> > "@{-1}@{u}", we would want to be generous and err on the side of
> > assuming it is a branch if it _might_ be one.
> 
> I am not sure X and Y mesh well in your "Since X, we would want Y".
> It seems to argue for erring on the side of detached HEAD to me.

Thinking on it more, I don't see that one is actually better than the
other. If you claim a detached HEAD when there isn't one, the user says
"stupid git, that was a branch, and you should tell me its upstream".
But if you claim an undetached HEAD when there isn't one, asking for the
upstream provides wildly inaccurate results (e.g., "git checkout
@{-1}@{u}" taking you somewhere unexpected).

> Checking the "from" name $HEX against old_sha1 is a local and cheap
> measure I added there for the first level of disambiguation.  If
> they do not match, we _know_ we didn't come back from a detached
> HEAD state.
> 
> In order to err on the "favor branch when it could have been one",
> you could additionally look for the reflog .git/logs/refs/heads/$HEX
> when the "from" name $HEX matches old_sha1 (which is likely to be
> detached, but it is possible that we were on the $HEX branch when
> its tip was at $HEX) and making sure the tip of that $HEX branch
> once used to be at $HEX at the time recorded for @{-N} in the HEAD
> reflog in question.

I was thinking in terms of @{-1}@{u}, so that you could say "well, do we
have upstream config for such a branch currently?". Because even though
we are digging into history (and it _may_ have been a branch at the
time, but isn't now), if we are ultimately going to ask about the
upstream config (as it is _now_, not when the entry was made), then it
does not matter if the branch was detached or not: we are still going to
return failure either way.

But there are _other_ uses for @{-1}, and I am probably being too
focused on this one use-case.

So given all of the above, I think I am fine with the direction of the
series.

-Peff
