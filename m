From: Jeff King <peff@peff.net>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 01:32:09 -0500
Message-ID: <20121212063208.GA18322@sigill.intra.peff.net>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
 <20121212033043.GA24937@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 07:32:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tifrs-0007nh-Pn
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 07:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab2LLGcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 01:32:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42542 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab2LLGcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 01:32:12 -0500
Received: (qmail 21174 invoked by uid 107); 12 Dec 2012 06:33:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 01:33:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 01:32:09 -0500
Content-Disposition: inline
In-Reply-To: <20121212033043.GA24937@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211329>

On Tue, Dec 11, 2012 at 10:30:43PM -0500, Eric S. Raymond wrote:

> My sense is that git's use cases are better served by a glue language
> in the Python/Perl/Ruby class rather than an extension langage. But
> my mind is open on this issue.

I think there are really two separate use cases to consider:

  1. Providing snippets of script to Git to get Turing-complete behavior
     for existing Git features. For example, selecting commits during a
     traversal (e.g., a better "log --grep"), formatting output (e.g., a
     better "log --format" or "for-each-ref --format").

  2. Writing whole new git commands in a language that is quicker or
     easier to develop in than C.

I think (1) is a good match for lua. It's light-weight and easy to
embed, we can map the few bits of information we want for each snippet
into the language (e.g., a commit object as a lua table), and the
language ecosystem is not that important (the user is more interested in
writing readable one-liners manipulating data provided by git than they
are in calling out to third-party modules).

But for (2), you are going to care a lot more about the language and its
ecosystem (because you'll be interacting more with the world outside of
git), and about having bindings to lots of different parts of git
(because you'll want to do more interesting things than just examine a
few data structures).  We provide that right now with executable
plumbing commands. That's convenient for shell scripts, and you can
build bindings for other languages on top (e.g., see perl/Git.pm).

It's nicely universal, but of course there are some drawbacks: it's slow
(fork and pipe overhead), and it's sometimes awkward (parsing, quoting,
no interactivity between caller and plumbing). The other obvious choice
for a lingua franca is a linkable C library, with bindings in your
language of choice.

It would take a lot of effort to expose git-core's internals in a clean
way; you'd probably be better off starting from scratch and rewriting
large parts in a friendly library-like manner. Fortunately, there is
already a project underway to do so: libgit2.  It does not yet have
feature parity with git, but it can do quite a bit.  And there are
already ruby and python bindings.

-Peff
