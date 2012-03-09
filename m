From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] p4000: use -3000 when promising -3000
Date: Fri, 9 Mar 2012 10:52:54 +0100
Message-ID: <16d90c224b9a0cac0054f8903b9c674a67270cda.1331285117.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>,
	Lawrence Holding <Lawrence.Holding@cubic.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5wVU-0007BM-Vo
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab2CIJw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 04:52:59 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:50118 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233Ab2CIJw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 04:52:58 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Mar
 2012 10:52:54 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Mar
 2012 10:52:55 +0100
X-Mailer: git-send-email 1.7.10.rc0.218.g3ed6ff
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192705>

The 'log -3000 (baseline)' test accidentally still used -1000 from an
earlier version.

Noticed-by: Lawrence Holding <Lawrence.Holding@cubic.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

That has to be the worst paperbag bug in quite some time, especially
considering that this is already in master and -rc0.  Luckily it
doesn't affect the validity of the *actual* tests, and thus what the
commit message said.


Going off on a tangent: I played with bisecting for performance
regressions yesterday, and this shows a bit of a problem with all of
these tests.

I could use an unrestricted 'log' here, but then the perf suite would
be too slow to "just run" with defaults (i.e., on git.git).  For
example, if I run p4000 with 'sed -i s/-3000//' applied I get

  Test                             this tree        
  --------------------------------------------------
  4000.1: log  (baseline)          0.59(0.52+0.06)  
  4000.2: log --raw  (tree-only)   3.02(2.57+0.43)  
  4000.3: log -p  (Myers)          17.66(16.65+0.93)
  4000.4: log -p  --histogram      17.64(16.78+0.79)
  4000.5: log -p  --patience       20.71(19.68+0.96)

For best-of-3 runs (the default) that's still a runtime on the order
of 3min -- for a single test!

The -3000 is also plenty, on my box, to prove (statistically, with
significance to spare) an improvement with this hack for the diff
engine:

  https://github.com/trast/git/commit/a0acba9b853ae257260fd7bd2f1a81389e1c75e8

OTOH I had some problems with completely unattended bisections.
Consider the results, for the fixed version:

  Test                                  this tree      
  -----------------------------------------------------
  4000.1: log -3000 (baseline)          0.08(0.07+0.01)
  4000.2: log --raw -3000 (tree-only)   0.38(0.33+0.04)
  4000.3: log -p -3000 (Myers)          1.70(1.58+0.11)
  4000.4: log -p -3000 --histogram      1.67(1.57+0.09)
  4000.5: log -p -3000 --patience       2.02(1.89+0.12)

Suppose I was bisecting for a 5% performance hit.  On the 1.70s
timings, that would be about 90ms, but the noise in the timings can
easily be 30-50ms.  So there is a gap between "nice for humans to just
run" and "great S/N".  "Reasonable S/N" won't do it for a bisection,
as a single bad decision sends you the wrong way.

I did, however, get good results by removing the -3000 limits and then
automating a bisection for an 8% performance hit in 4000.3 between
v1.7.0 and master, which turns out to be explained by 3e5a188 (diff.c:
Ensure "index $from..$to" line contains unambiguous SHA1s,
2010-05-30).

So perhaps there should be a knob that says "and now take 10 times
longer please".  Or something like that.


 t/perf/p4000-diff-algorithms.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p4000-diff-algorithms.sh b/t/perf/p4000-diff-algorithms.sh
index d6e505c..7e00c9d 100755
--- a/t/perf/p4000-diff-algorithms.sh
+++ b/t/perf/p4000-diff-algorithms.sh
@@ -7,7 +7,7 @@ test_description="Tests diff generation performance"
 test_perf_default_repo
 
 test_perf 'log -3000 (baseline)' '
-	git log -1000 >/dev/null
+	git log -3000 >/dev/null
 '
 
 test_perf 'log --raw -3000 (tree-only)' '
-- 
1.7.10.rc0.218.g3ed6ff
