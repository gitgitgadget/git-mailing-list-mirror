From: Jeff King <peff@peff.net>
Subject: Re: Breakage in master?
Date: Thu, 2 Feb 2012 12:46:01 -0500
Message-ID: <20120202174601.GB30857@sigill.intra.peff.net>
References: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 18:46:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt0jh-0001xM-8W
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 18:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756887Ab2BBRqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 12:46:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53536
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755989Ab2BBRqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 12:46:07 -0500
Received: (qmail 23455 invoked by uid 107); 2 Feb 2012 17:53:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 12:53:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 12:46:01 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSbWu0r_gKGvCHk567pUtQiyDOCO8vFfrzPMFW1eUaj1nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189660>

On Thu, Feb 02, 2012 at 01:14:19PM +0100, Erik Faye-Lund wrote:

> But here's the REALLY puzzling part: If I add a simple, unused
> function to diff-lib.c, like this:
> [...]
> "git status" starts to error out with that same vsnprintf complaint!
> 
> ---8<---
> $ git status
> # On branch master
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> fatal: BUG: your vsnprintf is broken (returned -1)
> ---8<---

OK, that's definitely odd.

At the moment of the die() in strbuf_vaddf, what does errno say?
vsnprintf should generally never be returning -1 (it should return the
number of characters that would have been written). Since you're on
Windows, I assume you're using the replacement version in
compat/snprintf.c.

That one will return -1 if realloc fails. So I'm curious if that is what
is happening (you might also instrument the call to realloc in
snprintf.c to see if it is failing, and if so, at what maxsize). And/or
check errno in git_vsnprintf after calling the native vsnprintf and
getting -1.

Here's one possible sequence of events that seems plausible to me (and
remember that this is a wild guess):

  1. gettext somehow munges the format string in a way that Windows
     vsnprintf doesn't like, and it returns -1.

  2. Our git_vsnprintf wrapper interprets this -1 as "you didn't give me
     enough space to store the result", and we grow our test-buffer to
     try again

  3. Eventually the test buffer gets unreasonably large, and realloc
     fails. We have no choice but to return -1 from our wrapper.

  4. strbuf_vaddf sees the -1 and thinks you are using a broken
     vsnprintf.

All of that would make sense to me, _except_ for your weird "if I add a
random function, the problem is more reproducible" bit. Which does seem
like something is invoking undefined behavior (of course, it could be
that undefined behavior or stack-smashing that is causing vsnprintf to
report an error). Lacking any better leads, it might be worth pursuing.

> I've bisected the issues down to 5e9637c (i18n: add infrastructure for
> translating Git with gettext). Trying to apply my unused-function
> patch on top of this commit starts giving the same "fatal: BUG: your
> vsnprintf is broken (returned -1)" error. It's ancestor, bc1bbe0(Git
> 1.7.8-rc2), does not yield any of the issues.

I've looked at 5e9637c, and it really doesn't do anything that looks
bad. I wonder if your gettext library is buggy. Does compiling with
NO_GETTEXT help?

-Peff
