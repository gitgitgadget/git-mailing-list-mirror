From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] send-pack: don't update tracking refs on error
Date: Thu, 18 Oct 2007 02:19:15 -0400
Message-ID: <20071018061915.GB29531@coredump.intra.peff.net>
References: <20071018045358.GB14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Perry Wagle <wagle@cs.indiana.edu>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 08:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOjC-0002ez-DQ
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 08:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbXJRGTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 02:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbXJRGTS
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 02:19:18 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4556 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbXJRGTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 02:19:18 -0400
Received: (qmail 535 invoked by uid 111); 18 Oct 2007 06:19:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 02:19:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 02:19:15 -0400
Content-Disposition: inline
In-Reply-To: <20071018045358.GB14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61491>

Previously, we updated the tracking refs (which match refs we
are pushing) while generating the list of refs to send.
However, at that point we don't know whether the refs were
accepted.

Instead, we now wait until we get a response code from the
server. If an error was indicated, we don't update any local
tracking refs. Technically some refs could have been updated
on the remote, but since the local ref update is just an
optimization to avoid an extra fetch, we are better off
erring on the side of correctness.

The user-visible message is now generated much later in the
program, and has been tweaked to make more sense.

Signed-off-by: Jeff King <peff@peff.net>
---
 send-pack.c |   50 ++++++++++++++++++++++++++++++++++----------------
 1 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index f74e66a..25d5c25 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -177,6 +177,35 @@ static int receive_status(int in)
 	return ret;
 }
 
+static void update_tracking_ref(struct remote *remote, struct ref *ref)
+{
+	struct refspec rs;
+	int will_delete_ref;
+
+	rs.src = ref->name;
+	rs.dst = NULL;
+
+	if (!ref->peer_ref)
+		return;
+
+	will_delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
+
+	if (!will_delete_ref &&
+			!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1))
+		return;
+
+	if (!remote_find_tracking(remote, &rs)) {
+		fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
+		if (is_null_sha1(ref->peer_ref->new_sha1)) {
+			if (delete_ref(rs.dst, NULL))
+				error("Failed to delete");
+		} else
+			update_ref("update by push", rs.dst,
+					ref->new_sha1, NULL, 0, 0);
+		free(rs.dst);
+	}
+}
+
 static int send_pack(int in, int out, struct remote *remote, int nr_refspec, char **refspec)
 {
 	struct ref *ref;
@@ -302,22 +331,6 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 			fprintf(stderr, "\n  from %s\n  to   %s\n",
 				old_hex, new_hex);
 		}
-		if (remote) {
-			struct refspec rs;
-			rs.src = ref->name;
-			rs.dst = NULL;
-			if (!remote_find_tracking(remote, &rs)) {
-				fprintf(stderr, " Also local %s\n", rs.dst);
-				if (will_delete_ref) {
-					if (delete_ref(rs.dst, NULL)) {
-						error("Failed to delete");
-					}
-				} else
-					update_ref("update by push", rs.dst,
-						ref->new_sha1, NULL, 0, 0);
-				free(rs.dst);
-			}
-		}
 	}
 
 	packet_flush(out);
@@ -330,6 +343,11 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 			ret = -4;
 	}
 
+	if (remote && ret == 0) {
+		for (ref = remote_refs; ref; ref = ref->next)
+			update_tracking_ref(remote, ref);
+	}
+
 	if (!new_refs && ret == 0)
 		fprintf(stderr, "Everything up-to-date\n");
 	return ret;
-- 
1.5.3.4.1162.gc3e8e-dirty
