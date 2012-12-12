From: Jeff King <peff@peff.net>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 03:32:11 -0500
Message-ID: <20121212083210.GB18322@sigill.intra.peff.net>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
 <20121212033043.GA24937@thyrsus.com>
 <20121212063208.GA18322@sigill.intra.peff.net>
 <CACh33FrgZhsKp7o9ki6n1AbfRKYYbdLMWuGUGKUqDfH5m0Akng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 09:32:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tihjz-0004Br-NX
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 09:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574Ab2LLIcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 03:32:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42647 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab2LLIcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 03:32:14 -0500
Received: (qmail 21686 invoked by uid 107); 12 Dec 2012 08:33:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 03:33:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 03:32:11 -0500
Content-Disposition: inline
In-Reply-To: <CACh33FrgZhsKp7o9ki6n1AbfRKYYbdLMWuGUGKUqDfH5m0Akng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211332>

On Wed, Dec 12, 2012 at 02:03:56AM -0500, Patrick Donnelly wrote:

> On Wed, Dec 12, 2012 at 1:32 AM, Jeff King <peff@peff.net> wrote:
> > It would take a lot of effort to expose git-core's internals in a clean
> > way; you'd probably be better off starting from scratch and rewriting
> > large parts in a friendly library-like manner. Fortunately, there is
> > already a project underway to do so: libgit2.  It does not yet have
> > feature parity with git, but it can do quite a bit.  And there are
> > already ruby and python bindings.
> 
> Of course, this comes back to the issue of whether it's a good idea to
> use perl/ruby/python as a front-end to regular git commands
> (pull/push/etc.).

Yeah, I think that is a separate issue, though. I cannot see us ever
writing core commands like "git pull" in any scripting language besides
POSIX shell due to dependency issues. So language bindings are really
for things that are not going to go into git-core, or are ancillary
commands that people can live without (e.g., git-add--interactive,
remote helpers, etc).

> While, yes, bindings can be made for these languages, you are now
> making git depend on the presence of one of these languages in order
> for git to function. With Lua, the (static) dependence is very small
> yet brings much to git in terms of extensibility and maintainability.

And I would include Lua in my list of "I cannot see..." above. It can be
statically linked, so it is not a run-time dependency, but it would
still be a build-time dependency. The community has historically been
pretty resistant to dependencies (I do not care too much myself,
though).

I think doing anything significant in Lua would have the same problem as
doing anything significant in Python: there would need to be substantial
internal cleanup to make sane bindings. And again, that is what libgit2
is doing (and yes, there are Lua bindings for it already).

Using libgit2 bindings would introduce a new dependency, of course, but
that is on par with a Lua dependency.

> As for Lua's suitability for your (2) point, I admit I'm not familiar
> with how much "interacting with the outside world" the git commands
> do; however, I would suspect that it is not significant enough to rule
> Lua out?

I did not mean to rule it out for point (2); I only meant that it is
probably the only reasonable thing for point (1), whereas for point (2),
we have many more options.  I suspect Lua would do just fine given the
right set of modules, though I tend to prefer other languages myself
when embeddedness is not an issue.

As for "interacting with the outside world", I was specifically thinking
of stuff like git-send-email (currently in perl) and git-imap-send
(written in C). They need to open network sockets and speak standard
protocols. I suspect Lua would need a module or custom bindings to do
the former at all, and certainly the code would be much simpler if we
re-used standard modules for speaking SMTP and IMAP (which of course
increases our dependencies again...).

-Peff
