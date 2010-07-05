From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 4/4] name-rev: respect core.clockskew
Date: Mon, 5 Jul 2010 08:36:53 -0400
Message-ID: <20100705123653.GD25699@sigill.intra.peff.net>
References: <20100705122723.GB21146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Mon Jul 05 14:37:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVkuz-0003a8-Tb
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 14:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255Ab0GEMg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 08:36:56 -0400
Received: from peff.net ([208.65.91.99]:38154 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756029Ab0GEMg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 08:36:56 -0400
Received: (qmail 12230 invoked by uid 107); 5 Jul 2010 12:37:52 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 05 Jul 2010 08:37:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jul 2010 08:36:53 -0400
Content-Disposition: inline
In-Reply-To: <20100705122723.GB21146@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150265>

Before core.clockskew existed, we were just hard-coded to
86400 seconds. This allows users to tweak the value as
appropriate.

Signed-off-by: Jeff King <peff@peff.net>
---
I think it makes sense to adapt this to core.clockskew. Especially if
our default stays at 86400, then there is no change in behavior. But
even if it does change, I think having it tweakable (and especially if
we automatically calculate per-repo skew) makes sense.

 builtin/name-rev.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 06a38ac..5c6d712 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -5,8 +5,6 @@
 #include "refs.h"
 #include "parse-options.h"
 
-#define CUTOFF_DATE_SLOP 86400 /* one day */
-
 typedef struct rev_name {
 	const char *tip_name;
 	int generation;
@@ -270,8 +268,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		add_object_array((struct object *)commit, *argv, &revs);
 	}
 
-	if (cutoff)
-		cutoff = cutoff - CUTOFF_DATE_SLOP;
+	if (cutoff && core_clock_skew >= 0)
+		cutoff = cutoff - core_clock_skew;
+	else
+		cutoff = 0;
 	for_each_ref(name_ref, &data);
 
 	if (transform_stdin) {
-- 
1.7.2.rc1.209.g2a36c
