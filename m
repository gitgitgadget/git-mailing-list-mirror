From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Sat, 8 Nov 2008 01:29:52 +0100
Message-ID: <20081108002952.GC4030@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth> <20081101220319.1116.50509.stgit@gandelf.nowhere.earth> <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org> <20081107193957.GI5158@nan92-1-81-57-214-146.fbx.proxad.net> <7v3ai3gugt.fsf@gitster.siamese.dyndns.org> <20081107203952.GJ5158@nan92-1-81-57-214-146.fbx.proxad.net> <7vskq3fdgz.fsf@gitster.siamese.dyndns.org> <20081107221224.GK5158@nan92-1-81-57-214-146.fbx.proxad.net> <7vhc6jdrvs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 01:31:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kybjg-0008Nz-GK
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 01:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbYKHAaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 19:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYKHAaR
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 19:30:17 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:33260 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbYKHAaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 19:30:16 -0500
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 8FB2312B6BD;
	Sat,  8 Nov 2008 01:30:14 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 6559012B6BA;
	Sat,  8 Nov 2008 01:30:14 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 31C191F072; Sat,  8 Nov 2008 01:29:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhc6jdrvs.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100368>

On Fri, Nov 07, 2008 at 03:43:19PM -0800, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > I hope I just miss your point.  Letting unaware tools handle such a
> > patch "the right way" would imply just adding the information "dir foo
> > moved to bar", and not removing the individual file moves, which goes
> > in the way of the exact reason why I have started to work on this.
> 
> If your change is to move a/{1,2,3} to b/{1,2,3} and without content
> change to a/{1,2} to b/{1,2}, then do you want to say "a/ moved to b/
> and by the way here is the content change from a/3 to b/3" without saying
> anything about a/{1,2} and b/{1,2}?
> 
> Two points.
> 
>  * I do not think it is a good idea to begin with.  If you are to apply
>    such a patch (with git-apply that is updated with your patch to
>    understand that notation) to the exact tree that has only {1,2,3} under
>    a/, you would get an expected result.  But if the recipient of your
>    patch has a/4 (or lacks a/2), there is no cue in the patch that
>    automatically moving a/4 to b/4 may or may not be what is sane (or the
>    patch is unapplicable in general).

Sure in theory.  But in practice I do not remember one time when, if
all files from one dir are moved in one branch, the files added on
another in the same dir were not bound to be moved as well.

Anway, if we feel git-apply should not decide without the user
knowing, we can make it refuse by default, with options to do either
way, and one option to ask for each doubtful file instead.


>  * If you give at least the names of paths that were moved without any
>    content changes as I suggested, at least the recipient of your patch
>    can catch the case where his tree is structurally different from what
>    you used to prepare the patch for by noticing the a/2 in the patch that
>    he does not have.

Right.

> In addition, if you keep the movements for the paths whose contents did
> not change, existing tools are perfectly capable of applying (or showing)
> the output.  I seriously doubt that keeping 4 lines per perfectly moved
> paths is too much a price to pay to keep backward compatibility.

OK, so I realize we need 2 things here: one format for diff-exporting
with complete info, and one for human viewing (which is, again, the
primary reason why I needed this feature, so I'm not very keen on
letting all this work finally not being useful for me :).  Commands
for saving/mailing patches could issue a bold warning if the user
specifies the for-human-viewing flag.


> > Compare this to the addition of the "file rename" feature (correct me
> > if I'm wrong): it was added without bothering whether plain old
> > "patch" can deal with it,...
> 
> Sorry, but that's an old history whie git-diff output format was rapidly
> being developed, when we did not have that many users, and when we did not
> have an old version of git-apply that did not understand the new feature
> in majority of user's hands.
> 
> We do not have that kind of luxury anymore.  git is much more widespread
> now and the majority of people use pre-1.6.1 git now (including me ;-)).

I was talking about exchanging patches with the non-git part of the
world.  The point is that eg. GNU patch still happily accepts
git-generated files but produces nonsense using some, exactly because
it ignores meaningful data which (by design ?) appear to it to be
legal to ignore.
