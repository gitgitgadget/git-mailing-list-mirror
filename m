From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 2/3] send-pack: check ref->status before updating
	tracking refs
Date: Tue, 13 Nov 2007 05:27:57 -0500
Message-ID: <20071113102757.GB2905@sigill.intra.peff.net>
References: <20071113102500.GA2767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 11:28:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irt0C-0006yF-72
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbXKMK2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbXKMK2A
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:28:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3687 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbXKMK17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:27:59 -0500
Received: (qmail 19334 invoked by uid 111); 13 Nov 2007 10:27:58 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 05:27:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 05:27:57 -0500
Content-Disposition: inline
In-Reply-To: <20071113102500.GA2767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64785>

Previously, we manually checked the 'NONE' and 'UPTODATE'
conditions. Now that we have ref->status, we can easily
say "only update if we pushed successfully".
---
 builtin-send-pack.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 3ac2615..2805c92 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -180,24 +180,17 @@ static int receive_status(int in)
 static void update_tracking_ref(struct remote *remote, struct ref *ref)
 {
 	struct refspec rs;
-	int will_delete_ref;
 
-	rs.src = ref->name;
-	rs.dst = NULL;
-
-	if (!ref->peer_ref)
+	if (ref->status != REF_STATUS_OK)
 		return;
 
-	will_delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
-
-	if (!will_delete_ref &&
-			!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1))
-		return;
+	rs.src = ref->name;
+	rs.dst = NULL;
 
 	if (!remote_find_tracking(remote, &rs)) {
 		if (args.verbose)
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
-		if (is_null_sha1(ref->peer_ref->new_sha1)) {
+		if (ref->deletion) {
 			if (delete_ref(rs.dst, NULL))
 				error("Failed to delete");
 		} else
-- 
1.5.3.5.1704.g24d42-dirty
