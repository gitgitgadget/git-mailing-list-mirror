From: Sergei Organov <osv@javad.com>
Subject: Put part of working tree on another file-system.
Date: Wed, 05 Dec 2007 16:44:39 +0300
Message-ID: <87mysp8ddk.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 14:45:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzuYp-0006tE-2j
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 14:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbXLENos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 08:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbXLENos
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 08:44:48 -0500
Received: from javad.com ([216.122.176.236]:1237 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbXLENor (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 08:44:47 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lB5DijU59305
	for <git@vger.kernel.org>; Wed, 5 Dec 2007 13:44:45 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IzuYJ-0000UY-Gn
	for git@vger.kernel.org; Wed, 05 Dec 2007 16:44:39 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67152>

Hello,

I've a desire to put a sub-tree of my working tree into another
file-system. With CVS I've used symlink to achieve this. It works fine
with CVS as it doesn't care about directories and symlinks at all. I ha=
d
little hope it will work with GIT, but I've performed a test anyway. To
my surprise it almost worked, so I have a hope that maybe it's not that
difficult to support this. What do you think? Or maybe there is a
different way to achieve the goal with GIT?

The test has been performed in a clone of the git tree (my comments are
prefixed by "osv>"):

$ git status
# On branch master
nothing to commit (working directory clean)
$ mv gitweb ../ && ln -s ../gitweb .
$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       gitweb
nothing added to commit but untracked files present (use "git add" to t=
rack)

osv> here GIT is slightly confused by the change of a directory to a
osv> symlink to a directory.

$ echo hehe >> gitweb/INSTALL
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   gitweb/INSTALL
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       gitweb
no changes added to commit (use "git add" and/or "git commit -a")

osv> here confusion is more obvious as GIT reports modified file in an
osv> untracked directory.

$ git commit -a

Created commit 7470207: The commit
 1 files changed, 1 insertions(+), 0 deletions(-)
$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       gitweb
nothing added to commit but untracked files present (use "git add" to t=
rack)

osv> surprisingly nothing very bad happened, -- GIT has commited the
osv> modified file just fine, and left the symlink unchanged.
=20
$ git reset --hard HEAD^
HEAD is now at 7a4a2e1... Set OLD_ICONV on Cygwin.
[osv@fulcrum git]$ git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    gitweb/README
#       deleted:    gitweb/git-favicon.png
#       deleted:    gitweb/git-logo.png
#       deleted:    gitweb/gitweb.css
#       deleted:    gitweb/gitweb.perl
#       deleted:    gitweb/test/M=C3=A4rchen
#       deleted:    gitweb/test/file with spaces
#       deleted:    gitweb/test/file+plus+sign
#
no changes added to commit (use "git add" and/or "git commit -a")

osv> Ooops, -- now things begin to be more seriously broken. The result
osv> is that GIT removed the symlink, created gitweb directory, and put
osv> only INSTALL file into it. The directory the symlink was pointing
osv> to has the rest of files but INSTALL.

$ git reset --hard HEAD
HEAD is now at 7a4a2e1... Set OLD_ICONV on Cygwin.
$ git status
# On branch master
nothing to commit (working directory clean)

osv> This is now as expected, -- GIT just re-populated the gitweb
osv> directory as there is no symlink anymore.

--=20
Sergei.
