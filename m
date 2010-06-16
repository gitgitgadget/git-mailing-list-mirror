From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Wed, 16 Jun 2010 02:05:20 +0200
Message-ID: <201006160205.20705.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006150159.42680.johan@herland.net> <4C17BA67.4060500@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 16 02:05:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOg8J-0001FC-K7
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 02:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073Ab0FPAF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 20:05:27 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44786 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888Ab0FPAF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 20:05:26 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4200GREYWZCY70@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 16 Jun 2010 02:05:23 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 92AFE1EEEF42_C181543B	for <git@vger.kernel.org>; Wed,
 16 Jun 2010 00:05:23 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 1F8BE1EEC6D3_C181541F	for <git@vger.kernel.org>; Wed,
 16 Jun 2010 00:05:21 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L420066XYWXK520@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 16 Jun 2010 02:05:21 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <4C17BA67.4060500@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149243>

On Tuesday 15 June 2010, Jens Lehmann wrote:
> Am 15.06.2010 01:59, schrieb Johan Herland:
> >> Lets assume Alice creates a feature branch feature_a for her
> >> development and needs to modify the submodule and creates a branch
> >> there as well. At the same time Bob develops feature_b and also needs
> >> changes in the submodule and so he creates a feature branch there as
> >> well.
> >> 
> >> Assume we now have the following history in the submodule:
> >>   B---C---D         [feature_a]
> >>  /         \
> >> A---E---F---G---K   [master]
> >>      \         /
> >>       H---I---J     [feature_b]
> >> 
> >> Now during the development of her branch Alice would link D in the
> >> superproject as it is the tip of her branch. Bob would do the same and
> >> link to J as his tip. Now Alice sends out her branch to the reviewers
> >> and after everybody is happy with it the maintainer merges her branch
> >> first. The superproject links to D.
> > 
> > No. The superproject would get a conflict between the A->D and A->F
> > updates of the submodule. The correct resolution would be to go into
> > the submodule, do the merge to produce G, and then record this as the
> > correct merge resolution in the superproject.
> 
> But as far as I understood this patch this merge has already been done
> inside the submodule (at least this is what the setup of the test case
> seems to do at a quick glance).

Ok, let's look at a sequence of events:

0. There is a master branch in the superproject which points to commit A (on 
the master branch) in the submodule.

1. Alice creates feature_a branch in both superproject and submodule, 
creates commits B, C & D in the submodule and updates the superproject to 
point to D

2. Someone creates E in the submodule, and updates the master branch in the 
superproject to point to E.

3. Bob creates feature_b branch in both superproject and submodule, creates 
commits H, I & J in the submodule and updates the superproject to point to J

4. Someone creates F in the submodule, and updates the master branch in the 
superproject to point to F.

5. Maintainer starts integrating feature_a into master in superproject, and 
discovers the conflict between A->D and A->F. Mantainer then descends into 
submodule to create the merge G. Maintainer can now 'git add' the submodule 
in the superproject to record A->G as the merge resolution of the A->D vs. 
A->F conflict.

(6. Same as step #5, but replace Alice/A/D/F/G with Bob/E/J/G/K)

I assume here that nobody has made the merge commit G before Git produces 
the A->D vs. A->F conflict in step #5 (which prompts Maintainer to make G in 
order to resolve the conflict). I believe this would be the most common 
case.

If the merge commit G for some reason _already_ exists in the submodule 
before step #5, the maintainer's job is to simply recognize it as the 
correct resolution of the conflict, and check it out (and finally 'git add' 
it to the superproject index). But I don't see this happening very often: 
For one, who has the incentive to create G before it is needed in step #5? 
Both Alice and Bob are content with pointing to their respective submodule 
branches, and the only person who cares about doing the submodule merges is 
Maintainer who has to tie everything together into a coherent whole.

However, we should not require clairvoyance from the Maintainer as to which 
submodules have been modified by each feature branch, and hence which of 
them require preparatory submodule merges to be performed before the main 
superproject merge can be started. To the contrary, I believe the typical 
Maintainer will start the superproject merge, and then respond to the 
submodule conflicts that Git produces by descending into the submodule and 
merging submodules (or whatever else is required to reach a satisfactory 
submodule state).

Thus, if the purpose of Heiko's patches is to simply recognize merges that 
have already happened before step #5, then I'm afraid they will seldom or 
never be useful in practice (since these merges typically happen _after_ the 
superproject merge has been started).

> > You want Git to do this automatically for you, whereas I think that Git
> > should not be that "clever", because there are situations (as I've
> > demonstrated previously in this thread) where the "cleverness" would do
> > The Wrong Thing.
> > 
> >> Now Bob does the same and the
> >> maintainer wants to merge his branch and gets a merge conflict because
> >> D and J do not have a parent/children relationship.
> > 
> > Well, s/D/G/, but your point still stands. And the correct resolution
> > is, of course, to merge G and J to produce K, and then record K in the
> > superproject as the correct merge resolution.
> > 
> > Again, the question is whether Git should do these submodule merges
> > automatically, or not.
> 
> Hm, maybe I am missing something here, but isn't the question whether Git
> should /use/ these submodule merges already done by a human being instead
> of /doing them itself/? So isn't it just about making Git so clever it
> proposes a merge already present in the submodule for recording in the
> superproject when merging there?

Ah, yes, sorry, I confused the concepts at this point. Still:

- If the purpose is to re-use existing submodule merges then I'm afraid (as 
I've argued above) that this would happen too seldom to be useful in 
practice (and even then you would already have had to set up the appropriate 
config for your branch, to enable Git to find this pre-existing merge at 
all).

- If the purpose is to create new submodule merges to resolve the conflicts 
(which, granted, the patches currently don't do, but that I'm afraid they 
would _have_ to do in order to be useful in practice), then there is too 
much cleverness/magic for my liking.

> > Feel free to post the patches, if you can spend the time making them.
> > So far, there's been no other feedback in this thread, so maybe I'm
> > alone in my worries...
> 
> I fully understand your worries concerning automagic merges inside a
> submodule. But I really would like to see Git assisting me when merging
> submodule commits in the superproject that have already been merged in
> the submodule repo.

As I've argued above, I'm afraid this situation would seldom/never arise in 
practice.

Taking a step back and comparing the merging of submodules vs. the merging 
of regular files:

Git's rules are simple and straightforward for regular files: If both 
sides/branches have changed the same area of code (and the changes don't 
exactly coincide), you get a conflict. There's no magic/cleverness applied 
to try to figure out what a good resolution would look like; it's a 
conflict, and the user must resolve it. Simple as that.

I'd argue that the submodule case should be the same: If both sides/branches 
change the submodule (and the SHA1s don't exactly match), you get a 
conflict, and it's up to the user to resolve it.

We may to make an exception for the case where one SHA1 is a descendant of 
the other (i.e. a fast-forward situation), since that seems like a safe 
choice in most situations, but I don't feel safe doing much beyond that.

> And for me the first commit containing the others is the one I would like
> to see then.

In that case you will have to modify Heiko's patches, because (I believe) 
they currently choose the _latest_ commit containing the others...


Cheers,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
