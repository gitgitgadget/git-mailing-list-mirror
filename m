From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 03/11] ref-filter: implement '--points-at' option
Date: Thu,  2 Jul 2015 20:51:02 +0530
Message-ID: <1435850470-5175-3-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 17:22:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAgJc-0000NW-8N
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 17:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbbGBPWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 11:22:09 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36728 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbbGBPVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 11:21:34 -0400
Received: by pdcu2 with SMTP id u2so47647845pdc.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 08:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G6+dnlZQaI+yZsrFsIbYxEJtBO9bCk76piyk3fW+3Mo=;
        b=Nv8q6DEKr712eabhuW+VoIJiJcVT11IeBjcGFP/RDap9s1hMrKw4LPh/RwqEC6AkpH
         mIOOEP6UnkutN3WokY7Yp87/LW3sfUoNH/sFKlSwIsaeKvWBeox0/kn6w10tqcRPOFq4
         n/vscd+C2uKzJNJSemwQFRnN7f10zIye8OgXASj2/bN+g2oR4lAmr4c7PDkWI6t5xhc2
         8Cvo3fGa1H8dpeS3iFo+SVKTNYQ3GVJl7C8Ik1LfWAHC/jMlW56ZkwVMkIFBBJKLi7nv
         r1wOjQkbhw2f6ikqABnTJ3N89tbDDa3OUBu2f0OiE7ak8jKY7PnScYFbyd1zvXDe1Yl8
         xJQw==
X-Received: by 10.68.229.200 with SMTP id ss8mr68032778pbc.150.1435850494253;
        Thu, 02 Jul 2015 08:21:34 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id fu2sm635208pdb.32.2015.07.02.08.21.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 08:21:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273239>

In 'tag -l' we have '--points-at' option which lets users
list only tags of a given object. Implement this option in
'ref-filter.{c,h}' so that other commands can benefit from this.

This is duplicated from tag.c, we will eventually remove that
when we port tag.c to use ref-filter APIs.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/tag.c |  4 ++++
 ref-filter.c  | 34 ++++++++++++++++++++++++++++++++++
 ref-filter.h  |  1 +
 3 files changed, 39 insertions(+)

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
index c4004db..f1f425e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -842,6 +842,37 @@ static int match_name_as_path(const char **pattern, const char *refname)
 	return 0;
 }
 
+/*
+ * Given a ref (sha1, refname), check if the ref belongs to the array
+ * of sha1s. If the given ref is a tag, check if it tags one of the sha1s
+ * the given sha1_array.
+ * NEEDSWORK:
+ * 1. Only a single level of inderection is obtained, we might want to
+ * change this to account for multiple levels (e.g. annotated tags
+ * pointing to annotated tags pointing to a commit.)
+ * 2. As the refs are cached we might know what refname peels to without
+ * the need to parse the object via parse_object(). peel_ref() might be a
+ * more efficient alternative to obtain the pointee.
+ */
+static const unsigned char *match_points_at(struct sha1_array *points_at,
+					    const unsigned char *sha1,
+					    const char *refname)
+{
+	const unsigned char *tagged_sha1 = NULL;
+	struct object *obj;
+
+	if (sha1_array_lookup(points_at, sha1) >= 0)
+		return sha1;
+	obj = parse_object(sha1);
+	if (!obj)
+		die(_("malformed object at '%s'"), refname);
+	if (obj->type == OBJ_TAG)
+		tagged_sha1 = ((struct tag *)obj)->tagged->sha1;
+	if (tagged_sha1 && sha1_array_lookup(points_at, tagged_sha1) >= 0)
+		return tagged_sha1;
+	return NULL;
+}
+
 /* Allocate space for a new ref_array_item and copy the objectname and flag to it */
 static struct ref_array_item *new_ref_array_item(const char *refname,
 						 const unsigned char *objectname,
@@ -880,6 +911,9 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
 		return 0;
 
+	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid->hash, refname))
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
2.4.4
