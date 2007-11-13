From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: The 5th issue of the msysGit Herald
Date: Tue, 13 Nov 2007 03:13:45 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711130312180.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 04:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrmEK-0008RS-Hc
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 04:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbXKMDOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 22:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755864AbXKMDOF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 22:14:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:58160 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755262AbXKMDOC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 22:14:02 -0500
Received: (qmail invoked by alias); 13 Nov 2007 03:13:59 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp046) with SMTP; 13 Nov 2007 04:13:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7XhxzAm77ZtjjkS4RsrQC0l1dPet30VUpEmjQQ5
	8Vpq7CMTD3B/2R
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64745>

Good morning git land!

This lovely dark 4am (see http://youtube.com/watch?v=yXi6hg90LUU) is 
as good an occasion as any to offer to you the 5th issue of the 
msysGit Herald, the not-quite-biweekly news letter to keep you 
informed about msysGit, the effort to bring one of the most powerful 
Source Code Management systems to the poor souls stuck with Windows. 

These are the covered topics:

	git-gui and git-fetch

	git-svn

	cvsps

	git.git, mingw.git and 4msysgit.git closing ranks



Seems like this edition is mostly about transport... which is a good 
sign. It means that the installer has no more issues and we can 
concentrate on getting git on Windows to work. 


git-gui and git-fetch
=====================

Some time ago, git-gui could call git-fetch to update the remotes, but 
it popped up a new cmd window. This was ugly, and at some stage Shawn 
Pearce, the maintainer of git-gui, changed some parts to avoid that. 
Unfortunately, this broke fetching from within git-gui. 

Warning: technical explanation ahead! 

The problem is this: apparently there are two different kinds of 
processes on Windows (actually three, but let's not make things 
complicated, and for the same reason, let's not play the obvious pun 
on Microsoft): graphical and console processes. 

Whenever you start a console process from a graphical process, you 
have to provide it with a console instance, which would be inherited 
from the calling process if that were a console process, too. But in 
our case, a graphical process calls a console process (this works), 
which in turn calls another console process (this doesn't). 

So the symptom is that git-fetch, called from git-gui, does not pop up 
a cmd window, but ssh, which is called from git-fetch for ssh:// urls, 
does. 

I suspected a bug in Tcl/Tk, which might have been fixed in version 
8.5b2, so I compiled it and tested it, but the behaviour is still the 
same. At least we now have a script in our repository to conveniently 
compile and install Tcl/Tk, should the need ever arise again! 

Steffen Prohaska (see interview in the fourth Herald) and Johannes 
Sixt (see interview in the second Herald) are currently hard at work 
to flesh out this issue, and maybe the solution lies in using Putty's 
plink instead of MSys' ssh. 

Or maybe we will find some clever way to replace the spawnvpe() call 
with a CreateProcess() call which forces the console instance to be 
inherited by the called process. Hannes suggested that a possible 
reason is our heavy usage of dup2(), which might be helped by using 
CreateProcess(), but only time, and a fix, will tell what happens 
here. 


git-svn
=======

It seems that quite a few people want to have a working git-svn in 
msysGit. In our bug tracker, this problem comes in disguise such as 
"Digest.pm is missing". 

Alas, it is not as easy as that... Perl is an MSys program (remember, 
MSys gives you Unix-like paths relative to the install location), and 
compiling that came with its own set of surprises: you need to use a 
different compiler than for MinGW programs! 

As I wrote in the third Herald, Simon Sasburg was hard at work to get 
it to compile, and finally succeeded. But dynamically linked modules 
(otherwise known as DLLs) would not work, instead resulting in 
Windows' version of a segmentation fault. 

A few more days of trial and error led to the discovery of a source 
package of Perl for MSys, which was successfully munged into a 
quilt-like setup: we now have a script to download Perl's sources, 
patch them with our set of patches, build, install and prepare 
everything for commit. 

The next steps are easy: git-svn's dependencies MIME-Base64, Digest 
and Digest-MD5 are nice to build and install. 

The bigger chunk will be to get subversion and its Perl module to 
compile, especially given the dependency of the Apache Runtime (APR): 
subversion's configure complains that it was not found, and the 
documentation suggest to -- you guessed it -- checking it out with 
subversion. 

Stay tuned. 


cvsps
=====

While working at git-svn, I also though about git-cvsimport. This tool 
heavily depends on cvsps, a program which was inspired by the 
PatchSets of the source code management system git set out to replace. 
It is not all that trivial to compile cvsps on MSys, though, since it 
really loves our good old friend, fork(). 

Alas, Peer Sommerlund already worked on compiling this on Windows, and 
was friendly enough to export his Mercurial commits as plain patches, 
which soon found their way into a git repository. Now cvsps compiles 
fine, but cvsimport still fails to work, probably because Peer's 
patches make a few assumptions about the cvs program he used: cvsnt. 

It's likely not hard to work out the kinks until it works, but the 
time to do so successfully avoided finding me. 


git.git, mingw.git and 4msysgit.git closing ranks
=================================================

The official repository for git is git.git, maintained by Junio C 
Hamano. It does not contain any support for MinGW, because the port is 
not polished enough yet. Johannes "Hannes" Sixt maintains the official 
port to MinGW in the mingw.git fork of Junio's repository, and since 
the msysGit project started during Hannes' vacation, mingw.git was 
forked yet again, as 4msysgit.git. 

It is not totally superfluous to have separate repositories for these 
projects, because they differ in workflow and focus. For example, one 
of the big goals of the msysGit project was to provide an integrated 
installer which comes with everything you will need to run git on 
Windows (including MSys with its bash and perl), while the MinGW port 
tries to avoid the dependency on MSys as much as possible. 

But recently Hannes has succeeded in polishing a few topics from 
mingw.git to the point where Junio included them in git.git. There is 
no MinGW specific code yet, but the foundations are laid. 

In related news, Steffen Prohaska has undertaken some tremendous 
effort to merge mingw.git's 'master' branch into 4msysgit.git's 
'devel' branch. Maybe we succeed at some stage to close in totally on 
mingw.git, and then we'll probably move our history to some 
"historical" branch, and just keep with mingw.git's master. 
