From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 3/3] completion: match ctags symbol names in grep
 patterns
Date: Tue, 1 Nov 2011 08:21:48 -0700
Message-ID: <20111101152148.GA5552@sigill.intra.peff.net>
References: <20111021172239.GA22289@sigill.intra.peff.net>
 <20111021173021.GC24417@sigill.intra.peff.net>
 <20111023212928.GG22551@goldbirke>
 <20111028060517.GA3993@sigill.intra.peff.net>
 <20111029124755.GE2345@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 01 16:21:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLGA0-0005Fg-84
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 16:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab1KAPVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 11:21:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59317
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab1KAPVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 11:21:50 -0400
Received: (qmail 4791 invoked by uid 107); 1 Nov 2011 15:27:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Nov 2011 11:27:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2011 08:21:48 -0700
Content-Disposition: inline
In-Reply-To: <20111029124755.GE2345@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184571>

On Sat, Oct 29, 2011 at 02:47:55PM +0200, SZEDER G=C3=A1bor wrote:

> > Grep only looks in the current subdirectory for matches.
>=20
> Unless the user explicitly specifies the path(s)...  But that comes a=
t
> the end of the command line, so the completion script could have no
> idea about it at the time of 'git grep <TAB>'.

True. But that's a more general problem. You have a 'tags' file that
presumably represents the working tree. But you are not necessarily
grepping there. You might be grepping something related (e.g., what's i=
n
the index), which makes the tags file still a good guess.

But you might also be grepping some totally unrelated branch, in which
case this is not helpful.

I tend to think that we are OK erring on the side of using the 'tags'
file, even if it might be wrong, since otherwise we have nothing to
tab-complete. When the user hits <Tab>, they are asking us to make our
best guess, and if they know there is nothing to complete, they won't
hit <Tab>. So it's not like we're hurting some existing workflow.

And in that sense, maybe we should just do the "search back up the
working tree" thing. Sure, it may be return way more matches than are
accurate, but even that's better than having no tab-completion at all.

> > You don't want __gitdir here, but rather "git rev-parse --show-cdup=
".
>=20
> Oh, yes, indeed.
>=20
> But there was a point in using __gitdir() here: it respects the
> --git-dir=3D option.  Which brings up the question: what
> should 'git --git-dir=3D/some/where/.git grep <TAB>' offer?

I guess if core.worktree is set, it would look there instead (and ditto
for specifying --work-tree on the command line).  Handling those is suc=
h
a corner case that I'm not too concerned if we don't. And if somebody
really cares, they can fix the completion later to pick up magic like
that from the early part of the command line. I don't see it as a
blocker for an initial version of the patch.

> _get_comp_words_by_ref() is a general completion function, the purpos=
e
> of which is to provide a bash-version-independent equivalent of
> $COMP_WORDS and $COMP_CWORD by working around the different word
> splitting rules.  It doesn't know about git and its commands at all.
>=20
> But there is the while loop in _git() that looks for the git command
> (among other things) on the command line, which could store the index
> of the command name in $words in a variable.  This variable could the=
n
> be used in that case statement (and probably in a couple of other
> places, too).

Yeah, that makes sense. Again, my inclination is to just leave that for
a further patch if somebody really wants to make the completion (for
this and any other positional slots) more accurate.

-Peff
