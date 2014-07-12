From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 and initial import
Date: Sat, 12 Jul 2014 13:56:38 -0400
Message-ID: <20140712175638.GA26857@padd.com>
References: <53BE98EC.9000200@promptu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Laurent =?iso-8859-1?Q?Charri=E8re?= <lcharriere@promptu.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 19:56:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X61XU-00048t-Hh
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 19:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbaGLR4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 13:56:42 -0400
Received: from honk.padd.com ([71.19.245.7]:34909 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbaGLR4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 13:56:41 -0400
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id EA8DF20D5;
	Sat, 12 Jul 2014 10:56:40 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 98C22202A3; Sat, 12 Jul 2014 13:56:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <53BE98EC.9000200@promptu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253393>

lcharriere@promptu.com wrote on Thu, 10 Jul 2014 15:45 +0200:
> I've used git-p4 for several years now and it's generally working well for
> me.
> 
> The only thing that bugs me at this time is having to re-clone regularly.
> Here is how this happens:
> 
> * Say my p4 client maps //foo/bar/... to /home/jdoe/perforce/foo/bar/... (I
> don't want to clone the entire repo, because it's too big).
> * I do git p4 clone --use-client-spec //foo /home/jdoe/git/foo, work with
> it, all goes well.
> * Meanwhile, at some point somebody else adds //foo/baz.
> * Eventually I need //foo/baz. I add it to my p4 client.
> * Naturally, git-p4 won't pick up the changes, because they happened before
> I added //foo/baz to my client.
> * So I git reset --hard to the first commit, delete even that using git
> update-ref -d HEAD, then again I do git p4 clone //foo /home/jdoe/git/foo.
> When the repo gets big, this takes a lot of time.
> 
> So, I have a few questions:
> 1. Am I doing this wrong? Is there another way I could proceed?

What you observe makes sense.  You do need somehow to sync in the
change that added the files in //foo/baz.  Say that path was
added in change 5, and you already synced change 5 but did not 
have //foo/baz in your client spec.  It would not be in the git
commit corresponding to change 5.

Now you don't have to reset all the way back to the first commit,
you can just rewind back to the one that introduced //foo/baz.
This still is disruptive and takes a while, depending on how long
between when //foo/baz got added and when you decided you needed
it.

Say there's just a few changes to //foo/baz, among the thousands
of ones you've already synced.  You can surgically go in and
re-sync just those few changes, rebasing the rest of the changes
after each one.  Something like:

    p4change=3227  ;# want to reimport this one as it added baz
    sha=$(git rev-parse :/"change = $p4change")
    git update-ref refs/remotes/p4/master $sha^
    git p4 sync @$p4change  ;# re-sync 3227, now with baz
    git rebase --onto p4/master $sha  ;# put everything back on top

Now you don't have to re-import change 3228 etc.  Repeat until
you've fixed up all the baz.  Of course the rebases might be
slow...

If you don't care about your history, you could make a new branch
and import just //foo/baz into the new branch.

    git p4 sync --branch refs/remotes/p4/baz //foo/baz

Then merge it into your main branch.  You may have to use a
different client spec to put the baz files in the right subdir
name.  Or filter-branch --subdirectory-filter.  Now adjust your
main client spec and future git p4 sync will grab both //foo/bar
and //foo/baz.  Of course you have this odd wart in your history
where they got glued together.

If you do script up something cool, be sure to send it in for
contrib/ or even a magic option in git-p4.

> 2. It occurred to me that when I re-clone a repository using
> --use-client-spec, I already have everything I need in my local copy of the
> p4 client. Why does git-p4 need to redownload everything from the
> repository? Could we find a way to tell it to p4 sync, then fetch the files
> from the local copy? Or is there a way I can copy everything over from my
> local client and pretend this is the initial import?

That should work in theory.  We've got all the blobs (file
objects) already. If we had a database that mapped each p4
file#revision to a blob, git p4 sync could look at that and see
if it already has the blob.  Possibly with
.git/objects/info/alternates to grab them from somewhere nearby.

But we don't have that database.  Git p4 knew the mapping when it
did the syncs, but didn't write them down.  You could script up
something to recreate this by asking p4 for the revision of each
file for each change already in git.  And git already knows the
blob for each of files in those changes.  With this mapping, you
could modify git p4 to check for the blob first, before doing "p4
print" on the file#rev.  See also git-p4raw from Sam Vilain that
builds up SQL from a raw p4 db.

Fun bit of work maybe if you're motivated.

		-- Pete
