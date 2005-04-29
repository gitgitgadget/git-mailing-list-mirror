From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 09:37:05 -0700
Message-ID: <20050429163705.GU21897@waste.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1> <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 18:33:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRYQO-0003BB-5f
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 18:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVD2Qih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 12:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVD2Qig
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 12:38:36 -0400
Received: from waste.org ([216.27.176.166]:8406 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262822AbVD2QhP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 12:37:15 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j3TGb5wf019552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Apr 2005 11:37:05 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j3TGb5VT019549;
	Fri, 29 Apr 2005 11:37:05 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 07:34:15AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 29 Apr 2005, Matt Mackall wrote:
> > 
> > Mercurial is even younger (Linus had a few days' head start, not to
> > mention a bunch of help), and it is already as fast as git, relatively
> > easy to use, much simpler, and much more space and bandwidth
> > efficient.
> 
> You've not mentioned two out of my three design goals:
>  - distribution
>  - reliability/trustability
> 
> ie does mercurial do distributed merges, which git was designed for, and 
> does mercurial notice single-bit errors in a reasonably secure manner, or 
> can people just mess with history willy-nilly?

Distribution: yes, it does BK/Monotone-style branching and merging.
In fact, these should be more "correct" than git as it has DAG
information at the file level in the case where there are multiple
ancestors at the changeset graph level:

M   M1   M2

AB
 |`-------v     M2 clones M
aB       AB     file A is change in mainline
 |`---v  AB'    file B is changed in M2
 |   aB / |     M1 clones M
 |   ab/  |     M1 changes B
 |   ab'  |     M1 merges from M2, changes to B conflict
 |    |  A'B'   M2 changes A
  `---+--.|
      |  a'B'   M2 merges from mainline, changes to A conflict
      `--.|
         ???    depending on which ancestor we choose, we will have
	        to redo A hand-merge, B hand-merge, or both
                but if we look at the files independently, everything
		is fine

> For the latter, the cryptographic nature of sha1 is an added bonus - the
> _big_ issue is that it is a good hash, and an _exteremely_ effective CRC
> of the data. You can't mess up an archive and lie about it later. And if
> you have random memory or filesystem corruption, it's not a "shit happens"  
> kind of situation - it's a "uhhoh, we can catch it (and hopefully even fix
> it, thanks to distribution)" thing.

Reliability/trustability: Mercurial is using a SHA1 hash as a checksum
as well, much like Monotone and git. A changeset contains a hash of a
manifest which contains a hash of each file in the project, so you can
do things like sign the manifest hash (though I haven't implemented it
yet. Making a backup is as simple as making a hardlink branch:

 mkdir backup
 cd backup
 hg branch ../linux  # takes about a second

> I had three design goals. "disk space" wasn't one of them, so you've
> concentrated on only one so far in your arguments.

That's because no one paid attention until I posted performance
numbers comparing it to git! Mercurial's goals are:

- to scale to the kernel development process
- to do clone/pull style development
- to be efficient in CPU, memory, bandwidth, and disk space
  for all the common SCM operations
- to have strong repo integrity

It's been doing all that quite nicely since its first release.
The UI is also pretty straightforward:

Setting up a Mercurial project:

 $ cd linux/
 $ hg init         # creates .hg
 $ hg status       # show changes between repo and working dir
 $ hg addremove    # add all unknown files and remove all missing files
 $ hg commit       # commit all changes, edit changelog entry

 Mercurial will look for a file named .hgignore in the root of your
 repository contains a set of regular expressions to ignore in file
 paths.

Mercurial commands:

 $ hg history          # show changesets
 $ hg log Makefile     # show commits per file
 $ hg diff             # generate a unidiff
 $ hg checkout         # check out the tip revision
 $ hg checkout <hash>  # check out a specified changeset
 $ hg add foo          # add a new file for the next commit
 $ hg remove bar       # mark a file as removed

Branching and merging:

 $ cd ..
 $ mkdir linux-work
 $ cd linux-work
 $ hg branch ../linux        # create a new branch
 $ hg checkout               # populate the working directory
 $ <make changes>
 $ hg commit
 $ cd ../linux
 $ hg merge ../linux-work    # pull changesets from linux-work

Importing patches:

 Fast:
 $ patch < ../p/foo.patch
 $ hg addremove
 $ hg commit

 Faster:
 $ patch < ../p/foo.patch
 $ hg commit `lsdiff -p1 ../p/foo.patch`

 Fastest:
 $ cat ../p/patchlist | xargs hg import -p1 -b ../p 

Network support:

 # export your .hg directory as a directory on your webserver
 foo$ ln -s .hg ~/public_html/hg-linux 

 # merge changes from a remote machine
 bar$ hg init                              # create an empty repo
 bar$ hg merge http://foo/~user/hg-linux   # populate it
 bar$ <do some work>
 bar$ hg merge http://foo/~user/hg-linux   # resync

 This is just a proof of concept of grabbing byte ranges, and is not
 expected to perform well.

-- 
Mathematics is the supreme nostalgia of our time.
