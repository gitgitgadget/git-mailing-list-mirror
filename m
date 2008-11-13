From: Nicolas Pitre <nico@cam.org>
Subject: Re: running out of memory when doing a clone of a large repository?
Date: Wed, 12 Nov 2008 22:22:35 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811122206550.27509@xanadu.home>
References: <491B2550.1050005@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Paul E. Rybski" <prybski@cs.cmu.edu>
X-From: git-owner@vger.kernel.org Thu Nov 13 04:24:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0SoI-0002lQ-A3
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 04:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbYKMDWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 22:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbYKMDWn
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 22:22:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21697 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbYKMDWm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 22:22:42 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KA90091F5DNWND0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Nov 2008 22:22:36 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <491B2550.1050005@cs.cmu.edu>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100849>

On Wed, 12 Nov 2008, Paul E. Rybski wrote:

> Hi,
> 	I've recently started evaluating git for use on one of my projects.  I
> used git-svn to convert a fairly large subversion repository and one of
> its branches into two separate git repositories following the
> instructions found here:
> 
> http://www.simplisticcomplexity.com/2008/03/05/cleanly-migrate-your-subversion-repository-to-a-git-repository/
> 
> From that, I created a 1.5G repository from the trunk of the subversion
> repo and a 1.1G repository from one of the branches.  I then tried to
> clone the repositories from one machine to another via ssh and the
> smaller 1.1G repository of the subversion branch (with 1932 commits)
> came over just fine but the larger 1.5G repository of the subversion
> trunk (5865 commits) died with the following error:
> 
> remote: Counting objects: 48415, done.
> remote: warning: suboptimal pack - out of memory
> error: git-upload-pack: git-pack-objects died with error.
> fatal: git-upload-pack: aborting due to possible repository corruption
> on the remote side.
> remote: aborting due to possible repository corruption on the remote side.
> fatal: early EOF
> fatal: index-pack failed
> 
> Is this simply because the git repository is too large for the machine
> that's trying to send it over ssh?

Possibly.

> Is there a way to restrict the memory usage of git or do I need to get 
> more RAM or somehow not import the full subversion history of my 
> original trunk?

It is possible that the inport from svn didn't produce a fully packed 
repository.  Try a "git repack -a -f -d" on the server machine. If you 
get the same out-of-memory problem then ideally you should copy the 
whole directory to a bigger machine and run 'git repack -a -f -d" there.  
Then you may copy it back to the small machine and subsequent clone 
requests should be just fine.

You could also investigate the pack.windowMemory configuration variable 
on the server side.  If you have lots of big files then setting this to 
64m for example may help.

> I'm using Ubuntu 8.04.1 on both machines and using the Ubuntu packages
> of git version 1.5.4.3.

There was a bug in versions prior to v1.5.6.4 affecting memory usage.  
Upgrading to this version or later on the server machine might help too.

> The machine holding the repository is a 5-year
> old AthlonXP 3200 with 1G RAM and 32-bit Ubuntu.  The machine I'm
> cloning the repository on is a more recent Intel Dual Core Quad Q6600
> with 4GRAM and 64-bit Ubuntu.
> 
> Any advice would be greatly appreciated.
> 
> Thanks!
> 
> -Paul
> 
> -- 
> Paul E. Rybski, Ph.D., Systems Scientist
> The Robotics Institute, Carnegie Mellon University
> Phone: 412-268-7417, Fax: 412-268-7350
> Web: http://www.cs.cmu.edu/~prybski
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Nicolas
