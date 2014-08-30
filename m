From: Jeff King <peff@peff.net>
Subject: [PATCH 3/2] t5309: mark delta-cycle failover tests as passing
Date: Sat, 30 Aug 2014 09:23:12 -0400
Message-ID: <20140830132311.GA14709@peff.net>
References: <53F79CE3.60803@gmx.net>
 <53F868F8.9080000@web.de>
 <20140823105640.GA6881@peff.net>
 <20140823110459.GA13087@peff.net>
 <20140823111804.GA17335@peff.net>
 <53FB66D1.709@web.de>
 <20140828220821.GA31545@peff.net>
 <20140828222227.GA30879@peff.net>
 <xmqq1ts08ax2.fsf@gitster.dls.corp.google.com>
 <20140829205538.GD29456@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 15:23:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNicg-00072a-IV
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 15:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbaH3NXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 09:23:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:33806 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751707AbaH3NXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 09:23:13 -0400
Received: (qmail 20543 invoked by uid 102); 30 Aug 2014 13:23:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 30 Aug 2014 08:23:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Aug 2014 09:23:12 -0400
Content-Disposition: inline
In-Reply-To: <20140829205538.GD29456@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256251>

t5309 checks that we detect and fail when there is a cycle
of deltas (i.e., A is a delta on B, which is a delta on A).
It also checks the cases where we have such a cycle, but we
have an extra copy of the object either in the same pack or
in another one. These cases are recoverable, because we can
use the alternate copy to reconstruct the delta object.

However, it did not work in practice (and the tests were
marked as expect_failure) because it led to us trying to
resolve some deltas multiple times, something we assert()
should not happen. E.g., we'd see the full base A, use it to
resolve delta B on top of A, then use that to resolve the
delta A on top of B, and then finally try resolving B on top
of A again.

Since the previous commit, we handle duplicate bases more
gracefully, and the tests pass. While we're here, let's also
make the tests a little more robust:

  1. For the case of finding the extra base in the same
     pack, we do not need to use --fix-thin; it should (and
     does) work without it.

  2. Confirm that the resulting pack has a duplicate object.
     In the case of using --fix-thin to pull the object from
     another pack, the duplicate is added to the pack by us
     (this is a good thing, as otherwise future readers
     would encounter the cycle again).

Signed-off-by: Jeff King <peff@peff.net>
---
An obvious follow-on to the other two patches.

The implications of this make me slightly nervous, though. In the
--fix-thin case, the resulting pack will have 3 objects:

  - A as a delta on B
  - B as a delta on A
  - a full copy of either A (or B) provided by --fix-thin

We create a .idx that has duplicate entries for A. If a reader is trying
to reconstruct B and they find the full copy of A, they're fine. If they
find the delta copy, what happens?

Ideally the reader would say "hey, I can't reconstruct A here, let me
try to find another copy". But I am not sure if that happens, or if we
are even capable of finding another copy of A (certainly we can find one
in another pack, but I do not think we are smart enough to find a
duplicate in the same pack).

By definition, we have a copy in another pack here (that is where the
--fix-thin base came from), but there is nothing to guarantee that the
other pack lives on.

 t/t5309-pack-delta-cycles.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 3e7861b..5309095 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -56,13 +56,14 @@ test_expect_success 'index-pack detects REF_DELTA cycles' '
 	test_must_fail git index-pack --fix-thin --stdin <cycle.pack
 '
 
-test_expect_failure 'failover to an object in another pack' '
+test_expect_success 'failover to an object in another pack' '
 	clear_packs &&
 	git index-pack --stdin <ab.pack &&
-	git index-pack --stdin --fix-thin <cycle.pack
+	git index-pack --stdin --fix-thin <cycle.pack &&
+	test_must_fail git index-pack --strict --stdin --fix-thin <cycle.pack
 '
 
-test_expect_failure 'failover to a duplicate object in the same pack' '
+test_expect_success 'failover to a duplicate object in the same pack' '
 	clear_packs &&
 	{
 		pack_header 3 &&
@@ -71,7 +72,8 @@ test_expect_failure 'failover to a duplicate object in the same pack' '
 		pack_obj $A
 	} >recoverable.pack &&
 	pack_trailer recoverable.pack &&
-	git index-pack --fix-thin --stdin <recoverable.pack
+	git index-pack --stdin <recoverable.pack &&
+	test_must_fail git index-pack --strict --stdin <recoverable.pack
 '
 
 test_done
-- 
2.1.0.346.ga0367b9
