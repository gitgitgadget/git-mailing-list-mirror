From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/14] opt_arg(): use convert_i() in implementation
Date: Tue, 17 Mar 2015 17:00:12 +0100
Message-ID: <1426608016-2978-11-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:01:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvT-0001I3-3e
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbbCQQAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:45 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43300 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932413AbbCQQAf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:35 -0400
X-AuditID: 12074414-f797f6d000004084-4d-55084fa22054
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 48.3C.16516.2AF48055; Tue, 17 Mar 2015 12:00:34 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSl023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:33 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqLvInyPU4MF8YYuuK91MFg29V5gt
	bq+Yz2zx+NYEJgcWj7/vPzB5zL1v6XHxkrLH501yASxR3DZJiSVlwZnpefp2CdwZU1feZitY
	xVXx4PlElgbGs+xdjJwcEgImEt+OHGGEsMUkLtxbz9bFyMUhJHCZUeL76xcsEM5JJon3b66y
	glSxCehKLOppZgKxRQTUJCa2HWIBsZkFUiQ6/9wBmyos4CzxfedjsBoWAVWJDyvug8V5BVwk
	1v78zQaxTU7i/PGfzCA2J1D8xZ/XYFcIAfWunTaZbQIj7wJGhlWMcok5pbm6uYmZOcWpybrF
	yYl5ealFuhZ6uZkleqkppZsYIeEjsoPxyEm5Q4wCHIxKPLwNeeyhQqyJZcWVuYcYJTmYlER5
	8zw4QoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8N5xB8rxpiRWVqUW5cOkpDlYlMR5vy1W9xMS
	SE8sSc1OTS1ILYLJynBwKEnw6vgBNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSD
	YiO+GBgdICkeoL2fQNp5iwsSc4GiEK2nGBWlxHnf+AIlBEASGaV5cGNhSeEVozjQl8K8IsAU
	IcQDTChw3a+ABjMBDW5pZwMZXJKIkJJqYNT26z049dLku88yubJrgpunpp9TmGZp4fj21obl
	GVO3PNOxLAmoEpTfzyywTZ7z/jP2D8Iq5abXGc3Kbhnd6gjT27s7VKvhxR2H+hNFlXJV5pK5
	b1YGPZwgGH42xvvD35goGw7rKTfK9ln7FYn5tTNtZDWNK7i+IPDHdIWHMo2P62Ye 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265643>

This shortens the code and avoids the old code's careless truncation
from unsigned long to int.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 6e3f498..77c7acb 100644
--- a/diff.c
+++ b/diff.c
@@ -3366,16 +3366,10 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	if (c == arg_short) {
 		c = *++arg;
 		if (!c)
-			return 1;
-		if (isdigit(c)) {
-			char *end;
-			int n = strtoul(arg, &end, 10);
-			if (*end)
-				return 0;
-			*val = n;
-			return 1;
-		}
-		return 0;
+			return 1; /* optional argument was missing */
+		if (convert_i(arg, 10, val))
+			return 0;
+		return 1;
 	}
 	if (c != '-')
 		return 0;
@@ -3384,16 +3378,10 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	len = eq - arg;
 	if (!len || strncmp(arg, arg_long, len))
 		return 0;
-	if (*eq) {
-		int n;
-		char *end;
-		if (!isdigit(*++eq))
-			return 0;
-		n = strtoul(eq, &end, 10);
-		if (*end)
-			return 0;
-		*val = n;
-	}
+	if (!*eq)
+		return 1; /* '=' and optional argument were missing */
+	if (convert_i(eq + 1, 10, val))
+		return 0;
 	return 1;
 }
 
-- 
2.1.4
