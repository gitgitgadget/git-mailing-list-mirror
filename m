From: mhagger@alum.mit.edu
Subject: [RFC 01/13] check_refname_component(): iterate via index rather than via pointer
Date: Wed, 19 Oct 2011 22:55:04 +0200
Message-ID: <1319057716-28094-2-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:55:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdB6-0003da-7H
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab1JSUzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:55:47 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60887 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab1JSUzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:55:24 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4e-000423-Gy; Wed, 19 Oct 2011 22:49:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183957>

From: Michael Haggerty <mhagger@alum.mit.edu>

This will make later changes easier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 0d74d70..3b41252 100644
--- a/refs.c
+++ b/refs.c
@@ -912,11 +912,11 @@ static inline int bad_ref_char(int ch)
  */
 static int check_refname_component(const char *ref, int flags)
 {
-	const char *cp;
+	int i, len = strlen(ref);
 	char last = '\0';
 
-	for (cp = ref; ; cp++) {
-		char ch = *cp;
+	for (i = 0; i < len; i++) {
+		char ch = ref[i];
 		if (ch == '\0' || ch == '/')
 			break;
 		if (bad_ref_char(ch))
@@ -927,7 +927,7 @@ static int check_refname_component(const char *ref, int flags)
 			return -1; /* Refname contains "@{". */
 		last = ch;
 	}
-	if (cp == ref)
+	if (i == 0)
 		return -1; /* Component has zero length. */
 	if (ref[0] == '.') {
 		if (!(flags & REFNAME_DOT_COMPONENT))
@@ -936,12 +936,12 @@ static int check_refname_component(const char *ref, int flags)
 		 * Even if leading dots are allowed, don't allow "."
 		 * as a component (".." is prevented by a rule above).
 		 */
-		if (ref[1] == '\0')
+		if (i == 1)
 			return -1; /* Component equals ".". */
 	}
-	if (cp - ref >= 5 && !memcmp(cp - 5, ".lock", 5))
+	if (i >= 5 && !memcmp(&ref[i - 5], ".lock", 5))
 		return -1; /* Refname ends with ".lock". */
-	return cp - ref;
+	return i;
 }
 
 int check_refname_format(const char *ref, int flags)
-- 
1.7.7
