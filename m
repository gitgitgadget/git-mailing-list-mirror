From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/12] xdl_fill_merge_buffer(): separate out a too deeply
 nested function
Date: Fri, 29 Aug 2008 17:42:32 -0700
Message-ID: <1220056963-2352-2-git-send-email-gitster@pobox.com>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:44:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZL-00073m-Q7
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbYH3Amv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbYH3Amu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:42:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbYH3Amu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:42:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 335C457A05
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3E9D057A03 for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:48
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
In-Reply-To: <1220056963-2352-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 920D7C4E-762C-11DD-98C3-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94340>

This simply moves code around to make a separate function that prepares
a single conflicted hunk with markers into the buffer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xmerge.c |  121 ++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 70 insertions(+), 51 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 82b3573..6ffaa4f 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -113,65 +113,84 @@ static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 	return size;
 }
 
-static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
-		xdfenv_t *xe2, const char *name2, xdmerge_t *m, char *dest)
+static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
+			      xdfenv_t *xe2, const char *name2,
+			      int size, int i,
+			      xdmerge_t *m, char *dest)
 {
 	const int marker_size = 7;
 	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
 	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
-	int conflict_marker_size = 3 * (marker_size + 1)
-		+ marker1_size + marker2_size;
-	int size, i1, j;
-
-	for (size = i1 = 0; m; m = m->next) {
-		if (m->mode == 0) {
-			size += xdl_recs_copy(xe1, i1, m->i1 - i1, 0,
-					dest ? dest + size : NULL);
-			if (dest) {
-				for (j = 0; j < marker_size; j++)
-					dest[size++] = '<';
-				if (marker1_size) {
-					dest[size] = ' ';
-					memcpy(dest + size + 1, name1,
-							marker1_size - 1);
-					size += marker1_size;
-				}
-				dest[size++] = '\n';
-			} else
-				size += conflict_marker_size;
-			size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
-					dest ? dest + size : NULL);
-			if (dest) {
-				for (j = 0; j < marker_size; j++)
-					dest[size++] = '=';
-				dest[size++] = '\n';
-			}
-			size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
-					dest ? dest + size : NULL);
-			if (dest) {
-				for (j = 0; j < marker_size; j++)
-					dest[size++] = '>';
-				if (marker2_size) {
-					dest[size] = ' ';
-					memcpy(dest + size + 1, name2,
-							marker2_size - 1);
-					size += marker2_size;
-				}
-				dest[size++] = '\n';
-			}
-		} else if (m->mode == 1)
-			size += xdl_recs_copy(xe1, i1, m->i1 + m->chg1 - i1, 0,
-					dest ? dest + size : NULL);
+	int j;
+
+	/* Before conflicting part */
+	size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
+			      dest ? dest + size : NULL);
+
+	if (!dest) {
+		size += marker_size + 1 + marker1_size;
+	} else {
+		for (j = 0; j < marker_size; j++)
+			dest[size++] = '<';
+		if (marker1_size) {
+			dest[size] = ' ';
+			memcpy(dest + size + 1, name1, marker1_size - 1);
+			size += marker1_size;
+		}
+		dest[size++] = '\n';
+	}
+
+	/* Postimage from side #1 */
+	size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
+			      dest ? dest + size : NULL);
+	if (!dest) {
+		size += marker_size + 1;
+	} else {
+		for (j = 0; j < marker_size; j++)
+			dest[size++] = '=';
+		dest[size++] = '\n';
+	}
+
+	/* Postimage from side #2 */
+	size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
+			      dest ? dest + size : NULL);
+	if (!dest) {
+		size += marker_size + 1 + marker2_size;
+	} else {
+		for (j = 0; j < marker_size; j++)
+			dest[size++] = '>';
+		if (marker2_size) {
+			dest[size] = ' ';
+			memcpy(dest + size + 1, name2, marker2_size - 1);
+			size += marker2_size;
+		}
+		dest[size++] = '\n';
+	}
+	return size;
+}
+
+static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
+		xdfenv_t *xe2, const char *name2, xdmerge_t *m, char *dest)
+{
+	int size, i;
+
+	for (size = i = 0; m; m = m->next) {
+		if (m->mode == 0)
+			size = fill_conflict_hunk(xe1, name1, xe2, name2,
+						  size, i, m, dest);
+		else if (m->mode == 1)
+			size += xdl_recs_copy(xe1, i, m->i1 + m->chg1 - i, 0,
+					      dest ? dest + size : NULL);
 		else if (m->mode == 2)
-			size += xdl_recs_copy(xe2, m->i2 - m->i1 + i1,
-					m->i1 + m->chg2 - i1, 0,
-					dest ? dest + size : NULL);
+			size += xdl_recs_copy(xe2, m->i2 - m->i1 + i,
+					      m->i1 + m->chg2 - i, 0,
+					      dest ? dest + size : NULL);
 		else
 			continue;
-		i1 = m->i1 + m->chg1;
+		i = m->i1 + m->chg1;
 	}
-	size += xdl_recs_copy(xe1, i1, xe1->xdf2.nrec - i1, 0,
-			dest ? dest + size : NULL);
+	size += xdl_recs_copy(xe1, i, xe1->xdf2.nrec - i, 0,
+			      dest ? dest + size : NULL);
 	return size;
 }
 
-- 
1.6.0.1.149.ga4c44
