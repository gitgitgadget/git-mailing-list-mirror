From: Andreas Ericsson <ae@op5.se>
Subject: Re: impure renames / history tracking
Date: Wed, 01 Mar 2006 16:38:58 +0100
Message-ID: <4405C012.6080407@op5.se>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 16:39:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FETPr-0005wO-Kt
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 16:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWCAPjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 10:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWCAPjA
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 10:39:00 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:58830 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932241AbWCAPi7
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 10:38:59 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 8E79C6BD0A; Wed,  1 Mar 2006 16:38:58 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16979>

Paul Jakma wrote:
> 
> - git obviously detects pure renames perfectly well
> 
> - git doesn't however record renames, so 'impure' renames may not be
>   detected
> 
> My question is:
> 
> - why not record rename information explicitely in the commit object?
> 

Mainly for two reasons, iirc:
1. Extensive metadata is evil.
2. Backwards compatibility. Old repos should always work with new tools. 
Old tools should work with new repos, at least until a new major-release 
is released.


> I.e. so as to be able to follow history information through 'impure' 
> renames without having to resort to heuristics.
> 
> E.g. imagine a project where development typically occurs through:
> 
> o: commit
> m: merge
> 
>    o---o-m--o-o-o--o----m <- project
>   /     /              /
> o-o-o-o-o--o-o-o--o-o-o <- main branch
> 
> The project merge back to main in one 'big' combined merge (collapsing 
> all of the commits on 'project' into one commit). This leads to 'impure 
> renames' being not uncommon. The desired end-result of merging back to 
> 'main' being to rebase 'project' as one commit against 'main', and merge 
> that single commit back, a la:
> 
>    o---o-m--o-o-o--o----m <- project
>   /     /              /
> o-o-o-o-o--o-o-o--o-o-o---m <- main branch
>                        \ /
>                         o <- project_collapsed
> 
> So that 'm' on 'main' is that one commit[1].
> 

I think you're misunderstanding the git meaning of rebase here. "git 
rebase" moves all commits since "project" forked from "main branch" to 
the tip of "main branch".

Other than that, this is the recommended workflow, and exactly how Linux 
and git both are managed (i.e. topic branches eventually merged into 
'master').

In your drawings, 'main branch' would be 'master' and 'project' would be 
any amount of topic-branches (or just one, if you like that better).

I'm not sure what you mean by 'project_collapsed' though. If I 
understand you correctly, each branch-head represents one 'collapse'. I 
suggest you clone the git repo and do

	$ gitk master
	$ gitk next
	$ gitk pu

gitk is great for visualizing what you've done and what the repo looks 
like. Use and abuse it frequently every time you're unsure what was you 
just did. It's the best way to quickly learn what happens, really.

If you just want to distribute snapshots I suggest you do take a look at 
git-tar-tree. Junio makes nice use of it in the git Makefile (the dist: 
target).


> The merits or demerits of such merging practice aside, what reason would 
> there be /against/ recording explicit rename information in the commit 
> object, so as to help browsers follow history (particularly impure 
> renames) better in a commit?
> 
> I.e. would there be resistance to adding meta-info rename headers commit 
> objects, and having diffcore and other tools to use those headers to 
> /augment/ their existing heuristics in detecting renames?
> 

Personally I think metadata is evil. Renames will still be auto-detected 
anyway, and with the distributed repo setup the only reason git 
shouldn't be able to detect a rename is if you rename a file and hack it 
up so it doesn't even come close to matching its origin (close in this 
case is 80% by default, I think). In those cases it isn't so much a 
rename as a rewrite. If you find the commit where the file was renamed 
it should be listed in that commit, like so:

	similarity index 92%
	rename from Documentation/git-log-script.txt
	rename to Documentation/git-log.txt

(this is gitk output from the git repo. Search for "Big tool rename")

IMO this is far better than having to tell git "I renamed this file to 
that", since it also detects code-copying with modifications, and it's 
usually quick enough to find those renames as well.

> Thanks!
> 
> 1. Git currently doesn't have 'porcelain' to do this, presumably there'd 
> be no objection to one?
> 

	$ git checkout master
	$ git pull . project

The dot means "pull from the local repo". "project" is the branch you 
want to merge into master. You can pull an arbitrary amount of branches 
in one go ("octopus" merge). The current tested limit is 12 (thanks, Len 
;) ).

If, for some reason, you want to combine lots of commits into a single 
mega-patch (like Linus does for each release of the kernel), you can do:

	$ git diff $(git merge-base main project) project > patch-file

Then you can apply patch-file to whatever branch you want and make the 
commit as if it was a single change-set. I'd recommend against it unless 
you're just toying around though. It's a bad idea to lie in a projects 
history.

Hope that helps.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
