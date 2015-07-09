From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Thu,  9 Jul 2015 15:57:42 +0530
Message-ID: <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 12:28:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD947-0003al-J3
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 12:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbbGIK2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 06:28:09 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33119 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbbGIK1z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 06:27:55 -0400
Received: by pacws9 with SMTP id ws9so150035671pac.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kcx6mpE3r8i83bMRcooBA45HTz9/qd73huawx71w3sI=;
        b=svIEQCAF+7R2+2v0Iq/uxX3NOmQt8dABo5z3sxwA2Y6jwnVRu8OfSbpoznnJVhIMN5
         nbIag9LhK3mfnnImTWP/ArACc00U8yHhVCX0nw+HSHyAp4Je7WK7sLJB2HVYl7p0knJ2
         7UyNiRRZhus3kKhxU2aLe+MJ7Y3Xk32wkMAj4uoEREVlnHFdRM//uo1wdS80DqiKeFkU
         Z/YwW70rS/0BDZ75DjfiLHYki1JnfEry4JSY0SchA6Xo8N0wyedwV0L4bm4avaG4C5d0
         3U1zvGpassdmQZ3SCQh43+bPZkiaDyqGh41+3n+YFZ4XGsuWyYrTHdNoLVUX/vbS/538
         fOQA==
X-Received: by 10.68.109.67 with SMTP id hq3mr29531250pbb.83.1436437675009;
        Thu, 09 Jul 2015 03:27:55 -0700 (PDT)
Received: from ashley.localdomain ([49.201.133.206])
        by smtp.gmail.com with ESMTPSA id b10sm5449836pdo.84.2015.07.09.03.27.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 03:27:54 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273732>

Add support for %(refname:shortalign=X) where X is a number.
This will print a shortened refname aligned to the left
followed by spaces for a total length of X characters.
If X is less than the shortened refname size, the entire
shortened refname is printed.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index dd0709d..3098497 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,6 +10,7 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "utf8.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -695,7 +696,23 @@ static void populate_value(struct ref_array_item *ref)
 			int num_ours, num_theirs;
 
 			formatp++;
-			if (!strcmp(formatp, "short"))
+			if (starts_with(formatp, "shortalign=")) {
+				const char *valp, *short_refname = NULL;
+				int val, len;
+
+				skip_prefix(formatp, "shortalign=", &valp);
+				val = atoi(valp);
+				refname = short_refname = shorten_unambiguous_ref(refname,
+										  warn_ambiguous_refs);
+				len = utf8_strwidth(refname);
+				if (val > len) {
+					struct strbuf buf = STRBUF_INIT;
+					strbuf_addstr(&buf, refname);
+					strbuf_addchars(&buf, ' ', val - len);
+					free((char *)short_refname);
+					refname = strbuf_detach(&buf, NULL);
+				}
+			} else if (!strcmp(formatp, "short"))
 				refname = shorten_unambiguous_ref(refname,
 						      warn_ambiguous_refs);
 			else if (!strcmp(formatp, "track") &&
-- 
2.4.5
