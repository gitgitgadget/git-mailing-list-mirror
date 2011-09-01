From: Jeff King <peff@peff.net>
Subject: Re: git 'new' alias
Date: Thu, 1 Sep 2011 17:17:47 -0400
Message-ID: <20110901211747.GA16308@sigill.intra.peff.net>
References: <CACnwZYfo2E0SFfFrYzUktAZYwqgyX_J4KgFQD5kqXToGmip3Lg@mail.gmail.com>
 <vpqei00m4pf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 01 23:17:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzEe3-0001JT-Cs
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 23:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758006Ab1IAVRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 17:17:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47043
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757962Ab1IAVRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 17:17:49 -0400
Received: (qmail 24495 invoked by uid 107); 1 Sep 2011 21:18:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Sep 2011 17:18:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2011 17:17:47 -0400
Content-Disposition: inline
In-Reply-To: <vpqei00m4pf.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180572>

On Thu, Sep 01, 2011 at 09:40:28PM +0200, Matthieu Moy wrote:

> Thiago Farina <tfransosi@gmail.com> writes:
> 
> > Hi,
> >
> > Could we change the 'new' alias in the wiki page,
> >
> > from:
> > new = !sh -c 'git log $1@{1}..$1@{0} "$@"'
> >
> > to:
> > new = !git log $1@{1}..$1@{0} "$@"
> >
> > ?
> 
> Go on. I think I'm the one who added it, and I didn't know $1 and $@
> would work without "sh -c", but I guess my version results in calling
> stg like sh -c "sh -c 'git log ...'" which is a bit overkill ;-).

Hmm. Aren't both of these somewhat wrong?

Git will assume your alias is a shell snippet, append the
space-separated shell-quoted arguments provided to the alias to your
snippet, and then hand the result to the shell.

We can simulate the first one with:

  $ git config alias.one
  !sh -c 'echo $1@{1}..$1@{0} "$@"'

which gives:

  $ git one foo
  @{1}..@{0}

Oops, that's not right. You need a placeholder for $0. So make it:

  $ git config alias.one
  !sh -c 'echo $1@{1}..$1@{0} "$@"' --

and now you get:

  $ git one foo
  foo@{1}..foo@{0} foo

Wait, what's that extra "foo" on the end? I'm not sure of the intent.
Either it is totally superfluous, or perhaps it was meant to pass along
other options, like path limiters. In the former case, you just want:

  !sh -c 'echo $1@{1}..$1@{0}' --

and in the latter case, you actually want to shift off $1 and provide
the rest of the options. Of course, for this particular alias, it so
happens that adding an extra $1 is equivalent to $1@{0}, which is
superfluous but harmless. More on that in a minute.

How about the second one:

  $ git config alias.two
  !echo $1@{1}..$1@{0} "$@"

which yields:

  $ git two foo
  foo@{1}..foo@{0} foo foo

Now we have two extra foos! One is from a superfluous use of "$@", which
is no longer necessary to pass along extra args, since we aren't
invoking a subshell. So we are better off with:

  $ git config alias.two
  !echo $1@{1}..$1@{0}

which yields:

  $ git two foo
  foo@{1}..foo@{0} foo

Better, but we still get our superfluous "foo" at the end. And there's
no way to get rid of it here, since it is appended to our shell snippet.
We can't just shift it away.

So in this particular alias, you can live without the subshell wrapper,
and the final alias.two I mentioned is OK. If you're satisfied with
that, you can stop reading now. I still find the repeated refname a
little hack-ish, though, as it doesn't extend to other aliases
naturally.

You mentioned the ugliness in having the shell call itself. Weep for the
quoting nightmare that is:

  $ git config alias.one
  !sh -c 'echo $1@{1}..$1@{0} "$@"' --

  $ GIT_TRACE=1 git one foo
  trace: exec: 'sh' '-c' 'sh -c '\''echo $1@{1}..$1@{0} "$@"'\'' -- "$@"' 'sh -c '\''echo $1@{1}..$1@{0} "$@"'\'' --' 'foo'

Fortunately, we can do a little better using shell functions. I would
write this as:

  $ git config alias.one
  !f() { r=$1; shift; echo $r@{1}..$r@{0} "$@"; }; f

  $ git one foo
  foo@{1}..foo@{0}

  $ git one foo bar
  foo@{1}..foo@{0} bar

which I think was the original intent (modulo me replacing "git log"
with "echo" for debugging, of course). And if you peek at GIT_TRACE
output, we only invoke a single shell.

Now back to the original complaint: no shell completion. For that, I
would simply add:

  _git_new() {
    __git_complete_revlist
  }

to my .bashrc. Yeah, it's a little more work than having the completion
automatically figure out that "new" takes the same arguments as "git
log", but it works in the general case.

-Peff
