From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 4/9] ref-filter: add support to sort by version
Date: Thu, 25 Jun 2015 17:13:11 +0530
Message-ID: <1435232596-27466-4-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 13:44:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z85Zd-0006Tf-Cw
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 13:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbbFYLoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 07:44:00 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34515 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbFYLoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 07:44:00 -0400
Received: by pabvl15 with SMTP id vl15so48646977pab.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IROyuw7VN0X2dTx+ZIFqXV/2MLJCEz0wG+sTfO1GFd8=;
        b=YaMjiKxt9WEitsr9LuikeeCGIphAHOkcNEIFmlQBLk9Zq+jsZlL1aYJkuIiD1GSNYH
         Ca9sWk9NCrG/B6+4uZVIO01Q6ptM9S2zkyg+JGmL+cIJ5NH4GLM0bYSmX5U7ckzOCXQ0
         826RRAsY/45kOY05MnN0GCo1PNSbg+NuQMVmg5y/4fPFGjlbfk0nm5TJwE55dCeUzvcB
         OCegVw0ZoYcS5AMqz0uXWJbMualOB7jOeOinQkNKDIpmfZOQU8SPcbC+YDJoCAcz5v0A
         8f7cnTui4b1utet9IlQZojvJjYlX16adg4iLaQPLzdeNlK2ch8jz7EPmt1rgE60ELrOT
         7gjg==
X-Received: by 10.66.65.195 with SMTP id z3mr53602100pas.6.1435232639688;
        Thu, 25 Jun 2015 04:43:59 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id xn2sm11575446pbc.44.2015.06.25.04.43.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 04:43:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272662>

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
index 57a5cfb..e307fab 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -10,8 +10,9 @@
 #include "quote.h"
 #include "ref-filter.h"
 #include "revision.h"
+#include "version.h"
 
-typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
+typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME, FIELD_VER } cmp_type;
 
 static struct {
 	const char *name;
@@ -53,6 +54,8 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "version", FIELD_VER },
+	{ "v", FIELD_VER },
 };
 
 /*
@@ -629,7 +632,9 @@ static void populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (starts_with(name, "refname"))
+		if (starts_with(name, "refname") ||
+		    starts_with(name, "version:") ||
+		    starts_with(name, "v:"))
 			refname = ref->refname;
 		else if (starts_with(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
@@ -695,7 +700,13 @@ static void populate_value(struct ref_array_item *ref)
 			int num_ours, num_theirs;
 
 			formatp++;
-			if (starts_with(formatp, "lalign")) {
+			if (starts_with(name, "version") || starts_with(name, "v")) {
+				if (strcmp(formatp, "refname"))
+					die("unknown %.*s format %s",
+					    (int)(formatp - name), name, formatp);
+				v->s = refname;
+				continue;
+			} else if (starts_with(formatp, "lalign")) {
 				const char *valp;
 				int val;
 
@@ -1165,6 +1176,9 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
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
2.4.4
