From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 10/11] for-each-ref: introduce filter_refs()
Date: Sun,  7 Jun 2015 16:06:13 +0530
Message-ID: <1433673373-16441-1-git-send-email-karthik.188@gmail.com>
References: <1433598496-31287-10-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 12:36:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1XwJ-0001Qh-CN
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 12:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbbFGKgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 06:36:23 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33123 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbFGKgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 06:36:21 -0400
Received: by pdjn11 with SMTP id n11so43508502pdj.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UTEcJXyaQHuQvuI7BKK9tQ1VCaBEs1cicGcq2K8viXY=;
        b=hH8a1MQPudoTCl0bnMxVRjI/gowYNbPm5MufdDGsuQf2awYQYIJTP6bLFhBobHNWbT
         bFPDGjJD16D521zIsziP7X5DuStIm2dW778e40j+jJ7hcUqdaV3TpH/j57BZeH5MFm1P
         ldA1HKumUG4O41qv7QncheOMeJf7IHQkCogSMWad5kBMVd9g7Xv6s7KHS5LpO5hy8h2i
         uIfvYCYSrcSYWGH1zbCa2DWwu4mi36skzcVVPpgfMMn6LEJ6GvMfV2SYW7S1dO/KmpnH
         jLvrlWPdsZzkGfhTxpq/s081vJ31oPJIBrCgHJlZkaWoQbHfYk3yQxRHxsHioMp4kkJj
         qiKA==
X-Received: by 10.66.231.168 with SMTP id th8mr20410911pac.80.1433673381354;
        Sun, 07 Jun 2015 03:36:21 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ho10sm11511302pbc.27.2015.06.07.03.36.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2015 03:36:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433598496-31287-10-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270965>

Introduce filter_refs() which will act as an API for users to
call and provide a function which will iterate over a set of refs
while filtering out the required refs.

Currently this will wrap around ref_filter_handler(). Hence,
ref_filter_handler is made file scope static.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 12 +++++++++++-
 ref-filter.h |  8 ++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ece16a1..886c3d7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -858,7 +858,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = &ref_cbdata->filter;
@@ -904,6 +904,16 @@ void ref_array_clear(struct ref_array *array)
 	array->nr = array->alloc = 0;
 }
 
+/*
+ * API for filtering a set of refs. The refs are provided and iterated
+ * over using the for_each_ref_fn(). The refs are stored into and filtered
+ * based on the ref_filter_cbdata structure.
+ */
+int filter_refs(int (for_each_ref_fn)(each_ref_fn, void *), struct ref_filter_cbdata *data)
+{
+	return for_each_ref_fn(ref_filter_handler, data);
+}
+
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
diff --git a/ref-filter.h b/ref-filter.h
index c2c5d37..15e6766 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -46,8 +46,12 @@ struct ref_filter_cbdata {
 	struct ref_filter filter;
 };
 
-/*  Callback function for for_each_*ref(). This filters the refs based on the filters set */
-int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data);
+/*
+ * API for filtering a set of refs. The refs are provided and iterated
+ * over using the for_each_ref_fn(). The refs are stored into and filtered
+ * based on the ref_filter_cbdata structure.
+ */
+int filter_refs(int (for_each_ref_fn)(each_ref_fn, void *), struct ref_filter_cbdata *data);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
 /*  Parse format string and sort specifiers */
-- 
2.4.2
