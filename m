From: Nicolas Pitre <nico@cam.org>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Wed, 07 Jan 2009 10:02:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901070955500.26118@xanadu.home>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
 <c09652430901070026m6ca0ec98ndc7483aac8dfde89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Opk/N19Q+bgpN4feITNfsA)"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?=D8yvind_Harboe?= <oyvind.harboe@zylin.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 16:04:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKZxE-0003vL-8B
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 16:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbZAGPC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 10:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbZAGPC4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 10:02:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19841 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbZAGPCz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 10:02:55 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KD300E17WGP6XB0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Jan 2009 10:02:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <c09652430901070026m6ca0ec98ndc7483aac8dfde89@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104802>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Opk/N19Q+bgpN4feITNfsA)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Wed, 7 Jan 2009, Øyvind Harboe wrote:

> Here is a summary of the solution I used. I'm a beginner in git
> and just summarizing what others told me and what I did. Use at
> your own risk!
> 
> 1. Remove anything you know should be removed, e.g.:
> 
> git filter-branch --tree-filter 'find . -regex ".*toolchain\..*" -exec
> rm -f {} \;' HEAD
> 
> 2. Expire the log:
> 
> git reflog expire --all
> 
> 3. Delete stuff from .git that should be manually "verified" to be
> correct. I don't actually
> know how to "verify" that at this point... Use backups Luke!
> 
> rm -rf .git/refs/original
> # delete lines w/"refs/original" from .git/packed-refs
> vi .git/packed-refs
> # for good measure...
> git reflog expire --all
> git gc
> 
> 4. Your repository is still huge. By creating a new repository and pulling from
> this one, the garbage will stay in the old one...
> 
> mkdir newrep
> cd newrep
> git init
> git pull file:///oldrep

I'd suggest you skip 2 and 3, and do 4 only.  Using 4 makes 2 
unnecessary, and is far safer than 3.  Manually deleting stuff in .git 
is fine only if you really know what you're doing and have some 
acquaintance with the git internals.

> 5. Check size of .git. If it is still too big, try figuring out which
> files that are big by looking at the packs(.git/objects/pack/xxx):
> 
> $ git verify-pack -v $PACK | grep -v "^chain " | sort -n -k 4
> 
> and then for the last few lines do a
> 
> $ git rev-list --all --objects | grep $SHA1
> 
> 6. Go back to #1 until done.
> 
> Your repository should now be of reasonable size...
> 
> I've found some great scripts for converting from svn/cvs, but really
> the above procedure
> is necessary to run when converting nasty old repositories...
> 
> -- 
> Øyvind Harboe
> http://www.zylin.com/zy1000.html
> ARM7 ARM9 XScale Cortex
> JTAG debugger and flash programmer
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--Boundary_(ID_Opk/N19Q+bgpN4feITNfsA)--
