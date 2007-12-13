From: Markus Klinik <markus.klinik@gmx.de>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Thu, 13 Dec 2007 09:39:31 +0100
Message-ID: <20071213083931.GA6441@mkl-desktop>
References: <20071211200418.GA13815@mkl-desktop> <20071212083154.GB7676@coredump.intra.peff.net> <46a038f90712121158n674a9044t75ef99473314457c@mail.gmail.com> <20071213041737.GA23624@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 09:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2jbl-0006ND-Uj
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 09:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbXLMIjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 03:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbXLMIjc
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 03:39:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:52675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750722AbXLMIjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 03:39:31 -0500
Received: (qmail invoked by alias); 13 Dec 2007 08:39:29 -0000
Received: from g226147154.adsl.alicedsl.de (EHLO localhost) [92.226.147.154]
  by mail.gmx.net (mp047) with SMTP; 13 Dec 2007 09:39:29 +0100
X-Authenticated: #4146147
X-Provags-ID: V01U2FsdGVkX1/c65NZVGfc3yQK21E6f+tm6p7cLdpnvj8S1QdVmG
	j1Za3VjXUkZT4C
Content-Disposition: inline
In-Reply-To: <20071213041737.GA23624@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68130>

On Wed, Dec 12, 2007 at 11:17:37PM -0500, Jeff King wrote:
> it would be nice to get feedback from Markus on what platform he is
> using and what is a reasonable value), or just using a tempfile with
> xargs, which should figure out the correct value.

My platform is an ubuntu 7.04.

$ uname -a 
Linux mkl-desktop 2.6.20-16-386 #2 Sun Sep 23 19:47:10 UTC 2007 i686
GNU/Linux
$ ulimit -s
8192

I wasn't able to verify if the patch or increasing the stack limit works
because I stumbled upon what seems to be this problem:
http://marc.info/?l=git&m=119419453726664&w=2

There is already a patch for the cvs-status-fileorder bug but it doesn't
apply and obviously never made it to the public reopsitory.
http://marc.info/?l=git&m=118718448305647&w=2

At the end of this message is a session log that reproduces this
behaviour. The session uses git-cvsexportcommit without the xargs-patch.

If my understanding is correct the 'cvs status' query is just to make
sure everything is up to date, and can be overridden by the -f flag.
I'll try that today and report if the xargs-patch and the stack limit
thing worked.

-Markus

mkl@mkl-desktop:~/tmp$ # ---------------------- begin
mkl@mkl-desktop:~$ cvs --version

Concurrent Versions System (CVS) 1.12.13 (client/server)

Copyright (C) 2005 Free Software Foundation, Inc.

Senior active maintainers include Larry Jones, Derek R. Price,
and Mark D. Baushke.  Please see the AUTHORS and README files from the
CVS
distribution kit for a complete list of contributors and copyrights.

CVS may be copied only under the terms of the GNU General Public
License,
a copy of which can be found with the CVS distribution kit.

Specify the --help option for further information about CVS
mkl@mkl-desktop:~$ git --version
git version 1.5.3.7.1157.gbf82a
mkl@mkl-desktop:~/tmp$ mkdir ~/cvsroot
mkl@mkl-desktop:~/tmp$ export CVSROOT=~/cvsroot
mkl@mkl-desktop:~/tmp$ cvs init
mkl@mkl-desktop:~/tmp$ mkdir cfoo
mkl@mkl-desktop:~/tmp$ cd cfoo/
mkl@mkl-desktop:~/tmp/cfoo$ cvs import -m'import' cfoo A AA

No conflicts created by this import

mkl@mkl-desktop:~/tmp/cfoo$ cd ..
mkl@mkl-desktop:~/tmp$ mkdir gfoo
mkl@mkl-desktop:~/tmp$ cd gfoo/
mkl@mkl-desktop:~/tmp/gfoo$ git-init
Initialized empty Git repository in .git/
mkl@mkl-desktop:~/tmp/gfoo$ mkdir bar
mkl@mkl-desktop:~/tmp/gfoo$ touch a b c d bar/a bar/b bar/e
mkl@mkl-desktop:~/tmp/gfoo$ git add .
mkl@mkl-desktop:~/tmp/gfoo$ git commit -m'empty'
Created initial commit a11f9bc: empty
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
 create mode 100644 b
 create mode 040000 bar
 create mode 100644 c
 create mode 100644 d
mkl@mkl-desktop:~/tmp/gfoo$ echo 'hi' > 0
mkl@mkl-desktop:~/tmp/gfoo$ echo 'hi' > a
mkl@mkl-desktop:~/tmp/gfoo$ echo 'hi' > bar/e
mkl@mkl-desktop:~/tmp/gfoo$ echo 'hi' > e
mkl@mkl-desktop:~/tmp/gfoo$ git add .
mkl@mkl-desktop:~/tmp/gfoo$ git commit -m 'hi'
Created commit e71a144: hi
 3 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 0
 create mode 100644 e
mkl@mkl-desktop:~/tmp/gfoo$ cd ..
mkl@mkl-desktop:~/tmp$ cvs co cfoo
cvs checkout: Updating cfoo
mkl@mkl-desktop:~/tmp$ cd cfoo
mkl@mkl-desktop:~/tmp/cfoo$ export GIT_DIR=../gfoo/.git
mkl@mkl-desktop:~/tmp/cfoo$ git-cvsexportcommit -c HEAD^ 
Checking if patch will apply
cvs status: nothing known about `a'
cvs status: nothing known about `b'
cvs status: nothing known about `c'
cvs status: nothing known about `d'
Applying
Patch applied successfully. Adding new files and directories to CVS
Directory /home/mkl/cvsroot/cfoo/bar added to the repository
cvs add: scheduling file `a' for addition
cvs add: use `cvs commit' to add this file permanently
cvs add: scheduling file `b' for addition
cvs add: use `cvs commit' to add this file permanently
cvs add: scheduling file `bar/a' for addition
cvs add: use `cvs commit' to add this file permanently
cvs add: scheduling file `bar/b' for addition
cvs add: use `cvs commit' to add this file permanently
cvs add: scheduling file `bar/e' for addition
cvs add: use `cvs commit' to add this file permanently
cvs add: scheduling file `c' for addition
cvs add: use `cvs commit' to add this file permanently
cvs add: scheduling file `d' for addition
cvs add: use `cvs commit' to add this file permanently
Commit to CVS
Patch title (first comment line): empty
Autocommit
  cvs commit -F .msg 'a' 'b' 'bar/a' 'bar/b' 'bar/e' 'c' 'd'
/home/mkl/cvsroot/cfoo/a,v  <--  a
initial revision: 1.1
/home/mkl/cvsroot/cfoo/b,v  <--  b
initial revision: 1.1
/home/mkl/cvsroot/cfoo/c,v  <--  c
initial revision: 1.1
/home/mkl/cvsroot/cfoo/d,v  <--  d
initial revision: 1.1
/home/mkl/cvsroot/cfoo/bar/a,v  <--  bar/a
initial revision: 1.1
/home/mkl/cvsroot/cfoo/bar/b,v  <--  bar/b
initial revision: 1.1
/home/mkl/cvsroot/cfoo/bar/e,v  <--  bar/e
initial revision: 1.1
Committed successfully to CVS
mkl@mkl-desktop:~/tmp/cfoo$ git-cvsexportcommit -c HEAD
Checking if patch will apply
cvs status: nothing known about `0'
cvs status: nothing known about `e'
File e is already known in your CVS checkout -- perhaps it has been added by another user. Or this may indicate that it exists on a different branch. If this is the case, use -f to force the merge.
Status was: Up-to-date
File bar/e not up to date but has status 'Unknown' in your CVS checkout!
Exiting: your CVS tree is not clean for this merge. at /home/mkl/bin/git-cvsexportcommit line 235.
mkl@mkl-desktop:~/tmp/cfoo$ # ----------- end
