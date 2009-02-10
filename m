From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-svn: incomplete data after terminated "git svn clone"
Date: Tue, 10 Feb 2009 07:01:05 -0800 (PST)
Message-ID: <ec54bf47-c1a8-4d5e-a950-30303f1f9198@v15g2000yqn.googlegroups.com>
References: <40aa078e0902100350m2d885516o853b1ec56eb43ce1@mail.gmail.com> 
	<200902101442.32772.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 16:03:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWu8D-0005gi-4m
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 16:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbZBJPBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 10:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbZBJPBJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 10:01:09 -0500
Received: from yx-out-2122.google.com ([74.125.44.25]:25433 "EHLO
	yx-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbZBJPBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 10:01:08 -0500
Received: by yx-out-2122.google.com with SMTP id 33so185740yxl.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 07:01:05 -0800 (PST)
Received: by 10.150.202.8 with SMTP id z8mr1497778ybf.29.1234278065720; Tue, 
	10 Feb 2009 07:01:05 -0800 (PST)
In-Reply-To: <200902101442.32772.trast@student.ethz.ch>
X-IP: 217.140.96.21
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) 
	AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.46 Safari/525.19,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109251>

On Feb 10, 2009 2:42pm, Thomas Rast <trast@student.ethz.ch> wrote:
> Some ideas:
>
> First you can try to reset the git-svn head to the SHA of the commit
> before (in case the one it stopped at ended up being corrupted).  For
> example, if $stopped is the commit you interrupted it at,
>
>  git update-ref refs/remotes/git-svn $stopped^
>
> Adjust the ref name if you used a trunk/branches layout.  Then remove
> the .git/svn/ cache and try again.


Thanks for the suggestion.

I'm not entirely sure what you mean by "Adjust the ref name if you
used a trunk/branches layout." - in what way do I need to adjust it?
Would something like "refs/remotes/trunk/git-svn" be right? At least
that ref corresponds with a file relative to the .git-folder.

Yes, I use a trunk/branches-layout... but I'm fetching a branch that
has been moved (multiple times), so git-svn seems to try to fetch
something called "trunk@54516"... perhaps the "@ 54516"

Anyway, I tried doing the following:

git update-ref refs/remotes/trunk/git-svn <SHA1 of old revision>
rm .git/svn
git svn fetch

git then outputs something like this:

r<some rev> = <some SHA1>
r<some rev> = <some SHA1>
...lots and lots of these...
r<some rev> = <some SHA1>
r<old revision> = <SHA1 of old revision>
r<some rev> = <some SHA1>
r<some rev> = <some SHA1>
...some more lines...
r<some rev> = <some SHA1>
Done rebuilding .git/svn/trunk@<some revision>/.rev_map.<some SHA1>
Incomplete data: Delta source ended unexpectedly at /home/erifay01/
libexec/git-core/git-svn line 4249

This is basically the same thing I'm getting if I just delete the .git/
svn-folder and re-fetch. For the record, I decided to roll-back about
10 more revisions than where I terminated, just to be sure.


> Failing that, you could test if this also happens when only looking at
> a few surrounding revisions, for example if the failure was around
> revision 100:
>
>  mkdir ../new-test
>  cd ../new-test
>  git svn init <args you gave to the other git svn init/clone>
>  git svn fetch -r 95:105

This turns out to be a bit more tricky than I expected. You see, the
project has moved inside the repo multiple times during it's life-
time, and the revision where I broke the fetching is at an old
location.

So I tried fetching if from old location:
git svn init <old path> -s .
git svn fetch -r <old revision - 100>:<old revision + 100>

Doing the fetch outputs nothing (git svn init outputs "the usual
stuff", though). Trying to do the same thing with the new path (same
as above, but with <old path> set to the path of the new location)
gives the following output:

Path '<old path>' was probably deleted:
Filesystem has no item: REPORT request failed on '<new path>/!svn/bc/
<last rev>':
File not found: revision <last rev>, path '<old path>'

Will attempt to follow revisions r<old revision - 100> .. r<old
revision + 100> committed before the deletion

... And then nothing.

So, I'm still quite lost here. It might be that a full re-clone is
what is needed.
