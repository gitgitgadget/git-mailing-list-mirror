From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Tags
Date: Sat, 2 Jul 2005 16:38:06 -0400
Message-ID: <20050702203805.GB19206@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com> <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com> <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 22:38:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoolD-0007R9-76
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 22:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVGBUii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 16:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVGBUii
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 16:38:38 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:24730 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261277AbVGBUif (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2005 16:38:35 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DookY-0005XN-00; Sat, 02 Jul 2005 16:38:06 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
Content-Disposition: inline
In-Reply-To: <42C5DA77.4030107@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 01, 2005 at 05:06:15PM -0700, H. Peter Anvin wrote:
> Eric W. Biederman wrote:
> >
> >If I really care what developer xyz tagged I will pull from them,
> >or a mirror I trust.  And since developer xyz doesn't pull his
> >own global tags from other repositories that should be sufficient.
> >
> 
> You're missing something totally and utterly fundamental here: I'm 
> talking about creating an infrastructure (think sourceforge) where there 
> is only one git repository for the whole system, period, full stop, end 
> of story.

I'm not entirely sure what you are envisoning, but it is definitely
doable in a secure way.

- Assume that each developer will one or more private trees with one or
  more branches on kernel.org, lets say all these private repositories
  are stored under /scm/git/<user>/

- Now you create a single 'global repository' which is going to be the
  publicly visible one that will be mirrored out,

- Then you run the following script (untested)
  #!/bin/sh
  GIT_DIR=$global_repo
  for user in `(cd /scm/git ; ls)`; do
    for tree in `find /scm/git/$user -name *.git` ; do
	for ref in `find $tree/refs -type f`  ; do
	    type=`echo $ref | sed 'sX^.*/refs/\([^/]*\)/.*$X\1X'`
	    name=`echo $ref | sed 'sX^.*/refs/[^/]*/\(.*\)$X\1X'`
	    git fetch /scm/git/$tree $branch 
	    mkdir -p $GIT_DIR/refs/$type/$user/$name
	    cat $GIT_DIR/FETCH_HEAD > $GIT_DIR/refs/$type/$user/$name
	done
    done
  done

- You can repack the global repository whenever you want.
- Finally, once a user knows that all his changes are available from the
  global repository, he can remove any objects from his tree and use
  GIT_ALTERNATE_OBJECT_DIRECTORIES=$global_repo/objects
  (maybe there should be a flag for git prune to removes local objects
  that are already available in the alternate object directories)

Jan
