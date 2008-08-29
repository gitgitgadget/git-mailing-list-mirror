From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff: treat -crlf files as binary
Date: Fri, 29 Aug 2008 14:28:20 -0700
Message-ID: <7vfxon4ikr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 23:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZBXA-0003ba-Hv
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 23:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbYH2V20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 17:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756145AbYH2V20
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 17:28:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYH2V2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 17:28:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D6596DEA9;
	Fri, 29 Aug 2008 17:28:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C8E276DEA8; Fri, 29 Aug 2008 17:28:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69646BEC-7611-11DD-BC82-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94329>

The manual advertises that setting "crlf" attribute to false marks the
file as binary.  We should pay attention to this condition in addition
to the "do not diff" attribute (i.e. setting "diff" to false) when
deciding not to show the textual diff.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Strictly speaking any change is backward incompatible, and this is
   certainly one, but I do not think of a good use case to depend on the
   previous behaviour, which was reported as a bug by my coworker.

 diff.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 18fa7a7..258b438 100644
--- a/diff.c
+++ b/diff.c
@@ -1314,36 +1314,46 @@ static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two)
 static void setup_diff_attr_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_diff;
+	static struct git_attr *attr_crlf;
 
-	if (!attr_diff) {
+	if (!attr_diff)
 		attr_diff = git_attr("diff", 4);
-	}
+	if (!attr_crlf)
+		attr_crlf = git_attr("crlf", 4);
 	check[0].attr = attr_diff;
+	check[1].attr = attr_crlf;
 }
 
 static void diff_filespec_check_attr(struct diff_filespec *one)
 {
-	struct git_attr_check attr_diff_check;
+	struct git_attr_check attr_diff_check[2];
 	int check_from_data = 0;
 
 	if (one->checked_attr)
 		return;
 
-	setup_diff_attr_check(&attr_diff_check);
+	setup_diff_attr_check(attr_diff_check);
 	one->is_binary = 0;
 	one->funcname_pattern_ident = NULL;
 
-	if (!git_checkattr(one->path, 1, &attr_diff_check)) {
+	if (!git_checkattr(one->path, 2, attr_diff_check)) {
 		const char *value;
 
-		/* binaryness */
-		value = attr_diff_check.value;
+		/* binaryness; check both "diff" and "crlf" */
+		value = attr_diff_check[0].value;
 		if (ATTR_TRUE(value))
 			;
 		else if (ATTR_FALSE(value))
 			one->is_binary = 1;
-		else
-			check_from_data = 1;
+		else {
+			const char *crlf = attr_diff_check[1].value;
+			if (ATTR_TRUE(crlf))
+				;
+			else if (ATTR_FALSE(crlf))
+				one->is_binary = 1;
+			else
+				check_from_data = 1;
+		}
 
 		/* funcname pattern ident */
 		if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value))
-- 
1.6.0.1.90.g27a6e
