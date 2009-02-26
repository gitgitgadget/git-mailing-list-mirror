From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] diffcore-pickaxe: micro-optimize has_match() function
Date: Wed, 25 Feb 2009 22:52:04 -0800
Message-ID: <2dbd5fcdfd9da5f8fbbab5b0928b361d8119c97b.1235629933.git.gitster@pobox.com>
References: <cover.1235629933.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 07:54:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lca83-0006C2-SJ
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 07:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbZBZGwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 01:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbZBZGwQ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 01:52:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZBZGwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 01:52:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E75FE1260
	for <git@vger.kernel.org>; Fri, 27 Feb 2009 01:52:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 580B7125F for
 <git@vger.kernel.org>; Fri, 27 Feb 2009 01:52:12 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.91.gf9a36
In-Reply-To: <cover.1235629933.git.gitster@pobox.com>
X-Pobox-Relay-ID: 2970B194-049B-11DE-A8F1-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111531>

When we are looking at an event that creates (or removes) a path, we only
need to see if the created (or removed) blob has an instance of the needle
we are looking for.  There is no need to count, once we know there is one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-pickaxe.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index d27e725..007b39c 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -5,7 +5,8 @@
 #include "diff.h"
 #include "diffcore.h"
 
-static unsigned int count_match(struct diff_filespec *one,
+static unsigned int count_match(int one_or_more,
+				struct diff_filespec *one,
 				const char *needle, unsigned long len,
 				regex_t *regexp)
 {
@@ -30,6 +31,8 @@ static unsigned int count_match(struct diff_filespec *one,
 			data += regmatch.rm_so;
 			if (*data) data++;
 			cnt++;
+			if (one_or_more)
+				break;
 		}
 
 	} else { /* Classic exact string match */
@@ -41,6 +44,8 @@ static unsigned int count_match(struct diff_filespec *one,
 			if (!memcmp(needle, data + offset, len)) {
 				offset += len - 1;
 				cnt++;
+				if (one_or_more)
+					break;
 			}
 		}
 	}
@@ -52,15 +57,15 @@ static int has_match(struct diff_filespec *one,
 		     const char *needle, unsigned long len,
 		     regex_t *regexp)
 {
-	return !!count_match(one, needle, len, regexp);
+	return count_match(1, one, needle, len, regexp);
 }
 
 static int has_different_matches(struct diff_filepair *p,
 				 const char *needle, unsigned long len,
 				 regex_t *regexp)
 {
-	return (count_match(p->one, needle, len, regexp)
-		!= count_match(p->two, needle, len, regexp));
+	return (count_match(0, p->one, needle, len, regexp)
+		!= count_match(0, p->two, needle, len, regexp));
 
 }
 
-- 
1.6.2.rc2.91.gf9a36
