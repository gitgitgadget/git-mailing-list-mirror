From: Oswald Buddenhagen <ossi@kde.org>
Subject: Re: GC of alternate object store (was: Bringing a bit more sanity to
 $GIT_DIR/objects/info/alternates?)
Date: Wed, 29 Aug 2012 09:42:49 +0200
Message-ID: <20120829074249.GA14408@ugly.local>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
 <loom.20120827T233125-780@post.gmane.org>
 <hbf.20120828vnfp@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Wed Aug 29 10:13:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6dP0-0003NT-IK
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 10:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010Ab2H2INW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 04:13:22 -0400
Received: from byte.kde.org ([212.110.188.12]:44385 "EHLO
	byte1.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab2H2INS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 04:13:18 -0400
X-Greylist: delayed 1826 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Aug 2012 04:13:18 EDT
Received: from localhost ([127.0.0.1])
	by byte1.vm.bytemark.co.uk with esmtp (Exim 4.72)
	(envelope-from <ossi@kde.org>)
	id 1T6cvJ-0002WO-JD; Wed, 29 Aug 2012 08:42:49 +0100
Received: by ugly.local (masqmail 0.3.4, from userid 1000)
	id 1T6cvJ-3nr-00; Wed, 29 Aug 2012 09:42:49 +0200
Content-Disposition: inline
In-Reply-To: <hbf.20120828vnfp@bombur.uio.no>
User-Agent: Mutt/1.5.21+55 (4318606a6e5a) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204471>

On Tue, Aug 28, 2012 at 09:19:53PM +0200, Hallvard Breien Furuseth wrote:
> Oswald Buddenhagen wrote:
> > (...)so the second approach is the "bare aggregator repo" which adds
> > all other repos as remotes, and the other repos link back via
> > alternates. problems:
> > 
> > - to actually share objects, one always needs to push to the aggregator
> 
> Run a cron job which frequently does that?
> 
nope. i also have separate repos which share the same code, so when i
develop it i need to pick between them "live". of course it's unlikely
to get conflicts in this case, so the missing object sharing is not that
bad (the objects are transferred via format-patch, as i'm rewriting
paths anyway), but when it happens it's messy to get out again.

> > - tags having a shared namespace doesn't actually work, because the
> > repos have the same tags on different commits (they are independent
> > repos, after all)
> 
> Junio's proposal partially fixes that: It pushes refs/* instead of
> refs/heads/*, to refs/remotes/<borrowing repo>/.  However...
> 
i did exacty that. the tags are *still* not populated - git just tries
very hard to treat them specially.
and the "stash" file is also ignored, unfortunately.

> > - one still cannot safely garbage-collect the aggregator, as the refs
> > don't include the stashes and the index, so rebasing may invalidate
> > these more transient objects.
> 
> Also if you copy a repo (e.g. making a backup) instead of cloning it,
> and then start using both, they'll push into the same namespace -
> overwriting each other's refs.
>
right. it's a clear user error, though - i wouldn't *expect* it to work.
anyway, i don't have *that* problem, as my aggregator actually pulls,
not the other way round.

anyway, the bottom line is that using alternates as-is for anything but
sharing refs/remotes/origin/* (which i'm assuming to be ff-only) is
a recipe for disaster.

anything which is supposed to be in any way safe must make the "donor"
object store aware of the sharing, which at the very least means setting
the proposed append-only flag _by the borrowing_ object store. which
means that the info/alternates file should be obfuscated, so people
can't edit it manually.

> > i would re-propose hallvard's "volatile" alternates (at least i think that's
> > what he was talking about two weeks ago): they can be used to obtain
> > objects, but every object which is in any way referenced from the current
> > clone must be available locally (or from a "regular" alternate). that means
> > that diffing, etc.  would get objects only temporarily, while cherry-picking
> > would actually copy (some of) the objects. this would make it possible to
> > "cross-link" repositories, safely and without any "3rd parties".
> 
> I'm afraid that idea by itself won't work:-(

> Either you borrow from a store or not.
>
correct. from "regular" alternates you "borrow", in "volatile" ones you
only "peek".
so apparently our definitions are different after all.

> If Git uses an object from the volatile store, it can't always know if
> the caller needs the object to be copied.
> 
it doesn't have to. the distinction comes when creating objects: if an
object is only in a volatile alternate, it does not already exist for the
purpose of object creation and is thus created locally.

regards
