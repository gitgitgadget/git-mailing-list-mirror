From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] repack: do not accidentally pack kept objects by
 default
Date: Wed, 11 Jun 2014 02:32:45 -0400
Message-ID: <20140611063244.GA32333@sigill.intra.peff.net>
References: <20140610200741.GA11248@sigill.intra.peff.net>
 <20140610200837.GA14974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 08:32:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wuc5a-0004eS-AZ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 08:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbaFKGcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 02:32:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:41702 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751127AbaFKGcp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 02:32:45 -0400
Received: (qmail 13368 invoked by uid 102); 11 Jun 2014 06:32:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jun 2014 01:32:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jun 2014 02:32:45 -0400
Content-Disposition: inline
In-Reply-To: <20140610200837.GA14974@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251328>

On Tue, Jun 10, 2014 at 04:08:37PM -0400, Jeff King wrote:

> Note the update to t7700. It failed to turn on bitmaps,
> meaning we were actually confirming the wrong behavior!

After writing this, I was thinking about the test, and why we didn't
notice this regression. True, the test added to t7700 was checking the
wrong thing. But the test _before_ it was trying to check the right
thing, and still did not notice. It's because ee34a2b sabotaged it by
adding an explicit --no-pack-kept-objects, so we were no longer testing
the default behavior at all.

I think we should do something like this on top of the series I posted
earlier. And possibly look into what kind of crack I was smoking when I
wrote the original tests.

-- >8 --
Subject: t7700: drop explicit --no-pack-kept-objects from .keep test

We want to make sure that the default behavior of git-repack,
without any options, continues to treat .keep files as it
always has. Adding an explicit --no-pack-kept-objects, as
ee34a2b did, is a much less interesting test, and prevented
us from noticing the bug fixed by 64d3dc9 (repack: do not
accidentally pack kept objects by default, 2014-06-10).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7700-repack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 82d39ad..021c547 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -21,7 +21,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
 		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
-	git repack --no-pack-kept-objects -A -d -l &&
+	git repack -A -d -l &&
 	git prune-packed &&
 	for p in .git/objects/pack/*.idx; do
 		idx=$(basename $p)
-- 
2.0.0.729.g520999f
