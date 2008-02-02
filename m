From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/13] builtin-apply.c: push match-beginning/end logic down
Date: Sat,  2 Feb 2008 02:54:09 -0800
Message-ID: <1201949659-27725-4-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:55:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG1j-0005A3-6e
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762284AbYBBKyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762252AbYBBKyp
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762201AbYBBKyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B6E1550EE
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0900750ED
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:28 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72247>

This moves the logic to force match at the beginning and/or at
the end of the buffer to the actual function that finds the
match from its caller.  This is a necessary preparation for the
next step to allow matching disregarding certain differences,
such as whitespace changes.

We probably could optimize this even more by taking advantage of
the fact that match_beginning and match_end forces the match to
be at an exact location (anchored at the beginning and/or the
end), but that's for another commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |   46 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 0a304ab..f84a405 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1439,18 +1439,36 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 
 static int match_fragment(const char *buf, unsigned long size,
 			  unsigned long try,
-			  const char *fragment, unsigned long fragsize)
+			  const char *fragment, unsigned long fragsize,
+			  int match_beginning, int match_end)
 {
-	if (try + fragsize > size)
+	if (match_beginning && try)
 		return 0;
-	if (memcmp(buf + try, fragment, fragsize))
-		return 0;
-	return 1;
+
+	/*
+	 * Do we have an exact match?  If we were told to match
+	 * at the end, size must be exactly at try+fragsize,
+	 * otherwise try+fragsize must be still within the preimage,
+	 * and either case, the old piece should match the preimage
+	 * exactly.
+	 */
+	if ((match_end
+	     ? (try + fragsize == size)
+	     : (try + fragsize <= size)) &&
+	    !memcmp(buf + try, fragment, fragsize))
+		return 1;
+
+	/*
+	 * NEEDSWORK: We can optionally match fuzzily here, but
+	 * that is for a later round.
+	 */
+	return 0;
 }
 
 static int find_offset(const char *buf, unsigned long size,
 		       const char *fragment, unsigned long fragsize,
-		       int line, int *lines)
+		       int line, int *lines,
+		       int match_beginning, int match_end)
 {
 	int i, no_more_backwards, no_more_forwards;
 	unsigned long start, backwards, forwards, try;
@@ -1483,7 +1501,8 @@ static int find_offset(const char *buf, unsigned long size,
 		no_more_backwards = !backwards;
 		no_more_forwards = (forwards + fragsize > size);
 
-		if (match_fragment(buf, size, try, fragment, fragsize)) {
+		if (match_fragment(buf, size, try, fragment, fragsize,
+				   match_beginning, match_end)) {
 			int shift = ((i+1) >> 1);
 			if (i & 1)
 				shift = -shift;
@@ -1765,17 +1784,16 @@ static int apply_one_fragment(struct strbuf *buf, struct fragment *frag,
 	pos = frag->newpos;
 	for (;;) {
 		offset = find_offset(buf->buf, buf->len,
-				     oldlines, oldsize, pos, &lines);
-		if (match_end && offset + oldsize != buf->len)
-			offset = -1;
-		if (match_beginning && offset)
-			offset = -1;
+				     oldlines, oldsize, pos, &lines,
+				     match_beginning, match_end);
 		if (offset >= 0) {
 			if (ws_error_action == correct_ws_error &&
-			    (buf->len - oldsize - offset == 0)) /* end of file? */
+			    (buf->len - oldsize - offset == 0))
+				/* end of file? */
 				newsize -= new_blank_lines_at_end;
 
-			/* Warn if it was necessary to reduce the number
+			/*
+			 * Warn if it was necessary to reduce the number
 			 * of context lines.
 			 */
 			if ((leading != frag->leading) ||
-- 
1.5.4.2.g41ac4
