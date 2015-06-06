From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 05/11] for-each-ref: introduce 'ref_array_clear()'
Date: Sat,  6 Jun 2015 19:18:10 +0530
Message-ID: <1433598496-31287-5-git-send-email-karthik.188@gmail.com>
References: <5572F904.1080608@gmail.com>
 <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 15:48:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ESy-0004uo-LU
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 15:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbbFFNst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 09:48:49 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36255 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbFFNsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 09:48:47 -0400
Received: by pablj1 with SMTP id lj1so11574543pab.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6amuQ+URkjQy7cdiUui3uWdOefdnW/b0eyKcjCvTslM=;
        b=a4ICwE2yaCq4DCX4zxQfoGJbpdWsPXuFArymh8hOtmtUmGFaq68gzO2pOWZ7nm+uMs
         Dnddclf+NomMZI5doDau2ZlS9HhICjSj0Yvx2R5vaWu1CfHo3L+rC36ZHsMlRKr+J7Wg
         83kOQbBC4fhXZl4h5s0L/MN4QWFp8+MWdty6GiMx3yl6IQTKvCxRnMINIqBqBixpwZr6
         3RsvytSjrztVOzt+QZd3uhMiGaw2U4KOL7g1DSFfsO1USNnry8cS4e4fdD/H0GrrtECo
         qcZUr3lSZr7IiT1pP4fItKaofl59KjDZP57loKDFi7I4yTUeXcEfRXGWHksVphW2T0ko
         gRjA==
X-Received: by 10.70.92.164 with SMTP id cn4mr14193751pdb.106.1433598527173;
        Sat, 06 Jun 2015 06:48:47 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id p9sm9715427pds.92.2015.06.06.06.48.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 06:48:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433598496-31287-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270927>

Introduce and implement 'ref_array_clear()' which will free
all allocated memory for 'ref_array'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 42a89cd..a65a4db 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -926,6 +926,26 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+/*  Free memory allocated for a ref_array_item */
+static void free_array_item(struct ref_array_item *item)
+{
+	free(item->symref);
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
@@ -1156,5 +1176,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		maxcount = ref_cbdata.array.nr;
 	for (i = 0; i < maxcount; i++)
 		show_ref(ref_cbdata.array.items[i], format, quote_style);
+	ref_array_clear(&ref_cbdata.array);
 	return 0;
 }
-- 
2.4.2
