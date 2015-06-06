From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v5 10/10] ref-filter: make 'ref_array_item' use a FLEX_ARRAY for refname
Date: Sat,  6 Jun 2015 12:39:41 +0530
Message-ID: <1433574581-23980-10-git-send-email-karthik.188@gmail.com>
References: <55729B78.1070207@gmail.com>
 <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 09:11:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z18Fm-0003HA-Bp
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 09:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbbFFHKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 03:10:38 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32857 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158AbbFFHKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 03:10:35 -0400
Received: by pdjn11 with SMTP id n11so29275847pdj.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHYnxW5ftL7S5gcrO0ioUkh26pOFUtZfNsgBcn9ZdmE=;
        b=o7fA2mgM3jHWzHzXm0KbHVBzg3bXaRixoBhzGrn/mzDkXSpKRCdQTX8TlFjONARB0X
         AKO7ju6icVo9651mUxgLl9E50ci6EhRflEJFDatxQR3746WhSeFSeL0A1wBxDASbU/OZ
         q0xt3qUkrYcZwFu1dEfmM4OyfoeX0+S+MTZ7pvJYa3nn9NOjwW2Pd6i9tb5JlJ3tsdsx
         PpS+j/lPQoVMQUP+F5SLp2dwiV9HEkMnFgKoKnBJiTp8t4TCOAdgKVurSjUId3rrngh5
         qtyfMm4wmwUcFE4DaogbLzRP/7Hp3bdvTQlu3HJ8MGjDdMc9SClFoACr1TPhwHTaN0gE
         QCYw==
X-Received: by 10.66.141.109 with SMTP id rn13mr11811843pab.127.1433574633995;
        Sat, 06 Jun 2015 00:10:33 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ve1sm8572230pbc.52.2015.06.06.00.10.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 00:10:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433574581-23980-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270911>

This would remove the need of using a pointer to store refname.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 7 ++++---
 ref-filter.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index c32b86f..1bd1a28 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -831,8 +831,10 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 						 const unsigned char *objectname,
 						 int flag)
 {
-	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item));
-	ref->refname = xstrdup(refname);
+	size_t len = strlen(refname);
+	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
+	memcpy(ref->refname, refname, len);
+	ref->refname[len] = '\0';
 	hashcpy(ref->objectname, objectname);
 	ref->flag = flag;
 
@@ -873,7 +875,6 @@ static int ref_filter_handler(const char *refname, const unsigned char *sha1, in
 static void free_array_item(struct ref_array_item *item)
 {
 	free(item->symref);
-	free(item->refname);
 	free(item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 15e6766..041a39a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -29,7 +29,7 @@ struct ref_array_item {
 	int flag;
 	char *symref;
 	struct atom_value *value;
-	char *refname;
+	char refname[FLEX_ARRAY];
 };
 
 struct ref_array {
-- 
2.4.2
