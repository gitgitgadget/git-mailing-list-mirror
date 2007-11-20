From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] send-pack: print "maybe you need to pull" hint
Date: Tue, 20 Nov 2007 06:21:46 -0500
Message-ID: <20071120112146.GB7814@sigill.intra.peff.net>
References: <20071120111317.GA4120@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 12:22:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuRB8-0006xP-Ui
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 12:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbXKTLVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 06:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195AbXKTLVt
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 06:21:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1728 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728AbXKTLVs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 06:21:48 -0500
Received: (qmail 29380 invoked by uid 111); 20 Nov 2007 11:21:47 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 20 Nov 2007 06:21:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2007 06:21:46 -0500
Content-Disposition: inline
In-Reply-To: <20071120111317.GA4120@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65540>

If there were refs rejected for not being fastforwards, then
we used to print a "maybe you are not up-to-date" hint. This
was lost in the recent terse-output patches.

Signed-off-by: Jeff King <peff@peff.net>
---
I am slightly negative on this patch, just because I always found that
particular warning a bit ugly (and the new output is so nice and
compact). But for new users, perhaps the extra hint is helpful?

If we do want the warning, then other options include:
  - listing each non-fast forward, as Alex's original patch did; this
    seems kind of pointless given that they are clustered at the bottom
    already
  - possibly cluster non-fast forwards differently from other errors in
    the output
  - tweak the text

 builtin-send-pack.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index f1cdb97..4bfa847 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -341,6 +341,7 @@ static void print_push_status(const char *dest, struct ref *refs)
 {
 	struct ref *ref;
 	int n = 0;
+	int nonff = 0;
 
 	if (args.verbose) {
 		for (ref = refs; ref; ref = ref->next)
@@ -357,7 +358,15 @@ static void print_push_status(const char *dest, struct ref *refs)
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n);
+		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
+			nonff++;
 	}
+
+	if (nonff)
+		error("%d remote refs were not ancestors of their "
+		      "corresponding local ref\n"
+		      "Maybe you are not up-to-date and need to pull first?",
+		      nonff);
 }
 
 static int refs_pushed(struct ref *ref)
-- 
1.5.3.6.1784.gd1b1d-dirty
