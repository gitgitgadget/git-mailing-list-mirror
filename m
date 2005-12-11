From: Ben Lau <benlau@ust.hk>
Subject: Re: Branches merging by only overwrite files
Date: Sun, 11 Dec 2005 19:15:44 +0800
Message-ID: <439C0A60.6070500@ust.hk>
References: <439BE3B9.3040308@ust.hk> <7vbqzonfkx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 12:16:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElPBl-00052l-Dm
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 12:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVLKLQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 06:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVLKLQL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 06:16:11 -0500
Received: from mx4.ust.hk ([143.89.13.26]:36875 "EHLO mx4.ust.hk")
	by vger.kernel.org with ESMTP id S1751345AbVLKLQK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 06:16:10 -0500
Received: from [221.125.13.158] ([221.125.13.158])
	(authenticated bits=0)
	by mx4.ust.hk (8.12.11/8.12.11) with ESMTP id jBBBFigT025751;
	Sun, 11 Dec 2005 19:15:48 +0800 (HKT)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqzonfkx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13498>

Junio C Hamano wrote:

>Ben Lau <benlau@ust.hk> writes:
>
>
>>   I am looking for a solution to merge two branches but do not perform 
>>file level merge. Instead, I wish the result file is the copy from any 
>>one of the branches.
>>
>
>It might be better to state why you need this first.  It could
>be that what you really want to solve is not related to merge at
>all.
>
>
Sorry for not giving the reason to require this merge strategy. I just 
afraid it need to write too long and discourge people in reading my email.

Recently, besides to use git for kernel's version control. I used it to 
manage the change of a content management software called xoops. It is a 
PHP system. I have maintained several websites based on this engine.

Those website's code was maintained by CVS in the past. But CVS's branch 
management is quite terrible and therefore each site have their own 
repository. And now I am going to merge all the sites into a single git 
repository with multple branches.

Source layout of xoops:

html/class
html/themes
html/include
[[:snipped:]]
html/modules

As it is module-based CMS system, after install the core system, users 
may choose to install any module to enchance their site by placing codes 
under the path of 'html/modules' .

That means every user must have their own changes. To simplify the 
upgrade process, users just have to replace the old files by newest 
source , no matter it is the core system or modules.

Consider the following tree:

        v2.0
       /    \
    tag1    v2.2  
    /   \     \
 site1 site2  tag2
                \
              site3

Branches site1 and site2 are dervated from v2.0 and have installed 
several different modules. In the tree, it may have another sites 
running v2.2 like site3. Now, I am going to upgrade site2 to tag2(based 
on v2.2) by merge the branches the produce the tree as follow:

        v2.0
       /    \
    tag1     v2.2  
    /   \     \
 site1   \   tag2
          \  /  \
        site2   site3

But the merge is not smooth, tag2 may contains some modules that are 
newer then what site2 has been installed. Replace those conflict files 
from tag2 should be the simplest method , and that is why I want this 
merge strategy.

>>   For example, assumes it has two branches A and B,  some of the files 
>>are modified in both of them. In this case, `/usr/bin/merge` could not 
>>be execated, it just have to choose the revision from branch A and 
>>discards all the changes from B. For the rest of files, it just simply 
>>choose the newest copy from A or B.
>>
>
>I wonder why you say "could not be executed".  I take it to mean
>you just do not want to even when it could.
>
>
well... a typo mistake, should be "should not be execated"

>Now, it is not clear if you always want copy from branch A and
>not from branch B when both branches have the same path, or you
>want to pick one at random between A and B.  If branch A kept
>the file intact and branch B modified it, what do you want to
>happen?  The default "merge" semantics in git (unless you are
>using "ours" strategy) in such a case is always to take the
>version from branch B.  Is that consistent with what you want?
>
>What do you exactly mean "newest copy from A or B"?  What are
>you basing the "newest" determination on?  The commit date of A
>and B commits, or the author date ot two?
>
>
If the file is modified in branch A, choose the revision from A.
If branch A kept the file intact and branch B modified it, It could use 
the branch B's version.

In fact, It just copy files from branch A to branch B.

>Assuming that you can give reasonable and consistent answer to
>the above question to define the semantics of your "new merge
>algorithm", what you would do is to write a new script
>git-merge-benlau to implement whatever semantics you picked.
>You could model it after existing merge strategy, such as
>git-merge-resolve.sh or git-merge-stupid.sh.  Then you give the
>new merge strategy to "git-merge" or "git-pull".
>
>
hmmm. Do you think my answer make sense? May be I could call it 
"git-merge-direct-copy".  Although it just copy and overwrite files from 
a branch to another , it could help to manage web-based CMS like xoops 
where add-ons are installed by source  within the source tree.

>For example, if you want all the usual "trivial merges" to work
>just like the default git merge algorithms, but always take
>"our" version instead of running file-level merge when both
>sides modified a file, then you start from a copy of
>git-merge-stupid.sh, and replace "git-merge-one-file" with
>"git-merge-one-file-benlau'.  Copy "git-merge-one-file.sh" to
>create another new script, "git-merge-one-file-benlau", and
>replace this line:
>
>	merge "$src1" "$orig" "$src"
>
>with
>
>	cat "$orig" >"$src1"
>
>and you are done.
>
>I outlined the above without knowing what you really want to
>achieve, and I do not think the resulting merge strategy makes
>much sense, but that is what I get form hacking without knowing
>what you are really trying to do ;-).
>
>
Spent some times reading the manual and source code, I found similar way 
to implement. But I don't want to waste the effort in coding , that is 
why I sent this email out to see would it have any solutions that don't 
require to add a new algorithm and changes the source code. If no such 
method, then I will start coding, at least it will be useful to me.

Thanks!!
