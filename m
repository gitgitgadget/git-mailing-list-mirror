From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Fri, 18 Jun 2010 11:40:16 +0200
Message-ID: <201006181140.16652.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006170239.01951.johan@herland.net> <4C1A8FDC.7010309@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 18 11:41:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPY4e-0008Eh-1L
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 11:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759407Ab0FRJlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 05:41:11 -0400
Received: from smtp.getmail.no ([84.208.15.66]:46296 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685Ab0FRJlI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 05:41:08 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4700CEFEV50H00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 18 Jun 2010 11:40:17 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A7A4F1EA5742_C1B3F01B	for <git@vger.kernel.org>; Fri,
 18 Jun 2010 09:40:17 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 521D21EA42C9_C1B3F01F	for <git@vger.kernel.org>; Fri,
 18 Jun 2010 09:40:17 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4700C01EV5SJ00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 18 Jun 2010 11:40:17 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <4C1A8FDC.7010309@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149339>

On Thursday 17 June 2010, Jens Lehmann wrote:
> Am 17.06.2010 02:39, schrieb Johan Herland:
> > But this is pure speculation, and as you say, I'd like to see what
> > workflows Jens and Heiko are actually using.
> 
> Ok, here we go. And as I have difficulties thinking about that when
> looking at a single graph, I'll draw two: The upper for the superproject
> and the lower for the submodule.
> 
> Superproject:
>   -----2         [Alice's branch]
>  /      \
> 1--3-----4---5   [master]
>     \       /
>      ------6     [Bob's branch]
> 
>        ^   ^
>        |   |     [commits of the submodule committed in the superproject]
> 
> Submodule:
>   ---B           [feature_a]
>  /    \
> A--C---D---E     [master]
>     \     /
>      ----F       [feature_b]
> 
> Alice hacks away on her feature branch and notices she has to make
> changes to a submodule. She creates the "feature_a" branch there with
> commit 'B' and asks the maintainer of the submodule to review and merge
> her change. Our policy is to never commit submodule commits that are not
> merged yet, as they could just vanish (e.g. by rebasing; imagine having
> git as a submodule and committing a SHA1 from the "pu" branch in the
> superproject ... a later bisect might get really frustrating). So the
> submodule maintainer merges 'B' into 'D' and tells Alice that. She
> commits 'D' for the submodule in her '2' commit and asks the maintainer
> of the superproject to review and merge that. The moment he merges that
> into '4', 'D' gets recorded in the master branch of the superproject for
> the submodule.
> 
> Meanwhile Bob also needs a change in the submodule for his work in the
> superproject and adds commit 'F' on the "feature_b" branch there. He
> waits for the submodule maintainer to merge that into 'E' so he can do
> commit '6'.
> 
> But now the submodule commit 'D' in the superproject commit '4' has
> become an obstacle for him and the superprojects maintainer. Bob can't
> rebase or cherrypick beyond or up to '4' because he will get a merge
> conflict. If he asks to merge his branch into '5', the superprojects
> maintainer will get a merge conflict and tells to him to resolve that.

Just verifying here: The superproject graph (with referenced submodule 
commits in parentheses) looks like this:

   --------2(D)            [Alice's branch]
  /         \
 1(A)--3(A)--4(D)---5(?)   [master]
        \          /
         ---------6(E)     [Bob's branch]

...and the conflict that causes problems when merging '4' and '6', is the 
'A'->'D' vs. 'A'->'E' submodule updates.

> This situation would disappear when git merge would do fast-forwards for
> submodule commits. And I argue that this is The Right Thing, because just
> as commit '5' contains /all/ changes from both branches to the files it
> should also contain /all/ changes to the submodules files that happened
> during these branches. And that means merge should resolve the submodule
> to commit 'E'.

I agree, and this is in line with my counter-proposal to Heiko: <quote> 
Given a submodule being part of a superproject conflict, if one of the 
candidate submodule SHA1s is a descendant of all the other submodule SHA1 
candidates, then choose that SHA1 as the proposed resolution</quote>.

> This is somehow similar to merging binary files. But for submodules Git
> has a chance to tell the combined version of both changes in the
> fast-forward case, whereas it can't know that for binary files. And yes,
> merge conflicts could happen for the same reasons they may happen to
> files: The changes in Bob's branch could break something in Alice's
> branch. But that applies for files just like it does for submodule
> commits, no?

Correct. I guess this means that - for the fast-forward case - Git can 
automatically record this resolution in the index, hence not requiring the 
user to "confirm" the resolution with 'git add'.

> And the non-fast-forward case happens e.g. when Alice and Bob do not wait
> for the submodule maintainer to merge their changes:
> 
> Superproject:
>   ---2         [Alice's branch]
>  /    \
> 1--3---4---5   [master]
>     \     /
>      ----6     [Bob's branch]
> 
>      ^   ^
>      |   |       [commits of the submodule committed in the superproject]
> 
> Submodule:
>   ---B           [feature_a]
>  /    \
> A--C---D---E     [master]
>     \     /
>      ----F       [feature_b]
> 
> In this case submodule commit 'B' is recorded in '2' and thus '4', while
> commit 'F' will be recorded in '6'. So when '4' and '6' are merged, a
> valid guess for '5' would be to use submodule commit 'E', as it is the
> first one based on both 'B' and 'F'.

Again, to verify: The superproject graph (with referenced submodule commits 
in parentheses) looks like this:

   --------2(B)            [Alice's branch]
  /         \
 1(A)--3(A)--4(B)---5(?)   [master]
        \          /
         ---------6(F)     [Bob's branch]

(Note that the situation would be different if '3' recorded 'C', as then '4' 
should record 'D' instead of 'B', IMHO.)

In this case, the conflict that causes problems when merging '4' and '6', is 
the 'A'->'B' vs. 'A'->'F' submodule updates.

And, indeed, in the scenario you present 'E' is probably the best guess '5'.

(Here, you still assume that although the submodule merges 'D'/'E' may not 
be done by the time Alice/Bob records '2'/'6', they are definitely done by 
the time the superproject maintainer gets around to creating '5'. Although 
this apparently works well for your case, I'm sure there are other scenarios 
where this is not the case, and are neither helped, nor hurt, by this 
effort.)

> But in this case it is not so clear that 'E' is the right commit, as
> there might be other commits present in the paths 'B'->'E' and 'F'->'E'.
> So 'E' is just a probable solution for the merge, but not one I would
> like to see automatically merged. But it should be proposed to the
> person doing the merge as a probable resolution of the conflict, so that
> she can decide if that is the case.

Agreed. Automatic resolving in this case is evil.

> And no 'special' branch is used here.

Well, you need to traverse _some_ submodule ref(s) in order to find 'E' at 
all. My argument is that there may also be _other_ submodule refs that 
contain merges of 'B' and 'F' as well, and they should _also_ be considered 
as valid candidates for the resolution in '5'. I would in fact argue that 
you should traverse _all_ submodule refs (maybe even including remote-
tracking refs) to look for merges of 'B' and 'F' [1], and present them all 
as equal alternatives.

Consider for example this submodule scenario:

        -----------G      [maint]
       /          /
   ---B--------  /        [feature_a]
  /    \       \/
 A--C---D---E  /\         [master]
     \     /  /  \
      ----F---    \       [feature_b]
              \    \
               --H--I--J  [next]

If there exist multiple merges that resolve 'B' and 'F' (in this case: 'G', 
'E' and 'I'), then all of those should be presented as equal alternatives to 
the user.

> But I think this approach will solve a lot of the problems we - and maybe
> others - have with submodule merges without doing any harm to other
> workflows.

For the fast-forward case, I fully agree.

For the non-fast-forward case, I would suggest to search for submodule 
merges that contain both submodule commits (as described in [1]), and then:

- If there are no merges, do nothing (leave a conflict).

- If there is exactly one merge, then check it out (but do not record it as 
resolved in the index).

- If there are more merge alternatives, present them as equal alternatives, 
but do nothing (leave a conflict).


Have fun! :)

...Johan


[1]: To put the search in general terms: Find all merge commits that has 
_both_ (or in the case of octopus; _all_) of the candidate commits (but none 
of the other merges) somewhere in its ancestry. You could implement this by 
first intersecting the sets returned from these commands (run in the 
submodule):

  git rev-list --merges --ancestry-path --all ^B
  git rev-list --merges --ancestry-path --all ^F

to get the set of merges descending from both 'B' and 'F', and then prune 
each member in the remaining set that has another set member in its 
ancestry.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
