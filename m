From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 03/11] ref-filter: implement '--points-at' option
Date: Tue, 16 Jun 2015 19:50:49 +0530
Message-ID: <1434464457-10749-3-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 16:25:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4rnL-00069a-At
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691AbbFPOYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 10:24:32 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36646 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115AbbFPOY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:24:28 -0400
Received: by pdjm12 with SMTP id m12so15496934pdj.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Rk1dFPhxUB1Bn2eNhTDfdq4ES2SbcoXADEcWWlOnhY=;
        b=hSmAFFd4CtPPsVAer+k0/gt+Mka7W7le/SEkvz2A2gfUWZBasqD6Tet9Uqr+pU1zMb
         403SUOfpIiRkeVGUztqqnIRbYZmuOnicpG9urmpZbZXTc8vHuaqL+4X0WY8ZLJpZsMkE
         2T59ZpHCI7ndR+TatFHr84bwN+DlgBClg8OOrrODH8jd6G3oM/ecVUp8diM3y8g+GneN
         4X+D89p4KuBcDDoTYTVi0bsOkANE5LbLyMz2Wpmz6joUIv3ZVBtuQgw2IGfrGpSkgEZh
         id4QBHk3sTd9cG0YBwVMQzD0iZsxkZq+4pPRGR4C7A9ARRsdocW27rpCt7yu8f3EhLA4
         El2g==
X-Received: by 10.68.205.33 with SMTP id ld1mr1241319pbc.22.1434464667306;
        Tue, 16 Jun 2015 07:24:27 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm1594145pda.54.2015.06.16.07.24.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 07:24:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.436.g722e2ce.dirty
In-Reply-To: <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271757>

In 'tag -l' we have '--points-at' option which lets users
list only tags which point to a particular commit. Implement
this option in 'ref-filter.{c,h}' so that other commands can
benefit from this.

This is duplicated from tag.c, we will eventually remove that
when we port tag.c to use ref-filter APIs.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/tag.c |  4 ++++
 ref-filter.c  | 26 ++++++++++++++++++++++++++
 ref-filter.h  |  1 +
 3 files changed, 31 insertions(+)

diff --git a/builtin/tag.c b/builtin/tag.c
index e36c43e..280981f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -56,6 +56,10 @@ static int match_pattern(const char **patterns, const char *ref)
 	return 0;
 }
 
+/*
+ * This is currently duplicated in ref-filter.c, and will eventually be
+ * removed as we port tag.c to use the ref-filter APIs.
+ */
 static const unsigned char *match_points_at(const char *refname,
 					    const unsigned char *sha1)
 {
diff --git a/ref-filter.c b/ref-filter.c
index 43502a4..591e281 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -842,6 +842,29 @@ static int match_name_as_path(const char **pattern, const char *refname)
 	return 0;
 }
 
+/*
+ * Given a ref (sha1, refname) see if it points to a one of the sha1s
+ * in a sha1_array.
+ */
+static int match_points_at(struct sha1_array *points_at, const unsigned char *sha1,
+			   const char *refname)
+{
+	struct object *obj;
+
+	if (!points_at || !points_at->nr)
+		return 1;
+
+	if (sha1_array_lookup(points_at, sha1) >= 0)
+		return 1;
+
+	obj = parse_object_or_die(sha1, refname);
+	if (obj->type == OBJ_TAG &&
+	    sha1_array_lookup(points_at, ((struct tag *)obj)->tagged->sha1) >= 0)
+		return 1;
+
+	return 0;
+}
+
 /* Allocate space for a new ref_array_item and copy the objectname and flag to it */
 static struct ref_array_item *new_ref_array_item(const char *refname,
 						 const unsigned char *objectname,
@@ -875,6 +898,9 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
 		return 0;
 
+	if (!match_points_at(&filter->points_at, oid->hash, refname))
+		return 0;
+
 	/*
 	 * We do not open the object yet; sort may only need refname
 	 * to do its job and the resulting list may yet to be pruned
diff --git a/ref-filter.h b/ref-filter.h
index 6997984..c2856b8 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -42,6 +42,7 @@ struct ref_array {
 
 struct ref_filter {
 	const char **name_patterns;
+	struct sha1_array points_at;
 };
 
 struct ref_filter_cbdata {
-- 
2.4.3.436.g722e2ce.dirty
