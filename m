From: andreas.t.auer_gtml_37453@ursus.ath.cx
Subject: Re: Auto update submodules after merge and reset
Date: Thu, 08 Dec 2011 10:13:49 +0100
Message-ID: <4EE07FCD.8090702@ursus.ath.cx>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 08 10:24:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYaDM-0002ZH-8V
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 10:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab1LHJYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 04:24:23 -0500
Received: from brln-4db92d04.pool.mediaWays.net ([77.185.45.4]:13616 "EHLO
	here" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751237Ab1LHJYU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 04:24:20 -0500
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Dec 2011 04:24:19 EST
Received: from [192.168.0.14] (unknown [192.168.0.14])
	by here (Postfix) with ESMTP id 819B71A0608;
	Thu,  8 Dec 2011 10:14:32 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20111110 Icedove/3.0.11
In-Reply-To: <4EDFE75C.5050201@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186544>



On 07.12.2011 23:23 Jens Lehmann wrote:
>  Am 07.12.2011 10:07, schrieb Andreas T.Auer:
> > Jens Lehmann wrote:
> >
> >> Am 30.11.2011 01:55, schrieb Max Krasnyansky: I'm working on a
> >> patch series to teach Git to optionally update the submodules
> >> work trees on checkout, reset merge and so on, but I'm not there
> >> yet.
> >>
> >>> I'm thinking about adding a config option that would enable
> >>> automatic submodule update but wanted to see if there is some
> >>> fundamental reason why it would not be accepted.
> > Because there is no good way to do so. It would be fine when you
> > just track the submodules "read-only", but if you are actually
> > working on submodules, it is a bad idea to always get a detached
> > HEAD.
>
>  YMMV. We get along *really* well with this because all developers
>  know that if they want to hack on a submodule, they have to create a
>  branch in there first (and if they forget to do that, git status and
>  friends will tell them).
Sorry, my fault. I was answering to the question why auto-update is not 
the default, but replied to the  wrong text block. (I should have heeded 
the note to self about the coffee in the morning ;-) )
Having the config option is fine, of course. But it is not easy to 
choose a good default auto-update method, because you need different 
workflows for different submodules/users .
>  What bugs us is that submodule HEADs don't follow what is checked
>  out (or merged, or reset ...) in the superproject. We had some
>  really nasty mismerges because of that, so we need the option to
>  enable it.
>
Full ack. Using the auto-update method "disabled" is a bad choice, too. ;-)

> > Because if you are working on a maint branch in the submodule and
> > then you checkout a pu branch in the superproject, because you
> > have forgotten that maint branch in the submodule then all the
> > proposed updates go to the maintenance branch -> bad.
>
>  Nope, checkout will fail and not do anything as it will detect
>  changes in the submodule to be updated by the checkout (just as it
>  would do with a regular file).
>
Without auto-update you can easily checkout the pu branch in the 
superproject. And when you execute
git submodule update --merge
the pu referenced commit of the submodule will be merged into the 
currently checkedout maint branch of the submodule without warning 
unless you have merge conflicts.
And when auto-update is just running git submodule update automatically 
it would act as I described.
But you are right, with auto-update the submodule's HEAD can be checked 
against the old gitlink before it is changed. If doing it in two steps 
it is not possible to have this check.

> >
> > I was thinking about submodule integration and had the idea to
> > bind a submodule to the superproject by having special references
> > in the submodule like refs/super/master, refs/super/featureX... So
> > these references are like tracking branches for the refs/heads/* of
> > the superproject.
>
>  Having stuff in the submodule reference branches in the superproject
>   sounds upside down, as a superproject has (and should have) zero
>  knowledge about the superproject (as it could have many different of
>  them).
>
My viewpoint is that I have a big project that is divided into 
submodules because not all developerss need all parts of the project. 
Therefore I wanted something that uses submodules as separate repos, but 
from the users viewpoint it should be as if the submodules are just 
subdirectories. It would include that diffs of submodules are not shown 
as a summary of commit messages but as a diff of the sources. And from 
that perspective it makes more sense to have tracking branches in the 
submodule that are owned by the superproject. In the first thought these 
tracking refs were meant to be readonly in the submodule and only 
updatable from the superproject, but then I thought the possibility of  
detaching and re-attaching is nice, too. One thing I've forgot to 
mention: the refs/super/* are not SHA1-refs to the superproject (that 
would be stupid indeed), but they contain the corresponding gitlink-SHA1 
from the revision referenced by refs/heads/*. So when you have a 
detached HEAD after auto-update you would simply "git checkout -B 
super/<superproject-branchname>" in the submodule, with the difference 
that it shouldn't update refs/heads/super/*, but refs/super/* so that 
these branches can be treated specially.

> > If you have tracking branches, the supermodule can just update the
> > corresponding branch. If this branch is currently checkedout and
> > the work area is clean, then the work area is updated, too. If
> > there is currently a local branch or a diffent super-branch
> > checked out then the working area should be considered "detached"
> > from the superproject and not updated.
>
>  This sounds a lot like the "follow branch tip" model we discussed
>  recently (which could be configured via .gitmodules), but I'm not
>  sure you really are in the same boat here.
When I understood that correctly it was just a configuration to what 
branch should be automatically checked out in the submodule. This seems 
to be too complicated IMO, because when you have different branches in 
the superproject then you may want to have different branches in the 
submodules, too, but you would need to configure that submodule branch 
in .gitmodules for each branch separately. I.e. in the master branch the 
.gitmodule may contain "master", in the maint branch the .gitmodules may 
have "maint" as the branch to follow.
I do want to follow the tip of the branch, if the superproject has that 
currently checked out. If the superproject checks out a tagged version 
for a rebuild, then the submodule should not follow the tip, but should 
get a detached HEAD of the corresponding commit, just as the 
superproject. When the superproject goes back to the branch, the 
submodule should go back to its tracking branch.
>
> > With this concept you could even switch branches in the
> > superproject and the attached submodules follow - still having no
> > detached HEAD. When you want to do some local work on the
> > submodule you checkout a local branch and merge back into the super
> > branch later.
>
>  You lost me here. How can you merge a submodule branch into one of
>  the superproject?
It wouldn't work, if the super/* branch would contain a superproject's 
SHA-1, that is right. But as explained above, it points to a commit of 
the submodule.
>
>  But we would want to have a deterministic update procedure, no? (And
>  what has more freedom than a detached HEAD? ;-)__
I think my proposal would be deterministic.
And everything where you can commit to has more freedom than a detached HEAD

>
> > Even though it will raise a lot of detailed questions like "should
> > the refs/super/* be pushed/pulled when syncing the submodule
> > repositories".
>
>  I doubt that is a good idea, as that might conflict with the same
>  submodule sitting in a different superproject. But I'm interested to
>  hear how you want to solve that.
The first answer to my question was "yes, you need to transfer the refs 
or you get unreferenced objects" and "no, you can't transfer the refs, 
because they are owned by the superproject, not the submodule."
But binding a submodule to a superproject makes perfect sense if it is 
_one_ project that is split into submodules. In that case you only have 
one superproject for a submodule and for that purpose it would be good 
workflow. It is even nice to see which commits in the submodule belong 
to what branches in the superproject or to what release version (so 
tracking superproject tags would make sense, too). If you have a 
submodule that has more than one superproject but these are 
well-defined, it could be solved using refspecs (e.g. refs/super/foo/* 
for one and refs/super/bar/* for the other superproject), but currently 
I can't think of a context where this makes sense.

Of course there are other types of submodules, so using refs/super/* 
wouldn't be a good default variant for auto-update either. E.g. if you 
use a 3rdParty lib, then the detached HEAD is fine, because usually you 
don't touch it except when you switch to a new version from time to time.
