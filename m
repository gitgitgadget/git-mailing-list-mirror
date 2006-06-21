From: "Art Haas" <ahaas@airmail.net>
Subject: Odd behavior with git and cairo-devel repo
Date: Tue, 20 Jun 2006 20:00:30 -0500
Message-ID: <20060621010030.GP2820@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 21 03:03:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsr60-0000FR-Ji
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 03:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWFUBBZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 21:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWFUBBZ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 21:01:25 -0400
Received: from 8f.7b.d1c4.cidr.airmail.net ([209.196.123.143]:33292 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S932342AbWFUBBY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 21:01:24 -0400
Received: from cpe-24-28-121-3.houston.res.rr.com ([24.28.121.3] helo=pcdebian)
	by covert.iadfw.net with esmtp (Exim 4.24)
	id 1FsrAo-00011I-TP
	for git@vger.kernel.org; Tue, 20 Jun 2006 20:06:26 -0500
Received: (qmail 21477 invoked by uid 1000); 21 Jun 2006 01:00:30 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22233>

Hi.

I've been seeing some odd errors with git when it is dealing with
the Cairo graphics library repo. The errors include git failing
a 'fsck-objects' with a 'Floating point exception' error message
and 'git prune' mangling the repo.

A fresh cloning of the repo is needed to see the FPE error. The
repo is about 13M in size, btw.

$ git clone git://git.cairographics.org/git/cairo cairo
[ ... git clones the repo without problem ... ]
$ cd cairo
$ git fsck-objects
Floating point exception
$

The strace of this shows that things bomb after the '.git/index' file is
read. Here's the tail end of the strace output ...

close(3)                                = 0
open(".git/index", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=51472, ...}) = 0
mmap2(NULL, 51472, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xb7f4b000
close(3)                                = 0
--- SIGFPE (Floating point exception) @ 0 (0) ---
+++ killed by SIGFPE +++

Now, if the repo is added to and you 'git pull' to update your copy,
the 'git fsck-objects' command completes without error.

As for the problem where 'git prune' mangles the local copy, it would
happen after a 'git fsck-objects' run succeeds without incident.
Then 'git prune' would run, seemingly without problems, and I would
try and repack my repo with 'git repack -a -d'. Here, things go
boom with SHA1 errors, and subsequent 'git fsck-objects' runs
produce errors.

My local 'git' build is current with the 'master' branch. I've observed
these problems with the Cairo repo on a machine running Debian unstable,
Fedora Core 4, and Fedora Rawhide. The Debian machine uses git built
by the current gcc-4.1 package, FC4 uses its current gcc-4.0 package,
and rawhide uses its current gcc-4.1 package. All these machines are
kept up-to-date with the respective current packages versions for
that distro.

Can anyone out in git-land seeing problems with the Cairo
git repo, or able to duplicate these problems?

Thanks in advance,

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
