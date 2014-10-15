From: Jeff King <peff@peff.net>
Subject: [PATCH v2 25/25] pack-objects: double-check options before
 discarding objects
Date: Wed, 15 Oct 2014 18:48:15 -0400
Message-ID: <20141015224815.GY25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:48:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXMk-0003aW-2X
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbaJOWsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:48:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:59046 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750887AbaJOWsS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:48:18 -0400
Received: (qmail 2921 invoked by uid 102); 15 Oct 2014 22:48:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:48:18 -0500
Received: (qmail 28386 invoked by uid 107); 15 Oct 2014 22:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:48:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:48:15 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are given an expiration time like
--unpack-unreachable=2.weeks.ago, we avoid writing out old,
unreachable loose objects entirely, under the assumption
that running "prune" would simply delete them immediately
anyway. However, this is only valid if we computed the same
set of reachable objects as prune would.

In practice, this is the case, because only git-repack uses
the --unpack-unreachable option with an expiration, and it
always feeds as many objects into the pack as possible. But
we can double-check at runtime just to be sure.

Signed-off-by: Jeff King <peff@peff.net>
---
No test here, because the potential breakage cannot be seen by running
"git repack" (because it gives sane options), nor by just running "git
pack-objects" (you can convince it not explode a loose object, but then
you would have to reimplement the part of "git repack" where it deletes
all the packs except the one we just created). So really this would only
be protecting in practice against somebody who tried to reimplement
git-repack themselves (and I do not know of anybody who has done that).

 builtin/pack-objects.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3dc9108..72589ed 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2757,6 +2757,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (keep_unreachable && unpack_unreachable)
 		die("--keep-unreachable and --unpack-unreachable are incompatible.");
+	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
+		unpack_unreachable_expiration = 0;
 
 	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
 		use_bitmap_index = 0;
-- 
2.1.2.596.g7379948
