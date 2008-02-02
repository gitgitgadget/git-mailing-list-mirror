From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/13] builtin-apply.c: refactor small part that matches context
Date: Sat,  2 Feb 2008 02:54:07 -0800
Message-ID: <1201949659-27725-2-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG1i-0005A3-Gs
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761946AbYBBKyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761830AbYBBKym
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:54:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761722AbYBBKy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8737E50EA
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E48E650E9
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:54:23 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72245>

This moves three "if" conditions out of line from find_offset()
function, which is responsible for finding the matching place in
the preimage to apply the patch.  There is no change in the
logic of the program.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 15432b6..2c052f8 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1437,6 +1437,17 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	}
 }
 
+static int match_fragment(const char *buf, unsigned long size,
+			  unsigned long try,
+			  const char *fragment, unsigned long fragsize)
+{
+	if (try + fragsize > size)
+		return 0;
+	if (memcmp(buf + try, fragment, fragsize))
+		return 0;
+	return 1;
+}
+
 static int find_offset(const char *buf, unsigned long size,
 		       const char *fragment, unsigned long fragsize,
 		       int line, int *lines)
@@ -1461,8 +1472,7 @@ static int find_offset(const char *buf, unsigned long size,
 	}
 
 	/* Exact line number? */
-	if ((start + fragsize <= size) &&
-	    !memcmp(buf + start, fragment, fragsize))
+	if (match_fragment(buf, size, start, fragment, fragsize))
 		return start;
 
 	/*
@@ -1494,9 +1504,7 @@ static int find_offset(const char *buf, unsigned long size,
 			try = forwards;
 		}
 
-		if (try + fragsize > size)
-			continue;
-		if (memcmp(buf + try, fragment, fragsize))
+		if (!match_fragment(buf, size, try, fragment, fragsize))
 			continue;
 		n = (i >> 1)+1;
 		if (i & 1)
-- 
1.5.4.2.g41ac4
