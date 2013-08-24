From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] test index-pack on packs with recoverable delta cycles
Date: Fri, 23 Aug 2013 20:02:35 -0400
Message-ID: <20130824000235.GD25833@sigill.intra.peff.net>
References: <20130824000111.GA20255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 02:02:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD1JT-00020V-Do
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 02:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988Ab3HXACj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 20:02:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:41496 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754881Ab3HXACi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 20:02:38 -0400
Received: (qmail 30097 invoked by uid 102); 24 Aug 2013 00:02:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 19:02:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 20:02:35 -0400
Content-Disposition: inline
In-Reply-To: <20130824000111.GA20255@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232846>

The previous commit added tests to show that index-pack
correctly bails in unrecoverable situations. There are some
situations where the data could be recovered, but it is not
currently:

  1. If we can break the cycle using an object from another
     pack via --fix-thin.

  2. If we can break the cycle using a duplicate of one of
     the objects found in the same pack.

Note that neither of these is particularly high priority; a
delta cycle within a pack should never occur, and we have no
record of even a buggy git implementation creating such a
pack.

However, it's worth adding these tests for two reasons. One,
to document that we do not currently handle the situation,
even though it is possible. And two, to exercise the code
that runs in this situation; even though it fails, by
running it we can confirm that index-pack detects the
situation and aborts, and does not misbehave (e.g., by
following the cycle in an infinite loop).

In both cases, we hit an assert that aborts index-pack.

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---
 t/t5309-pack-delta-cycles.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 1640bf7..3e7861b 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -56,4 +56,22 @@ test_expect_success 'index-pack detects REF_DELTA cycles' '
 	test_must_fail git index-pack --fix-thin --stdin <cycle.pack
 '
 
+test_expect_failure 'failover to an object in another pack' '
+	clear_packs &&
+	git index-pack --stdin <ab.pack &&
+	git index-pack --stdin --fix-thin <cycle.pack
+'
+
+test_expect_failure 'failover to a duplicate object in the same pack' '
+	clear_packs &&
+	{
+		pack_header 3 &&
+		pack_obj $A $B &&
+		pack_obj $B $A &&
+		pack_obj $A
+	} >recoverable.pack &&
+	pack_trailer recoverable.pack &&
+	git index-pack --fix-thin --stdin <recoverable.pack
+'
+
 test_done
-- 
1.8.4.rc2.28.g6bb5f3f
