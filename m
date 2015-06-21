From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 03/19] ref-filter: implement '--points-at' option
Date: Mon, 22 Jun 2015 02:18:17 +0530
Message-ID: <1434919705-4884-3-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 22:48:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6mAb-0005Lr-7Z
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbbFUUsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:48:46 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:32883 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbbFUUso (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:48:44 -0400
Received: by pdjn11 with SMTP id n11so124852523pdj.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gITxATMxYhW19hK+/VwP2jL5WWNfpwTplqhnv3oGPDs=;
        b=ORCHajsqdMgidwZHG6bH3mPUTv1fsjVSC1RIhaKkFCk+12D06zWtvROQWusrD7UNpn
         YjbFG8rQ21VH+/I4s3iuzBtyxzfssE5MisAf9eYEI7hErwwzo3Qh77OdDdavjaodDfHg
         aNlfeOyUYD0ERY9Z1EAkCCEYjLTr2hc223vjk3/FYIfHgIM1PWO0+tJmDQ3UERdXqgkW
         T8vNBherlxCiM6iXyBSwjR+5s5gvIPbWM5V3SIlm4d99MYRWnfVbQumYY0koWak+Bppl
         Ex3Z4+MoZ7r39BvCB1tlOVsG2f5Kq/rfiQOeRaMUAWzIzfFUxUaAVufwjXRkXxcas8Gu
         w81g==
X-Received: by 10.68.65.66 with SMTP id v2mr53127729pbs.9.1434919724041;
        Sun, 21 Jun 2015 13:48:44 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm17519488pda.54.2015.06.21.13.48.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jun 2015 13:48:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272289>

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
2.4.3.439.gfea0c2a.dirty
