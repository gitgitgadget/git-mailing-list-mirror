From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Bug: segfault during git-prune
Date: Thu, 28 Jun 2007 23:21:42 +0100
Message-ID: <200706282321.44244.andyparkins@gmail.com>
References: <200706281134.58453.andyparkins@gmail.com> <alpine.LFD.0.98.0706280844460.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 00:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I42NQ-0001nY-CM
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 00:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765168AbXF1WVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 18:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764858AbXF1WVw
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 18:21:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:31966 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764912AbXF1WVv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 18:21:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so689466ugf
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 15:21:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mJhLRkuPyYKrdzaxPmMXLxIUMQqHqEuNN0BUIhhyYfI/gstC7DjVWAIwMf62sY92GYWKzQSihY0E9LVscsq7AJpXS2C6jGaL5HPHV7ROfJcWoMZRTewb3FKbkuTlrR5aAPssjcfvnE/Ok1aFvZAriKCotDR1FYztsXer7pIyOJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JlNStAFn3567c1xUzS9LI96nhLwTu56tcv8BagowNn+ZRHP3BVpBu7T3oJYuXIM/m5eaAxMF9wOUkO8gwzN8VsbcFE1CXJTxS0E3KcoQ8Tf1inFcszGvNWxIcXiuhi4X0JflcNniE3WVdhdWePAUHWJ0SiDYJxgrr7MAx64fp9M=
Received: by 10.67.30.6 with SMTP id h6mr488568ugj.1183069308901;
        Thu, 28 Jun 2007 15:21:48 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 54sm7642742ugp.2007.06.28.15.21.47
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jun 2007 15:21:48 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.0.98.0706280844460.8675@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51135>

On Thursday 2007, June 28, Linus Torvalds wrote:
> On Thu, 28 Jun 2007, Andy Parkins wrote:
> > I ran git-prune on a repository and got this:
> >
> > $ git-prune
> > error: Object 228f8065b930120e35fc0c154c237487ab02d64a is a blob, not a
> > commit Segmentation fault (core dumped)
>
> Do you have subprojects in that git repo?

Yes.  I'm also doing something that is possibly very naughty; and I'm sure 
you're going to say "what on earth do you expect when you've done _that_"

The subproject is the same repository...  It's a git conversion of the 
ffmpeg history; ffmpeg uses svn:externals for the libswscale directory; so 
I set that as an independent branch in the same repository, fetched with 
git-svn as well.  Then I cloned the repository into a subdirectory of 
itself.

 $ git clone -n . libswscale

Then I went into libswscale/.git/ and ln -s objects, refs, info, and logs.  
In fact the only thing that isn't shared is HEAD.

Then I changed into libswscale and checked out the libswscale branch.  Back 
in the ffmpeg repository I git-add the libswscale directory and everything 
seems to be working wonderfully.

> And the only case I know of that does that is using an old git binary, or
> a unconverted git code-path program, on a repository with subprojects
> when the code-path doesn't understand that a tree can contain pointers to
> commits.

Sounds like the last one to me.  I tend to be only a few days behind 
upstream git.

> Yeah, git-fsck knows about subprojects. I bet git-prune just doesn't.
>
> And indeed.. Here's a patch for it, but the fact is, you really should
> *not* prune that repository, because you'll prune away all the subproject
> data, which you seem to have in the same repo!

Correct; you did well figuring that out from the meagre information I gave.

I had hoped that git-prune wouldn't be a risk because I have:

 * -- * -- * -- * -- * (ffmpeg-svn)

      * -- * -- * -- * (libswscale-svn)

Then I forked master from ffmpeg-svn and added the libswscale-svn branch as 
a submodule as described above.  Now, because the submodule always refers 
to commits that are ancestors of libswscale-svn, they'll never be seen as 
dangling and pruned?

> (General rule: never *ever* prune a shared object repository!)

Even when I'm sure that every object of interest is behind a head ref?

> ---
>  reachable.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)

The repository in question is on my work computer, so I won't be able to try 
this patch until Monday.  I'll report back then.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
