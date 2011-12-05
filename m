From: Jeff King <peff@peff.net>
Subject: Re: hooks that do not consume stdin sometimes crash git with SIGPIPE
Date: Mon, 5 Dec 2011 16:43:52 -0500
Message-ID: <20111205214351.GA15029@sigill.intra.peff.net>
References: <20110829203107.GA4946@gnu.kitenet.net>
 <20111205192930.GA32463@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Lars Wirzenius <liw@liw.fi>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 22:44:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXgKO-0007D6-2J
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 22:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689Ab1LEVnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 16:43:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39906
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488Ab1LEVny (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 16:43:54 -0500
Received: (qmail 29867 invoked by uid 107); 5 Dec 2011 21:50:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Dec 2011 16:50:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2011 16:43:52 -0500
Content-Disposition: inline
In-Reply-To: <20111205192930.GA32463@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186291>

On Mon, Dec 05, 2011 at 03:29:30PM -0400, Joey Hess wrote:

> We had a weird problem where, after moving to a new, faster server,
> "git push" would sometimes fail like this:
> 
> Unpacking objects: 100% (3/3), done.
> fatal: The remote end hung up unexpectedly
> fatal: The remote end hung up unexpectedly
> 
> Turns out that git-receive-pack was dying due to an uncaught SIGPIPE.
> The SIGPIPE occurred when it tried to write to the pre-receive hook's
> stdin. The pre-receive hook, in this case, was able to do all the checks
> it needed to do[1] without the input, and so did exit(0) without
> consuming it.

Ugh. Yeah, receive-pack should probably just be ignoring SIGPIPE
entirely. It checks the return from write() properly where it matters,
so SIGPIPE is just an annoyance.

I would go so far as to say that git should be ignoring SIGPIPE 99% of
the time. We have crap like this sprinkled throughout the code base:

  $ git grep -C1 SIGPIPE
  builtin/tag.c-  /* When the username signingkey is bad, program could be terminated
  builtin/tag.c:   * because gpg exits without reading and then write gets SIGPIPE. */
  builtin/tag.c:  signal(SIGPIPE, SIG_IGN);
  [...]
  upload-pack.c-   * If rev-list --stdin encounters an unknown commit, it
  upload-pack.c:   * terminates, which will cause SIGPIPE in the write loop
  upload-pack.c-   */
  upload-pack.c:  sigchain_push(SIGPIPE, SIG_IGN);

but I find it highly unlikely that they are covering all of the cases.
You found one already, and these things can quite often be
race-condition heisenbugs.

The one place where SIGPIPE _is_ useful is for things like "git log"
which are just dumping to a pager over stdout. When the pager dies, we
can stop bothering to produce output.

It would be really nice if we could write a sigpipe handler that knew
which fd caused the the signal, and then we could do something like:

  void sigpipe_handler(int sig)
  {
          /* If we're writing to a pager over stdout, then there is
           * little use in writing more; nobody is interested in our
           * output. */
          if (get_fd_that_caused_sigpipe() == 1 && pager_in_use)
                  exit(1);

          /* Otherwise, ignore it, as it's a write to some auxiliary
           * process and we will be careful about checking the return
           * code from write(). */
  }

But I don't think such a function exists. We could just check
pager_in_use, which would cover most cases (e.g., programs like
receive-pack don't use a pager). But it would fail in the case of
something like "git log" using an auxiliary process that closes the pipe
early. Maybe that would be good enough, though. I dunno.

Another option is to just ignore SIGPIPE entirely, and convince programs
like log to actually bother checking the result of write(). It would be
a slight pain to check every printf() call we make in log-tree.c, but we
could do one of:

  1. Make a set of stdio wrapper scripts that exit gracefully on EPIPE.
     Using the wrapper scripts everywhere is a slight pain, but would
     work pretty well, and adapts easily to other places like printing
     lists of refs, etc.

  2. Don't check every printf. After printing each commit, check
     ferror(stdout) and exit as appropriate. This is a very small amount
     of code, but you'd need to do it in several places (i.e., anywhere
     that produces a lot of output).

> I think git should ignore SIGPIPE when writing to hooks. Otherwise,
> hooks may have to go out of their way to consume all input, and as I've
> seen, the races when they fail to do this can lurk undiscovered.

Yeah, certainly. The question to me is whether we should just stick a
SIG_IGN in the beginning of receive-pack, or whether we should try to
deal with this problem everywhere.

For example, I suspect the same problem exists in the credential helpers
I wrote recently. Generally they will read all of their input, but you
could do something like:

  [credential "https://github.com"]
          username = peff
          helper = "!
                  f() {
                          # if we call this helper, we know we want the
                          # github password,  or else this helper config
                          # would never have been triggered.  so we
                          # don't even have to bother reading our stdin.

                          # We only handle getting the password.
                          test "$1" = "get" || return

                          # Presumably gpg-agent will ask for and cache
                          # your gpg password.
                          p=`gpg -qd --no-tty <~/.github-password.gpg`

                          echo "password=$p"
                  }; f"

This can racily fail if our write happens after the helper has already
finished (unlikely, but possible).

-Peff
