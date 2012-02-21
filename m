From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Git tree object storing policy
Date: Tue, 21 Feb 2012 11:18:27 +0100
Message-ID: <87vcn0bibw.fsf@thomas.inf.ethz.ch>
References: <loom.20120221T094746-680@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Ivan Tolstosheyev <ivan.tolstosheyev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 11:18:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzmnv-0001sO-Lb
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 11:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab2BUKSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 05:18:31 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:30977 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285Ab2BUKSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 05:18:30 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 21 Feb
 2012 11:18:26 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 21 Feb
 2012 11:18:27 +0100
In-Reply-To: <loom.20120221T094746-680@post.gmane.org> (Ivan Tolstosheyev's
	message of "Tue, 21 Feb 2012 09:22:12 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191150>

Ivan Tolstosheyev <ivan.tolstosheyev@gmail.com> writes:

> #!/usr/bin/env bash
>
> git init test
> cd test
> for i in `seq 1 10000` 
> do
> touch ${i} ; git add ${i} ; git commit -m "Add ${i}" ;
> done
> cd ..
> du -hs test
[...]
> 180 MB!!!?? and 7.4M after `git gc` - thanks to delta compression!

Most of those 180MB are waste from mostly unused 4KB (presumably) blocks
of your filesystem.  You should be looking at the post-gc'd numbers.

Let's see the breakdown of 'du -h .git':

0       .git/rr-cache
1.5M    .git/logs/refs/heads
1.5M    .git/logs/refs
2.9M    .git/logs
4.0K    .git/objects/info
2.8M    .git/objects/pack
2.8M    .git/objects
0       .git/branches
12K     .git/info
0       .git/remotes
88K     .git/hooks
0       .git/refs/tags
0       .git/refs/heads
0       .git/refs
6.5M    .git

So 2.9MB are git keeping a reflog of everything we did (on HEAD and on
master).  Since merely storing a SHA1 for each of your 10000 operations
already takes 200K, that's not so far off -- the factor of 10 is in the
email, date and log message.

In my case 704K went into the index (not directly visible above, it's
the bulk of the top level).  That's also not unreasonable: merely
storing the object SHA1 (20 bytes) and a bunch of timestamps for 10000
files also gets you into the 500K ballpark.

The pack index amazingly takes only about 500K, even though it is
indexing 10000 trees and 10000 commits, so again the SHA1s alone get you
into the 400K ballpark.

That leaves only 2.3MB for the actual pack (which contains all the
data!).  But every commit must store a tree and a parent, so there are
at least 2*10000*20 = 400K uncompressable bytes in the commits
already[*].  So we are within a factor of 6 of just the data required to
save the shape of your history DAG, no content included.  I'd say that's
not too bad.


[*] This is not quite true, the parents and trees might be pointers
within the pack.  AFAIK the proposed pack v4 format does this, and would
yield a more efficient compression.  So if you're going to waste energy
worrying about this, you should help with pack v4.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
