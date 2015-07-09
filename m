From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 04/10] ref-filter: add support to sort by version
Date: Thu,  9 Jul 2015 15:57:45 +0530
Message-ID: <1436437671-25600-4-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 12:28:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD94M-0003kh-3Y
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 12:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbbGIK2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 06:28:36 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36693 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbbGIK2H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 06:28:07 -0400
Received: by pdjr16 with SMTP id r16so1969750pdj.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 03:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dm9wBDR8iu+IBW1clUp9OCPcP5WclRLxTHHQygwrIh0=;
        b=dOozsku8erZpPiA/BOzC36Ri1QKxtqKaPfaVx8+Uweviu+gj5nlrz3iZ2B9/zpdjun
         fBY2tIbG302WsS9KgOzdvzUQOTV8/mpc4YuHlERG+GTjG8dYFUUEmzWHZz8ZB8EKfoGW
         FY/YbniUPInYwdQwb55oxgYTuIRIRep13Mq+vCKqZXu2APSDS2BYcWEgxq8HOSWK71PQ
         t1w5sgYvP4qnRcFmthuCljHnomgqrP4rrkLu4Hr5kkBQj2D2uwJQdJwacGiP3K+uql03
         SGOpAoE7fRMqXcEZS/0TqiumiANPSKdSqqHDaHor7CTSJRXYb0kUkJiao1n4BuzusHjT
         t59g==
X-Received: by 10.70.49.43 with SMTP id r11mr29553715pdn.91.1436437686515;
        Thu, 09 Jul 2015 03:28:06 -0700 (PDT)
Received: from ashley.localdomain ([49.201.133.206])
        by smtp.gmail.com with ESMTPSA id b10sm5449836pdo.84.2015.07.09.03.28.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 03:28:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273735>

Add support to sort by version using the "v:refname" and
"version:refname" option. This is achieved by using the
'version_cmp()' function as the comparing function for qsort.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1b088b1..1516cd1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -11,8 +11,9 @@
 #include "ref-filter.h"
 #include "revision.h"
 #include "utf8.h"
+#include "version.h"
 
-typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
+typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME, FIELD_VER } cmp_type;
 
 static struct {
 	const char *name;
@@ -54,6 +55,8 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "version", FIELD_VER },
+	{ "v", FIELD_VER },
 };
 
 /*
@@ -630,7 +633,9 @@ static void populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (starts_with(name, "refname"))
+		if (starts_with(name, "refname") ||
+		    starts_with(name, "version:") ||
+		    starts_with(name, "v:"))
 			refname = ref->refname;
 		else if (starts_with(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
@@ -696,7 +701,13 @@ static void populate_value(struct ref_array_item *ref)
 			int num_ours, num_theirs;
 
 			formatp++;
-			if (starts_with(formatp, "shortalign=")) {
+			if (starts_with(name, "version") || starts_with(name, "v")) {
+				if (strcmp(formatp, "refname"))
+					die("unknown %.*s format %s",
+					    (int)(formatp - name), name, formatp);
+				v->s = refname;
+				continue;
+			} else if (starts_with(formatp, "shortalign=")) {
 				const char *valp, *short_refname = NULL;
 				int val, len;
 
@@ -1176,6 +1187,9 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	case FIELD_STR:
 		cmp = strcmp(va->s, vb->s);
 		break;
+	case FIELD_VER:
+		cmp = versioncmp(va->s, vb->s);
+		break;
 	default:
 		if (va->ul < vb->ul)
 			cmp = -1;
-- 
2.4.5
