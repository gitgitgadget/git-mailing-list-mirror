From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 03/11] ref-filter: implement '--points-at' option
Date: Tue,  7 Jul 2015 21:36:09 +0530
Message-ID: <1436285177-12279-3-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
 <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 18:07:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVOk-0001Ka-D3
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbbGGQHC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:07:02 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36046 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757176AbbGGQHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:07:00 -0400
Received: by pddu5 with SMTP id u5so40694385pdd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XLHsn3L8B8p+T5PwG+JLM/EWZjFDnaF8qWM0IP03yjA=;
        b=oLg1odxjWmSyPQhqIZYE5xjN8eW3kJdkWNU3qnArs9t0zcX9TNb+7RjwO3NyJTCuvs
         xcK3kPlzndvKdROlzYU3HY+Jd+qnMZ5/T9mjTLpzOB2Tgu1sYW9sYZ9l6btRw1EujmRP
         osT2SViRf5gb7RW/lPQ2hRuetR18ZtWKi7HBKoSEZ3PhNHtdO+bFxHjNPgxfaCWib4ET
         H6RXfWhdMfX9J2fMUPhzddECzPFkONWydp/vkbbWiUJHSja0IPvjFAEFYbiqyg2np98m
         nzKUke4MmC2Og4LjWlImCtLNGS4WrgawAb1IOoToHe7+kUeN3s7zKK4OqB1hyuE0ex74
         2bhg==
X-Received: by 10.66.139.138 with SMTP id qy10mr10669317pab.30.1436285220122;
        Tue, 07 Jul 2015 09:07:00 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nt6sm22295515pbc.18.2015.07.07.09.06.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 09:06:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273573>

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
 ref-filter.c  | 35 +++++++++++++++++++++++++++++++++++
 ref-filter.h  |  1 +
 3 files changed, 40 insertions(+)

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
index c4004db..58e532c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -842,6 +842,38 @@ static int match_name_as_path(const char **pattern, const char *refname)
 	return 0;
 }
 
+/*
+ * Given a ref (sha1, refname), check if the ref belongs to the array
+ * of sha1s. If the given ref is a tag, check if the given tag points
+ * at one of the sha1s in the given sha1 array.
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
@@ -880,6 +912,9 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
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
2.4.5
