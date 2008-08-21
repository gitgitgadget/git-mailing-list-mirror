From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 0/5] More git blame speed improvements
Date: Thu, 21 Aug 2008 18:21:56 -0500
Message-ID: <1219360921-28529-1-git-send-email-bdowning@lavos.net>
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:34:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJfI-0003Ti-6B
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001AbYHUXdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 19:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756928AbYHUXc7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:32:59 -0400
Received: from mail.somat.com ([63.252.84.66]:50096 "EHLO somat1.somat.local"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756820AbYHUXc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 19:32:58 -0400
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 19:32:39 EDT
Received: from silvara.lavos.net ([192.168.0.108]) by somat1.somat.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 21 Aug 2008 18:22:01 -0500
Received: (nullmailer pid 28562 invoked by uid 1000);
	Thu, 21 Aug 2008 23:22:01 -0000
X-Mailer: git-send-email 1.5.6.1
X-OriginalArrivalTime: 21 Aug 2008 23:22:01.0210 (UTC) FILETIME=[B6DC7DA0:01C903E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93231>

This patch series contains more git blame speed improvements.  It's
really in two parts; patches 1-2 are the first improvement, and patches
3-5 are the second (which depend on the first, at least textually.)

There are some things I'm not entirely happy about in here, but overall
it's not too bad for a first effort.  I'm interested in hearing what
people have to say about it, especially since I'm adding new interfaces
to the xdiff core for some of this.

Performance summary for my (proprietary, alas) test case:
:; time git-blame -M -C -C -p --incremental server.c >/dev/null
Before (master):
79.62user 0.10system 1:19.81elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+41189minor)pagefaults 0swaps
After:
29.68user 0.22system 0:29.98elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+37897minor)pagefaults 0swaps

I have an additional patch (not included here) that caches the actual
entry lines from the blame, but the performance gain was not exciting
(the entries passed as the second file to the compare_buffer() call in
find_copy_in_blob() are generally quite small), and it results in more
page faults and a fair amount more code:
:; time git-blame -M -C -C -p --incremental server.c >/dev/null
28.82user 0.07system 0:28.93elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+40268minor)pagefaults 0swaps

 [PATCH 1/5] Allow alternate "low-level" emit function from xdl_diff
 [PATCH 2/5] Bypass textual patch generation and parsing in git blame
 [PATCH 3/5] Always initialize xpparam_t to 0
 [PATCH 4/5] Allow xdiff machinery to cache hash results for a file
 [PATCH 5/5] Use xdiff caching to improve git blame performance

 builtin-blame.c  |  103 +++++++++++++++++++++--------------------------------
 builtin-rerere.c |    1 +
 combine-diff.c   |    1 +
 diff.c           |    5 +++
 merge-file.c     |    1 +
 xdiff/xdiff.h    |   12 ++++++
 xdiff/xdiffi.c   |    4 ++-
 xdiff/xemit.c    |    3 +-
 xdiff/xemit.h    |    3 ++
 xdiff/xprepare.c |   59 +++++++++++++++++++++++++++----
 xdiff/xtypes.h   |    1 +
 11 files changed, 121 insertions(+), 72 deletions(-)

-bcd
