From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 12:57:11 -0700
Message-ID: <20081031195711.GW14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <20081031185435.GC8464@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 20:58:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw08Y-0006y6-BY
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 20:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbYJaT5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 15:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbYJaT5N
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 15:57:13 -0400
Received: from george.spearce.org ([209.20.77.23]:33735 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbYJaT5M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 15:57:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4293B3835F; Fri, 31 Oct 2008 19:57:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081031185435.GC8464@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99630>

Yet more updates to the API:

http://www.spearce.org/projects/scm/libgit2/apidocs/html/modules.html

In particular I've started to define what revision machinary might
look like, based somewhat on JGit's (public) RevWalk API.  The guts
of how to make it work of course aren't yet defined.

My goal here is to have the git_revp_t be non-thread safe, but
also to contain the entire object pool, so git_revp_free() will
dispose of any and all git_commit_t's which were created from it.

This "fixes" the "we leak everything" behavior and allows
applications to have multiple pools on different threads if
it needs to.  Thus the core git_revp_t isn't thread-safe and
doesn't get weighed down by locking if the application wants
multiple threads.


Pierre Habouzit <madcoder@debian.org> wrote:
> 
> Well, I propose the following: we set-up on GNU-ld + gcc enabled systems
> all what is needed to use symbol visibility, which isn't that intrusive,
> and also rather easy given your GIT_EXPORT macro definition.

Yes, agreed.  Only I don't know how to do it myself.  I know its
possible, so if someone wants to contribute a patch for this ... :-)
 
> No, my worry was rather wrt git core itself, I really think we _must_
> make it link against libgit2 if we want libgit2 to stay current, but git
> core will _very likely_ need the private stuff, and it _will_ be a
> problem. I mean we cannot seriously so-name a library and show its guts
> at the same time, and I'm unsure how to fix that problem. _that_ was my
> actual question.

Hmmph.  I agree git-core needs to link to libgit2.

I disagree it needs private bits.  If we do the library right
git-core can use the public API.  And where it cannot its either
not something that is "right" for libgit2 (e.g. its parseopts and
we aren't committed yet to including option parsing) or its highly
experimental and we shouldn't put it into the library (and thus
also git-core) until its more frozen.

That said, I don't think its criminal to have git-core include and
link to a static libgit2, especially if git-core's usage of the
library is ahead of what the library itself is able to expose at
the present time.
 
> I'd say we should do both at the same time. Asking people if they would
> agree to relicense code can be done in parallel. We could extract a list
> of source files that we may need (my extraction included stuff that is
> very unlikely to be useful like test-*.c that aren't useful, and some
> that are already BSD I think), and see who it yields. It should be
> possible to do a matrix source-file x people and see on a per-file basis
> what they think.
> 
> If someone gives me the list of files we should consider (I'm not sure
> about a good list right now) I could do the matrix at some fixed sha1
> from git.git using git blame -C -M -M -w, and ask people see where it
> leads us ?

Off the top of my head some really important ones:

	diff-delta.c
	object.c
	patch-delta.c
	refs.c
	revision.c
	sha1_file.c
	sha1_name.c

They form a pretty large part of the guts of what most people want
from a git library.

Slightly less important, but still fairly core:

	builtin-fetch-pack.c
	builtin-send-pack.c
	connect.c
	remote.c
	transport.c

Is most of the client side of the git:// transport, something people want.

-- 
Shawn.
