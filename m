From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git-svn set-tree bug
Date: Sun, 10 Jun 2007 19:21:26 +0200
Organization: Transmode AB
Message-ID: <1181496086.30670.115.camel@gentoo-jocke.transmode.se>
References: <1181323515.30670.110.camel@gentoo-jocke.transmode.se>
	 <20070610014734.GA542@muzzle>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 19:21:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxR6a-0001qp-B7
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 19:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241AbXFJRVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 13:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755791AbXFJRVa
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 13:21:30 -0400
Received: from mail.transmode.se ([83.241.175.147]:53413 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751178AbXFJRV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 13:21:29 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 10 Jun 2007 19:21:26 +0200
In-Reply-To: <20070610014734.GA542@muzzle>
X-Mailer: Evolution 2.8.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49749>

On Sat, 2007-06-09 at 18:47 -0700, Eric Wong wrote:
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > trying to do git-svn set-tree remotes/trunk..svn
> > in my new git-svn repo I get:
> > config --get svn-remote.svn.fetch :refs/remotes/git-svn$: command returned error: 1
> 
> You need to specify "-i trunk" in the command-line
> 
> git-svn set-tree -i trunk remotes/trunk..svn
> 

Thanks

I have found a bug or two. Run this script and
see what happens ant the end.
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
git-svn clone  file:///$PWD/mysvnrepo -t tags -T trunk -b branches
mygitsvn
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
git pull . merge
git svn dcommit  # this fails 
git svn rebase  
# this fails too, mismerges the last commit and remove the merge commit
