From: Jeff King <peff@peff.net>
Subject: Re: Feature idea: git rebase --exec $CMD
Date: Sun, 6 May 2012 08:26:49 -0400
Message-ID: <20120506122649.GB26194@sigill.intra.peff.net>
References: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
 <vpqobq1mxru.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antonio Ospite <ospite@studenti.unina.it>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun May 06 14:26:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR0YC-0001Gq-EE
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 14:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab2EFM0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 08:26:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59592
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391Ab2EFM0v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 08:26:51 -0400
Received: (qmail 10083 invoked by uid 107); 6 May 2012 12:27:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 06 May 2012 08:27:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 May 2012 08:26:49 -0400
Content-Disposition: inline
In-Reply-To: <vpqobq1mxru.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197172>

On Sun, May 06, 2012 at 12:03:49PM +0200, Matthieu Moy wrote:

> > Maybe this -x option should conflict with -i to simplify its "execute
> > the command after each commit" semantics (what if it is combined with -i
> > and 'x/exec' lines?).
> 
> Actually, implementation-wise, it's simpler to have '-x' imply '-i', and
> suggest a todo-list containing 'x' lines. Then, the code would simply
> have to add these "x whatever" lines, and let the
> "git-rebase--interactive.sh" mechanics do the job. That would show the
> "x whatever" lines to the user, but that can be seen as added value,
> since it gives an opportunity to the user to remove or edit some of them
> if needed.

Yeah, that makes a lot of sense to me. FWIW, I use this trick now:

  GIT_EDITOR='sed -i "/^pick .*/aexec $test"' \
  git rebase -i "$@"

to test individual commits on a topic before publishing it. But it would
be awesome to do:

  git rebase -ix "$test" "$@"

instead (and clean up the quoting disaster waiting to happen in my sed
invocation). We should perhaps start slow and call this "--exec" instead
of stealing the short-and-sweet "-x" until the feature is more proven,
though.

> I'm not familiar with the code behind non-interactive rebase, but it
> doesn't seem to use the same todo-list at all. Maybe the sequencer would
> help, I don't know.

With "-m", it's basically just a for loop over the commits, so I don't
know that it would be too hard, but there may be bad interactions. With
stock rebase using the "git-rebase--am" backend, it's a bit harder, as
we are just bulk-feeding the contents between format-patch and am.

However, I like that the "-i" case already has a concept of
execute-and-stop-if-fail, and that we can just build on that. I hope one
day that it will all be unified via the sequencer code, but for now,
it's not. Having the option mean "just add some exec lines to the todo
file" is very simple and not likely to cause bugs.

As tempting as it would be to have "-x" imply "-i", I think it makes
sense for it to simply fail in the non-interactive case (and say "sorry,
not supported yet"). Then people can experiment with making it work for
the non-interactive case (or when the non-interactive case eventually
just uses the same code without the editor invocation), we won't be
trapped into always having "-x" start the editor.

-Peff
