From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 11:07:24 -0400
Message-ID: <20070501150724.GA20797@pe.Belkin>
References: <200705011121.17172.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 17:18:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiu76-0005kJ-Ho
	for gcvg-git@gmane.org; Tue, 01 May 2007 17:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbXEAPRw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 11:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbXEAPRw
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 11:17:52 -0400
Received: from eastrmmtai111.cox.net ([68.230.240.30]:39372 "EHLO
	eastrmmtai111.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbXEAPRu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 11:17:50 -0400
X-Greylist: delayed 625 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 May 2007 11:17:50 EDT
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501150725.UGGT16669.eastrmmtao107.cox.net@eastrmimpo02.cox.net>;
          Tue, 1 May 2007 11:07:25 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id tr7Q1W00D0epFYL0000000; Tue, 01 May 2007 11:07:24 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1Hitwq-0005Sp-DC; Tue, 01 May 2007 11:07:24 -0400
Content-Disposition: inline
In-Reply-To: <200705011121.17172.andyparkins@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45946>

On Tue, May 01, 2007 at 11:21:14AM +0100, Andy Parkins wrote:
> Hello,
> 
> I've done this by hand as a proof of concept I suspect it would need loads of 
> work in git-svn to do it properly.  However, I thought I'd mention as part of 
> my "success with submodules" reports.

That's truly interesting, Andy.  Thanks for the encouraging report.
Please do keep us informed of anything more you conclude about this
approach.  I'm sure some of the experts around here can respond with
the pros and cons of this technique.

For my part, I wonder if it can be simplified somehow; and I suspect
it doesn't work well with svn:externals that specify a particular
revision.

-chris

> ffmpeg is managed with svn; I like to track its development with git-svn.  
> Works wonderfully except for one problem: they've made use of svn:externals 
> for one component, libswscale.  Previously I just regularly updated the 
> libswscale subdirectory by checking out the latest copy (which is all that 
> subversion does) and committing it to my own branch off upstream.
> 
> With submodule support in git, it makes it possible to do a much better job.  
> What I did was have two svn-remote sections in the config:
> 
> [svn-remote "ffmpeg"]
>     url = svn://svn.mplayerhq.hu/ffmpeg
>     fetch = trunk:refs/remotes/ffmpeg-svn
> 
> [svn-remote "libswscale"]
>     url = svn://svn.mplayerhq.hu/mplayer
>     fetch = trunk/libswscale:refs/remotes/libswscale-svn
> 
> After running git-svn fetch; there are two independent branches in my 
> repository:
> 
>   -- * -- * -- * -- * -- * (ffmpeg-svn)
>   ---- * ----- * ------- * (libswscale-svn)  
> 
> Now, we fork from ffmpeg-svn and libswscale-svn to make non-tracking branches 
> that can be committed to:
> 
>  $ git checkout -b master-ffm ffmpeg-svn
>  $ git branch master-sws libswscale-svn
> 
> Next, we create a shared clone of the repository as a subdirectory in that 
> repository.
> 
>  $ git clone -s . libswscale
> 
> Now we want that clone to be even more strongly linked to the parent - to the 
> extent that they share the same refs, etc:
> 
>  $ cd libswscale
>  $ rm -rf .git/refs .git/logs .git/info description config
>  $ ln -s ../../.git/refs .git/refs
>  $ ln -s ../../.git/logs .git/logs
>  $ ln -s ../../.git/info .git/info
>  $ ln -s ../../.git/config .git/config
>  $ ln -s ../../.git/description .git/description
> 
> Only HEAD and index are independent.  Next we switch from the ffmpeg branch to 
> the libswscale branch in this subdirectory:
> 
>  $ git checkout master-sws
> 
> Now, we make the subdirectory a submodule in the parent:
> 
>  $ cd ..
>  $ git add libswscale
>  $ git commit -m "libswscale is now a submodule"
> 
> How dangerous is this?  I've made the repository it's own submodule and it 
> shares the same refs, info and logs.  LIVING ON THE EDGE MAN!
> 
> You have to run two git-svn commands to sync with upstream:
> 
>  $ git-svn fetch ffmpeg
>  $ git-svn fetch libswscale
> 
> Then of course you would merge
> 
>  $ git merge ffmpeg-svn
>  $ cd libswscale; git merge libswscale-svn; cd ..
>  $ git commit -m "Sync with upstream"
> 
> Personally I think that's pretty cool, this is significantly better than 
> svn:externals because the particular revision of libswscale in use is 
> recorded.  Seriously - someone show me another VCS that can do that - I think 
> git has actual magic powers :-)
> 
> I dare say that git-svn could do much better because it could reconstruct the 
> submodule history based on the repository dates and create the link in the 
> tracking branch rather than having to do it manually at the end as I've done 
> here.  That would mean that the recorded submodule was right for all 
> history - again, not the case for svn:externals, if you check out a previous 
> version the external remains current.
> 
> 
> 
> Andy
> -- 
> Dr Andy Parkins, M Eng (hons), MIET
> andyparkins@gmail.com
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
