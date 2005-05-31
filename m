From: Matt Mackall <mpm@selenic.com>
Subject: Mercurial 0.5b vs git
Date: Tue, 31 May 2005 14:31:03 -0700
Message-ID: <20050531213103.GR7685@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mercurial@selenic.com, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 23:33:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdELP-0006pU-Ul
	for gcvg-git@gmane.org; Tue, 31 May 2005 23:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVEaVeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 17:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVEaVdd
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 17:33:33 -0400
Received: from waste.org ([216.27.176.166]:8126 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261500AbVEaVbH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 17:31:07 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j4VLV39n025140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 May 2005 16:31:03 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j4VLV3Lv025136;
	Tue, 31 May 2005 16:31:03 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The latest version of Mercurial is available at:

 http://selenic.com/mercurial/

Utilities to convert git repos and interoperate with git are beginning
to appear on the mercurial mailing list, including a port of gitk.

As a practical demonstration, I've imported Ingo's BKCVS patchset into
Mercurial. The result is a 297M archive with 28237 changesets going back
to 2.4.0. Some history is lost because of the BK->CVS flattening. You
can browse it here:

 http://userweb.kernel.org/~mpm/linux-hg/index.cgi

Be sure to check out the annotate feature. Unfortunately there are no
branches in this repo because of the BK->CVS flattening, but you can
look at the main Mercurial repo to see examples of pulls.

The full tarball of the Mercurial kernel repo (144MB) can be grabbed here:

 http://www.kernel.org/pub/linux/kernel/people/mpm/linux-hg.tar.gz

If you want to browse this repo on your own machine (very fast and
convenient for laptops!), simply install Mercurial, download the
tarball, run 'hg serve' in the repo directory and point your web
browser at http://localhost:8000.

The web interface also serves as a highly efficient merge server:

$ time hg -v merge http://remotehost:8000/
searching for changes
adding changesets
adding manifests
adding files
118549846 bytes of data transfered
modified 23306 files, added 28238 changesets and 188476 new revisions

real    4m51.371s
user    1m25.852s
sys     0m8.303s

That's pulling the whole kernel history over fast DSL with only 113M
of traffic. Compare that to the 2.6.11 tar.bz2 at 35M. Smaller merges
are of course proportionally faster. (Pulls from userweb.kernel.org
are disabled because the machine has limited bandwidth.)

Verifying the archive:

$ time hg verify
checking changesets
checking manifests
crosschecking files in changesets and manifests
checking files
23305 files, 28238 changesets, 188464 total revisions

real    2m48.986s
user    1m30.055s
sys     0m7.158s

Checking the integrity of the equivalent git archive looks like it
will take an hour or more of seek intensive I/O (though the person
who was timing it for me gave up).

This highlights one of git's most serious problems: storing the
repository by hash. This tends to pessimize layout over time. Initial
check-ins will be nicely ordered by write order, but as changes are
made, the set of files in the tip will get spread further and further
apart on the disk and in more and more random order. Copying the
archive via rsync, cp -a, or the like will tend to exacerbate things
by reordering _everything_ in hash (aka worst possible) order. This is
pretty fundamental to the git design and will cause its scalability to
fall apart as the number of revisions mount.

Mercurial was originally using a similar scheme, and when I ran into
this problem, I spent a day playing with variations on sorting by
inode, prefetching, etc to get the performance back. None of it came
close to the performance of simply having everything layed out well on
disk in the first place.

My eventual solution was a simple 5-line change to switch back to a
tree-structured repo layout like CVS. This lets the filesystem block
allocator assist by putting files in the same directory near each
other on disk. Also, copying repos tends to optimize things rather
than making things worse. Mercurial also inherently stores all file
revisions together so operations like tree diffs or file annotate can
be done with a minimum of seeking.


Here's a quick comparison:

                    Mercurial      git                     BK (*)
storage             revlog delta   compressed revisions    SCCS weave
storage naming      by filename    by revision hash        by filename
merge               file DAGs      changeset DAG           file DAGs?
consistency         SHA1           SHA1                    CRC
signable?           yes            yes                     no       

retrieve file tip   O(1)           O(1)                    O(revs)
add rev             O(1)           O(1)                    O(revs)
find prev file rev  O(1)           O(changesets)           O(revs)
annotate file       O(revs)        O(changesets)           O(revs)
find file changeset O(1)           O(changesets)           ?

file tracking       stat-based     stat-based              bk edit
checkout            O(files)       O(files)                O(revs)?
commit              O(changes)     O(changes)              ?
                    6 patches/s    6 patches/s             slow
diff working dir    O(changes)     O(changes)              ?
                    < 1s           < 1s                    ?
tree diff revs      O(changes)     O(changes)              ?
                    < 1s           < 1s                    ?
hardlink clone      O(files)       O(revisions)            O(files)

find remote csets   O(log new)     rsync: O(revisions)     ?
                                   git-http: O(changesets)
pull remote csets   O(patch)       O(modified files)       O(patch)

repo growth         O(patch)       O(revisions)            O(patch)
 kernel history     297M           3.5G?                   250M?
lines of code       3700           6500+cogito+gitweb+..   ??

* I've never used BK so this is just guesses

-- 
Mathematics is the supreme nostalgia of our time.

