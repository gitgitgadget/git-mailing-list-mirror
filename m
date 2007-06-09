From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] remote.c: minor clean-up of match_explicit()
Date: Sat,  9 Jun 2007 02:21:34 -0700
Message-ID: <11813808961996-git-send-email-gitster@pobox.com>
References: <11813808962261-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 11:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwx93-0000t8-79
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 11:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbXFIJVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 05:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbXFIJVk
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 05:21:40 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:63908 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbXFIJVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 05:21:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609092137.FPWE14072.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sat, 9 Jun 2007 05:21:37 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9MMc1X00J1kojtg0000200; Sat, 09 Jun 2007 05:21:37 -0400
X-Mailer: git-send-email 1.5.2.1.144.gabc40
In-Reply-To: <11813808962261-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49563>

When checking what ref the source refspec matches, we have no
business setting the default for the destination, so move that
code lower.  Also simplify the result from the code block that
matches the source side by making it set matched_src only upon
unambiguous match.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index f469fb3..30abdbb 100644
--- a/remote.c
+++ b/remote.c
@@ -430,9 +430,6 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	if (rs->pattern)
 		return errs;
 
-	if (dst_value == NULL)
-		dst_value = rs->src;
-
 	matched_src = matched_dst = NULL;
 	switch (count_refspec_match(rs->src, src, &matched_src)) {
 	case 1:
@@ -445,16 +442,22 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		matched_src = try_explicit_object_name(rs->src);
 		if (matched_src)
 			break;
-		errs = 1;
 		error("src refspec %s does not match any.",
 		      rs->src);
 		break;
 	default:
-		errs = 1;
+		matched_src = NULL;
 		error("src refspec %s matches more than one.",
 		      rs->src);
 		break;
 	}
+
+	if (!matched_src)
+		errs = 1;
+
+	if (dst_value == NULL)
+		dst_value = rs->src;
+
 	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
 	case 1:
 		break;
@@ -466,21 +469,19 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			 * remote does not have master yet.
 			 */
 			matched_dst = make_dst(matched_src->name, dst_tail);
-		else {
-			errs = 1;
+		else
 			error("dst refspec %s does not match any "
 			      "existing ref on the remote and does "
 			      "not start with refs/.", dst_value);
-		}
 		break;
 	default:
-		errs = 1;
+		matched_dst = NULL;
 		error("dst refspec %s matches more than one.",
 		      dst_value);
 		break;
 	}
-	if (errs)
-		return errs;
+	if (errs || matched_dst == NULL)
+		return 1;
 	if (matched_dst->peer_ref) {
 		errs = 1;
 		error("dst ref %s receives from more than one src.",
-- 
1.5.2.1.144.gabc40
