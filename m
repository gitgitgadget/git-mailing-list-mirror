From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH WIP] sha1-lookup: make selection of 'middle' less aggressive
Date: Sun, 30 Dec 2007 03:38:51 -0800
Message-ID: <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 12:39:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8wVm-0007an-UT
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 12:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbXL3Li6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 06:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbXL3Li6
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 06:38:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbXL3Li5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 06:38:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 60E133436;
	Sun, 30 Dec 2007 06:38:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 962463435;
	Sun, 30 Dec 2007 06:38:53 -0500 (EST)
In-Reply-To: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 30 Dec 2007 02:22:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69353>

If we pick 'mi' between 'lo' and 'hi' at 50%, which was what the
simple binary search did, we are halving the search space
whether the entry at 'mi' is lower or higher than the target.

The previous patch was about picking not the middle but closer
to 'hi', when we know the target is a lot closer to 'hi' than it
is to 'lo'.  However, if it turns out that the entry at 'mi' is
higher than the target, we would end up reducing the search
space only by the difference between 'mi' and 'hi' (which by
definition is less than 50% --- that was the whole point of not
using the simple binary search), which made the search less
efficient.  And the risk of overshooting is high, because we try
to be too precise.

This tweaks the selection of 'mi' to be a bit closer to the
middle than we would otherwise pick to avoid the problem.

With this patch, we actually see slight improvements in
execution time as well.  In the same partial kde repository
(3.0GB pack, 95MB idx; the numbers are from the same machine as
before, best of 5 runs):

    $ GIT_USE_LOOKUP=t git log -800 --stat HEAD >/dev/null
    3.88user 0.18system 0:04.07elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+56378minor)pagefaults 0swaps

    $ git log -800 --stat HEAD >/dev/null
    3.93user 0.18system 0:04.11elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+60258minor)pagefaults 0swaps

    $ GIT_USE_LOOKUP=t git log -2000 HEAD >/dev/null
    0.05user 0.00system 0:00.06elapsed 95%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+4517minor)pagefaults 0swaps

    $ git log -2000 HEAD >/dev/null
    0.10user 0.03system 0:00.14elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+8505minor)pagefaults 0swaps

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is no way close to even 'pu' yet, but I found it an
   interesting mental exercise with a bit of random hackery.

 sha1-lookup.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/sha1-lookup.c b/sha1-lookup.c
index f5c9094..b309270 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -50,6 +50,12 @@
  * the midway of the table.  It can reasonably be expected to be near
  * 87% (222/256) from the top of the table.
  *
+ * However, we do not want to pick "mi" too precisely.  If the entry at
+ * the 87% in the above example turns out to be higher than the target
+ * we are looking for, we would end up narrowing the search space down
+ * only by 13%, instead of 50% we would get if we did a simple binary
+ * search.  So we would want to hedge our bets by being less aggressive.
+ *
  * The table at "table" holds at least "nr" entries of "elem_size"
  * bytes each.  Each entry has the SHA-1 key at "key_offset".  The
  * table is sorted by the SHA-1 key of the entries.  The caller wants
@@ -119,11 +125,25 @@ int sha1_entry_pos(const void *table,
 		if (hiv < kyv)
 			return -1 - hi;
 
-		if (kyv == lov && lov < hiv - 1)
-			kyv++;
-		else if (kyv == hiv - 1 && lov < kyv)
-			kyv--;
-
+		/*
+		 * Even if we know the target is much closer to 'hi'
+		 * than 'lo', if we pick too precisely and overshoot
+		 * (e.g. when we know 'mi' is closer to 'hi' than to
+		 * 'lo', pick 'mi' that is higher than the target), we
+		 * end up narrowing the search space by a smaller
+		 * amount (i.e. the distance between 'mi' and 'hi')
+		 * than what we would have (i.e. about half of 'lo'
+		 * and 'hi').  Hedge our bets to pick 'mi' less
+		 * aggressively, i.e. make 'mi' a bit closer to the
+		 * middle than we would otherwise pick.
+		 */
+		kyv = (kyv * 1022 + lov + hiv) / 1024;
+		if (lov < hiv - 1) {
+			if (kyv == lov)
+				kyv++;
+			else if (kyv == hiv)
+				kyv--;
+		}
 		mi = (range - 1) * (kyv - lov) / (hiv - lov) + lo;
 
 		if (debug_lookup) {
-- 
1.5.4.rc2.3.g441ed
