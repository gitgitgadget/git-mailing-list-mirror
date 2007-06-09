From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] remote.c: refactor match_explicit_refs()
Date: Sat,  9 Jun 2007 02:21:32 -0700
Message-ID: <11813808962261-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 11:21:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwx8d-0000mL-Mq
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 11:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbXFIJVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 05:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbXFIJVi
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 05:21:38 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53921 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbXFIJVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 05:21:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609092135.TVDQ25947.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sat, 9 Jun 2007 05:21:35 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9MMc1X00J1kojtg0000000; Sat, 09 Jun 2007 05:21:36 -0400
X-Mailer: git-send-email 1.5.2.1.144.gabc40
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49561>

This does not change functionality; just splits one block that
is deeply nested and indented out of a huge loop into a separate
function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c |  159 +++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 86 insertions(+), 73 deletions(-)

diff --git a/remote.c b/remote.c
index 33c8e50..b53130f 100644
--- a/remote.c
+++ b/remote.c
@@ -406,90 +406,98 @@ static struct ref *try_explicit_object_name(const char *name)
 	return ref;
 }
 
-static int match_explicit_refs(struct ref *src, struct ref *dst,
-			       struct ref ***dst_tail, struct refspec *rs,
-			       int rs_nr)
+static int match_explicit(struct ref *src, struct ref *dst,
+			  struct ref ***dst_tail,
+			  struct refspec *rs,
+			  int errs)
 {
-	int i, errs;
-	for (i = errs = 0; i < rs_nr; i++) {
-		struct ref *matched_src, *matched_dst;
+	struct ref *matched_src, *matched_dst;
 
-		const char *dst_value = rs[i].dst;
+	const char *dst_value = rs->dst;
 
-		if (rs[i].pattern)
-			continue;
+	if (rs->pattern)
+		return errs;
 
-		if (dst_value == NULL)
-			dst_value = rs[i].src;
+	if (dst_value == NULL)
+		dst_value = rs->src;
 
-		matched_src = matched_dst = NULL;
-		switch (count_refspec_match(rs[i].src, src, &matched_src)) {
-		case 1:
-			break;
-		case 0:
-			/* The source could be in the get_sha1() format
-			 * not a reference name.  :refs/other is a
-			 * way to delete 'other' ref at the remote end.
-			 */
-			matched_src = try_explicit_object_name(rs[i].src);
-			if (matched_src)
-				break;
-			errs = 1;
-			error("src refspec %s does not match any.",
-			      rs[i].src);
-			break;
-		default:
-			errs = 1;
-			error("src refspec %s matches more than one.",
-			      rs[i].src);
-			break;
-		}
-		switch (count_refspec_match(dst_value, dst, &matched_dst)) {
-		case 1:
-			break;
-		case 0:
-			if (!memcmp(dst_value, "refs/", 5)) {
-				int len = strlen(dst_value) + 1;
-				matched_dst = xcalloc(1, sizeof(*dst) + len);
-				memcpy(matched_dst->name, dst_value, len);
-				link_dst_tail(matched_dst, dst_tail);
-			}
-			else if (!strcmp(rs[i].src, dst_value) &&
-				 matched_src) {
-				/* pushing "master:master" when
-				 * remote does not have master yet.
-				 */
-				int len = strlen(matched_src->name) + 1;
-				matched_dst = xcalloc(1, sizeof(*dst) + len);
-				memcpy(matched_dst->name, matched_src->name,
-				       len);
-				link_dst_tail(matched_dst, dst_tail);
-			}
-			else {
-				errs = 1;
-				error("dst refspec %s does not match any "
-				      "existing ref on the remote and does "
-				      "not start with refs/.", dst_value);
-			}
-			break;
-		default:
-			errs = 1;
-			error("dst refspec %s matches more than one.",
-			      dst_value);
+	matched_src = matched_dst = NULL;
+	switch (count_refspec_match(rs->src, src, &matched_src)) {
+	case 1:
+		break;
+	case 0:
+		/* The source could be in the get_sha1() format
+		 * not a reference name.  :refs/other is a
+		 * way to delete 'other' ref at the remote end.
+		 */
+		matched_src = try_explicit_object_name(rs->src);
+		if (matched_src)
 			break;
+		errs = 1;
+		error("src refspec %s does not match any.",
+		      rs->src);
+		break;
+	default:
+		errs = 1;
+		error("src refspec %s matches more than one.",
+		      rs->src);
+		break;
+	}
+	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
+	case 1:
+		break;
+	case 0:
+		if (!memcmp(dst_value, "refs/", 5)) {
+			int len = strlen(dst_value) + 1;
+			matched_dst = xcalloc(1, sizeof(*dst) + len);
+			memcpy(matched_dst->name, dst_value, len);
+			link_dst_tail(matched_dst, dst_tail);
 		}
-		if (errs)
-			continue;
-		if (matched_dst->peer_ref) {
-			errs = 1;
-			error("dst ref %s receives from more than one src.",
-			      matched_dst->name);
+		else if (!strcmp(rs->src, dst_value) &&
+			 matched_src) {
+			/* pushing "master:master" when
+			 * remote does not have master yet.
+			 */
+			int len = strlen(matched_src->name) + 1;
+			matched_dst = xcalloc(1, sizeof(*dst) + len);
+			memcpy(matched_dst->name, matched_src->name,
+			       len);
+			link_dst_tail(matched_dst, dst_tail);
 		}
 		else {
-			matched_dst->peer_ref = matched_src;
-			matched_dst->force = rs[i].force;
+			errs = 1;
+			error("dst refspec %s does not match any "
+			      "existing ref on the remote and does "
+			      "not start with refs/.", dst_value);
 		}
+		break;
+	default:
+		errs = 1;
+		error("dst refspec %s matches more than one.",
+		      dst_value);
+		break;
+	}
+	if (errs)
+		return errs;
+	if (matched_dst->peer_ref) {
+		errs = 1;
+		error("dst ref %s receives from more than one src.",
+		      matched_dst->name);
 	}
+	else {
+		matched_dst->peer_ref = matched_src;
+		matched_dst->force = rs->force;
+	}
+	return errs;
+}
+
+static int match_explicit_refs(struct ref *src, struct ref *dst,
+			       struct ref ***dst_tail, struct refspec *rs,
+			       int rs_nr)
+{
+	int i, errs;
+	for (i = errs = 0; i < rs_nr; i++)
+		errs |= match_explicit(src, dst, dst_tail, &rs[i], errs);
 	return -errs;
 }
 
@@ -513,6 +521,11 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 	return NULL;
 }
 
+/*
+ * Note. This is used only by "push"; refspec matching rules for
+ * push and fetch are subtly different, so do not try to reuse it
+ * without thinking.
+ */
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, char **refspec, int all)
 {
-- 
1.5.2.1.144.gabc40
