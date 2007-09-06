From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Significant performance waste in git-svn and friends
Date: Thu, 6 Sep 2007 00:04:08 -0700
Message-ID: <20070906070407.GA19624@soma>
References: <20070905184710.GA3632@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 09:04:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITBPT-0003BY-GV
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 09:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbXIFHEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 03:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757356AbXIFHEK
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 03:04:10 -0400
Received: from hand.yhbt.net ([66.150.188.102]:58561 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756676AbXIFHEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 03:04:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 997DD2DC08D;
	Thu,  6 Sep 2007 00:04:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070905184710.GA3632@glandium.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57835>

Mike Hommey <mh@glandium.org> wrote:
> Hi,

Hi Mike,

> Being a pervert abusing the way subversion doesn't deal with branches
> and tags, I'm actually not a user of git-svn or git-svnimport, because
> they just can't deal easily with my perversion. So I'm writing a script
> to do the conversion for me, and since I also like to learn new things
> when I'm coding, I'm writing it in ruby.
> 
> Anyways, one of the things I'm trying to convert is my svk repository
> for debian packaging of xulrunner (so, a significant subset of the
> mozilla tree), which doesn't involve a lot of revisions (around 280,
> because I only imported releases or CVS snapshots), but involves a lot
> of files (roughly 20k).
> 
> The first thing I noticed when twisting around the svk repo so that
> git-svn could somehow import it a while ago, is that running git-svn
> was in my case significantly slower than svnadmin dump | svnadmin load
> (more than 2 times slower).
> 
> And now, with my own script, I got the same kind of "slowdown". So I
> investigated it, and it didn't take long to realize that replacing
> git-hash-object by a simple reimplementation in ruby was *way* faster.
> git-hash-object being more than probably what you do the most when you
> import a remote repository, it is not much of a surprise that forking
> thousands of times is a huge performance waste.

I haven't looked at the times in a while, but I suspect that exec()
is the (much bigger) culprit.

Since I usually import off remote repositories, so I notice network
latency way before I notice local performance problems with git-svn.

> So, just for the record, I did a lame hack of git-svn to see what kind
> of speedup could happen in git-svn. You can find this lame hack as a
> patch below. I did some tests (with a 1.5.2.1 release) and here are the
> results, importing only the trunk (192 revisions), with no checkout, and
> redirecting stdout to /dev/null:
> 
> original git-svn:
> real    25m1.871s
> user    8m51.593s
> sys     12m31.659s
> 
> patched git-svn:
> real    14m45.870s
> user    7m31.928s
> sys     4m1.047s

That's awesome.

> - It might be worth testing if git-cat-file is called a lot. If so,
>   implementing a simple git-cat-file equivalent that would work for
>   unpacked objects could improve speed.

IIRC git-cat-file is called a lot.  Every modified file needs the
original cat-ed to make use of the delta.

> The same things obviously apply to git-cvsimport and other scripts
> calling git-hash-object a lot.

Making git-svn use fast-import would be very nice.  I've got a bunch
of other git-svn things that I need to work on, but having git-svn
converted to use fast-import would be nice.  Or allowing Git.pm
to access more of the git internals...

However, how well/poorly would fast-import work for incremental
fetches throughout the day?

-- 
Eric Wong
