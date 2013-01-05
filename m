From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Sat, 5 Jan 2013 09:03:16 -0500
Message-ID: <20130105140316.GA7272@sigill.intra.peff.net>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vsj6gsi7v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 15:03:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrULc-0002c7-2D
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 15:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab3AEODV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 09:03:21 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44318 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158Ab3AEODT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 09:03:19 -0500
Received: (qmail 27243 invoked by uid 107); 5 Jan 2013 14:04:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 Jan 2013 09:04:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2013 09:03:16 -0500
Content-Disposition: inline
In-Reply-To: <7vsj6gsi7v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212691>

On Fri, Jan 04, 2013 at 02:20:52PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I have two reservations with this patch:
> >
> >   1. We are ignoring SIGPIPE all the time. For an alias that is calling
> >      "log", that is fine. But if pack-objects dies on the server side,
> >      seeing that it died from SIGPIPE is useful data, and we are
> >      squelching that. Maybe callers of run-command should have to pass
> >      an "ignore SIGPIPE" flag?
> 
> What should this do:
> 
>     GIT_PAGER='head -n 1' git -p -c alias.o='!cat longfile' o
> 
> Should it behave just like
> 
>     cat longfile | head -n 1
> 
> or should it behave differently?

With respect to error messages, I'd think they should behave the same.
But they don't necessarily. The latter does not print any message at
all. But consider this version of the former:

  $ cat foo
  #!/bin/sh
  exec cat longfile

  $ git -c alias.o='!./foo' o | head -n 1
  error: ./foo died of signal 13
  fatal: While expanding alias 'o': './foo': Success

So why don't we see that message more often? There are two reasons.

One reason is that we piped it ourselves here. When git pipes to the
pager, it sends stderr along the same channel. So even if you did:

  GIT_PAGER='head -n 1' git -p -c alias.o='!./foo' o

git writes the error, but it goes to the pager, which has already ended
(since that is what caused the SIGPIPE in the first place). But imagine
that your sub-command is actually invoking git itself, and it is the
sub-git which starts the pager. Meaning the outer git wrapper's stderr
is _not_ redirected. Like this:

  $ cat foo
  #!/bin/sh
  exec git log -p

  $ GIT_PAGER='head -n 1' git -c alias.o='!./foo' o
  error: ./foo died of signal 13
  fatal: While expanding alias 'o': './foo': Success

The second reason is that most shells will "eat" the SIGPIPE exit
status, and convert it into a high, positive error code. You can see
that effect here:

  $ GIT_PAGER='head -n 1' git log -p
  $ echo $?
  141

And since we execute aliases via the shell, we end up seeing the
converted exit code (141) instead of the signal death. _Unless_ we
optimize out the shell call (which is why we see it by putting the
command inside "./foo", which git executes directly, but not when we
give the literal "cat longfile", which git will feed to the shell).

Or at least that's _one_ way to see it. Another way is to use a shell
that does not do such conversion. Setting SHELL_PATH to zsh seems to do
so, and I think that is how Bart ran into it (my patch is a followup to
a Google+ posting he made).

> I am having a feeling that whatever external command given as the
> value of alias.$cmd should choose what error status it wants to be
> reported.

I suppose. It means that our "do not run the shell if there are no
meta-characters" optimization is leaky, since the exit code behaves
differently depending on whether we run the shell (and depending on your
exact shell). One solution would be to fix that leakiness, and if
use_shell is in effect for run-command, to convert a signal death into
the value that the shell would otherwise give us.

In fact, I really wonder if this code from wait_or_whine is actually
correct:

  code = WTERMSIG(status);
  /*
   * This return value is chosen so that code & 0xff
   * mimics the exit code that a POSIX shell would report for
   * a program that died from this signal.
   */
  code -= 128;

If we get signal 13, we end up with -115, because "code" is signed. When
the lower 8 bits are taken, and then converted into an unsigned value,
we get 141: the shell value.

But do we really want to return a negative value here? Should this
instead be:

  code += 128

which yields the same code when fed to exit, but internally looks like
the shell version to us? So we get a consistent result whether the shell
was actually used or not.

That makes more sense to me, and would mean that whether we converted
the signal number or whether it was done by a subshell, it looks the
same to us. Callers which care about signals (e.g., the recent changes
to launch_editor to detect SIGINT) would have to be adjusted. But I
think it fixes an obscure bug there. Right now launch_editor is actually
checking the whether the _shell_ died from a signal, and will fail to
notice when an editor invoked by the shell is killed by those signals
(this would be pretty rare, though, because typically SIGINT is
delivered to the shell as well as the editor).

This would also fix the code in handle_alias. It looks for a negative
return code from run_command as the sign that there was an internal
error running the command, and that errno would be valid. But right now
a negative return can also come from signal death.

> >   2. The die_errno in handle_alias is definitely wrong. Even if we want
> >      to print a message for signal death, showing errno is bogus unless
> >      the return value was -1. But is it the right thing to just pass the
> >      negative value straight to exit()? It works, but it is depending on
> >      the fact that (unsigned char)(ret & 0xff) behaves in a certain way
> >      (i.e., that we are on a twos-complement platform, and -13 becomes
> >      141).
> 
> Isn't that what POSIX.1 guarantees us, though?
> 
>     The value of status may be 0, EXIT_SUCCESS, EXIT_FAILURE, or any
>     other value, though only the least significant 8 bits (that is,
>     status & 0377) shall be available to a waiting parent process.

Sort of. I was worried about:

  1. Not-quite-POSIX platforms (i.e., Windows). But JSixt has said that
     is fine, because we already have a compatibility wrapper which
     masks off only the low byte.

  2. We are relying on the specifics of how a negative value is treated
     by exit(). The cast I gave above is guaranteed to work in standard
     C, but we do not know the implementation details of exit(). Still,
     I think that is being overly paranoid. Any sane implementation will
     do what we expect.

-Peff
