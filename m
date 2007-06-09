From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] remote.c: refactor creation of new dst ref
Date: Sat,  9 Jun 2007 02:21:33 -0700
Message-ID: <11813808961403-git-send-email-gitster@pobox.com>
References: <11813808962261-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 11:22:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwx92-0000t8-OQ
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 11:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbXFIJVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 05:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbXFIJVj
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 05:21:39 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44560 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbXFIJVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 05:21:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609092137.PTXS7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sat, 9 Jun 2007 05:21:37 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9MMc1X00J1kojtg0000100; Sat, 09 Jun 2007 05:21:36 -0400
X-Mailer: git-send-email 1.5.2.1.144.gabc40
In-Reply-To: <11813808962261-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49565>

This refactors open-coded sequence to create a new "struct ref"
and link it to the tail of dst list into a new function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/remote.c b/remote.c
index b53130f..f469fb3 100644
--- a/remote.c
+++ b/remote.c
@@ -406,6 +406,18 @@ static struct ref *try_explicit_object_name(const char *name)
 	return ref;
 }
 
+static struct ref *make_dst(const char *name, struct ref ***dst_tail)
+{
+	struct ref *dst;
+	size_t len;
+
+	len = strlen(name) + 1;
+	dst = xcalloc(1, sizeof(*dst) + len);
+	memcpy(dst->name, name, len);
+	link_dst_tail(dst, dst_tail);
+	return dst;
+}
+
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec *rs,
@@ -447,23 +459,13 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 1:
 		break;
 	case 0:
-		if (!memcmp(dst_value, "refs/", 5)) {
-			int len = strlen(dst_value) + 1;
-			matched_dst = xcalloc(1, sizeof(*dst) + len);
-			memcpy(matched_dst->name, dst_value, len);
-			link_dst_tail(matched_dst, dst_tail);
-		}
-		else if (!strcmp(rs->src, dst_value) &&
-			 matched_src) {
+		if (!memcmp(dst_value, "refs/", 5))
+			matched_dst = make_dst(dst_value, dst_tail);
+		else if (!strcmp(rs->src, dst_value) && matched_src)
 			/* pushing "master:master" when
 			 * remote does not have master yet.
 			 */
-			int len = strlen(matched_src->name) + 1;
-			matched_dst = xcalloc(1, sizeof(*dst) + len);
-			memcpy(matched_dst->name, matched_src->name,
-			       len);
-			link_dst_tail(matched_dst, dst_tail);
-		}
+			matched_dst = make_dst(matched_src->name, dst_tail);
 		else {
 			errs = 1;
 			error("dst refspec %s does not match any "
@@ -567,11 +569,8 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			goto free_name;
 		if (!dst_peer) {
 			/* Create a new one and link it */
-			int len = strlen(dst_name) + 1;
-			dst_peer = xcalloc(1, sizeof(*dst_peer) + len);
-			memcpy(dst_peer->name, dst_name, len);
+			dst_peer = make_dst(dst_name, dst_tail);
 			hashcpy(dst_peer->new_sha1, src->new_sha1);
-			link_dst_tail(dst_peer, dst_tail);
 		}
 		dst_peer->peer_ref = src;
 	free_name:
-- 
1.5.2.1.144.gabc40
