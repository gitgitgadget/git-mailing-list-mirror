From: Ben Lau <benlau@ust.hk>
Subject: Re: Clone a repository with only the objects needed for a single
 tag
Date: Wed, 02 Nov 2005 16:27:21 +0800
Message-ID: <43687869.7060104@ust.hk>
References: <43681E47.4010203@ust.hk> <7vy847y1m2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 09:28:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXDxx-00030W-6u
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 09:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbVKBI10 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 03:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVKBI10
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 03:27:26 -0500
Received: from mx3.ust.hk ([143.89.13.11]:27403 "EHLO mx3.ust.hk")
	by vger.kernel.org with ESMTP id S932645AbVKBI1Z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 03:27:25 -0500
Received: from [143.89.135.159] (atz113.rd.ust.hk [143.89.135.159])
	by mx3.ust.hk (8.12.11/8.12.11) with ESMTP id jA28RH5g081436;
	Wed, 2 Nov 2005 16:27:17 +0800 (HKT)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy847y1m2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11008>

Hi Junio,

  It works!  Thanks a lot.

  However, it has a problem when involves the gitk/git-log. Because the 
parent commit is missed in the shallow repository, gitk would complain 
the object is missed and exit immediately. To solve the problem, i added 
a pair of
ID of the new root object into .git/info/grafts.

Example:

  $ cat .git/info/grafts
  741b2252a5e14d6c60a913c77a6099abe73a854a 
741b2252a5e14d6c60a913c77a6099abe73a854a

git-log/gitk do not complains afterward, but it also make gitk shows 
nothing during run. Any solution?

 By the way, although I am not sure do any other people also require 
this feature, I wish the process could be more smooth.  As the 
git-shallow-pack script do not destroy and modify any thing in the 
cloned repository beside the newly created pack file, I would suggest it 
can run the script in the 'monthership' repository, take out
the pack file to another directory or remote machine. And then build a 
new git repository based on the pack file.

  To achieve the process, it need another script that could create a git 
repository from pack file. Do any similar script existed?

Junio C Hamano wrote:

>Ben Lau <benlau@ust.hk> writes:
>
>  
>
>>  Is there any method to clone/copy a repository with only the
>>objects needed for a single tag in order to save disk space?
>>  For example, if I want to start a new project based on a
>>specific version of kernel like v2.6.14. I would run
>>`git-clone` and then checkout a new branch based on the tag.
>>    
>>
>
>Depends on what you want to do in that shallow copy.
>
>If the only thing you would want to do is to build it, then you
>could 'git-tar-tree v2.6.14' and extract that on your notebook.
>The output is just a tar so there will no history, though.
>
>If you want to develop while on the road, but do not
>particularly need to be able to inspect the history beyond the
>point you started, you could create a deliberately broken
>repository, using the git-shallow-clone script (attached), like
>this:
>
>    $ git clone -n $mothership satellite
>    $ cd satellite
>    $ git-shallow-pack --all
>    $ rm -f .git/objects/pack/pack-*
>    $ mv pack-* .git/objects/pack/.
>
>If the original repository you are cloning from is local, you
>could instead do:
>
>    $ git clone -l -s -n $mothership satellite
>    $ cd satellite
>    $ git-shallow-pack --all
>    $ rm .git/objects/info/alternates
>    $ mv pack-* .git/objects/pack/.
>
>You could develop in this repository, even build up your own
>commit chains, and when you come back you could push from this
>repository back to your 'mothership' repository.  In essense,
>any operation that does not require you to have full history
>should work.
>
>One important thing that would not always work would be to pull
>into this repository over git-aware protocols, although pulling
>from your 'mothership' repository would probably work most of
>the time.
>
>One case that would probably break is if the mothership side
>reverted a commit beyond this shallow-pack boundary and then you
>try to pull from there.  After the revert, the trees and blobs
>in that new commit you will be pulling from the mothership are
>likely to be the same as the ones contained in commits before
>the shallow clone is made.  Because your satellite repo would
>claim to have everything that is reachable from the tip (as of
>the time the clone was made) of the branch, you cannot complain
>if the mothership side assumes you must have those blobs and
>trees and did not send them to you when you pull.
>
>---
>#!/bin/sh
># git-shallow-pack
>
>git-rev-parse --revs-only --no-flags --default HEAD "$@" |
>while read sha1
>do
>	echo "$sha1"
>	while type=`git-cat-file -t "$sha1"` &&
>	      case "$type" in tag) ;; *) break ;; esac
>	do
>		next=`git-cat-file tag "$sha1" |
>			sed -ne 's/^object //p' -e q`
>		echo "$next"
>		sha1="$next"
>	done
>	git-rev-parse --verify "$sha1^{tree}" 2>/dev/null &&
>	git-ls-tree -r "$sha1" | sed -e 's/^[0-7]* [^ ]* //'
>done |
>sort -k 1,1 -u |
>git-pack-objects pack
>
>
>
>
>
>  
>
