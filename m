From: Yann Dirson <ydirson@altern.org>
Subject: Re: remaining git-cvsimport problems: robustness when cvsps feeds strange history
Date: Thu, 1 Jun 2006 23:28:25 +0200
Message-ID: <20060601212825.GO6535@nowhere.earth>
References: <20060527120105.GL6535@nowhere.earth> <46a038f90605270823qdea766fxcf2327ae0bf7373a@mail.gmail.com> <20060527163555.GM1164@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Thu Jun 01 23:15:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FluWD-0002rY-7u
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 23:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965296AbWFAVPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 17:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965313AbWFAVPo
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 17:15:44 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:18327 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S965298AbWFAVPo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 17:15:44 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 8F8A9270B8;
	Thu,  1 Jun 2006 23:15:42 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FluiQ-0004y7-9s; Thu, 01 Jun 2006 23:28:26 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060527163555.GM1164@nowhere.earth>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21123>

On Sat, May 27, 2006 at 06:35:55PM +0200, Yann Dirson wrote:
> > OTOH, the cvsps output you are showing us seems to be in the right
> > order...  patchset 20 should go on top of patchset 3... is cvsimport
> > truly mishandling this?
> 
> That's the problem.  I had just copypasted the logs for handling at
> home, and then I discovered in the cvsps log that the timestamp for
> patchset 2 is the same as the one for patchset 1, which is obviously
> wrong.  I'll look at the cvs repo next week to understand whether that
> comes from the RCS file, or whether it is cvsps misunderstanding
> something.

The problem indeed stems from the RCS files themselves.  It thus comes
from a bug-or-feature of cvs 1.12.12.  This week I have found a number
of files with such an history in various repos in use at work.

I finally realize I was trying to reproduce the problem at home using
1.12.9, where the issue does not appear to exist.  The following
script does show the problem with 1.12.13.

As you see, a phantom commit is added prior to the resurecting commit
on the branch, and it has the same timestamp as the its dead base
revision on the trunk.

In the logs I had from real repositories with 1.12.12, the "lines"
attribute for the phantom revision was a mirror of the revision
following it, reflecting no reality at all (would have been "+0 -1"
here).  There is no mention of such a bugfix in the cvs NEWS file, but
who knows.

I found no mention of such a feature in the 1.12.9-13 entries in the
CVS NEWS file, so I doubt that is an intended behaviour - I'll report
a bug on cvs.

However, cvsps should surely be made aware of this behaviour, even if
it is a bug, since being there for at least 2 cvs releases is enough
to have infected many repositories...


==== script
#!/bin/sh
set -e

# setup repo and working area
cvs -d $PWD/root init
mkdir root/test
cvs -d $PWD/root co test
cd test

# trunk
touch file1 file2
cvs add file1 file2
cvs ci -m "add files"
sleep 2

rm file1 
cvs rm file1 
cvs ci -m "rm file1"
sleep 2

cvs tag A

# branch based on trunk
cvs tag -b A_HEAD
cvs up -r A_HEAD -P
echo "stuff and more stuff" >file1
cvs add file1
cvs ci -m "work"
sleep 2

cvsps --norc -x -A
==== cvs log file1
----------------------------
revision 1.2
date: 2006-06-01 23:12:21 +0200;  author: dwitch;  state: dead;  lines: +0 -0;  commitid: GyCIctKzKqKVwlzr;
branches:  1.2.2;
rm file1
----------------------------
revision 1.1
date: 2006-06-01 23:12:17 +0200;  author: dwitch;  state: Exp;  commitid: j1zLyPu2Bw6Uwlzr;
add files
----------------------------
revision 1.2.2.2
date: 2006-06-01 23:12:23 +0200;  author: dwitch;  state: Exp;  lines: +1 -0;  commitid: D3Fd6f9Wz8cWwlzr;
work
----------------------------
revision 1.2.2.1
date: 2006-06-01 23:12:21 +0200;  author: dwitch;  state: dead;  lines: +0 -0;  commitid: D3Fd6f9Wz8cWwlzr;
file file1 was added on branch A_HEAD on 2006-06-01 21:12:23 +0000
====

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
