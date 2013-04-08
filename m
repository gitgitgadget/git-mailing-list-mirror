From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Sun, 7 Apr 2013 22:33:51 -0400
Message-ID: <20130408023351.GA32558@sigill.intra.peff.net>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
 <1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
 <20130408005155.GA24030@sigill.intra.peff.net>
 <CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:51:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5sK-0000sy-AW
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760767Ab3DHCd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 22:33:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33248 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760698Ab3DHCdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 22:33:55 -0400
Received: (qmail 7024 invoked by uid 107); 8 Apr 2013 02:35:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Apr 2013 22:35:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Apr 2013 22:33:51 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220401>

On Sun, Apr 07, 2013 at 09:03:25PM -0500, Felipe Contreras wrote:

> > I'm still not very excited about this approach, as it is racy to detect
> > errors. E.g., there is nothing to say that the helper does not close the
> > pipe to fast-import prematurely and then die afterwards, leaving the
> > refs unwritten, fast-import happy, but a failed exit code from the
> > helper.
> 
> That's right, and that would leave us in the situation we are right
> now, even with "done" check.

Yes. I do not think your patch makes anything worse. But it also does
not fix the problem completely.

> > The import test still passes even without the check_command part of your
> > patch because some of the refs in refs/testgit do not exist prior to the
> > failed fetch, and therefore also do not exist afterwards. When fetch
> > tries to feed their sha1s to check_everything_connected, you get the
> > funny:
> >
> >   fatal: bad object 0000000000000000000000000000000000000000
> >   error: testgit::/home/peff/compile/git/t/trash
> >    directory.t5801-remote-helpers/server did not send all necessary
> >    objects
> 
> And you think that is desirable? User-friendly?

No, as you probably realized if you read the rest of my email. My point
in bringing it up was to try to explain exactly what is going on in each
case. Your commit message provided zero explanation of what the current
problem is, nor why your fix is the right thing to do.

> > -       if (!check_command(data->helper))
> > +       /*
> > +        * We must disconnect from the helper at this point, because even
> > +        * though fast-import may have succeeded, it may only be because the
> > +        * helper was not able to feed fast-import all of the data, and what
> > +        * fast-import got looked OK (e.g., it may have got nothing if the
> > +        * helper died early). We still need to check the return code of the
> > +        * helper to make sure it is happy with what it sent.
> > +        *
> > +        * Since the import command does not require the helper to ever report
> > +        * success/failure of the import, we have no mechanism to check for
> > +        * problems except to check its exit status.
> > +        *
> > +        * Callers of the transport code are allowed to make more requests
> > +        * of our helper, so we may be disconnecting before they expect in that
> > +        * case. However:
> > +        *
> > +        *   1. Current callers don't do that; after fetching refs, there
> > +        *      is nothing left for the helper to do.
> > +        *
> > +        *   2. We transparently start the helper as necessary, so if we were
> > +        *      to get another request (e.g., to import more refs), we would
> > +        *      simply start a new instantiation of the helper.
> > +        *
> > +        */
> 
> That's a comprehensive essay, unfortunately, it's not correct. The
> exit status of the remote-helper is not important, it's the one of
> fast-import that we really care about.

Nowhere does it say that we should not check fast-import's exit value,
and indeed, the patch does not replace that check at all. It comes
immediately after. It replaces the WNOHANG check of the helper's exit
code (i.e., check_command) with a synchronous check.

The argument that the exit status of remote-helper is not important
would mean your series is pointless, too, no?

> > +       if (disconnect_helper(transport) != 0)
> >                 die("Error while running helper");
> 
> Yeah, that's good, *if* the remote-helper is implemented correctly,
> but try this:
> 
>                if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
>                then
>                        exit 0
>                fi

I don't see your point. If a helper reports success when it has failed,
and doesn't feed anything to fast-import, we can do nothing. That case
is indistinguishable from a helper which has nothing to fetch from the
remote, and exits. My patch doesn't help with such a broken helper, but
neither does yours, because they check the exact same thing.

> >         argv_array_free_detached(fastimport.argv);
> >
> > which passes both your original test and the more strict one above. Of
> > course adding a done-import capability would be nice to fix the protocol
> > deficiency, but it is more code.
> 
> The done-import capability *is already there*. The remote helper fails
> to say "done", fast-import detects that there was a problem and exits
> with -1 (or whatever), but it doesn't matter, because we
> (transport-helper) are oblivious of that return status until it's too
> late.

Wait, then why is this a problem at all? We check the exit code of
fast-import right before the code in question.

> Yeah, I already explored this option, and I said it was possible on
> pushing, but now the problem is fetching.
> 
> http://article.gmane.org/gmane.comp.version-control.git/219760
> 
> And to be frank, I'm tired of this. I keep repeating the same things
> over and over, when I ask for input on different ways to achieve this
> I get nothing, and when the patch is getting closer to be merged, then
> I receive criticism, only so I can repeat the same again.

I don't even know what to say to this. I reviewed your original patch,
raised some concerns. You responded. I had not yet responded back,
because I have many other things to work on. In the meantime you
submitted another round. Now I have the opportunity to respond and did
so, having read both threads.

Why is your patch to recvline so much more complicated than my
one-liner? Why do you go to lengths to pass out an error code from it
just so that we can end up dying anyway? Why do you need a done
capability for push when the blank line already signals the end of the
status?

I did not respond to 219760 separately because those are all questions
that _don't matter_ if you follow the analysis in my last email that
lead to my one-liner. Maybe there are interesting answers to those
questions, and my one-liner isn't sufficient. But I'll never know
because instead of pointing them out, you are complaining that I didn't
respond fast enough.

> I don't like the option to die right in recvline(), but it would work.
> We would need something else for import though. It would be possible
> to tell fast-import to ping the remote-helper, but I ran into a
> SIGPIPE, and I don't have the patience to find out if perhaps there's
> a way to solve that. This option seems rather hacky and asymmetric to
> me.

A ping-check would work. You just need:

  sigchain_push(SIGPIPE, SIG_IGN);
  /*
   * send ping; write can get EPIPE here, which is fine; we
   * would want to treat write errors as a failed ping
   */
  sigchain_pop(SIGPIPE);

but we would have to add a ping command, no?

> If this current patch series is not good enough, I think it's best to
> leave things as they are for me.

That's certainly your choice. It just seems like we can be more robust
while adding less code, as I tried to show.

-Peff
