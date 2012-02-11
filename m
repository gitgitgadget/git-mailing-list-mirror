From: mhagger@alum.mit.edu
Subject: [PATCH 2/7] clone.c: move more code into the "if (refs)" conditional
Date: Sat, 11 Feb 2012 07:20:56 +0100
Message-ID: <1328941261-29746-3-git-send-email-mhagger@alum.mit.edu>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 07:21:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw6Kw-0001hy-46
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 07:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab2BKGVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 01:21:25 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50475 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab2BKGVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 01:21:23 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED675.dip.t-dialin.net [84.190.214.117])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B6L6CC019131;
	Sat, 11 Feb 2012 07:21:11 +0100
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190486>

From: Michael Haggerty <mhagger@alum.mit.edu>

The bahavior of a bunch of code before the "if (refs)" statement also
depends on whether refs is set, so make the logic clearer by shifting
this code into the if statement.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/clone.c |   39 ++++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c62d4b5..279fdf0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -813,28 +813,28 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	refs = transport_get_remote_refs(transport);
-	mapped_refs = refs ? wanted_peer_refs(refs, refspec) : NULL;
 
-	/*
-	 * transport_get_remote_refs() may return refs with null sha-1
-	 * in mapped_refs (see struct transport->get_refs_list
-	 * comment). In that case we need fetch it early because
-	 * remote_head code below relies on it.
-	 *
-	 * for normal clones, transport_get_remote_refs() should
-	 * return reliable ref set, we can delay cloning until after
-	 * remote HEAD check.
-	 */
-	for (ref = refs; ref; ref = ref->next)
-		if (is_null_sha1(ref->old_sha1)) {
-			complete_refs_before_fetch = 0;
-			break;
-		}
+	if (refs) {
+		mapped_refs = wanted_peer_refs(refs, refspec);
+		/*
+		 * transport_get_remote_refs() may return refs with null sha-1
+		 * in mapped_refs (see struct transport->get_refs_list
+		 * comment). In that case we need fetch it early because
+		 * remote_head code below relies on it.
+		 *
+		 * for normal clones, transport_get_remote_refs() should
+		 * return reliable ref set, we can delay cloning until after
+		 * remote HEAD check.
+		 */
+		for (ref = refs; ref; ref = ref->next)
+			if (is_null_sha1(ref->old_sha1)) {
+				complete_refs_before_fetch = 0;
+				break;
+			}
 
-	if (!is_local && !complete_refs_before_fetch && refs)
-		transport_fetch_refs(transport, mapped_refs);
+		if (!is_local && !complete_refs_before_fetch)
+			transport_fetch_refs(transport, mapped_refs);
 
-	if (refs) {
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =
 			guess_remote_head(remote_head, mapped_refs, 0);
@@ -852,6 +852,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 	else {
 		warning(_("You appear to have cloned an empty repository."));
+		mapped_refs = NULL;
 		our_head_points_at = NULL;
 		remote_head_points_at = NULL;
 		remote_head = NULL;
-- 
1.7.9
