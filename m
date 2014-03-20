From: George Papanikolaou <g3orge.app@gmail.com>
Subject: [PATCH] builtin/apply.c: fuzzy_matchlines:trying to fix some inefficiencies
Date: Thu, 20 Mar 2014 03:32:47 +0200
Message-ID: <1395279167-20354-1-git-send-email-g3orge.app@gmail.com>
Cc: git@vger.kernel.org, George Papanikolaou <g3orge.app@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 20 02:39:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQRwt-0001qN-32
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 02:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbaCTBjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 21:39:06 -0400
Received: from poseidon.ceid.upatras.gr ([150.140.141.169]:54645 "EHLO
	poseidon.ceid.upatras.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbaCTBjF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 21:39:05 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Mar 2014 21:39:04 EDT
Received: from mail.ceid.upatras.gr (mail.ceid.upatras.gr [10.1.0.174])
	by poseidon.ceid.upatras.gr (Postfix) with ESMTP id 12D9280499;
	Thu, 20 Mar 2014 03:30:25 +0200 (EET)
Received: from localhost (ppp089210130219.access.hol.gr [89.210.130.219])
	(Authenticated sender: papanikge)
	by mail.ceid.upatras.gr (Postfix) with ESMTPSA id 7AE241FF72;
	Thu, 20 Mar 2014 03:30:21 +0200 (EET)
X-Mailer: git-send-email 1.9.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,UNPARSEABLE_RELAY autolearn=no version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mtax.ceid.upatras.gr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244515>

Hi fellows,
I'm planning on applying on GSOC 2014...

I tried my luck with that kinda weird microproject about inefficiencies,
and I think I've discovered some.

(also on a totally different mood, there are some warning about empty format
strings during compilation that could easily be silenced with some #pragma
calls on "-Wformat-zero-length". Is there a way you're not adding this?)

The empty buffers check could happen at the beggining.
Leading whitespace check was unnecessary.
Some style changes

Thanks.
---
 builtin/apply.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b0d0986..df2435f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -294,20 +294,16 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
 	const char *last2 = s2 + n2 - 1;
 	int result = 0;
 
+	/* early return if both lines are empty */
+	if ((s1 > last1) && (s2 > last2))
+		return 1;
+
 	/* ignore line endings */
 	while ((*last1 == '\r') || (*last1 == '\n'))
 		last1--;
 	while ((*last2 == '\r') || (*last2 == '\n'))
 		last2--;
 
-	/* skip leading whitespace */
-	while (isspace(*s1) && (s1 <= last1))
-		s1++;
-	while (isspace(*s2) && (s2 <= last2))
-		s2++;
-	/* early return if both lines are empty */
-	if ((s1 > last1) && (s2 > last2))
-		return 1;
 	while (!result) {
 		result = *s1++ - *s2++;
 		/*
@@ -315,18 +311,15 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
 		 * both buffers because we don't want "a b" to match
 		 * "ab"
 		 */
-		if (isspace(*s1) && isspace(*s2)) {
-			while (isspace(*s1) && s1 <= last1)
-				s1++;
-			while (isspace(*s2) && s2 <= last2)
-				s2++;
-		}
+		while (isspace(*s1) && s1 <= last1)
+			s1++;
+		while (isspace(*s2) && s2 <= last2)
+			s2++;
 		/*
 		 * If we reached the end on one side only,
 		 * lines don't match
 		 */
-		if (
-		    ((s2 > last2) && (s1 <= last1)) ||
+		if (((s2 > last2) && (s1 <= last1)) ||
 		    ((s1 > last1) && (s2 <= last2)))
 			return 0;
 		if ((s1 > last1) && (s2 > last2))
-- 
1.9.0
