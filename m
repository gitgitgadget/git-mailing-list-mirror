From: Jeff King <peff@peff.net>
Subject: Re: PATH modifications for git-hook processes
Date: Thu, 16 Apr 2015 02:17:33 -0400
Message-ID: <20150416061732.GA5612@peff.net>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
 <xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
 <CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthew Rothenberg <mroth@khanacademy.org>
X-From: git-owner@vger.kernel.org Thu Apr 16 08:17:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yid7U-0007je-H9
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 08:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbbDPGRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 02:17:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:46039 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751647AbbDPGRg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 02:17:36 -0400
Received: (qmail 15101 invoked by uid 102); 16 Apr 2015 06:17:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 01:17:36 -0500
Received: (qmail 22672 invoked by uid 107); 16 Apr 2015 06:17:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 02:17:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 02:17:33 -0400
Content-Disposition: inline
In-Reply-To: <CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267251>

On Wed, Apr 15, 2015 at 11:00:20AM -0400, Matthew Rothenberg wrote:

> So, I guess what I'm looking for is:
>   - A way to prevent the **path to the running "git" itself** portion
> of setup_path from firing, (OR)

Yeah, this behavior leaves me somewhat confused. It is obviously
dangerous (since we have no clue what else is in the directory along
with git, as opposed to the exec-path, which contains only git
programs), and that is biting you here. But is it actually doing any
good?

Surely we don't need to find the "git" executable from that directory;
it should already be in the exec-path itself. Ditto for any dashed
commands (built-ins or external commands) that git ships.

The only case I could come up with (that works now, but would not work
if we stopped prepending the argv0 directory to the PATH) is:

  mkdir foo
  cp $(which git) foo
  cat >foo/git-bar <<\EOF
  #!/bin/sh
  echo this external command is not in your PATH!
  EOF
  chmod +x foo/git-bar
  foo/git bar

but I am not sure that is altogether sane.

I tried to find some reasoning for this behavior in the history, and
this is what I found.

We originally started treating git programs as magical in 77cb17e (Exec
git programs without using PATH., 2006-01-10), but it specifically warns
against this:

  Modifying PATH is not desirable as it result in behavior differing
  from the user's intentions, as we may end up prepending "/usr/bin" to
  PATH.

So it uses a special git-specific version of exec, and doesn't touch the
PATH. Later, we did 231af83 (Teach the "git" command to handle some
commands internally, 2006-02-26), which says at the end:

   There's one other change: the search order for external programs is
   modified slightly, so that the first entry remains GIT_EXEC_DIR, but
   the second entry is the same directory as the git wrapper itself was
   executed out of - if we can figure it out from argv[0], of course.

There was some question of whether this would be a problem[1], but we
realized it is OK due to 77cb17e, mentioned above. The use case
described by Linus is more or less the "not altogether sane" scenario I
described above:

  IOW, you can do things like

        alias git=/opt/my-git/git

  and all the "git" commands will automatically work fine, even if you
  didn't know at compile time where you would install them, and you didn't
  set GIT_EXEC_DIR at run-time. It will still first look in GIT_EXEC_DIR,
  but if that fails, it will take the git commands from /opt/my-git/ instead
  of from /usr/bin or whatever.

I think this is pretty much a non-issue for stock git commands (we do
not even put them into /opt/my-git these days, so it cannot be helping
there). It's really about finding third-party commands you have added.

Later we did 511707d (use only the $PATH for exec'ing git commands,
2007-10-28) which went back to munging the PATH, and dropping the
protection we relied on when doing 231af83 (and causing the breakage
you're seeing today).

So I dunno. I find the current behavior quite questionable. I guess I
can see it coming in handy, but as you note it can also cause problems.
And "put the git-* programs somewhere in your PATH or git's exec-dir if
you want to use them" does not seem like that bad a thing to require
people to do.

>   - A way to specify (via env var?) paths that must remain in high
> precedence even during a git-exec, e.g.:
>       NEWPATH = [git --exec-path] : [GIT_EXEC_PATH] :
> [$PROPOSED_HIGH_PRECENDENCE_PATH] : ['git itself' path] : [$PATH] (OR)
>   - A way to refine git-exec default behavior to avoid this edge case
> (my C is a little rusty but I'm happy to try to help out if we can
> think of a good logic), (OR)
>   - Something else clever I am not aware of.

If we can get away with just dropping this element from the PATH, I'd
much rather do that than try to implement a complicated path-precedence
scheme.

-Peff
