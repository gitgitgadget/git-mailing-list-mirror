From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Fri, 26 Jul 2013 18:43:59 -0400
Message-ID: <20130726224359.GA3928@sigill.intra.peff.net>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
 <20130726191631.GD29799@sigill.intra.peff.net>
 <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
 <20130726212438.GA1388@sigill.intra.peff.net>
 <20130726213705.GJ14690@google.com>
 <20130726214036.GB1388@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 00:44:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2qk4-0007YY-Ga
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 00:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265Ab3GZWoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 18:44:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:33082 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757778Ab3GZWoB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 18:44:01 -0400
Received: (qmail 13041 invoked by uid 102); 26 Jul 2013 22:44:02 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 17:44:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 18:43:59 -0400
Content-Disposition: inline
In-Reply-To: <20130726214036.GB1388@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231212>

On Fri, Jul 26, 2013 at 05:40:36PM -0400, Jeff King wrote:

> > Jeff King wrote:
> > 
> > > Your patch is just swapping out "git reset" for "cherry-pick --abort",
> > > so I think that is a good improvement in the meantime.
> > 
> > Um, wasn't the idea of the original message that you can run "git
> > reset" and then "git cherry-pick --continue"?
> 
> Maybe. :)
> 
> I missed that subtlety. Of my "three things you would want to do", that
> means it was _trying_ say number 2, how to skip, rather than 3, how to
> abort. If that is the case, then it should probably explain the sequence
> of steps as "reset and then --continue" to make it more clear.
> 
> I.e., a patch is needed, but Ram's is going in the opposite direction.

I played around a bit with the test cases that Ram showed. It seems like
the advice needed is different depending on whether you are in a single
or multi-commit cherry-pick.

So if we hit an empty commit and you want to:

  1. Make an empty commit, then always run "git commit --allow-empty".

  2. Skip this commit, then if:

     a. this is a single commit cherry-pick, you run "git reset" (and
        nothing more, the cherry pick is finished; running "cherry-pick
        --continue" will yield an error).

     b. this is a multi-commit cherry-pick, you run "git reset",
        followed by "git cherry-pick --continue"

  3. Abort the commit, run "git cherry-pick --abort"

Let's assume that the instructions we want to give the user are how to
do options 1 and 2. I do not mind omitting 3, as it should be reasonably
obvious that "cherry-pick --abort" is always good way to abort.

So we give good instructions for the single-commit case, but bad
instructions for the multi-commit case. Ram's patch suggests --abort
instead of reset, which is the same for the single-commit case, but
suggests 3 instead of 2 for the multi-patch.

I think instead we would want to leave the single-commit case alone, and
for the multi-commit case add "...and then cherry-pick --continue". That
message is generated from within git-commit, though; I guess it would
need to learn about the difference between single/multi cherry-picks.

-Peff
