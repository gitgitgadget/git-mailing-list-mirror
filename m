From: "Troy Telford" <ttelford@linuxnetworx.com>
Subject: git clone dies (large git repository)
Date: Fri, 18 Aug 2006 16:42:06 -0600
Organization: Linux Networx
Message-ID: <op.teh30gmyies9li@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 19 00:43:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GED3Z-0000I3-Cv
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 00:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWHRWmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 18:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWHRWmm
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 18:42:42 -0400
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:40331 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1422631AbWHRWmh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 18:42:37 -0400
Received: from rygel.lnxi.com ([::ffff:192.168.40.106])
	by zoot.lnxi.com with ESMTP (TLS encrypted); Fri, 18 Aug 2006 16:42:07 -0600
To: git@vger.kernel.org
User-Agent: Opera Mail/9.01 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25701>

I've got a git repository I use to manage a set of RPMs.  It's got history  
stretching back for years, and imported nicely into git.  Since it's used  
to create RPMs, the repository has a structure similar to this:
.
|--README
|-- foo
|    |--SOURCES
|    |  |--foo.tar.bz2
|    |  `--foo-build.patch
|    `--SPECS
|       `--foo.spec
`-- bar
      |--SOURCES
      |  |--bar.tar.bz2
      |  `--bar-build.patch
      `--SPECS
         `--bar.spec

The source tarballs are updated when there's a new version of the  
software; I don't need to worry about changes that are /inside/ the  
tarball-- just that the tarball itself has changed.  As you can imagine, a  
fair amount of the 'stuff' in the repository are these binary tarballs.

The total repository size (ie. the '.git' folder):  4GB

I have only one complaint (and I can work around it anyway):  I can't 'git  
clone' the repository.

if I run:
git clone git://my.server.net/git/rpms
I get the following output:

remote: Generating pack...
remote: Done counting 20971 objects.
remote: Deltifying 20971 objects.
remote:  100% (20971/20971) done
3707.885MB  (21657 kB/s)

remote: Total 20971, written 20971 (delta 9604), reused 20971 (delta 9604)
error: git-fetch-pack: unable to read from git-index-pack
error: git-index-pack died of signal 11
fetch-pack from 'git://my.server.net/git/rpms' failed.

It's interesting to note that during the pack file transfer, it stops  
incrementing at ~3700 MB; the pack file is 4.0 GB.  So either 300MB isn't  
being transferred, or it's just not updating the display for the last few  
hundred megs.

My workaround is to just use 'rsync' to copy the data (although scp works  
too), then checkout the working copy.  After that, fetch/pull and push  
work fine.

The behavior is consistent with git v1.4.1 and v1.4.2, on SLES 9, SLES 10,  
RHEL 4, and Gentoo.

It is also consistent if I clone via the git daemon, or the ssh protocol  
('git clone server:/path/to/repo')

I originally had everything as loose objects.  I then ran 'git-repack -d'  
on occasion, so I had a combination of a large pack file, smaller pack  
files, and loose objects.  Finally, I tried 'git repack -a -d' and  
consolidated it all into a single 4GB pack file.  It didn't seem to make  
much difference in the output.

Am I bumping some sort of limitation within git, or have I uncovered a bug?
-- 
Troy Telford
