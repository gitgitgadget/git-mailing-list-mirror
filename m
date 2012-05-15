From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] drop length limitations on gecos-derived names and
 emails
Date: Tue, 15 May 2012 13:47:24 -0400
Message-ID: <20120515174724.GA329@sigill.intra.peff.net>
References: <20120511231303.GA24611@sigill.intra.peff.net>
 <20120514162824.GA24457@sigill.intra.peff.net>
 <20120514210225.GA9677@sigill.intra.peff.net>
 <20120514211324.GA11578@sigill.intra.peff.net>
 <20120515015437.GA13833@sigill.intra.peff.net>
 <7vtxzhfpv9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 15 19:47:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SULqS-0004cp-Ky
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 19:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346Ab2EORrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 13:47:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46288
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932207Ab2EORr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 13:47:29 -0400
Received: (qmail 1164 invoked by uid 107); 15 May 2012 17:47:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 May 2012 13:47:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 May 2012 13:47:24 -0400
Content-Disposition: inline
In-Reply-To: <7vtxzhfpv9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197846>

On Tue, May 15, 2012 at 08:03:38AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, May 14, 2012 at 05:13:24PM -0400, Jeff King wrote:
> >
> > We call setup_ident with our name pointer, which usually comes from
> > getenv("GIT_*_NAME"), although could also come from something like "git
> > commit -c $commit". We feed that to setup_ident. If name is NULL, then
> > setup_ident will use git_default_name (filling it in from gecos or
> > config). If it's not NULL, then we use it literally. And then we check
> > _that_ result to see if it's empty. If it is, we either die or warn,
> > depending on the flags. In the latter case, we fallback to using the
> > username as the name.
> >
> > And that's what confuses me. Depending on what was passed in, we may
> > have checked that GIT_COMMITTER_NAME is an empty string, or we may have
> > checked that the config or gecos field yielded an empty string. 
> 
> Sounds quite sensible to me, though.

Yes, I think it is OK to check what was given to us (or our fallback).
But using that check to decide which next step to take doesn't seem
right.

> > In the
> > latter case, it makes sense to fall back to the username.
> 
> I agree that we should use something like "Sorry, Mr. McDonald" codepath
> when the GECOS field returns an empty string---after all that is what we
> do when we are built with NO_GECOS_IN_PWENT.

Right, and that is more or less what we do (just without the
capitalization).

> > But in the
> > former case, it doesn't; we should fall back to the config name or the
> > gecos name.
> 
> If the user said GIT_COMMITTER_NAME is empty with "GIT_COMMITTER_NAME=",
> that is different from saying with "unset GIT_COMMITTER_NAME" that the
> user does not want the environment to take effect, no?

I agree two the cases are different. And for the most part, you are
insane to pass an empty GIT_COMMITTER_NAME. But if you do, why would the
right behavior be to fall back to sticking the username into the name
field, and not the gecos name?

Part of me is wondering why we should fall back at all in that case. If
a caller does not pass ERROR_ON_NO_NAME, then they don't really care
what the name is, do they? The current callers that do not pass it are:

  - blame.c:fake_working_tree_commit, which is passing in a fake name
    buffer anyway (so will never trigger this code path)

  - log.c:gen_message_id, which only cares about the email
    portion anyway

  - fmt-merge-msg.c:credit_people; this caller compares the name field
    to what's in the commits, checking for differences. So it could just
    as easily be "(none)" or some other token

  - commit.c:prepare_to_commit; this compares and shows author and
    commiter ids, and does not care about a blank name for the committer
    (but does for the author). The commit can't go through anyway with a
    blank committer name, so should it not just use ERROR_ON_NO_NAME?

  - log.c:make_cover_letter; this uses the committer information to make
    a fake commit that we ultimately use just to get the "%f" pretty
    userformat from it. In other words, we don't care about the
    committer at all, and this is really just working around an
    absolutely horrific interface.

  - refs.c:log_ref_write; finally, a caller who actually cares about the
    name, but doesn't want to die if we don't have a good name. We are
    happy enough with the username, though if somebody passes
    GIT_COMMITTER_NAME=, wouldn't it be OK to fail?

So it seems to me like a much simpler set of rules would be:

  1. When reading gecos, always fall back to the username if the gecos
     field is unavailable or blank.

  2. Always die when the name field is blank. That means we will die
     when you pass in a bogus empty GIT_COMMITTER_NAME (or an empty
     config name), which makes a lot more sense to me than falling back;
     those are bogus requests, not system config problems.  And we won't
     ever have a blank gecos name, because we'll always fall back on the
     username.

Again, I'm sorry to belabor this, and we can just drop it; I don't think
there's currently a bug. It's just that I'm cleaning up in the area, and
the current behavior seems overly complex; in particular, I'm worried
that writing the username into the git_default_name field (overwriting
the _real_ name the user gave us!) is a maintenance time-bomb that will
bite us later.

If I'm not being clear, I can express it in the form of patches, which
might be more obvious.

-Peff
