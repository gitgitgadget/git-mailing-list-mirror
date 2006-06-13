From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-cvsimport doesn't quite work, wrt branches
Date: Tue, 13 Jun 2006 23:13:44 +0200
Message-ID: <20060613211344.GC7766@nowhere.earth>
References: <87irn5ovn6.fsf@rho.meyering.net> <Pine.LNX.4.64.0606131008470.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 13 23:13:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqGCn-00088m-Ka
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 23:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWFMVNh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 17:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWFMVNh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 17:13:37 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:23492 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932259AbWFMVNc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 17:13:32 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 65F6154650;
	Tue, 13 Jun 2006 23:13:30 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FqGCm-0005lF-Pk; Tue, 13 Jun 2006 23:13:44 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606131008470.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21813>

On Tue, Jun 13, 2006 at 10:20:10AM -0700, Linus Torvalds wrote:
> Sadly, it also seems to be one that isn't fixed by the patches _I_ have, 
> and looking at Yann's set of patches, I don't think they fix it either.

I don't think so either.


> So CVSps basically tells git-cvsimport that commit 2 (on branch B) is 
> based on commit 1, and doesn't say that "on-trunk" has gone away, so the 
> resulting git repository has branch B containing "on-trunk" version 1.1, 
> and "on-br" version 1.1.2.1.
> 
> CVS branches obviously sometimes confuse CVSps. Sadly, they also confuse 
> _me_, so I don't see how to fix this particular CVSps bug, because I'm as 
> confused as CVSps is ;)
>
> We'd need to have CVSps tell git that the "on-trunk" file was never added 
> to branch B: the simplest way to do that would be to say that it has 
> become (DEAD) in PatchSet 2 (which is not technically true in CVS terms, 
> but _is_ technically true on git terms - on branch B, that file is 
> obviously dead).
> 
> Yann? Pavel? Anybody? Ideas?

This is exactly the problem I encountered one week ago with one my old
cvs repos, where I had created a branch only for a part of a source
hierarchy :)

One thing that amused me, is that in that case cvsps was DWIM enough
that the result was indeed what I expected from the conversion (I had
forgotten about the particular way that branch was created 3 years
ago).  I only discovered the problem when tailor's cvs backend
generated deletions when starting my branch.

So basically, because of how awkward cvs branches are, cvsps may
indeed do what many users expect here, because branches in cvs repos
are sometimes created in strange ways, (in my case, to avoid having to
merge changes in unrelevant areas of the tree - nowadays, I'd just use
stgit to isolate changes).

I don't know what was the particular thing in coreutils developement
that led to branching only some files.  In my case, it can be seen as
the cvs idiom for "branching a part of the tree" - something I don't
think there is a need to have a special idiom in GIT for.


If we want cvsps to output the exact history derived from cvs
(ie. what Jim expected, and I think it is reasonable), I fear it would
require substential modification to cvsps.  I should check, but I
don't think it currently keeps track of which files are part of the
tree resulting from a changeset, but only of the files actually touhed
by the changeset.  So the change would probably have a big ram
usage impact, if we store the file refs in each changeset.


That reminds me of another funny cs behaviour I noticed a couple of
months ago (not sure if it was in 1.11.x or 1.12.x): "cvs import" was
not marking files as dead on the vendor branch when it disappeared
from one upstream version to another, it was just not tagged in the
new version.  I guess cvsps would have a hard time figuring out what
happenned, and would just mark the taks as invalid.


For this type of cvsps issues and cvs tags in general, my latest idea
would be to add "fake" patchsets on which to apply tags and
branchpoints.  The ideal way would seem to make those similar to git's
merge commits, having as parents all patchsets the tag takes revision
from (obviously it's so biased towards the git model it would be a
pleasure to add support for this in git-cvsimport :) - but that would
produce patchsets not fitting well into the current cvsps model, so
that may require more thinking.

Anyway, it should provide a way to make sense out of what cvsps
currently considers to be "invalid" tags.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
