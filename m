From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v5 05/10] for-each-ref: introduce 'ref_array_clear()'
Date: Sat,  6 Jun 2015 12:39:36 +0530
Message-ID: <1433574581-23980-5-git-send-email-karthik.188@gmail.com>
References: <55729B78.1070207@gmail.com>
 <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 09:10:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z18FC-0002oC-UK
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 09:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbbFFHKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 03:10:09 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33793 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbbFFHKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 03:10:05 -0400
Received: by payr10 with SMTP id r10so63442604pay.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cAce3SHv9ikUX95Vi8/wNmcl9IlrFmLiGawug1IPkHc=;
        b=q3LKyg4noNjUV4JoiM8cB41IqE9GIus5Rm2cDAWoGrH2On/N7F+CycddWXGmNokmqp
         rDVol2mEvP62axf4sVmMxtnIpjFiCxQ2Ny8Gy9JJwhSq7Kup7ejyDzZSlIW1VDXzVU/t
         BNstSWSQn3MDeQDp2PQ7lO2nEZfxGK0ToqPXfBCSe8LNQpev2WvWzMtdHizmhnJRP5fA
         t6kKg9U7L3UAzws1tiOmkzUiIl68eW4shlxSMWyYaZqMOcWlKzpt2iL2FXfWsp6fPAPM
         06O+uE3c6dhXlngIYkSpLIngyEelK0bahH1bcAASvv43kem1xEv3OzWT1x1Iho+ryg1X
         +fjA==
X-Received: by 10.70.101.106 with SMTP id ff10mr12160652pdb.162.1433574604598;
        Sat, 06 Jun 2015 00:10:04 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ve1sm8572230pbc.52.2015.06.06.00.10.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 00:10:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270905>

Introduce and implement 'ref_array_clear()' which will free
all allocated memory for 'ref_array'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 169ccc8..54f03c9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -911,6 +911,26 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
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
@@ -1141,5 +1161,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		maxcount = ref_cbdata.array.nr;
 	for (i = 0; i < maxcount; i++)
 		show_ref(ref_cbdata.array.items[i], format, quote_style);
+	ref_array_clear(&ref_cbdata.array);
 	return 0;
 }
-- 
2.4.2
