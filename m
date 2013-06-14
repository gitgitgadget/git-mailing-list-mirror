From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t5303: drop "count=1" from corruption dd
Date: Fri, 14 Jun 2013 17:51:01 -0400
Message-ID: <20130614215100.GA3821@sigill.intra.peff.net>
References: <20130614214943.GA29138@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jun 14 23:51:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unbtp-0007XW-1q
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 23:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab3FNVvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 17:51:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:59405 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347Ab3FNVvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 17:51:07 -0400
Received: (qmail 22661 invoked by uid 102); 14 Jun 2013 21:52:01 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Jun 2013 16:52:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2013 17:51:01 -0400
Content-Disposition: inline
In-Reply-To: <20130614214943.GA29138@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227920>

This test corrupts pack objects by using "dd" with a seek
command. It passes "count=1 bs=1" to munge just a single
byte. However, the test added in commit b3118bdc wants to
munge two bytes, and the second byte of corruption is
silently ignored.

This turned out not to impact the test, however. The idea
was to reduce the "size of this entry" part of the header so
that zlib runs out of input bytes while inflating the entry.
That header is two bytes long, and the test reduced the
value of both bytes; since we experience the problem if we
are off by even 1 byte, it is sufficient to munge only the
first one.

Even though the test would have worked with only a single
byte munged, and we could simply tweak the test to use a
single byte, it makes sense to lift this 1-byte restriction
from do_corrupt_object. It will allow future tests that do
need to change multiple bytes to do so.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5303-pack-corruption-resilience.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 5b1250f..9cb8172 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -51,7 +51,7 @@ do_corrupt_object() {
     ofs=`git show-index < ${pack}.idx | grep $1 | cut -f1 -d" "` &&
     ofs=$(($ofs + $2)) &&
     chmod +w ${pack}.pack &&
-    dd of=${pack}.pack count=1 bs=1 conv=notrunc seek=$ofs &&
+    dd of=${pack}.pack bs=1 conv=notrunc seek=$ofs &&
     test_must_fail git verify-pack ${pack}.pack
 }
 
-- 
1.8.3.rc2.14.g7eee6b3
