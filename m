From: Nelson Elhage <nelhage@MIT.EDU>
Subject: [PATCH] Always output a trailing space conflicted merge markers.
Date: Mon, 29 Jun 2009 20:41:01 -0400
Message-ID: <1246322461-24742-1-git-send-email-nelhage@mit.edu>
Cc: Nelson Elhage <nelhage@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 02:41:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLRPy-00018Z-Jr
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 02:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbZF3AlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 20:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbZF3AlS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 20:41:18 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:55121 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751680AbZF3AlR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 20:41:17 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n5U0fIJ6029058;
	Mon, 29 Jun 2009 20:41:18 -0400 (EDT)
Received: from LUNATIQUE.MIT.EDU (dhcp-18-111-28-78.dyn.mit.edu [18.111.28.78])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n5U0fHYi013325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 29 Jun 2009 20:41:17 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.3
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122479>

Some tools, such as emacs' smerge-mode, except that diff3-style merge
conflict markers always include a trailing space (and optional
description) after the marker, and so fail to correctly detect
git's (notably the '|||||||' base marker, for which git never outputs a
trailing space).

(See http://emacsbugs.donarmstrong.com/cgi-bin/bugreport.cgi?bug=3553
for the emacs issue)

Signed-off-by: Nelson Elhage <nelhage@mit.edu>
---
 xdiff/xmerge.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 1cb65a9..a4baba8 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -148,8 +148,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      xdmerge_t *m, char *dest)
 {
 	const int marker_size = 7;
-	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
-	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
+	int marker1_size = (name1 ? strlen(name1) + 1 : 1);
+	int marker2_size = (name2 ? strlen(name2) + 1 : 1);
 	int j;
 
 	/* Before conflicting part */
@@ -165,6 +165,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			dest[size] = ' ';
 			memcpy(dest + size + 1, name1, marker1_size - 1);
 			size += marker1_size;
+		} else {
+			dest[size++] = ' ';
 		}
 		dest[size++] = '\n';
 	}
@@ -176,10 +178,11 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	if (style == XDL_MERGE_DIFF3) {
 		/* Shared preimage */
 		if (!dest) {
-			size += marker_size + 1;
+			size += marker_size + 2;
 		} else {
 			for (j = 0; j < marker_size; j++)
 				dest[size++] = '|';
+			dest[size++] = ' ';
 			dest[size++] = '\n';
 		}
 		size += xdl_orig_copy(xe1, m->i0, m->chg0, 1,
@@ -206,6 +209,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			dest[size] = ' ';
 			memcpy(dest + size + 1, name2, marker2_size - 1);
 			size += marker2_size;
+		} else {
+			dest[size++] = ' ';
 		}
 		dest[size++] = '\n';
 	}
-- 
1.6.3.3
