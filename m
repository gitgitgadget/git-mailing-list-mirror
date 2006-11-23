X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Advice on converting to git from versioning-by-directory
Date: Thu, 23 Nov 2006 09:58:22 +0000
Message-ID: <456570BE.5040702@shadowen.org>
References: <200611230916.46415.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 09:58:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <200611230916.46415.andyparkins@gmail.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32129>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnBLg-0001hG-Jy for gcvg-git@gmane.org; Thu, 23 Nov
 2006 10:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757290AbWKWJ6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 04:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757303AbWKWJ6Z
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 04:58:25 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:30990 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1757290AbWKWJ6X
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 04:58:23 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GnBKt-0008Vk-FR; Thu, 23 Nov 2006 09:57:39 +0000
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> Hello,
> 
> This is an overly long email, please don't waste your time unless you're 
> interested in git-based puzzles.  I'm only really trying to solve the problem 
> for fun. (This is what I do for fun now?  Oh dear).
> 
> I'm in the process of converting a colleague to using git for his project.  
> Previously it was stored in subversion - but was only really used as a backup 
> system, history is entirely linear and there are no merges and no branches.  
> Branching was effectively done by copying directories.  So the history went 
> like this:
> 
>  * version1/ created and worked on with regular commits
>  * version2/ created as a copy of version 1
>  * version2/ worked on with regular commits
>  * occasional commits in version1/
>  * version3/ created as a copy of version2/ and worked on
>  * version4/ created as a copy of version2/ and worked on
> 
> I simply converted the subversion repository to git and then used a bit of 
> rebase and cherry-pick work to put each commit in a particular directory in 
> its correct branch.
> 
>  * -- * -- * -- * -- * version1
>             \
>              * -- * -- * version2
>                        |\
>                        | * -- * version3
>                         \
>                          * -- * version4
>                           
> This is pretty good.  It's certainly a huge improvement over what there was.  
> However, it's still not quite what I want.  The problem is that I haven't 
> done any directory reorganising so now this is a mixed version-by-directory 
> and version-by-branch repository.  For example the version4 branch, because 
> it came from version2, which came from version1 contains directories 
> version1/, version2/ and version4/.
> 
> This makes merging changes impossible, a bug fix in version1, when pulled into 
> version4 simply goes in version4's version1/ directory - obviously not what 
> would be wanted.
> 
> Phew; still with me?  Obviously what I would like is to remove each 
> subdirectory, and have all the branching done using git.  However, I'd like 
> to keep the history so far for each branch.
> 
> What should I do?  I've thought of a number of things:
>  * Recreate the whole lot by hand, the repository isn't huge and I could 
> manually apply each commit as a patch in the correct place.  It would be a 
> bit time-consuming but would mean I'd have what I wanted
>  * Keep the current history and move and remove files out of each branch to 
> make it look like I want it now, and allow history to be a bit of a mess.
>  * As I make each branch reorganise it early on, _then_ apply the history of 
> each branch to the right branch.
> 
> I'm tempted to go with recreate by hand, as that has the fewest compromises.  
> Before I did that though I thought I'd ask you clever chaps to see if you had 
> any amazing ideas :-)

Ok, why is this so different from any normal SVN repository?

Yes your branches are in the 'wrong' place.  But they behave as you'd
expect don't they?  Each one has linear history from its appearance,
each is made from another branch.  I am supprised that you can't use
some mild variation on the svnimport to get it in.  I thought you could
move the branch directory etc.

On the assumption that its too differnt to make it work which is
entirely possible.  It feels like you could use the tree identity to
figure out which tree each is a copy of, where identity is something
like this:

identity() {
        (
                cd "$1" && \
			find . -type f -print | xargs md5sum | md5sum -
        )
}

I would then start with the svn repo checked out as 'svn' and an empty
git repo as 'git', it might go something like the following completly
untested fragment below:

let rev=0
let max=NNN
export GIT_DIR=`pwd/git/.git`
while [ "$rev" -lt "$max" ]; do
    # Get the next svn revision ...
    svn update -r $rev

    # For each 'directory' version ...
    for vd in *; do
        if git branch | grep "$vd"; then
            # We have this branch, so move to it ...
            ( cd git; git checkout "$vd")
        else
            # New one, find out where it came from ...
            id=`identity "$vd"`
            for from in *; do
                if [ "$from" != "$vd" ]; then
                    if [ "$id" = `identity "$from" ]; then
                        git checkout -v "$vd" "$from"
                        break
                    fi
                fi
            done
        fi
        rm -rf git/*
        cp -rp "$vd" git
        ( cd git; git add .; git commit -a -m "svn commit message" )
    done
done

Obviously it needs some error handling if we can't find the 'copy
source', likely we would need to checkin an empty commit under the first
version name, and its not doing the svn commit message etc.

No idea if thats any use...

-apw

