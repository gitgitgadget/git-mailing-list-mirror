From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] send-pack: check ref->status before updating tracking
	refs
Date: Sat, 17 Nov 2007 07:55:15 -0500
Message-ID: <20071117125515.GB23186@sigill.intra.peff.net>
References: <20071117125323.GA23125@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 13:55:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItNCy-0003dy-H3
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 13:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbXKQMzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 07:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXKQMzU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 07:55:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3871 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546AbXKQMzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 07:55:19 -0500
Received: (qmail 3905 invoked by uid 111); 17 Nov 2007 12:55:18 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 07:55:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 07:55:15 -0500
Content-Disposition: inline
In-Reply-To: <20071117125323.GA23125@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65274>

Previously, we manually checked the 'NONE' and 'UPTODATE'
conditions. Now that we have ref->status, we can easily
say "only update if we pushed successfully".

This adds a test for and fixes a regression introduced in
ed31df31 where deleted refs did not have their tracking
branches removed. This was due to a bogus per-ref error test
that is superseded by the more accurate ref->status flag.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-send-pack.c          |   18 +++++-------------
 t/t5404-tracking-branches.sh |    5 +++++
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 90ca2d3..c7d07aa 100644
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
@@ -445,8 +438,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 
 	if (!args.dry_run && remote) {
 		for (ref = remote_refs; ref; ref = ref->next)
-			if (!is_null_sha1(ref->new_sha1))
-				update_tracking_ref(remote, ref);
+			update_tracking_ref(remote, ref);
 	}
 
 	if (!new_refs)
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 799e47e..1493a92 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -45,4 +45,9 @@ test_expect_success 'check tracking branches not updated for failed refs' '
 	test "$(git rev-parse origin/b2)" = "$b2"
 '
 
+test_expect_success 'deleted branches have their tracking branches removed' '
+	git push origin :b1 &&
+	test "$(git rev-parse origin/b1)" = "origin/b1"
+'
+
 test_done
-- 
1.5.3.5.1795.gf2a4e-dirty
