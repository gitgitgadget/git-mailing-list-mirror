From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [doc]playing with git, and netdev/libata-dev trees
Date: Sat, 04 Jun 2005 14:16:07 -0400
Message-ID: <42A1EFE7.2080903@pobox.com>
References: <42955DF7.4000805@pobox.com>	 <21d7e99705060401405cfd5a11@mail.gmail.com>	 <42A181C1.3010902@pobox.com> <21d7e99705060403312234aa07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 20:14:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ded8y-0002ve-C1
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 20:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVFDSQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 14:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVFDSQW
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 14:16:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:42178 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261405AbVFDSQM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 14:16:12 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DedBq-0002Rm-RU; Sat, 04 Jun 2005 18:16:11 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Dave Airlie <airlied@gmail.com>
In-Reply-To: <21d7e99705060403312234aa07@mail.gmail.com>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dave Airlie wrote:
>>>1. when you want to publish your tree what do you do? just rsync it
>>>onto kernel.org?
>>
>>Basically.  I copy the attached script into each repo, customize the
>>script for the upload destination.
>>
>>When I publish the tree, I just cd to the toplevel dir on my local
>>workstation, and run "./push"
>>
>>
>>
>>>2. When you are taking things from your queue for Linus do you create
>>>another tree and merge your branches into it or what?
>>
>>Not quite sure what you're asking, but I'll attempt to answer anyway :)
> 
> 
> Yes that's what I'm asking, mainly the pulling of multiple trees into
> one tree for giving to Linus, for Andrew I'm quite happy to have him
> pull multiple HEADs from the one tree assuming I don't have many
> interdependencies between trees...
> 
> Say I want something like this one tree with
> 
> drm-2.6 - HEAD <- linus tree
>             - drm-via < a via driver
>             - drm-initmap 
>                       - drm-savage <- a savage driver that depends on
> the drm-initmap tree
> 
> How would I construct such a beast, how does it work out from where to
> branch, can I branch a branch for something like drm-savage so I can
> say send Linus the initmap branch and then have -mm pulling the savage
> one...

You used to use BitKeeper, right?

Well, git works just fine for creating and maintaining separate repos, 
where each repo is its own branch.  Dependent branches are handled 
simply by pulling new changes from the parent (drm-initmap) repo into 
the child (drm-savage) repo.

If you just have a few branches, such as your example above, rather than 
the 50+ branches I have, then I would recommend _ignoring_ the advice in 
my git howto, and instead create a new branch by cloning:

	cd /repos
	mkdir drm-via
	cp -a linux-2.6/.git drm-via
	rm -rf drm-via/.git/objects
	cp -al linux-2.6/.git/objects drm-via/.git

Once created by the above recipes, or similar, the directory will 
function as a repo just like with BK.  When you wish to update it from 
upstream, update your local linux-2.6 repo and then

	cd /repos/drm-via
	git-pull-script /repos/linux-2.6/.git

or to pull new changes from initmap into savage:

	cd /repos/drm-initmap
	# { check in some changes }
	cd /repos/drm-savage
	git-pull-script /repos/drm-initmap/.git

Does all that make sense?  It's really quite similar to BK, if you 
ignore the "[jg-specific]" portions of the git howto I wrote.

	Jeff


