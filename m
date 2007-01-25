From: Gerrit Pape <pape@smarden.org>
Subject: cvsimport/cvsps: wrong revisions in branch
Date: Thu, 25 Jan 2007 14:22:42 +0000
Message-ID: <20070125142242.1402.qmail@b4b5deb4d44aa3.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 15:22:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA5Ug-0006x9-S6
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 15:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbXAYOWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 09:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbXAYOWW
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 09:22:22 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:52236 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S965098AbXAYOWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 09:22:22 -0500
Received: (qmail 1403 invoked by uid 1000); 25 Jan 2007 14:22:42 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37724>

Hi, I struggle with importing a CVS repository into git to switch over
development.  In some branches there're differences in the source code
after importing into git.  We tracked this down to tags and branches
that where tagged partially in CVS, first a tag was set on one
subdirectory tree (sources), later on another subdirectory tree (docs).
This confuses cvsimport or cvsps, the tag in git after import doesn't
match the tag in CVS.

I use cvsps from http://ydirson.free.fr/soft/git/cvsps.git, here's how
to reproduce:

$ cvs -d /tmp/cvs init
$ mkdir repo && cd repo/
$ cvs -d /tmp/cvs import -m initial repo vendor-tag release-tag

No conflicts created by this import

$ cd .. && rmdir repo 
$ cvs -d /tmp/cvs co repo  
cvs checkout: Updating repo
$ cd repo/
$ mkdir a && echo foo >a/a
$ cvs add a a/a
Directory /tmp/cvs/repo/a added to the repository
cvs add: scheduling file `a/a' for addition
cvs add: use `cvs commit' to add this file permanently
$ cvs ci -m foo
cvs commit: Examining .
cvs commit: Examining a
/tmp/cvs/repo/a/a,v  <--  a/a
initial revision: 1.1
$ cvs tag TAG0 a/
cvs tag: Tagging a
T a/a
$ echo 'not in TAG0' >a/a 
$ cvs ci -m 'not in TAG0'
cvs commit: Examining .
cvs commit: Examining a
/tmp/cvs/repo/a/a,v  <--  a/a
new revision: 1.2; previous revision: 1.1
$ mkdir b && echo bar >b/b
$ cvs add b b/b
Directory /tmp/cvs/repo/b added to the repository
cvs add: scheduling file `b/b' for addition
cvs add: use `cvs commit' to add this file permanently
$ cvs ci -m 'add b/b'
cvs commit: Examining .
cvs commit: Examining a
cvs commit: Examining b
/tmp/cvs/repo/b/b,v  <--  b/b
initial revision: 1.1
$ cvs tag TAG0 b/
cvs tag: Tagging b
T b/b
$ git-cvsimport -C git
Committing initial tree d59780674121a7f49784509ee85079a36c9954a3
$ cd git/
$ git checkout -f master
$ git checkout -b tmp TAG0
$ cat a/a 
not in TAG0
$ 

Thanks, Gerrit.
