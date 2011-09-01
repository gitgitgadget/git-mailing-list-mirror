From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: git-svn and mergeinfo
Date: Thu, 1 Sep 2011 10:43:27 -0400
Organization: White Oak Technologies
Message-ID: <20110901104327.14d4dba6@robyn.woti.com>
References: <20110829132052.0ad7a088@robyn.woti.com>
	<4E5F4987.5040205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 01 16:43:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz8UR-0005Ik-Hu
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 16:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757670Ab1IAOna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 10:43:30 -0400
Received: from mail02.woti.us ([66.92.158.6]:32804 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757632Ab1IAOn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 10:43:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 8F08C504D37EF;
	Thu,  1 Sep 2011 10:43:28 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cZkMgwks1O8E; Thu,  1 Sep 2011 10:43:28 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 334E4504D37EA;
	Thu,  1 Sep 2011 10:43:28 -0400 (EDT)
In-Reply-To: <4E5F4987.5040205@alum.mit.edu>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180531>

On Thu, 01 Sep 2011 10:59:51 +0200
Michael Haggerty <mhagger@alum.mit.edu> wrote:

> On 08/29/2011 07:20 PM, Bryan Jacobs wrote:
> > I have been (ab)using git-svn for committing to a central SVN
> > repository while doing my work locally with git. To this end, I've
> > written a set of scripts and hooks which perform squash merges
> > locally and then dcommit them with proper svn:mergeinfo
> > annotations. The final result is the perfect appearance of having
> > done a native SVN merge in the central repository, while using only
> > local git commands and gaining the full benefit of git's conflict
> > resolution and developer convenience.
> > 
> > However, to make this work with git 1.7.6, I needed to make *one*
> > change to the git internals: --merge-info does not allow setting
> > mergeinfo for more than one branch. Because it's a complete
> > overwrite operation instead of an update, this is a serious issue
> > preventing its use for nontrivial branches.
> > 
> > Might I suggest adding a block like the following around line 552 of
> > git-svn?
> > 
> >     if (defined($_merge_info))
> >     {  
> >         $_merge_info =~ tr{ }{\n};
> >     }
> 
> Naive question: why can't you pass a newline (properly quoted, of
> course) directly within the string argument to the --mergeinfo option?

The only way I know of to do that in bash is to assign the
newline-bearing string to a variable, and then use the variable in a
command line option. Extremely awkward.

I think the long-term solution for this issue is probably to have
git-svn populate the mergeinfo on its own, reducing the need for
users manipulating the value directly. This could in theory be done for
both cherry picks and merges, provided that the merge was --no-ff or
bears a body (so there is a commit object to carry the property
change) and both parents are tagged with SVN revs at the time the merge
is dcommitted (or, correspondingly, that the cherry-pick source carries
an SVN revision number). I will send patches for some to all of this
shortly as I pull my bash scripts into git-svn.perl and clean up the
code.

The cost of the automatic svn:mergeinfo pushing will be an SVN property
retrieval before each dcommit operation. I plan to have this behavior
disabled by default.

Bryan Jacobs
