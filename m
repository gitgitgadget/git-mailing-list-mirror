From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git-svn set-tree bug
Date: Mon, 11 Jun 2007 10:52:37 +0200
Organization: Transmode AB
Message-ID: <1181551957.30670.154.camel@gentoo-jocke.transmode.se>
References: <466C8B35.3020207@midwinter.com>
	 <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle>
	 <466CF2A0.4080604@midwinter.com>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 10:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxfdn-0000Lz-7a
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 10:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbXFKIwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 04:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXFKIwk
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 04:52:40 -0400
Received: from mail.transmode.se ([83.241.175.147]:18565 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750751AbXFKIwj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 04:52:39 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 11 Jun 2007 10:52:37 +0200
In-Reply-To: <466CF2A0.4080604@midwinter.com>
X-Mailer: Evolution 2.8.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49834>

On Sun, 2007-06-10 at 23:58 -0700, Steven Grimm wrote:
> Eric Wong wrote:
> > Doable?  Yes.  However, I think using grafts is quite hackish and
> > unreliable[1].  I'd rather just have users using set-tree if
> > they want to deal with non-linear history in the first place.
> >   
> 
> Agreed about grafts being hackish and unreliable. But they were what I 
> had to work with, given that I know little enough about git-svn's 
> internals to be able to implement Junio's more robust idea.
> 
> IMO set-tree is not much of an option. In my environment it is 
> unacceptable for there to be any possibility of accidentally and 
> silently overwriting some other change that just happened to hit the svn 
> repo right before I committed my change, which (unless it has changed 
> since I last tried it) set-tree will happily do. I can get away with 
> doing that maybe once before my company's release manager will, quite 
> justifiably, require me to stop using git and switch back to the 
> standard svn client.
> 
> > I'd personally avoid any sort of non-linear history when interacting
> > with SVN repositories, however.
> >   
> 
> Which is a shame since git loses a lot of its utility without nonlinear 
> history. For example, the script I posted uses git to do merges between 
> svn branches. It works wonderfully even if, as you and Junio point out, 
> its use of grafts to record svn merges scales poorly and is potentially 
> susceptible to corruption. Thanks to the ability to record the fact that 
> my merges between svn branches were actually merges, my git clone has a 
> more complete picture of what's in my svn repository than the svn 
> repository itself does!

Exactly, I too think that this is a much needed feature for git-svn.

I have also noted that this modified(added a git svn dcommit) script 
works:
rm -rf mygitsvn
rm -rf mysvnrepo
rm -rf mysvnwork
mkdir mysvnrepo
cd mysvnrepo
svnadmin create .
cd ..
svn checkout file:///$PWD/mysvnrepo mysvnwork
mkdir -p mysvnwork/trunk
cd mysvnwork/
cat << EOF  > trunk/README
#
# (C) Copyright 2000 - 2005
# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
#
# See file CREDITS for list of people who contributed to this
# project.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307 USA
#

EOF

svn add trunk
svn ci -m "first commit" trunk
cd ..
git-svn clone  file:///$PWD/mysvnrepo -t tags -T trunk -b branches  mygitsvn
cd mygitsvn

git checkout --track -b svn remotes/trunk
git checkout -b merge
echo new file > new_file
git add new_file
git commit -a -m "New file"

echo hello >> README
git commit -a  -m "hello"

echo add some stuff >> new_file
git commit -a -m "add some stuff"

git checkout svn
mv -f README tmp
echo friend > README
cat tmp >> README
git commit -a -m "friend"
git svn dcommit
git pull . merge
git svn dcommit

but, as expected, then merge commit is still gone.
