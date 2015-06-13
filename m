From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 05/11] for-each-ref: introduce 'ref_array_clear()'
Date: Sun, 14 Jun 2015 01:07:23 +0530
Message-ID: <1434224249-21476-5-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
 <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 21:38:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rGO-0002JM-Lk
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 21:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbbFMTii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 15:38:38 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36337 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbbFMTif (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 15:38:35 -0400
Received: by pabqy3 with SMTP id qy3so40679845pab.3
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 12:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QeC7mrlDccyxJjhbFGuMLGMIvqN0hhIbfCmD2ItlHg0=;
        b=lU5D3bhuxiBDVubeSgGqZDkwgPBVcRXrYHGZyKbNlXUx1z0GeVfHRFU71Z8xDtMShM
         e+tie2eAMgoR/iGlFRp22NWgjMnIflVCillJe4b1xsk4Bth4aXqu4+aatBbxfOsFoDL8
         kCGIE2lbQQWV8kTUt+qkrt0+ysQa7bVHOxfFyLMFHYPo25j1Z/790iH9VB/zW+a0Lz4E
         WNN5Hrs8QVJdgg/x/YaeVJcV8Jg8qcx4RsY8Km/pNJRoH4Msu+s57tKKIcy4m7KURdjk
         aOxlkpFUIWW5ya5EdYgQJRI6S3McaeXgRThGeVfnDZTrOlaUm2nTEkSH+DIdlxgi3JNe
         cSrQ==
X-Received: by 10.70.103.70 with SMTP id fu6mr34689761pdb.22.1434224315074;
        Sat, 13 Jun 2015 12:38:35 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nn6sm7388954pdb.79.2015.06.13.12.38.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 12:38:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271569>

Introduce and implement 'ref_array_clear()' which will free
all allocated memory for 'ref_array'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 822838a..bb83f7a 100644
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
2.4.3.435.g2403634.dirty
