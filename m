From: Jeff King <peff@peff.net>
Subject: Re: possible bug in autocompletion
Date: Wed, 19 Sep 2012 15:55:18 -0400
Message-ID: <20120919195518.GA22310@sigill.intra.peff.net>
References: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
 <20120717121232.GA32571@sigill.intra.peff.net>
 <CAMP44s2X5-BUyLtkTqGMa6w5K6uT25YLEp+Q2TdVR_qCObOpeA@mail.gmail.com>
 <20120919174336.GA11699@sigill.intra.peff.net>
 <CAMP44s1Xvvs7g1quUEs2b43VciK2=Nt-AntJcwG0CPf6p8Xk_A@mail.gmail.com>
 <CAMP44s1ZVTgBTQDyBHKvos-uSo0FeOO437MvTYH0YE0Lx-xDOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeroen Meijer <jjgmeijer@hotmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:55:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQN0-0008AW-8U
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab2ISTzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:55:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49944 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab2ISTzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:55:21 -0400
Received: (qmail 4663 invoked by uid 107); 19 Sep 2012 19:55:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 15:55:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 15:55:18 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1ZVTgBTQDyBHKvos-uSo0FeOO437MvTYH0YE0Lx-xDOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205986>

On Wed, Sep 19, 2012 at 08:23:01PM +0200, Felipe Contreras wrote:

> >> Care to wrap it up in a patch?
> >
> > I'm trying to, but unfortunately "\n" gets converted to "\\n", so it
> > doesn't get separated to words. Any ideas?
> 
> Actually, this seems to do the trick:
> 
> 	local words IFS=$'\n'
> 	printf -v words "%q" "$1"
> 	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "${words//\\n/$IFS}"
> -- "${3-$cur}"))
> 
> I don't know how to do $'\n' in the middle of double-quotes, but $IFS works.

I don't think you can search-and-replace backslash-escaped characters
and always get the correct result.  For example, in this string:

  \\n

Your regex would match the "\n", missing the context that the backslash
is actually the second-half of an escaped pair. Searching for "[^\\]\\n"
would similarly miss that:

  \\\n

should be converted. IOW, I think backslash-escaping fundamentally has
to either be parsed left-to-right, or quoted backslashes peeled in order
(if I were not such a bad computer scientist, I could probably come up
with some proof involving Chomsky's hierarchy of grammars).

I think the real problem is that we are feeding "printf %q" an input
where we want _most_ of the constructs quoted, but not some (namely
newline, which is syntactically significant, and which we accept will
break our completion). So something like the manual quoting I posted
earlier in the thread is actually much closer to what we want.

On a related note, I notice that even with either of our patches, doing
this:

  echo content >'${foo.bar}'
  git add .
  git commit -m whatever
  git show HEAD:<tab>

will yield this completion:

  git show HEAD:${foo.bar}

which is correct, but not useful. It needs to be quoted _again_ to avoid
interpolation when you actually quote the command. Bash's filename
completion handles this automatically. E.g., if you do:

  git add <tab>

you will get:

  git add \$\{foo.bar\}

I have no idea if that internal to bash's filename completion, or if
there is some easy facility offered to programmable completions to do
the same thing.  I don't think this is a high priority, but it would be
nice to handle it. And moreover, I am really wondering if we are missing
some solution that bash is providing to help us with the quoting issues.
Surely we are not the first completion script to come up against this.

-Peff
