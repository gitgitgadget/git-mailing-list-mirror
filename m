From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Alternate object pool mechanism updates.
Date: Tue, 16 Aug 2005 13:38:25 -0700
Message-ID: <7vacjhaa7y.fsf@assigned-by-dhcp.cox.net>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net>
	<20050813120815.GC5608@pasky.ji.cz>
	<7v1x4wcca0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508141726390.3553@g5.osdl.org>
	<7vr7cw7ypt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508161156430.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 22:39:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E58Cd-0003NJ-9u
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 22:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVHPUi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 16:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVHPUi1
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 16:38:27 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45776 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932420AbVHPUi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 16:38:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816203825.EWJZ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 16:38:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508161156430.3553@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 16 Aug 2005 12:07:42 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Btw, looking at the code, it strikes me that using ":" to separate the 
> alternate object directories in the file is rather strange.

Yes, I admit it one was done in a quick and dirty way.  Patches
welcome [*1*] ;-)

> Anyway, I don't think "alternates" is necessarily sensible as a "object"  
> information. Sure, it's about alternate objects, but the thing is, object 
> directories can be shared across many projects, but "alternates" to me 
> makes more sense as a per-project thing.

Well, I have to think about this a bit more, but I have to say
there were some thinking behind the way things are right now.

$GIT_DIR/info describes properties of the repository.  That's
why refs, graft and rev-cache go there.

$GIT_OBJECT_DIRECTORY/info describes the properties of the
object pool (I am inventing words as I speak, but an object pool
is a directory that can be combined with other object pools to
make an object database).  So object/info/packs talks about the
packs in it, but not about packs it borrows from its alternates.
The alternates file in question talks about what other object
pools you need to consult to obtain the objects it refers to but
it lacks itself.  If two repositories share a particular object
pool as its .git/objects directory, by symlinking .git/objects
or by using GIT_OBJECT_DIRECTORY environment, it does not matter
from which repository you look at this object pool.  The set of
objects it refers to but lacks itself, and from which other
pools these objects can be obtained, do not depend on from which
repository you are looking at it.  While I agree with everything
you said about "maybe logical but confusing", I have to disagree
with you about this one.

> What this all is leading up to is that I think we'd be better off with a 
> totally new "git config" file, in ".git/config", and we'd have all the 
> startup configuration there.

I think what _is_ lacking is an easy way to have per repository
configuration that can be shared among "opt-in" developers.  The
graft file naturally falls into this category, and probably the
Porcelain standard .git/info/exclude file as well.  Although we
ended up doing .git/hooks, it is a per repository thing and
logically it _could_ be moved to .git/info/hooks [*2*].  And
that might also be a nice thing to share among "opt-in"
developers.

[Footnote]

*1* Sorry I could not resist --- I always wanted to say this.

*2* I do not think we _should_ move it under .git/info, though.
