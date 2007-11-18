From: Jeff King <peff@peff.net>
Subject: [PATCH 3/2] send-pack: fix "everything up-to-date" message
Date: Sun, 18 Nov 2007 03:08:22 -0500
Message-ID: <20071118080820.GA25358@sigill.intra.peff.net>
References: <20071118055804.GA19313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 09:08:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItfCt-0000DE-C2
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 09:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbXKRIIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 03:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbXKRIIZ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 03:08:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3213 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbXKRIIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 03:08:25 -0500
Received: (qmail 8792 invoked by uid 111); 18 Nov 2007 08:08:24 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 Nov 2007 03:08:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Nov 2007 03:08:22 -0500
Content-Disposition: inline
In-Reply-To: <20071118055804.GA19313@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65347>

This has always been slightly inaccurate, since it used the
new_refs counter, which really meant "did we send any
objects," so deletions were not counted.

It has gotten even worse with recent patches, since we no
longer look at the 'ret' value, meaning we would say "up to
date" if non-ff pushes were rejected.

Instead, we now claim up to date iff every ref is either
unmatched or up to date. Any other case should already have
generated a status line.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-send-pack.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 14447bb..3aab89c 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -347,6 +347,20 @@ static void print_push_status(const char *dest, struct ref *refs)
 	}
 }
 
+static int refs_pushed(struct ref *ref)
+{
+	for (; ref; ref = ref->next) {
+		switch(ref->status) {
+		case REF_STATUS_NONE:
+		case REF_STATUS_UPTODATE:
+			break;
+		default:
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static int do_send_pack(int in, int out, struct remote *remote, const char *dest, int nr_refspec, const char **refspec)
 {
 	struct ref *ref;
@@ -487,7 +501,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 			update_tracking_ref(remote, ref);
 	}
 
-	if (!new_refs)
+	if (!refs_pushed(remote_refs))
 		fprintf(stderr, "Everything up-to-date\n");
 	if (ret < 0)
 		return ret;
-- 
1.5.3.5.1817.gd2b4b-dirty
