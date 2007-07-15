From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH 6/6] notes: add notes-index for a substantial speedup.
Date: Mon, 16 Jul 2007 00:33:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160031040.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160025480.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:33:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADas-00034u-GH
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607AbXGOXdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755249AbXGOXdf
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:33:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:58656 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754812AbXGOXde (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:33:34 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:33:33 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp030) with SMTP; 16 Jul 2007 01:33:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZvNgK0ErZBOy4Doq5rRFKWE1oEVaVVgdontRotE
	6ARXED69g2rzuN
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707160025480.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52607>

Hi,

[this explains what Patch 6/6 is all about:]

If GIT_NOTES_TIMING_TESTS is set, t3302 will output some timing data.

It will create three repositories, the first with 10 commits and a
commit note for each, the second with 100, the third with 1000.

For each repository, it times "git log" 100 times in several modes:

- with GIT_NOTES_REF set to a non-existing ref (should be equivalent to
  the timings without this patch series),

- with no .git/notes-index,

- recreating .git/notes-index as a hash map _every_ time,

- creating .git/notes-index as a hash map, and using it the rest of the time,

- recreating .git/notes-index as a sorted list _every_ time, and

- creating .git/notes-index as a sorted list only the first time, and then
  using it to find the notes by binary search.

Here is the output:

* expecting success: create_repo 10
*   ok 1: setup 10

* expecting success: test_notes 10
diff --git a/expect b/output
*   ok 2: notes work

* expecting success: time_notes 100
no-notes
0.13user 0.08system 0:00.22elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+45271minor)pagefaults 0swaps
no-cash
0.14user 0.13system 0:00.28elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+49421minor)pagefaults 0swaps
hash-cache-create
0.16user 0.24system 0:00.41elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+73111minor)pagefaults 0swaps
hash-cache
0.10user 0.08system 0:00.18elapsed 101%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+45660minor)pagefaults 0swaps
sorted-list-cache-create
0.23user 0.17system 0:00.40elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+72056minor)pagefaults 0swaps
sorted-list-cache
0.12user 0.08system 0:00.20elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+46854minor)pagefaults 0swaps
*   ok 3: notes timing

* expecting success: create_repo 100
*   ok 1: setup 100

* expecting success: test_notes 100
diff --git a/expect b/output
*   ok 2: notes work

* expecting success: time_notes 100
no-notes
0.38user 0.18system 0:00.56elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+54386minor)pagefaults 0swaps
no-cash
1.45user 0.66system 0:02.13elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+93980minor)pagefaults 0swaps
hash-cache-create
1.56user 0.98system 0:02.56elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+132604minor)pagefaults 0swaps
hash-cache
0.38user 0.17system 0:00.56elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+54785minor)pagefaults 0swaps
sorted-list-cache-create
1.56user 0.88system 0:02.47elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+124215minor)pagefaults 0swaps
sorted-list-cache
0.44user 0.23system 0:00.68elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+64952minor)pagefaults 0swaps
*   ok 3: notes timing

* expecting success: create_repo 1000
*   ok 1: setup 1000

* expecting success: test_notes 1000
diff --git a/expect b/output
*   ok 2: notes work

* expecting success: time_notes 100
no-notes
2.95user 1.19system 0:04.18elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+144766minor)pagefaults 0swaps
no-cash
23.05user 5.86system 0:33.06elapsed 87%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+639774minor)pagefaults 0swaps
hash-cache-create
23.86user 7.21system 0:32.67elapsed 95%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+710958minor)pagefaults 0swaps
hash-cache
3.16user 1.18system 0:04.35elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+145160minor)pagefaults 0swaps
sorted-list-cache-create
23.22user 7.32system 0:31.66elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+686007minor)pagefaults 0swaps
sorted-list-cache
3.74user 1.81system 0:05.77elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+241987minor)pagefaults 0swaps
*   ok 3: notes timing

Results:

These timings were taken from a desktop machine with a few background
processes running, so take them with a grain of salt.

As expected, without a .git/notes-index, it scales pretty badly.  Creating
.git/notes-index is slightly worse than that, but it typically happens
much less often than looking at a commit message.  Therefore the work is
worth it, since the lookup _with_ .git/notes-index is in the same ball park
as no notes at all, with the hash map being better than the sorted
list lookup.

Therefore I will go with the hash map approach, when cleaning up patch 6/6.
But not tonight.

Ciao,
Dscho
