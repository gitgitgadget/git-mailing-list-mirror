From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: git-add & "file vanishing" -> need git-add again [reformatted]
Date: Wed, 27 Dec 2006 21:58:51 +0000
Message-ID: <e1dab3980612271358w3dec594cy8453910ca9064806@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Dec 27 22:58:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzgnY-0003aZ-ED
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 22:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbWL0V6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 16:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754804AbWL0V6x
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 16:58:53 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:32182 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800AbWL0V6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 16:58:53 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1940086nze
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 13:58:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Sc4T2SKd0nTryxykkbxgYFmkuTZ4Ex5PDB2jfoekkvvxolKUlFndL0AJ4cu7Jwsn7UVgyd0PN+keQp6rxbeXLLBzi+totKHSJszYeiY2DazLM4Q2eJZ3p4onSvjkqHTVoN6cobZMAe1xVnfPP82s13MSIcwTq+k8SXMcT4mJGM4=
Received: by 10.65.177.6 with SMTP id e6mr20081568qbp.1167256732283;
        Wed, 27 Dec 2006 13:58:52 -0800 (PST)
Received: by 10.65.160.2 with HTTP; Wed, 27 Dec 2006 13:58:51 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35484>

This is a resend of previous mail reformatted.
(Unfortunately even university staff acounts
these days seem to only give you unconfigurable
web-browser interfaces; hopefully gmail won't butcher
the 72-character wrapped layout I'm seeing on my
screen right now too much.)
Many thanks for your forbearance and any insight.

Original message<<<<<<<<<<<<<<<<<<<<<<<<

Hi, I'm working on using git for chronological backups (think
selective P9 venti), which I've almost got working. (I know I'm using
git for something it wasn't designed for, and is arguably perverse.)
I've been trying to figure out why files which "ought" to be tracked
weren't in the database in certain commits and I think I've figured
out why.  Can someone confirm the following: with the set of
operations

git-init-db ....
git-add path/to/fileX
git-commit -a -m blah <1>
..... changes to things including fileX and commits
[fileX vanishes from the tree being tracked, but nothing
mentioned to git] <2>
..... changes to things and commits
[file X reappears in the working tree being tracked]
<3>
git-commit -a -m blah <4>

The git trees from <1> to <2> all contain fileX, even if its contents
haven't changed. Between <2> and <4> the git tree doesn't contain
fileX (perfectly properly). From <4> onwards fileX still doesn't
appear in the git trees recorded from the working directory even
though fileX is there again. If I want fileX tracked I have to
explicitly git-add it again at <3>. (Ie, git-commit -a when it detects
a file have vanished from the working tree removes it from the files
git will look at in future for changes to commit.)

Is it also correct that this behaviour ("forget" about a tracked file
when it disappear from the working tree in a commit) would be
difficult to change without major surgery to git?  Would there be any
problems with git-add'ing every file you want the tree to track before
every commit?

(I'm currently working on code to keep track of things that have ever
been tracked, and whether they're currently in the tree, in my scripts
outside git but obviously partially duplicating stuff git has in its
datastructures has the potential for subtle bugs when they diverge.)

Long story:
---------------

I'm trying to move a snapshotting-style system from my personal
hack-job to git. As well as manual snapshots there's a cron job that
runs every hour to snapshot stuff. Consequently there will be
"automatic commits" when you wouldn't have made one if you were doing
normal source control, eg, after you've wrongly deleted a file and
before you've noticed & restored it from the database an automatic
commit can come in (and even more kinky situations you don't want to
know about) and so sees the file "gone".

Sidenote: I'm moving the database from the old format to the new one
by repeatedly unpacking the old database for snapshot X, git-add'ing
any file names which have _never_ been in any snapshot before,
git-commit -a, git-tag, then remove all the files unpacked by the old
database and move onto snapshot X+1. This takes less than a second per
snapshot. I understand this shouldn't be a problem but just to let
people know the timestamps on the files aren't what would be expected.

Follow up clarification msg <<<<<<<<<<<<<<<<<<<<<<<<

|Not sure how large your snapshots are -- a
|second sounds like a long time for git operations. While it is a bit
|more complex, you _can_ operate directly on the index, and the
|"snapshot" never needs to hit the disk as such during your migration.

By trying to be brief I was a rather cryptic. What I was trying to say
was:

Running the git commands earlier in the message in a script, I see
that file are not present from the git tree generated by a commit at a
time when I know the file I'd previously git-added reappeared in the
working directory. I'm hypothesising that this is because when the
file disappears the machinery in git loses the `track this file'
information. However, I haven't (and would prefer not to) dig into the
git code to check that's the correct explanation. If this is why the
files aren't being tracked I can try to script around the issue by
git-adding all the files I want tracked by the snapshot before the
git-commit -a. To help anyone thinking about if the explanation is
right, the working directory is repeatedly being wiped and refilled
from my old backup system with a second, so often all files have both
creation and modification times set to the current second. This is a
really weird thing to do and might in some way be responsible for the
untracked file (cf racy-git)."

Most of the maybe half-second overhead is coming from my script
unpacking the files with gzip from my old database; git seems more
than fast enough.

|Have a look at how the cvsimport script works for an example.

As its my personal db which I'll only convert once if I can just make
replaying work I don't need anything more complicated; I've only got
2000-odd snapshots.


-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
Details are all that matters; God dwells there, and you never get to
see Him if you don't struggle to get them right. -- Stephen Jay Gould
