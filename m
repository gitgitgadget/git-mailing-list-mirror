From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/7] Introduce soft references (softrefs)
Date: Sat, 09 Jun 2007 20:19:13 +0200
Message-ID: <200706092019.13185.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5Wy-0003px-KR
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbXFISTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755145AbXFISTT
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:19:19 -0400
Received: from smtp.getmail.no ([84.208.20.33]:38849 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060AbXFISTS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:19:18 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00L05S85NU00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:19:17 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00JIUS81ID00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:19:13 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD000KPS81UB60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:19:13 +0200 (CEST)
In-reply-to: <200706040251.05286.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49592>

This patch series introduces soft references (softrefs); a mechanism for
declaring reachability between arbitrary (but existing) git objects.
Softrefs are meant to provide the mechanism for "reverse mapping" that
we determined was needed for tag objects (especially 'notes'). The patch
series also teaches git-mktag to create softrefs for all tag objects.

See the Discussion section in the git-softref manual page (patch #4/7) or
the comments in the header file (patch #1/7) for more details on the
design of softrefs.

I've added some informal performance data at the bottom of this mail [1].

Note that this patch series is incomplete in that the following things
have yet to be implemented:

1. Clone/fetch/push of softrefs

2. Packing of softrefs

3. General integration of softrefs into parts of git where they might be
   useful

4. Find appropriate value for MAX_UNSORTED_ENTRIES


There are also some questions connected to the above list of todos:

1. Just how should softrefs affect reachability? Should softrefs be
   used/followed in _all_ reachability computations? If not, which?

2. How should softrefs propagate. I suggest they are pretty much always
   propagated under clone/fetch/push. (Note that the softrefs merge
   algorithm in softrefs.c removes duplicates and softrefs between
   non-existing objects, so pre-filtering of the softrefs to be
   clones/fetched/pushed may not be necessary)

3. Where can softrefs be used to improve performance by replacing existing
   techniques?

4. How to best pack softrefs? Keeping them in the same pack as the objects
   they refer to seems to be a good idea, but more thought needs to be put
   into this before we can make an implementation

5. How to find _all_ (even unreachable) tag objects in repo for
   'git-softref --rebuild-tags'?

6. Optimization. Pretty much nothing has been done so far. Performance
   seems to be acceptable for now. Probably needs more testing to
   determine bottlenecks


NOTE: After the 7 patches, I will send an _optional_ patch
that changes the softrefs entries from text format (82 bytes per entry)
to binary format (40 bytes per entry). The patch is optional, because
I want the list to decide if we want the (marginal) speedup and
simplified code provided by the patch, or if we want to keep the
read-/maintainability of the text format. Currently I'm in favour of
keeping the text format, but I'm far from sure.


Finally, here's the shortlog: (This patch series of course goes on top of
the previous "Refactor the tag object" patch series, although there isn't
really that many dependencies between them):

Johan Herland (7):
      Softrefs: Add softrefs header file with API documentation
      Softrefs: Add implementation of softrefs API
      Softrefs: Add git-softref, a builtin command for adding, listing and administering softrefs
      Softrefs: Add manual page documenting git-softref and softrefs subsystem in general
      Softrefs: Add testcases for basic softrefs behaviour
      Softrefs: Administrivia associated with softrefs subsystem and git-softref builtin
      Teach git-mktag to register softrefs for all tag objects

 .gitignore                    |    1 +
 Documentation/cmd-list.perl   |    7 +-
 Documentation/git-softref.txt |  119 +++++++
 Makefile                      |    6 +-
 builtin-softref.c             |  167 ++++++++++
 builtin.h                     |    1 +
 git.c                         |    1 +
 mktag.c                       |   11 +-
 softrefs.c                    |  712 +++++++++++++++++++++++++++++++++++++++++
 softrefs.h                    |  188 +++++++++++
 t/t3050-softrefs.sh           |  314 ++++++++++++++++++
 11 files changed, 1521 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/git-softref.txt
 create mode 100644 builtin-softref.c
 create mode 100644 softrefs.c
 create mode 100644 softrefs.h
 create mode 100755 t/t3050-softrefs.sh


Have fun!

...Johan


[1] Informal performance measurements

I prepared a linux kernel repo (holding 57274 commits) with 10 tag objects,
and created softrefs from every commit to every tag object (572740 softrefs
in total). The resulting softrefs db was 46964680 bytes. The experiment was
done on a 32-bit Intel Pentium 4 (3 GHz w/HyperThreading) with 1 GB RAM:


========
Operations on unsorted softrefs:
(572740 (10 per commit) entries in random/unsorted order)
========

Listing all softrefs
(sequential reading of unsorted softrefs file)
--------
$ /usr/bin/time git softref --list > /dev/null
0.44user 0.02system 0:00.47elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+11786minor)pagefaults 0swaps

Listing HEAD's softrefs
(sequential reading of unsorted softrefs file)
--------
$ /usr/bin/time git softref --list HEAD > /dev/null
0.11user 0.01system 0:00.14elapsed 94%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+11790minor)pagefaults 0swaps

Sorting softrefs
--------
$ /usr/bin/time git softref --merge-unsorted
2.73user 4.97system 0:07.77elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+15833minor)pagefaults 0swaps

Sorting softrefs into existing sorted file
(throwing away duplicates)
--------
$ /usr/bin/time git softref --merge-unsorted
3.49user 5.12system 0:08.64elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+27300minor)pagefaults 0swaps


========
Operations on sorted softrefs:
(572740 (10 per commit) entries in sorted order)
========

Listing all softrefs
(sequential reading of sorted softrefs file)
--------
$ /usr/bin/time git softref --list > /dev/null
0.43user 0.02system 0:00.48elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+11786minor)pagefaults 0swaps

Listing HEAD's softrefs
(256-fanout followed by binary search in sorted softrefs file)
--------
$/usr/bin/time git softref --list HEAD > /dev/null
0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+334minor)pagefaults 0swaps

Sorting softrefs
(no-op)
--------
$ /usr/bin/time git softref --merge-unsorted
0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+312minor)pagefaults 0swaps


-- 
Johan Herland, <johan@herland.net>
www.herland.net
