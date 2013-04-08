From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Mon, 8 Apr 2013 15:15:49 -0400
Message-ID: <20130408191549.GB7337@sigill.intra.peff.net>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
 <1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
 <20130408005155.GA24030@sigill.intra.peff.net>
 <CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
 <20130408023351.GA32558@sigill.intra.peff.net>
 <CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:16:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHXt-0000XA-W0
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935364Ab3DHTPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 15:15:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34147 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761020Ab3DHTPx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:15:53 -0400
Received: (qmail 14247 invoked by uid 107); 8 Apr 2013 19:17:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 15:17:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 15:15:49 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220499>

On Mon, Apr 08, 2013 at 09:38:28AM -0500, Felipe Contreras wrote:

> > Nowhere does it say that we should not check fast-import's exit value,
> > and indeed, the patch does not replace that check at all. It comes
> > immediately after. It replaces the WNOHANG check of the helper's exit
> > code (i.e., check_command) with a synchronous check.
> 
> Yeah, and in the process it's changing the design of transport-helper,
> where the pipes are closed only at the very end.

Yes. And I tried to explain why this is acceptable in the "comprehensive
essay" of a comment. If you think there are reasons not to do so, please
elaborate. But talking about fast-import's exit value is irrelevant.

> > I don't see your point. If a helper reports success when it has failed,
> > and doesn't feed anything to fast-import, we can do nothing. That case
> > is indistinguishable from a helper which has nothing to fetch from the
> > remote, and exits. My patch doesn't help with such a broken helper, but
> > neither does yours, because they check the exact same thing.
> 
> No, my code checks that the remote-helper is *still running*, you code
> doesn't. And after all, that is the design of transport-helper.

I see. That would have been a very helpful thing to put in the commit
message, no?

But the issue still remains: a "still running" check is subject to race
conditions. A disconnect solution should fail not only on a failed exit
code, but also if we are unable to send the disconnect command (i.e., it
should be checking EPIPE rather than ignoring it). So my solution was
not sufficient, either.

But I think it is moot, as I agree with your statements below and the
follow-up patch.

> >> The done-import capability *is already there*. The remote helper fails
> >> to say "done", fast-import detects that there was a problem and exits
> >> with -1 (or whatever), but it doesn't matter, because we
> >> (transport-helper) are oblivious of that return status until it's too
> >> late.
> >
> > Wait, then why is this a problem at all? We check the exit code of
> > fast-import right before the code in question.
> 
> It's not, *If* the remote-helper is using "done", and a small one if it's not.

Something like this might have been helpful in the commit message to
make it more clear what the point of the patch is:

  If the remote-helper is using the "done" feature in the export stream,
  then it will signal to fast-import that it correctly output all of the
  data to the stream. We can trust that the exit code of fast-import
  will report such a problem to it, and do not have to worry.

  But for helpers which do not use the "done" feature and exit early,
  fast-import has no idea whether all of the data was written or not.
  The helper does not report any status to us, so we are left to guess
  at whether it worked successfully. We can make such a guess by seeing
  whether the process is still alive.

  This does not cover all cases, as it is possible for us to see the
  process still present just before it exits. However, it covers the
  common case that the helper dies with an error, closing the pipe to
  fast-import at the same time. Since we reap fast-import first, by the
  time we check whether the helper is still alive, it will have exited,
  too.

  That may miss some cases, but it is the best we can do for such a
  helper, given the current protocol. A remote helper which wants to be
  robust should use the "done" feature.

Maybe you thought about all of those issues. Maybe you even communicated
them somewhere on the list. But I did not see them in the commit message
nor in a comment, which is the main item I look at while reviewing. If
you did not realize it until after the discussion, that is fine, too.
That is why we have the discussions. Now we can perhaps improve the
patch (either by explaining there what is happening, or deciding that
this case is not worth caring about).

> > Why is your patch to recvline so much more complicated than my
> > one-liner? Why do you go to lengths to pass out an error code from it
> > just so that we can end up dying anyway?
> 
> Because I think dying inside a generic function is bad design. I think
> the error should be returned, and let the caller decide what to do
> with it.

We already die inside the function; my patch only added a message. If you
want to change the dying, fine, but that cleanup is a separate issue.

> In the current version of the code we seem to receive lines
> only from the remote-helper, so I guess your patch is fine and works.
> But I still think the current code is not good.

It's a static inside transport-helper.c. So I think it is OK for it to
assume that the transport-helper code will be the only caller. In such a
situation, it _may_ be worth changing later if it becomes a more generic
and widely accessible function, but I do not think that is the case
here. The function does nothing except report remote-helper debugging
information and ask strbuf_getline to do the heavy lifting.

> > I did not respond to 219760 separately because those are all questions
> > that _don't matter_ if you follow the analysis in my last email that
> > lead to my one-liner. Maybe there are interesting answers to those
> > questions, and my one-liner isn't sufficient. But I'll never know
> > because instead of pointing them out, you are complaining that I didn't
> > respond fast enough.
> 
> That's not what I said. My complaint is why _now_, and not six months ago.

Because I did not read your series 6 months ago, nor did you make any
mention of it in your more recent cover letter.

> After reading back all the mails and checking all the different
> situations, I think my main problem was that my test was not for the
> right thing. The test for import should be using the 'done' feature,
> and we should mostly ignore the rest.
> 
> While my patch does improve the situation when the remote-helper is
> not using the 'done' feature, it's probably not worth the effort, and
> we might want to enforce the remote helpers to implement this somehow.

Yes, that makes sense to me, too. I am inclined to say that failing to
use "done" is a quality-of-implementation issue for the remote-helper,
and the right fix is for them to use the proper signal.

-Peff
