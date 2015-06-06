From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 2/9] ref-filter: implement '--points-at' option
Date: Sun,  7 Jun 2015 01:34:05 +0530
Message-ID: <1433621052-5588-2-git-send-email-karthik.188@gmail.com>
References: <5573520A.90603@gmail.com>
 <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 22:04:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KKV-0002Lu-Tx
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 22:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbbFFUEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 16:04:25 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34100 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbbFFUEX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 16:04:23 -0400
Received: by pdbki1 with SMTP id ki1so74085074pdb.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ifflPiBjn/977PNwbPqxBii0GUKbpZhX6EIzhtytgk0=;
        b=SgmumTbg8eGSEgmYT//WO3WkdDMg9BV4ac9RssALdRIJYn/3HXVq9gLgHdzp7YbsQx
         Vm9rWTwcm8gMIUUBDt/FUrRSgjcmkDSrnEoaJxxefvyzLb+cuV1K/IzKm02A4IfH3pmh
         5ihiJDndClcfymfd+4EXcfvCUOEHDFPo1m7wcLlnEyT1WHOn6jpowflTBf6sNMIa5KF5
         hrgIRPg0cuK8SYa3anDtcKqJ1sKfkixOWTc6MC1RKNsl0RAJafF/arlxgb5j1TxCVEnQ
         1QFhLkfh/StKdr+SLEB8+oT55irA7q4O9r3Fl2dB+LYmsiroGoUXjikkoXQ2mduHFfax
         klFg==
X-Received: by 10.68.131.41 with SMTP id oj9mr16617760pbb.39.1433621062562;
        Sat, 06 Jun 2015 13:04:22 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id q5sm10333703pde.56.2015.06.06.13.04.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 13:04:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270945>

In 'tag -l' we have '--points-at' option which lets users
list only tags which point to a particular commit, Implement
this option in 'ref-filter.{c,h}' so that the other commands
can benefit from this.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 26 ++++++++++++++++++++++++++
 ref-filter.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 745d3b3..456b0fa 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -841,6 +841,29 @@ static int match_name_as_path(const char **pattern, const char *refname)
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
@@ -874,6 +897,9 @@ int ref_filter_handler(const char *refname, const struct object_id *oid, int fla
 	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
 		return 0;
 
+	if (!match_points_at(&filter->points_at, oid->hash, refname))
+		return 0;
+
 	/*
 	 * We do not open the object yet; sort may only need refname
 	 * to do its job and the resulting list may yet to be pruned
diff --git a/ref-filter.h b/ref-filter.h
index 041a39a..a8980e7 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -39,6 +39,7 @@ struct ref_array {
 
 struct ref_filter {
 	const char **name_patterns;
+	struct sha1_array points_at;
 };
 
 struct ref_filter_cbdata {
-- 
2.4.2
