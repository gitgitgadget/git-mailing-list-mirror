From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] fix git-config with duplicate variable entries
Date: Wed, 21 Nov 2012 14:27:39 -0500
Message-ID: <20121121192738.GA16280@sigill.intra.peff.net>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
 <20121022211505.GA3301@sigill.intra.peff.net>
 <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
 <20121023223502.GA23194@sigill.intra.peff.net>
 <7vsj84rt1g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:28:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFxr-0004NA-Qy
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab2KUT1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:27:49 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54422 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768Ab2KUT1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:27:48 -0500
Received: (qmail 9390 invoked by uid 107); 21 Nov 2012 19:28:40 -0000
Received: from ip68-100-44-35.dc.dc.cox.net (HELO sigill.intra.peff.net) (68.100.44.35)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Nov 2012 14:28:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2012 14:27:39 -0500
Content-Disposition: inline
In-Reply-To: <7vsj84rt1g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210165>

On Tue, Nov 20, 2012 at 11:08:43AM -0800, Junio C Hamano wrote:

> > Thanks. It had a few minor flaws (like a memory leak). I fixed those,
> > updated the tests, and split it out into a few more readable commits. In
> > the process, I managed to uncover and fix a few other memory leaks in
> > the area. I think this version is much more readable, and writing the
> > rationale for patch 7 convinced me that it's the right thing to do.
> > Another round of review would be appreciated.
> >
> >   [1/8]: t1300: style updates
> >   [2/8]: t1300: remove redundant test
> >   [3/8]: t1300: test "git config --get-all" more thoroughly
> >   [4/8]: git-config: remove memory leak of key regexp
> >   [5/8]: git-config: fix regexp memory leaks on error conditions
> >   [6/8]: git-config: collect values instead of immediately printing
> >   [7/8]: git-config: do not complain about duplicate entries
> >   [8/8]: git-config: use git_config_with_options
> >
> > For those just joining us, the interesting bit is patch 7, which fixes
> > some inconsistencies between the "git-config" tool and how the internal
> > config callbacks work.
> 
> The way for the Porcelain scripts to mimick the internal "last one
> wins" has been to grab values out of --get-all and do the "last one
> wins" themselves, and I agree that a mode that frees them from
> having to worry about it is a good *addition*.  I would even say
> that if we were designing "git config" plumbing without existing
> users, it would be the only sensible behaviour for "--get".
> 
> But "git config --get" users have been promised to get errors on
> duplicate values so far, so I have to say this needs to come with a
> big red sign about API breakage.

The problem is that scripts currently using "--get" are broken by
duplicate entries in include files, whereas internal git handles them
just fine.  Introducing a new switch means that everybody also has to
start using it.

That is not an excuse for breakage, of course, but only a motivation for
considering it. And here is what I think mitigates that breakage:

  1. If you are a script that cares about multiple values and choosing
     one (whether last-one-wins or otherwise), you are already using
     --get-all and are not affected.

  2. If you are a script that only wants to mimic how get retrieves
     a single value, then this is a bug fix, as it brings "--get" in
     line with git's internal use.

  3. If you are a script that only wants a single value, but cares about
     duplicates, you are already failing to notice them when the
     duplicates are cross-file. That is, we already do "last one wins"
     if an entry is found in ~/.gitconfig and .git/config.

I would argue that anybody fetching standard git config variables (and
not using --list or --get-all) falls into case (2) and is being fixed,
as they will not otherwise match the behavior of git itself.

For other variables that porcelains want to stuff inside the config
files, I suppose they could fall into case (3). But I am not sure why
they would care about duplicates. They have asked git for a single
value, and if they care more deeply about multiple values (but only
within a single file!), what do they hope to accomplish by not calling
--get-all? That is, what is the use case where this makes any sense?

The only case I can think of where the distinction even matters is:

  1. Porcelain foo writes to the .gitfoo file via "git config -f
     .gitfoo".

  2. It accidentally writes using "--add" instead of just setting the
     value.

  3. It fetches via "git config -f .gitfoo --get foo.var". Before my
     patch, duplicate detection would notice the bug in (2) and barf.
     Now, it silently takes the most recently added value (which is
     probably what was meant anyway).

IOW, I do not see a legitimate use case for this, but see it as an extra
check on broken config. But it is catching an unlikely condition, and is
an overly restrictive check, in that it is triggering on totally
reasonable config. So we are not breaking a use case so much as a
loosening a (in my opinion) useless check.

But maybe I am missing some more sane case.

> I would feel safer to introduce --get-one or something now, and
> worry about migration as a separate step.

Part of my impetus for fixing --get is that it let us cleanup and
harmonize the git_config() and git-config implementations. If we are not
going to do that, adding an extra option is not that appealing, as we
are stuck with the old duplicated code, anyway. As I mentioned above,
this only really affects include files (because from git-config's
perspective, the entries it sees are all "the same file", as they come
from the same call into git_config_from_file). If we are not going to
fix --get for all callers, it would probably make more sense to just
omit the duplicate suppression for entries across include-file
boundaries (which are something that callers would have to opt into when
using a specific file, anyway). IOW, to treat it as a bug in the include
system and fix it there.

-Peff
