From: Sam Vilain <sam@vilain.net>
Subject: Re: cherry picking and merge
Date: Fri, 01 Aug 2014 13:12:57 -0700
Message-ID: <53DBF4C9.2090905@vilain.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Mike Stump <mikestump@comcast.net>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:21:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDJKs-0007JV-5m
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 22:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979AbaHAUVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 16:21:50 -0400
Received: from tx.vilain.net ([74.50.57.245]:48762 "EHLO tx.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754822AbaHAUVs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 16:21:48 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Aug 2014 16:21:48 EDT
Received: from [10.10.100.181] (unknown [38.104.194.154])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by tx.vilain.net (Postfix) with ESMTPSA id C36AE8284;
	Fri,  1 Aug 2014 21:12:58 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254660>

On 08/01/2014 10:48 AM, Mike Stump wrote:
>> There is also git-imerge, third party tool that is intended to help
>> merging changes (and make it possible to do it in incremental way).
> Then remove git merge and replace it with git-imerge.  :-)  Anyway, I read that, and I can see some beauty of that that might be nice in complex merges.  The problem is, I want git merge to work.


Git merge has a notion of discrete "merge strategies".  The default,
"recursive" merge strategy isn't completely oblivious to history; in the
event that the two branches don't have a single merge bases, it performs
3-way merges (strangely enough) recursively, with the merge bases of the
branch you're trying to merge until it completes.  In general, this
works pretty well.  Some systems even simpler than that (eg, github's
green merge button) work acceptably as well.

There's no particular reason that you couldn't implement a merge
strategy which works more like SVN's approach, which essentially does an
internal rebase and then commits the result.  The advantages of a rebase
in this situation is that you get to eliminate changes which don't need
to be applied, either because (in SVN's case), it had some
metadata/hearsay information that told it that it could skip that
change, or (in git's case), because it found content/facts that the
change already was applied on one side.

However, there are corresponding disadvantages to this strategy.  It's
just as easy to contrive a situation where this "internal rebasing"
doesn't do the right thing, even without cheating by getting the
metadata wrong.  And besides, there's already a way to do this: do an
actual rebase.  You could also do a rebase, and then if, say, the
original branch you're rebasing is published and you don't want to
rewrite, then you can easily enough use squash merging, merge -s ours,
etc to make it look like the strategy you wanted was a built-in git
merge strategy.  Or, in the spirit of open source, you could contribute
the code required to make 'imerge' a built-in strategy.

> I was curious if svn handles this better the same or worse, and it did it just fine.  I know that a while ago, svn could not handle this, it would do what git does currently.  Apparently they figured out it was a bug and fixed it.  Have you guys figured out it is a bug yet?  The first step in solving a problem, is admitting you have a problem.

So, I have to chuckle when I read this indignant comment.  There's a
funny story to the "while ago" you refer to.  This refers to the time
period during which SVN was relevant; about versions 1.4 and earlier
(being generous).  Back in those days, SVN projects for the most part
avoided merging, because it was so problematic and not tracked at all. 
As one core SVN developer said to me, they found "teams collaborate more
closely if they're all working on the same branch".  Sure, you could do
it, and I even know of a few communities who did, but by and large, it
was avoided.  Then, the new wave of version control systems including
Git, bzr and Mercurial were cropping up, and their merges were actually
good enough that you could practically use them.

The SVN core team had to keep pace to match.  So, in 1.5 the "merge
tracking" system, previously only supplied as a "contrib" script, became
core.  This is ironic, because the version control system which SVN
imitated poorly--Perforce--had a very sophisticated, if
over-complicated, merge tracking system which was also based on
metadata.  Per-branch, per-patch, per-file entries for whether or not a
patch had been "integrated" into the target branch.  I can only guess
that the reason they didn't implement this in the original SVN version
was that it was something of a pain point for users in Perforce. 
Possibly something to do with the way that Perforce would store double
entries for each merge (yes: two rows in a relational store, one
representing the mirror image of the other), and differentiated between
many different forms of "integrated" (ie, 2 rows and 4 states instead
of, say, a single bit).  So the underlying data model wasn't as simple
as it could have been, and this was reflected in the difficult to use
command-line tools.  Plus, they were using BerkeleyDB for metadata
instead of the relational ISAM library, and debugging a rabbit's nest of
merge record as Perforce used would have been a nightmare.  They didn't
go there.  And besides, they found that often, detecting patches as
already applied based on content, like 'patch' did, worked.

Prior to 1.5, the Perl community developed SVK, an offline version of
SVN, and this had a far simpler model for merge tracking, more similar
to git's: just tracking whole-branch merges rather than individual
files, patches, and branches.  SVN eventually added two separate ways of
tracking merges: either a per-file, per-branch, per-commit or a
per-branch, per-commit model.

Anyway, I'm not sure where I'm going with this, but I guess a little
extra perspective would be useful!

Sam
