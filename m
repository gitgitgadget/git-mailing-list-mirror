From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 06/12] for-each-ref: introduce 'ref_array_clear()'
Date: Thu, 11 Jun 2015 21:39:57 +0530
Message-ID: <1434039003-10928-6-git-send-email-karthik.188@gmail.com>
References: <5579B253.4020804@gmail.com>
 <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 18:11:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z354E-0006do-4i
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 18:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494AbbFKQKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 12:10:40 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35701 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbbFKQKh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 12:10:37 -0400
Received: by pabli10 with SMTP id li10so2402216pab.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shaFhvzta9ipi+tkQkGLiJ/lQx/IvUSdXsF23vDTEhc=;
        b=WAANccIInXJIQk7ddmDZIFVrdxjcN5vZBGo6uWPENqKmkB5fWxU/iWOCZLTM/KvcS2
         +GVXCHSiodS35HygJ2cSJbWh8y4KOjEB/8kuJ/XnjmLzioCqtYxs4oDrmXM6H6bAQeVS
         bf7Ikxg2k/a5TiVMxwkNzuVJP9f/8ti9us4nPYAk5OZmGpuflVtZGqPLo7qXOHBWuRaP
         bOD2FRsqJj596Kerv2oJSQx4p9Iq69Q1xMHKSX5i3jWnsXbFi9pJTxOb19pbsna2AfAk
         ZbsONSnC/+ZEBzCV2Ig9pamdtigx1AoaW7YrLe/syWdQkcpxvUgQDRPfkYGrUlldchNe
         p6FA==
X-Received: by 10.67.6.231 with SMTP id cx7mr15767276pad.79.1434039036306;
        Thu, 11 Jun 2015 09:10:36 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id f4sm1132981pdc.95.2015.06.11.09.10.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 09:10:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271430>

Introduce and implement 'ref_array_clear()' which will free
all allocated memory for 'ref_array'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 913d757..58396b2 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -927,6 +927,26 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+/*  Free memory allocated for a ref_array_item */
+static void free_array_item(struct ref_array_item *item)
+{
+	free((char *)item->symref);
+	free(item->refname);
+	free(item);
+}
+
+/* Free all memory allocated for ref_array */
+void ref_array_clear(struct ref_array *array)
+{
+	int i;
+
+	for (i = 0; i < array->nr; i++)
+		free_array_item(array->items[i]);
+	free(array->items);
+	array->items = NULL;
+	array->nr = array->alloc = 0;
+}
+
 static int cmp_ref_sort(struct ref_sort *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
@@ -1157,5 +1177,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		maxcount = ref_cbdata.array.nr;
 	for (i = 0; i < maxcount; i++)
 		show_ref(ref_cbdata.array.items[i], format, quote_style);
+	ref_array_clear(&ref_cbdata.array);
 	return 0;
 }
-- 
2.4.2
