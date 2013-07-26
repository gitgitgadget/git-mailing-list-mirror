From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Fri, 26 Jul 2013 15:16:31 -0400
Message-ID: <20130726191631.GD29799@sigill.intra.peff.net>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 21:16:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2nVG-0003m6-Bu
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 21:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab3GZTQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 15:16:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:59951 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780Ab3GZTQd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 15:16:33 -0400
Received: (qmail 2922 invoked by uid 102); 26 Jul 2013 19:16:34 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 14:16:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 15:16:31 -0400
Content-Disposition: inline
In-Reply-To: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231198>

On Fri, Jul 26, 2013 at 11:42:00PM +0530, Ramkumar Ramachandra wrote:

> When a cherry-pick results in an empty commit, git prints:
> 
>   The previous cherry-pick is now empty, possibly due to conflict resolution.
>   If you wish to commit it anyway, use:
> 
>       git commit --allow-empty
> 
>   Otherwise, please use 'git reset'
> 
> The last line is plain wrong in the case of a ranged pick, as a 'git
> reset' will fail to remove $GIT_DIR/sequencer, failing a subsequent
> cherry-pick or revert.  Change the advice to:
> 
>   git cherry-pick --abort

Hmm. I don't think I've run across this message myself, so perhaps I do
not understand the situation. But it seems like you would want to do one
of:

  1. Make an empty commit.

  2. Skip this commit and continue the rest of the cherry-pick sequence.

  3. Abort the cherry pick sequence.

Those are the options presented when rebase runs into an empty commit,
where (2) is presented as "rebase --skip". I'm not sure how to do that
here; is it just "cherry-pick --continue"?

>  I'd also really like to squelch this with an advice.* variable; any
>  suggestions?

This seems like a good candidate for squelching, but you would probably
want to split it. The two parts of the message are:

  1. What happened (the cherry-pick is empty).

  2. How to proceed from here (allow-empty, abort, etc).

You still want to say (1), but (2) is useless to old-timers.  Probably
something like advice.cherryPickInstructions would be a good name for an
option to squelch (2), and it should apply wherever we tell the user how
to proceed. Potentially it should even be advice.sequenceInstructions,
and apply to rebase and am as well.

-Peff
