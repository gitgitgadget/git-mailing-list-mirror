From: Andreas Ericsson <ae@op5.se>
Subject: Re: impure renames / history tracking
Date: Wed, 01 Mar 2006 18:43:17 +0100
Message-ID: <4405DD35.8060804@op5.se>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org> <4405C012.6080407@op5.se> <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 18:44:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEVMB-0005xl-8s
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 18:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWCARnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 12:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWCARnU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 12:43:20 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:2257 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932165AbWCARnT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 12:43:19 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id CB4CA6BCBE; Wed,  1 Mar 2006 18:43:17 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16997>

Paul Jakma wrote:
> On Wed, 1 Mar 2006, Andreas Ericsson wrote:
> 
>>> o: commit
>>> m: merge
>>>
>>>    o---o-m--o-o-o--o----m <- project
>>>   /     /              /
>>> o-o-o-o-o--o-o-o--o-o-o <- main branch
>>>
>>> The project merge back to main in one 'big' combined merge 
>>> (collapsing all of the commits on 'project' into one commit). This 
>>> leads to 'impure renames' being not uncommon. The desired end-result 
>>> of merging back to 'main' being to rebase 'project' as one commit 
>>> against 'main', and merge that single commit back, a la:
>>>
>>>    o---o-m--o-o-o--o----m <- project
>>>   /     /              /
>>> o-o-o-o-o--o-o-o--o-o-o---m <- main branch
>>>                        \ /
>>>                         o <- project_collapsed
>>>
>>> So that 'm' on 'main' is that one commit[1].
> 
> 
>> I think you're misunderstanding the git meaning of rebase here. "git 
>> rebase" moves all commits since "project" forked from "main branch" to 
>> the tip of "main branch".
> 
> 
> Right, I'm referring to 'rebase' generally, as a concept, not to 
> git-rebase specifically. E.g. git diff main..project is another way of 
> rebasing I think.
> 

Yes, but imo a poor one, as you're losing all the history. git *can* do 
what you want, but it was designed to maintain a long history so that 
everyone can see it and improve on the code with many chains of small 
and simultanous changes.


>> Other than that, this is the recommended workflow, and exactly how 
>> Linux and git both are managed (i.e. topic branches eventually merged 
>> into 'master').
> 
> 
> They're not rebased though, generally. They're pulled. Ie, in Linux and 
> git when 'project' is merged, things look like:
> 
>     o---o-m--o-o-o--o----m   <- project
>    /     /              / \
> o-o-o-o-o--o-o-o--o-o-o----m <- main branch
> 
> The rest of the world sees /all/ the individual commits of 'project' 
> right? The traditional process for the case I'm thinking of results in 
> the 'main' tree seeing only /one/ single commit for the project.
> 

Perhpas we have a nomenclature clash here. When you say "one single 
commit", I can't help but thinking "snapshot". It's completely 
impossible to fold *ALL* the history into a single commit, and since you 
want heuristics I would imagine you wouldn't want that either.


>> I'm not sure what you mean by 'project_collapsed' though.
> 
> 
> All the commits on the project branch are 'collapsed' into one single 
> commit/delta, and then that /single/ commit is merged to 'main'. Rest of 
> the world sees:
> 
> o-o-o-o-o--o-o-o--o-o-o---m <- main branch
>                        \ /
>                         o <- project
> 

The only sane way to represent this is by doing a mega-patch and 
applying it with a new commit message. That way renamed files will show 
up as

	renamed from /path/to/foo
	renamed to /path/to/some/where/else

Since you're removing all the history in between one mega-patch and the 
next (as if Linus would have v2.6.12 one day and in the next commit it 
would be v2.6.13... strange thought), the history for that tree can't 
well know about renames that doesn't exist in its history. Again, if you 
wan't to keep "master" (can we please call it that? I can't keep up with 
what you call "project" and "main branch") to a single commit you'll 
have no history in it. In essence, that's a snapshot (or a release, 
which is just a snapshot with a tag).

>> Personally I think metadata is evil.
> 
> 
> Not sure I agree. Silly/redundant meta-data can be evil alright. But I'm 
> talking about meta-data which is not there and potentially not 
> reconstructable.
> 
>> Renames will still be auto-detected anyway,
> 
> 
> Chances are so, yes. Definitely with the git and Linux workflows.
> 
> The traditional workflow for the software project I'm thinking of is 
> different though. One commit may encompass multiple renames and edits of 
> a file (discouraged, but it's possible).
> 
> If my understanding is correct, following back history for such cases 
> would be difficult.
> 

It would be impossible. At best you can get "before mega-patch 64, the 
tree looked like this", "after mega-patch 64, it looked like this, and 
here are the files with 80% of above similarity index".


> There is an argument that that 'traditional' process should be changed. 
> However, leaving aside that argument, I'd like to know if git could 
> accomodate that process.
> 
>> be able to detect a rename is if you rename a file and hack it up so 
>> it doesn't even come close to matching its origin (close in this case 
>> is 80% by default, I think). In those cases it isn't so much a rename 
>> as a rewrite.
> 
> 
> Exactly - this is the case I'm concerned about. Imagine that you'd like 
> to be follow the history back through the rewrite and through to the 
> original file.
> 

I'm confused. First you say you want to have one single mega-patch for 
each commit, then you say you want to be able to follow history back. 
It's like deciding to throw away your wallet and then trying to get 
someone to pick it up and carry it around for you.

>> IMO this is far better than having to tell git "I renamed this file to 
>> that", since it also detects code-copying with modifications, and it's 
>> usually quick enough to find those renames as well.
> 
> 
> I think so too, but that involves arguing that very very long-standing 
> workflows should be changed to accomodate git. I intend to make that 
> argument to the 'project' concerned, however I would also like to be say 
> git could equally well deal with the 'traditional' workflow, modulo 
> having to explicitely use (say) git-mv.
> 

The simple fact is that once you start juggling 12MB patches instead of 
keeping the commits, your history is out the window anyway. Adding 
meta-data to accommodate for the lack of history when you throw it away 
is, to be honest, an approach that leaves "insane" in the dust.

As for convincing others, shove git-bisect under their noses and ask 
them if they'd like a tool to find their bugs for them.


>>
>>     $ git checkout master
>>     $ git pull . project
> 
> 
> Right, but 'pull' isn't what I mean :).
> 
> I mean:
> 
>     $ git checkout project
>     $ git pull . master
>     $ git checkout -b tmp project
>     $ git diff project..master | <git apply I think>
>

This way, 'project' and 'tmp' both would hold all patches since you 
merge 'master' into 'project' before creating the 'tmp' branch at the 
head of 'project'. As such, 'project' is ahead of 'master' (it has its 
own changes, those in master and the merge between 'project' and 
'master'), so the diff will be empty.

If 'master' is where you commit regularly (i.e. not mega-patches), you 
can do these two steps to create the mega-patch branch

	$ git checkout -b mega; # create the mega-patch branch
	$ # rewind the mega-patch branch to the dawn of time
	$ git reset --hard $(git rev-list HEAD | tail -n 1)

And for each mega-patch, do this:

	$ # create and apply mega-patch 1
	$ git diff project..master | git apply
	$ # commit the changes we just applied
	$ git commit -s -a -m "mega-patch 1"
	$ git checkout project; # back to project branch
	$ # Merge with 'master', or the next mega-patch won't apply
	$ git pull . master


>> Then you can apply patch-file to whatever branch you want and make the 
>> commit as if it was a single change-set. I'd recommend against it 
>> unless you're just toying around though. It's a bad idea to lie in a 
>> projects history.
> 
> 
> Presume that 'project' in the workflow is defined as
> 
>     "achieve one goal with one commit to the master"
> 
> So by definition, it always correct that the project only ever has one 
> commit.
> 

But that can't be true either, unless you intend to stop working at the 
project. At "best", you could be able to get a chain of commits in 
'master' where each commit hold several tons of changes.

The topic-branch approach to this would be to
a) Implement all changes required for a certain feature in one go and 
commit all of them. do "git pull . topic-branch" when on master branch. 
This will result in a "fast-forward" (i.e. top of 'master' is the 
merge-base between 'master' and 'topic-branch'), so no merge will happen.

b) Implement all changes required for a certain feature in small steps 
and then apply the diff between 'master..topic-branch' to master. The 
topic-branch has to be thrown away, since it can't ever be merged back 
into master, and master can't be merged into the topic-branch (that's 
ok, topic-branches are made to throw away).

For small changes, or one change and some stupid bugfixes, I'd say b) is 
a viable option. The kind of changes you talk about, with several 
renames of files and sometimes near-complete rewrite of them, would 
certainly warrant a merge (or a fast-forward).


> The trouble is that /sometimes/ projects do indeed 'rename and rewrite' 
> a file. At present, chances are git might not notice this, and ability 
> to follow history through the rename+rewrite would be lost.
> 
> I'm wondering whether:
> 
> - this could be solved?


Not with the mega-patch approach.

> - how? (some additional advisory-only meta-data in the
>   index-cache and commit?)
> 

You could maintain that data yourself in either an external or versioned 
file. I've never heard of anyone employing the workflow you describe so 
I doubt it's very common. I also shudder to think that git will be made 
less efficient for the benefit of throwing history away, when tracking 
history efficiently is what it's all about in the first place.


> If there is consensus on an acceptable way, I'm willing to implement it. 
> (I was thinking of just adding 'rename' headers to the commit objects, 
> then teaching diffcore to consider them in addition to current heuristics).
> 

The code is mightier than the mail. Perhaps if I see an implementation 
of this I could wrap my head around what you really mean. I'm sure I 
must misunderstand you one way or another.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
