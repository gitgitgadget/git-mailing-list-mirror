From: Matt Mackall <mpm@selenic.com>
Subject: Mercurial 0.4e vs git network pull
Date: Thu, 12 May 2005 02:44:06 -0700
Message-ID: <20050512094406.GZ5914@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 12 11:39:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWAA0-0000jJ-7K
	for gcvg-git@gmane.org; Thu, 12 May 2005 11:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVELJon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 05:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVELJof
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 05:44:35 -0400
Received: from waste.org ([216.27.176.166]:39300 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261378AbVELJoL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 05:44:11 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j4C9i6vt030936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 May 2005 04:44:06 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j4C9i6Eu030933;
	Thu, 12 May 2005 04:44:06 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Now that I'm back from vacation, there's a new Mercurial release as
well as snapshots at:

  http://selenic.com/mercurial/

A combined self-hosting repository / web interface can be found at:

  http://selenic.com/hg/

And there's now a mailing list at:

  http://selenic.com/mailman/listinfo/mercurial

The big news is that Mercurial now has a very fast network protocol.
This benchmark is pulling and merging 819 changesets (again, taken
from 2.6.12-rc2-mm3) from one repo to another over DSL using
Mercurial's new delta protocol:

 $ time hg merge hg://selenic.com/linux-hg/
 retrieving changegroup
 merging changesets
 merging manifests
 merging files

 real    0m10.276s
 user    0m3.299s
 sys     0m0.689s

For comparison, rsyncing the same set of changes between git repos from
the same server:

 $ time rsync -a rsync://10.0.0.12:2000/git/lgb/.git .
 sent 171508 bytes  received 31225542 bytes  312408.46 bytes/sec

 real    1m40.470s
 user    0m0.655s
 sys     0m1.896s

The original broken-out.tar.bz2: 2.3M
The same, uncompressed:           15M
The same, rsynced with git:       30M
The same, pulled with hg (zlib): 2.5M  <- what I used above
The same, pulled with hg (bz2):  2.1M

The server in question is a relatively busy 1GHz Athlon. The server
side of the hg protocol is stateless and is serviced by a simple CGI
script run under Apache.

Mercurial is more than 10 times as bandwidth efficient and
considerably more I/O efficient. On the server side, rsync uses about
twice as much CPU time as the Mercurial server and has about 10 times
the I/O and pagecache footprint as well.

Mercurial is also much smarter than rsync at determining what
outstanding changesets exist. Here's an empty pull as a demonstration:

 $ time hg merge hg://selenic.com/linux-hg/
 retrieving changegroup

 real    0m0.363s
 user    0m0.083s
 sys     0m0.007s

That's a single http request and a one line response.

And now with rsync:

 $ time rsync -av rsync://10.0.0.12:2000/git/lgb/.git .
 receiving file list ... done

 sent 76 bytes  received 1280245 bytes  2560642.00 bytes/sec
 total size is 85993841  speedup is 67.17

 real    0m0.539s
 user    0m0.185s
 sys     0m0.148s

Mercurial's communication here scales O(min(changed branches, log new
changesets)) which is less than O(new changesets), while rsync scales
with O(total number of file revisions) (ouch!). The above transfer
size for an empty pull will go from 1.2M to >12M when there's similar
history in git to what's in BK.

-- 
Mathematics is the supreme nostalgia of our time.
