From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: git-svn merge helper
Date: Sun, 30 Sep 2007 13:05:50 +0200
Message-ID: <20070930110550.GA4557@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 13:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibwcd-0006kC-DC
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 13:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbXI3LFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Sep 2007 07:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbXI3LFz
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 07:05:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:43399 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750946AbXI3LFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 07:05:54 -0400
Received: (qmail invoked by alias); 30 Sep 2007 11:05:52 -0000
Received: from i577B9DEB.versanet.de (EHLO localhost) [87.123.157.235]
  by mail.gmx.net (mp010) with SMTP; 30 Sep 2007 13:05:52 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+7gJ4xL5K7fItlOZG79Uc5h28qmQW3tAw8P22PUj
	sRgKuVaMdjph2m
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59533>

Hi,

I recently discovered git-svn and absolutey love it. One thing that I'm
missing though, is an equivalent of "svn merge" for merging between svn
remotes, to support the SVN way of using "squashed" merges, where you
just note the merge meta-data in the commit message. "git merge" didn't
work for me (and probably isn't expected to work) to merge between two
svn branches, so I've resorted to cherry-picking the required commits
one by one into a temporary branch and then squashing them together by
doing a --squash merge with a second temporary branch (as in [1]).

Of course that becomes extremely annoying if there are like 200
commits to merge, so I came up with the following script to help me.
It does just what I described above, but automated. Usage is like this:

git-svn-merge trunk 123 543

Which does the same as "svn merge -r123:543 trunk-url", except for bein=
g
incremental (ie. no huge one-time patch, eventually causing a massive
set of conflicts) and often faster.

In case of conflicts, it bails out and let's you fix them. Then you can
just re-run it with the same parameters again, as it automatically
determines where to start cherry-picking if you're currently on the
merge branch.

It's neither complete nor nice to look at, but it more or less gets the
job done, so I thought I'll just post it here, maybe someone picks it u=
p
and brings it into shape.

Thanks,
Bj=F6rn

[1] http://cheat.errtheblog.com/s/gitsvn/


#!/bin/sh

BRANCH=3D$(git branch | grep \* | cut -d ' ' -f2)

START=3D$(git svn find-rev r$2 $1)
END=3D$(git svn find-rev r$3 $1)

if echo $BRANCH | grep -q svnmerge/
then
	START=3D$(git svn find-rev r$(git svn find-rev HEAD) $1)
else
	git checkout -b svnmerge/$BRANCH
fi

for HASH in $(git log --pretty=3Dformat:%H --reverse $START..$END)
do
	git cherry-pick $HASH || exit
done

git checkout $BRANCH
git checkout -b svnmerge/$BRANCH-squashed
git merge --squash svnmerge/$BRANCH
git commit -m "Merged changes from revisions $2-$3 from $1 into $BRANCH=
=2E"
