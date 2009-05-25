From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/2] Change xdl_merge to generate output even for null merges
Date: Mon, 25 May 2009 01:21:14 +0100
Message-ID: <1243210874-18451-3-git-send-email-charles@hashpling.org>
References: <1243210874-18451-1-git-send-email-charles@hashpling.org>
 <1243210874-18451-2-git-send-email-charles@hashpling.org>
Cc: Charles Bailey <charles@hashpling.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 02:23:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Ny2-0005dH-Uo
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 02:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbZEYAVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 20:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbZEYAVp
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 20:21:45 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:27347 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754047AbZEYAVp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 20:21:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAMOBGUrUnw6T/2dsb2JhbADMUYQLBQ
Received: from ptb-relay03.plus.net ([212.159.14.147])
  by relay.ptn-ipout02.plus.net with ESMTP; 25 May 2009 01:21:41 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1M8Nwj-0004rQ-65; Mon, 25 May 2009 01:21:41 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n4P0Lef9018500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 May 2009 01:21:40 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n4P0LeCa018499;
	Mon, 25 May 2009 01:21:40 +0100
X-Mailer: git-send-email 1.6.3.1.72.gbd1ec
In-Reply-To: <1243210874-18451-2-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: 4cb5301aad5511b574d1fc9536748da3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119880>

xdl_merge used to have a check to ensure that there was at least
some change in one or other side being merged but this suppressed
output for the degenerate case when base, local and remote
contents were all identical.

Removing this check enables correct output in the degenerate case
and xdl_free_script handles freeing NULL scripts so there is no
need to have the check for these calls.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 xdiff/xmerge.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index d9737f0..9cdc3ac 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -563,23 +563,23 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		return -1;
 	}
 	status = 0;
-	if (xscr1 || xscr2) {
-		if (!xscr1) {
-			result->ptr = xdl_malloc(mf2->size);
-			memcpy(result->ptr, mf2->ptr, mf2->size);
-			result->size = mf2->size;
-		} else if (!xscr2) {
-			result->ptr = xdl_malloc(mf1->size);
-			memcpy(result->ptr, mf1->ptr, mf1->size);
-			result->size = mf1->size;
-		} else {
-			status = xdl_do_merge(&xe1, xscr1, name1,
-					      &xe2, xscr2, name2,
-					      flags, xpp, result);
-		}
-		xdl_free_script(xscr1);
-		xdl_free_script(xscr2);
+
+	if (!xscr1) {
+		result->ptr = xdl_malloc(mf2->size);
+		memcpy(result->ptr, mf2->ptr, mf2->size);
+		result->size = mf2->size;
+	} else if (!xscr2) {
+		result->ptr = xdl_malloc(mf1->size);
+		memcpy(result->ptr, mf1->ptr, mf1->size);
+		result->size = mf1->size;
+	} else {
+		status = xdl_do_merge(&xe1, xscr1, name1,
+					  &xe2, xscr2, name2,
+					  flags, xpp, result);
 	}
+	xdl_free_script(xscr1);
+	xdl_free_script(xscr2);
+
 	xdl_free_env(&xe1);
 	xdl_free_env(&xe2);
 
-- 
1.6.3.1.72.gbd1ec
