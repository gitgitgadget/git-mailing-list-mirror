From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] match_explicit: hoist refspec lhs checks into their own
 function
Date: Wed, 5 Mar 2014 14:03:21 -0500
Message-ID: <20140305190321.GA11039@sigill.intra.peff.net>
References: <20140305190248.GB31252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry <wipedout@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:03:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLH6G-0003KW-CH
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004AbaCETDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:03:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:33570 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752943AbaCETDX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 14:03:23 -0500
Received: (qmail 17866 invoked by uid 102); 5 Mar 2014 19:03:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Mar 2014 13:03:23 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2014 14:03:21 -0500
Content-Disposition: inline
In-Reply-To: <20140305190248.GB31252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243464>

In preparation for being able to check the left-hand side of
our push refspecs separately, this pulls the examination of
them out into its own function. There should be no behavior
change.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/remote.c b/remote.c
index e41251e..6aa9dd2 100644
--- a/remote.c
+++ b/remote.c
@@ -1096,12 +1096,36 @@ static char *guess_ref(const char *name, struct ref *peer)
 	return strbuf_detach(&buf, NULL);
 }
 
+static int match_explicit_lhs(struct ref *src,
+			      struct refspec *rs,
+			      struct ref **match,
+			      int *allocated_match)
+{
+	switch (count_refspec_match(rs->src, src, match)) {
+	case 1:
+		*allocated_match = 0;
+		return 0;
+	case 0:
+		/* The source could be in the get_sha1() format
+		 * not a reference name.  :refs/other is a
+		 * way to delete 'other' ref at the remote end.
+		 */
+		*match = try_explicit_object_name(rs->src);
+		if (!*match)
+			return error("src refspec %s does not match any.", rs->src);
+		*allocated_match = 1;
+		return 0;
+	default:
+		return error("src refspec %s matches more than one.", rs->src);
+	}
+}
+
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec *rs)
 {
 	struct ref *matched_src, *matched_dst;
-	int copy_src;
+	int allocated_src;
 
 	const char *dst_value = rs->dst;
 	char *dst_guess;
@@ -1110,23 +1134,8 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return 0;
 
 	matched_src = matched_dst = NULL;
-	switch (count_refspec_match(rs->src, src, &matched_src)) {
-	case 1:
-		copy_src = 1;
-		break;
-	case 0:
-		/* The source could be in the get_sha1() format
-		 * not a reference name.  :refs/other is a
-		 * way to delete 'other' ref at the remote end.
-		 */
-		matched_src = try_explicit_object_name(rs->src);
-		if (!matched_src)
-			return error("src refspec %s does not match any.", rs->src);
-		copy_src = 0;
-		break;
-	default:
-		return error("src refspec %s matches more than one.", rs->src);
-	}
+	if (match_explicit_lhs(src, rs, &matched_src, &allocated_src) < 0)
+		return -1;
 
 	if (!dst_value) {
 		unsigned char sha1[20];
@@ -1171,7 +1180,9 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return error("dst ref %s receives from more than one src.",
 		      matched_dst->name);
 	else {
-		matched_dst->peer_ref = copy_src ? copy_ref(matched_src) : matched_src;
+		matched_dst->peer_ref = allocated_src ?
+					matched_src :
+					copy_ref(matched_src);
 		matched_dst->force = rs->force;
 	}
 	return 0;
-- 
1.8.5.2.500.g8060133
