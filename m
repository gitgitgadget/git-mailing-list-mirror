From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Add a testcase for the safety of pull-policy='pull'.
Date: Thu, 1 Mar 2007 21:10:47 +0100
Message-ID: <20070301201047.GD4149@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070225220853.31361.7201.stgit@gandelf.nowhere.earth> <b0943d9e0702270625o5a9ef8b4xd0fa5df68e2b805a@mail.gmail.com> <20070227210906.GH4045@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0702271538q32e6a9d5y6ac73adfc4854ab6@mail.gmail.com> <20070228214851.GC4149@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 21:11:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMrcM-0000CR-21
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 21:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965552AbXCAUK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 15:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965555AbXCAUK7
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 15:10:59 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:46372 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965552AbXCAUK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 15:10:58 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id EF2D7398F;
	Thu,  1 Mar 2007 21:10:56 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 01AD21F08A; Thu,  1 Mar 2007 21:10:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070228214851.GC4149@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41123>

On Wed, Feb 28, 2007 at 10:48:51PM +0100, Yann Dirson wrote:
> On Tue, Feb 27, 2007 at 11:38:45PM +0000, Catalin Marinas wrote:
> > >> BTW, push --undo now requires a status --reset beforehand.
> > >
> > >Oh, I had not noticed that.  Why so ?  It's not like if "push --undo"
> > >would lose any valuable data...
> > 
> > I added it so that one cannot remove the local changes by doing a
> > "push --undo" in error. You would have to explicitly ask for local
> > changes removing with status --reset.
> 
> At least, the message in that case should probably be made better,
> when undoing to avoid having to resolve a conflict: the message says I
> cannot undo because I have a conflict, whereas it is the exact reason
> why I want to undo.
> Especially, since the conflict markers are now auto-recorded, we could
> simply allow undo in that case.

Actually, I find the behaviour to be much worse than before: forcing
the user to run "status --reset" before "push --undo" indeed brings
the patch that conflicted in a state where it is partly committed.
That is, if the user is interrupted in her work after resetting, and
later comes back, it is not unlikely that she forget that an operation
has not been finished, and eg. run "stg pop", in which case the patch
would be left in an unwanted state.  Eg, I just caused the problem
when pushing those patches of mine you integrated: the "editor" patch,
which is later modified by one of yours, caused a conflict on puch,
which causes an empty patch to be recorded (no idea why there was no
conflict markers recorded, BTW).

Indeed, the problem may well be that we should not commit the
unresolved conflict.  Why it has some value, recording it as if the
user had refreshed the patch is probably not a good idea at all,
precisely because we're mid-way in the push, and that the operation
can be aborted without stgit knowing.

Maybe with transactions we could manage to make something sensible
here, but even then, I'm not sure if we would be able to detect that
the user's actions should abort the push transaction and rollback to
the previous state.  Sounds really too much DWIM in the end.

Maybe instead we should write such a commit, but not as if it was a
refresh.  Maybe under some .../patches/name.conflict ref, leaving the
patch itself untouched, but causing the stack to be blocked until the
push gets undone (in which case things look simple), or the patch gets
resolved+refreshed (in which case, both the conflict and its
resolution can appear in the patchlog, but things should be made so
"push --undo" would rollback the 2 ones as a whole).

Does that sound sensible ?

Best regards,
-- 
Yann.
