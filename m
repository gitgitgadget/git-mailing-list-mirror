From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Thu, 17 Jun 2010 23:13:00 +0200
Message-ID: <4C1A8FDC.7010309@web.de>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006162332.56700.johan@herland.net> <7vy6eed3w0.fsf@alter.siamese.dyndns.org> <201006170239.01951.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jun 17 23:13:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPMOg-0006ss-In
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 23:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100Ab0FQVNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 17:13:07 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:50050 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0FQVNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 17:13:05 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 282BA1571874E;
	Thu, 17 Jun 2010 23:13:04 +0200 (CEST)
Received: from [80.128.111.51] (helo=[192.168.178.26])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OPMOV-0000UZ-00; Thu, 17 Jun 2010 23:13:04 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201006170239.01951.johan@herland.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/L3t0tJn93LC5uUDKUGRO3dFKgz3hTXX/SH7Q4
	vq6b/HtQqLqJGh7lRvJYgzrQzcv8kvkrRJy/RiEcVhBbgiATP0
	Bxm/0x9CTana7QDLMMnw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149327>

Am 17.06.2010 02:39, schrieb Johan Herland:
> But this is pure speculation, and as you say, I'd like to see what workflows 
> Jens and Heiko are actually using.

Ok, here we go. And as I have difficulties thinking about that when looking
at a single graph, I'll draw two: The upper for the superproject and the
lower for the submodule.

Superproject:
  -----2         [Alice's branch]
 /      \
1--3-----4---5   [master]
    \       /
     ------6     [Bob's branch]

       ^   ^
       |   |     [commits of the submodule committed in the superproject]

Submodule:
  ---B           [feature_a]
 /    \
A--C---D---E     [master]
    \     /
     ----F       [feature_b]

Alice hacks away on her feature branch and notices she has to make changes
to a submodule. She creates the "feature_a" branch there with commit 'B'
and asks the maintainer of the submodule to review and merge her change.
Our policy is to never commit submodule commits that are not merged yet, as
they could just vanish (e.g. by rebasing; imagine having git as a submodule
and committing a SHA1 from the "pu" branch in the superproject ... a later
bisect might get really frustrating). So the submodule maintainer merges 'B'
into 'D' and tells Alice that. She commits 'D' for the submodule in her '2'
commit and asks the maintainer of the superproject to review and merge that.
The moment he merges that into '4', 'D' gets recorded in the master branch
of the superproject for the submodule.

Meanwhile Bob also needs a change in the submodule for his work in the
superproject and adds commit 'F' on the "feature_b" branch there. He waits
for the submodule maintainer to merge that into 'E' so he can do commit '6'.

But now the submodule commit 'D' in the superproject commit '4' has become
an obstacle for him and the superprojects maintainer. Bob can't rebase or
cherrypick beyond or up to '4' because he will get a merge conflict. If he
asks to merge his branch into '5', the superprojects maintainer will get a
merge conflict and tells to him to resolve that.

This situation would disappear when git merge would do fast-forwards for
submodule commits. And I argue that this is The Right Thing, because just as
commit '5' contains /all/ changes from both branches to the files it should
also contain /all/ changes to the submodules files that happened during
these branches. And that means merge should resolve the submodule to commit
'E'.

This is somehow similar to merging binary files. But for submodules Git has
a chance to tell the combined version of both changes in the fast-forward
case, whereas it can't know that for binary files. And yes, merge conflicts
could happen for the same reasons they may happen to files: The changes in
Bob's branch could break something in Alice's branch. But that applies for
files just like it does for submodule commits, no?


And the non-fast-forward case happens e.g. when Alice and Bob do not wait
for the submodule maintainer to merge their changes:

Superproject:
  ---2         [Alice's branch]
 /    \
1--3---4---5   [master]
    \     /
     ----6     [Bob's branch]

     ^   ^
     |   |       [commits of the submodule committed in the superproject]

Submodule:
  ---B           [feature_a]
 /    \
A--C---D---E     [master]
    \     /
     ----F       [feature_b]

In this case submodule commit 'B' is recorded in '2' and thus '4', while
commit 'F' will be recorded in '6'. So when '4' and '6' are merged, a valid
guess for '5' would be to use submodule commit 'E', as it is the first one
based on both 'B' and 'F'.

But in this case it is not so clear that 'E' is the right commit, as there
might be other commits present in the paths 'B'->'E' and 'F'->'E'. So 'E'
is just a probable solution for the merge, but not one I would like to see
automatically merged. But it should be proposed to the person doing the
merge as a probable resolution of the conflict, so that she can decide if
that is the case.


And no 'special' branch is used here. But I think this approach will solve
a lot of the problems we - and maybe others - have with submodule merges
without doing any harm to other workflows.
