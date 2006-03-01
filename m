From: Paul Jakma <paul@clubi.ie>
Subject: Re: impure renames / history tracking
Date: Wed, 1 Mar 2006 16:27:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
 <4405C012.6080407@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 17:31:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEUBU-00039S-LL
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 17:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWCAQ2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 11:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWCAQ2N
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 11:28:13 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:42393 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751366AbWCAQ2N
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 11:28:13 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1/n6Z3sGu8bHE7mhMHWArHQYrJ69pcKkis@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k21GRLTs032296;
	Wed, 1 Mar 2006 16:27:33 GMT
X-X-Sender: paul@sheen.jakma.org
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4405C012.6080407@op5.se>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16988>

On Wed, 1 Mar 2006, Andreas Ericsson wrote:

> Mainly for two reasons, iirc:

> 1. Extensive metadata is evil.

Only if /required/. I wouldn't argue for rename meta-data to be 
'core', only as an additional hint into the rename-detection process.

FWIW, I think git's rename handling is really nice. It's just I 
suspect, being a heuristic, it won't be able to follow history 
reliably across 'very impure' renames.

> 2. Backwards compatibility. Old repos should always work with new 
> tools. Old tools should work with new repos, at least until a new 
> major-release is released.

Absolutely.

>> o: commit
>> m: merge
>>
>>    o---o-m--o-o-o--o----m <- project
>>   /     /              /
>> o-o-o-o-o--o-o-o--o-o-o <- main branch
>> 
>> The project merge back to main in one 'big' combined merge (collapsing all 
>> of the commits on 'project' into one commit). This leads to 'impure 
>> renames' being not uncommon. The desired end-result of merging back to 
>> 'main' being to rebase 'project' as one commit against 'main', and merge 
>> that single commit back, a la:
>>
>>    o---o-m--o-o-o--o----m <- project
>>   /     /              /
>> o-o-o-o-o--o-o-o--o-o-o---m <- main branch
>>                        \ /
>>                         o <- project_collapsed
>> 
>> So that 'm' on 'main' is that one commit[1].

> I think you're misunderstanding the git meaning of rebase here. 
> "git rebase" moves all commits since "project" forked from "main 
> branch" to the tip of "main branch".

Right, I'm referring to 'rebase' generally, as a concept, not to 
git-rebase specifically. E.g. git diff main..project is another way 
of rebasing I think.

> Other than that, this is the recommended workflow, and exactly how Linux and 
> git both are managed (i.e. topic branches eventually merged into 'master').

They're not rebased though, generally. They're pulled. Ie, in Linux 
and git when 'project' is merged, things look like:

     o---o-m--o-o-o--o----m   <- project
    /     /              / \
o-o-o-o-o--o-o-o--o-o-o----m <- main branch

The rest of the world sees /all/ the individual commits of 'project' 
right? The traditional process for the case I'm thinking of results 
in the 'main' tree seeing only /one/ single commit for the project.

> I'm not sure what you mean by 'project_collapsed' though.

All the commits on the project branch are 'collapsed' into one single 
commit/delta, and then that /single/ commit is merged to 'main'. Rest 
of the world sees:

o-o-o-o-o--o-o-o--o-o-o---m <- main branch
                        \ /
                         o <- project

> correctly, each branch-head represents one 'collapse'.

Not quite. It represents a branch with one or more commits. In the 
Linux and git work flow, multiple commits are left as is.

> gitk is great for visualizing what you've done and what the repo 
> looks like. Use and abuse it frequently every time you're unsure 
> what was you just did. It's the best way to quickly learn what 
> happens, really.

I do. It rocks! :)

> If you just want to distribute snapshots I suggest you do take a 
> look at git-tar-tree. Junio makes nice use of it in the git 
> Makefile (the dist: target).

Neat.

Though, I probably should stay away from the git Makefile for now. 
<cough>.

> Personally I think metadata is evil.

Not sure I agree. Silly/redundant meta-data can be evil alright. But 
I'm talking about meta-data which is not there and potentially not 
reconstructable.

> Renames will still be auto-detected anyway,

Chances are so, yes. Definitely with the git and Linux workflows.

The traditional workflow for the software project I'm thinking of is 
different though. One commit may encompass multiple renames and edits 
of a file (discouraged, but it's possible).

If my understanding is correct, following back history for such cases 
would be difficult.

There is an argument that that 'traditional' process should be 
changed. However, leaving aside that argument, I'd like to know if 
git could accomodate that process.

> be able to detect a rename is if you rename a file and hack it up 
> so it doesn't even come close to matching its origin (close in this 
> case is 80% by default, I think). In those cases it isn't so much a 
> rename as a rewrite.

Exactly - this is the case I'm concerned about. Imagine that you'd 
like to be follow the history back through the rewrite and through to 
the original file.

> IMO this is far better than having to tell git "I renamed this file 
> to that", since it also detects code-copying with modifications, 
> and it's usually quick enough to find those renames as well.

I think so too, but that involves arguing that very very 
long-standing workflows should be changed to accomodate git. I intend 
to make that argument to the 'project' concerned, however I would 
also like to be say git could equally well deal with the 
'traditional' workflow, modulo having to explicitely use (say) 
git-mv.

>> 1. Git currently doesn't have 'porcelain' to do this, presumably there'd be 
>> no objection to one?
>> 
>
> 	$ git checkout master
> 	$ git pull . project

Right, but 'pull' isn't what I mean :).

I mean:

 	$ git checkout project
 	$ git pull . master
 	$ git checkout -b tmp project
 	$ git diff project..master | <git apply I think>

> If, for some reason, you want to combine lots of commits into a single 
> mega-patch (like Linus does for each release of the kernel), you can do:
>
> 	$ git diff $(git merge-base main project) project > patch-file

Right.

> Then you can apply patch-file to whatever branch you want and make 
> the commit as if it was a single change-set. I'd recommend against 
> it unless you're just toying around though. It's a bad idea to lie 
> in a projects history.

Presume that 'project' in the workflow is defined as

 	"achieve one goal with one commit to the master"

So by definition, it always correct that the project only ever has 
one commit.

The trouble is that /sometimes/ projects do indeed 'rename and 
rewrite' a file. At present, chances are git might not notice this, 
and ability to follow history through the rename+rewrite would be 
lost.

I'm wondering whether:

- this could be solved?
- how? (some additional advisory-only meta-data in the
   index-cache and commit?)

If there is consensus on an acceptable way, I'm willing to implement 
it. (I was thinking of just adding 'rename' headers to the commit 
objects, then teaching diffcore to consider them in addition to 
current heuristics).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Be nice to people on the way up, because you'll meet them on your way down.
 		-- Wilson Mizner
