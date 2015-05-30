From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v4 5/8] for-each-ref: introduce 'ref_filter_clear_data()'
Date: Sat, 30 May 2015 23:23:28 +0530
Message-ID: <1433008411-8550-5-git-send-email-karthik.188@gmail.com>
References: <5569EF77.4010300@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 19:54:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yykxf-00061S-1m
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 19:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809AbbE3RyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 13:54:14 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34614 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756AbbE3RyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 13:54:11 -0400
Received: by pdbki1 with SMTP id ki1so76349341pdb.1
        for <git@vger.kernel.org>; Sat, 30 May 2015 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ziTa3ciQ9Z7vnD9FsvgroqgSkEGAO3tgsJFDL98VyFg=;
        b=f8gPQoELBUsRZZtgTsXo98NGVzJahxvjpOzPZgkk9jb+ttuuG0kLDk8ZIVi1gEvCc/
         oghi2cbioTCMj6CXVKRtS4s6rQMWC82Rtdmrue+WX+Ld0mYNw+7R6l7lbOJrqN8LGeaT
         H5bUxkbtcNPKbnXC88V+uR8gwHCWYKag16f/SSyEf7GuxFI0/J5a6fkwF+1mzFp2gl9A
         k1m+zfTzdpJ/0IO426L8LbTqnlGmMFNlEwXsV8y7ydfPuKGu/qB67uJfEFRsK+tBP/4j
         XKoOOURdxNLZh88/LLKPVirnc33CIcrbmlyiZS7PVBZ5P7+MwBZtpTmgJ4z3qS3hBB1H
         oYqw==
X-Received: by 10.70.88.108 with SMTP id bf12mr25733574pdb.159.1433008450575;
        Sat, 30 May 2015 10:54:10 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ob15sm9317839pdb.40.2015.05.30.10.54.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 May 2015 10:54:10 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <5569EF77.4010300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270297>

Introduce and implement 'ref_filter_clear_data()' which will free
all allocated memory for 'ref_filter_cbdata' and its underlying array
of 'ref_array_item'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index ef54c90..f896e1c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -907,6 +907,18 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	return 0;
 }
 
+/* Free all memory allocated for ref_filter_cbdata */
+void ref_filter_clear_data(struct ref_filter_cbdata *ref_cbdata)
+{
+	int i;
+
+	for (i = 0; i < ref_cbdata->array.nr; i++)
+		free(ref_cbdata->array.items[i]);
+	free(ref_cbdata->array.items);
+	ref_cbdata->array.items = NULL;
+	ref_cbdata->array.nr = ref_cbdata->array.alloc = 0;
+}
+
 static int cmp_ref_sort(struct ref_sort *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
@@ -1137,5 +1149,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		maxcount = ref_cbdata.array.nr;
 	for (i = 0; i < maxcount; i++)
 		show_ref(ref_cbdata.array.items[i], format, quote_style);
+	ref_filter_clear_data(&ref_cbdata);
 	return 0;
 }
-- 
2.4.2
