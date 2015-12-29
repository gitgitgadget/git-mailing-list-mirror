From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] avoid shifting signed integers 31 bits
Date: Tue, 29 Dec 2015 01:35:46 -0500
Message-ID: <20151229063545.GA30340@sigill.intra.peff.net>
References: <20151229063449.GA28755@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 07:35:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDnsu-0000C2-AL
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 07:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbbL2Gft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 01:35:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:46534 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750906AbbL2Gfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 01:35:48 -0500
Received: (qmail 15679 invoked by uid 102); 29 Dec 2015 06:35:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:35:48 -0600
Received: (qmail 18824 invoked by uid 107); 29 Dec 2015 06:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:36:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 01:35:46 -0500
Content-Disposition: inline
In-Reply-To: <20151229063449.GA28755@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283075>

We sometimes use 32-bit unsigned integers as bit-fields.
It's fine to access the MSB, because it's unsigned. However,
doing so as "1 << 31" is wrong, because the constant "1" is
a signed int, and we shift into the sign bit, causing
undefined behavior.

We can fix this by using "1U" as the constant.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 2 +-
 diff.h                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ca38131..2b3b746 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1618,7 +1618,7 @@ static void prepare_shallow_update(struct command *commands,
 				continue;
 			si->need_reachability_test[i]++;
 			for (k = 0; k < 32; k++)
-				if (si->used_shallow[i][j] & (1 << k))
+				if (si->used_shallow[i][j] & (1U << k))
 					si->shallow_ref[j * 32 + k]++;
 		}
 
diff --git a/diff.h b/diff.h
index f7208ad..893f446 100644
--- a/diff.h
+++ b/diff.h
@@ -91,7 +91,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
 #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
 #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
-#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1 << 31)
+#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1U << 31)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
-- 
2.7.0.rc2.368.g1cbb535
