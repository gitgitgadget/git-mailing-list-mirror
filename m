From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Git-SVN on Cygwin: svn+ssh good, https awkward
Date: Thu, 23 Apr 2009 18:31:09 +0200
Message-ID: <op.usulh7a71e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 18:36:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx1r4-0001TR-Fp
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 18:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbZDWQbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 12:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756756AbZDWQbP
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 12:31:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:39152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756358AbZDWQbM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 12:31:12 -0400
Received: (qmail invoked by alias); 23 Apr 2009 16:31:11 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp007) with SMTP; 23 Apr 2009 18:31:11 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+uabcsOoGuPRA97usYNN5dN59//u0BoZD54sQNLR
	6PQyctVSA68TUE
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117347>

Hi Eric,

=== Short story ===

git-svn on Cygwin works well with svn+ssh://, but needs some fixes around  
tempfile and/or subprocess handling for https:// - please help.


=== Long story ===

First the good news: git-svn on Cygwin seems to work just fine with  
svn+ssh://... style Subversion URLs. I've been doing this for quite a  
while now with various repos, never had issues: I can init, clone, fetch  
rebase, dcommit just fine.

I'm looking for some help https:// access on Cygwin (Windows XP SP3  
underneath; more version info at the end of the message).

I've debugged it a little, but am not sufficiently acquainted with the  
git-svn Perl source to do changes myself; I hope I can describe the issue  
well enough that you (or somebody else) can suggest code changes to  
improve the experience.


0. PROBLEM/SYMPTOM:

login@mycomp ~/compnet2.gitsvn
$ git svn fetch
         M       file1
         A       file2
         A       file3
         A       file4
r15 = 70a56f818a057442e29161170e28c5df4b38a811 (git-svn)
Permission denied: Can't open  
'/cygdrive/c/DOKUME~1/login/LOKALE~1/Temp/tempfile.tmp': Permission denied  
at /usr/local/libexec/git-core/git-svn line 2540

which is, in my version:

   2537                  }
   2538                  $ed = SVN::Git::Fetcher->new($self);
   2539          }
+ 2540          unless ($self->ra->gs_do_update($last_rev, $rev, $self,  
$ed)) {
   2541                  die "SVN connection failed somewhere...\n";
   2542          }
   2543          $self->make_log_entry($rev, \@parents, $ed);


Apparently, we die when fetching a new revision for the 2nd time. I can  
restart git svn fetch and it will pick up where it left off. It will make  
progress, but is painful.

git svn rebase has the same issues. I haven't tested other operations such  
as dcommit yet.


1. WORKAROUND for fetch/rebase:

while ! git svn fetch ; do : ; done
git svn rebase


2. A SHORT LOG OF FINDING THE CAUSE:

$ perl -d /usr/local/libexec/git-core/git-svn fetch
...
main::(/usr/local/libexec/git-core/git-svn:10):
10:     $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
   DB<1> c 2540
Git::SVN::do_fetch(/usr/local/libexec/git-core/git-svn:2540):
2540:           unless ($self->ra->gs_do_update($last_rev, $rev, $self,  
$ed)) {
   DB<2> c 2540
...
r16 = d7829595222a013e703fe4377996984b52921789 (git-svn)
Git::SVN::do_fetch(/usr/local/libexec/git-core/git-svn:2540):
2540:           unless ($self->ra->gs_do_update($last_rev, $rev, $self,  
$ed)) {

Now watch this (we're immediately before the problem):

$ ls -l /cygdrive/c/DOKUME~1/login/LOKALE~1/Temp/
??????????? ? ?       ?       ?            ? tempfile.tmp
$ ls -l /cygdrive/c/DOKUME~1/login/LOKALE~1/Temp/tempfile.tmp
ls: cannot access /cygdrive/c/DOKUME~1/login/LOKALE~1/Temp/tempfile.tmp:  
No such file or directory

This zombie behaviour of trashing the file flags happens if Cygwin is  
asked to unlink() a file to which there are still open handles. It can't  
delete the file right away (due to the open handles), so it marks it  
delete-on-close instead, which then happens when the process(es) terminate.

$ ~/Desktop/handle.exe tempfile.tmp
...
git.exe            pid: 2236    62C:  
C:\DOKUME~1\mandree\LOKALE~1\Temp\tempfile.tmp
git.exe            pid: 5552    62C:  
C:\DOKUME~1\mandree\LOKALE~1\Temp\tempfile.tmp
git-hash-object.exe pid: 5320    62C:  
C:\DOKUME~1\mandree\LOKALE~1\Temp\tempfile.tmp

So we have three processes that have the file open. I cannot say if they  
mean the same file, or a different one, but this is the problem.

Here's the pstree dump to help identify the users of this file, with  
cmdline arguments:

perl,5660 -d -I... /usr/local/libexec/git-core/git-svn fetch
   |-git,2236  --batch
   |-git,5552 git-hash-object -w --stdin-paths
   |   `-git-hash-object,5320
   `-git,1128 update-index -z --index-info

Let's continue in the Perl debugger and crash:

   DB<3> c
Permission denied: Can't open  
'/cygdrive/c/DOKUME~1/login/LOKALE~1/Temp/tempfile.tmp': Permission denied  
at /usr/local/libexec/git-core/git-svn line 2540


Bottom line: the second time we hit this "unless  
($self->ra->gs_do_update($last_rev, $rev, $self, $ed))" line, we die  
because there are still processes that have the tempfile open and thus the  
former unlink() on the tempfile.tmp couldn't become effective.



3. UNDERLYING CYGWIN LIMITATIONS

<http://wiki.osdev.org/Cygwin_Issues#unlink.28.29> documents now  
(2009-04-23 16:15 UTC):
* unlink isn't atomic (as on other platforms also)
...
On cygwin unlink() is deferred to the end of the process, when unlink  
fails because of locks or delete on close (ERROR_SHARING_VIOLATION).

* unlink a file and subsequent creation of a new file in the same location  
is not supported.

* "delete on close" (unlinking an open file) is supported.


I can provide a short C program to demonstrate this behaviour.



4. FIX SUGGESTIONS AND QUESTIONS

Can we defer unlink()ing the tempfile until all handles to it are closed?

Can we let complete and wait for all processes that hold handles to the  
tempfile.tmp file before attempting to create a new copy?

Can we use unique tempfile names (timestamps, counter, random number  
generator) instead of the hardcoded "tempfile.tmp"? This is probably a  
good idea anyways to evade symlink attacks.


Either should work to fix the issue.


I'm willing to test patches.


5. VERSION INFORMATION:

Cygwin:
CYGWIN_NT-5.1 balu 1.5.25(0.156/4/2) 2008-06-12 19:34 i686 Cygwin

Git:
git version 1.6.3.rc1.51.gea0b7

Subversion:
svn, version 1.6.1 (r37116)
    compiled Apr 11 2009, 12:07:06

Copyright (C) 2000-2009 CollabNet.
Subversion is open source software, see http://subversion.tigris.org/
This product includes software developed by CollabNet  
(http://www.Collab.Net/).

The following repository access (RA) modules are available:

* ra_neon : Module for accessing a repository via WebDAV protocol using  
Neon.
   - handles 'http' scheme
   - handles 'https' scheme
* ra_svn : Module for accessing a repository using the svn network  
protocol.
   - with Cyrus SASL authentication
   - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
   - handles 'file' scheme
* ra_serf : Module for accessing a repository via WebDAV protocol using  
serf.
   - handles 'http' scheme
   - handles 'https' scheme



Thanks for any efforts to help!

-- 
Matthias Andree
