From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] match_explicit_lhs: allow a "verify only" mode
Date: Wed, 5 Mar 2014 14:03:43 -0500
Message-ID: <20140305190343.GB11039@sigill.intra.peff.net>
References: <20140305190248.GB31252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry <wipedout@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:03:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLH6b-0003hn-OE
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbaCETDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:03:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:33573 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753783AbaCETDp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 14:03:45 -0500
Received: (qmail 17918 invoked by uid 102); 5 Mar 2014 19:03:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Mar 2014 13:03:45 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2014 14:03:43 -0500
Content-Disposition: inline
In-Reply-To: <20140305190248.GB31252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243465>

The match_explicit_lhs function has all of the logic
necessary to verify the refspecs without actually doing any
work. This patch lets callers pass a NULL "match" pointer to
indicate they want a "verify only" operation.

For the most part, we just need to avoid writing to the NULL
pointer. However, we also have to refactor the
try_explicit_object_name sub-function; it indicates success by
allocating and returning a new ref. Instead, we give it an
"out" parameter for the match and return a numeric status.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/remote.c b/remote.c
index 6aa9dd2..b6586c0 100644
--- a/remote.c
+++ b/remote.c
@@ -1031,11 +1031,13 @@ int count_refspec_match(const char *pattern,
 		}
 	}
 	if (!matched) {
-		*matched_ref = matched_weak;
+		if (matched_ref)
+			*matched_ref = matched_weak;
 		return weak_match;
 	}
 	else {
-		*matched_ref = matched;
+		if (matched_ref)
+			*matched_ref = matched;
 		return match;
 	}
 }
@@ -1055,18 +1057,25 @@ static struct ref *alloc_delete_ref(void)
 	return ref;
 }
 
-static struct ref *try_explicit_object_name(const char *name)
+static int try_explicit_object_name(const char *name,
+				    struct ref **match)
 {
 	unsigned char sha1[20];
-	struct ref *ref;
 
-	if (!*name)
-		return alloc_delete_ref();
+	if (!*name) {
+		if (match)
+			*match = alloc_delete_ref();
+		return 0;
+	}
+
 	if (get_sha1(name, sha1))
-		return NULL;
-	ref = alloc_ref(name);
-	hashcpy(ref->new_sha1, sha1);
-	return ref;
+		return -1;
+
+	if (match) {
+		*match = alloc_ref(name);
+		hashcpy((*match)->new_sha1, sha1);
+	}
+	return 0;
 }
 
 static struct ref *make_linked_ref(const char *name, struct ref ***tail)
@@ -1103,17 +1112,18 @@ static int match_explicit_lhs(struct ref *src,
 {
 	switch (count_refspec_match(rs->src, src, match)) {
 	case 1:
-		*allocated_match = 0;
+		if (allocated_match)
+			*allocated_match = 0;
 		return 0;
 	case 0:
 		/* The source could be in the get_sha1() format
 		 * not a reference name.  :refs/other is a
 		 * way to delete 'other' ref at the remote end.
 		 */
-		*match = try_explicit_object_name(rs->src);
-		if (!*match)
+		if (try_explicit_object_name(rs->src, match) < 0)
 			return error("src refspec %s does not match any.", rs->src);
-		*allocated_match = 1;
+		if (allocated_match)
+			*allocated_match = 1;
 		return 0;
 	default:
 		return error("src refspec %s matches more than one.", rs->src);
-- 
1.8.5.2.500.g8060133
