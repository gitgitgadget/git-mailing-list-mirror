From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/14] index-pack: make sure all objects are registered in v4's SHA-1 table
Date: Sun,  8 Sep 2013 14:22:34 +0700
Message-ID: <1378624960-8919-9-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:20:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZIM-00043x-1o
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab3IHHUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:24 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37472 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:20:22 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so4940117pdj.16
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xItwRGVOZh5VOadkYWpCdhhcSQVpjchpCx8uacuEbII=;
        b=s2MBm6GW7JrZqIvJz8u6AXVkM/mAU9RW4GfnJ7ZB1dZFRyjv435MKb6QVeEYfuZEgH
         UoKSrOI3jtUQZ7WSRIQ2iAd1fCDIWqxNNvHeODrDfRF2F0fEM0TfO+z9dYVgyhVCcLT0
         neVWdIVw0CQ+2x8f/sud8h7qAzOEIs9xYBu5oOPnwORqFpZPawZ9nyZjmw20X8MRDnI0
         vXy8YzFYbfia5aqqcUlndeomVh2edkm0HBpxirM4rUf/7yxMZVIDGVRDq9TF6PLmX1+8
         OIGndDytp0tDF4yPXBWncZsjJxvMYPjqGY+XgeQct8VPOuGt+hknv+Hqy+faAJPmd8jg
         +eow==
X-Received: by 10.66.27.43 with SMTP id q11mr13018040pag.97.1378624821178;
        Sun, 08 Sep 2013 00:20:21 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id qa9sm8460112pbc.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:20:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:29 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234205>

---
 builtin/index-pack.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 83e6e79..efb969a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -288,6 +288,19 @@ static inline void *fill_and_use(int bytes)
 	return p;
 }
 
+static void check_against_sha1table(const unsigned char *sha1)
+{
+	const unsigned char *found;
+	if (!packv4)
+		return;
+
+	found = bsearch(sha1, sha1_table, nr_objects, 20,
+			(int (*)(const void *, const void *))hashcmp);
+	if (!found)
+		die(_("object %s not found in SHA-1 table"),
+		    sha1_to_hex(sha1));
+}
+
 static NORETURN void bad_object(unsigned long offset, const char *format,
 		       ...) __attribute__((format (printf, 2, 3)));
 
@@ -907,6 +920,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_sha1_file(result->data, result->size,
 		       typename(delta_obj->real_type), delta_obj->idx.sha1);
+	check_against_sha1table(delta_obj->idx.sha1);
 	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
 	counter_lock();
@@ -1103,8 +1117,12 @@ static void parse_pack_objects(unsigned char *sha1)
 			/* large blobs, check later */
 			obj->real_type = OBJ_BAD;
 			nr_delays++;
-		} else
-			sha1_object(data, NULL, obj->size, obj->type, obj->idx.sha1);
+			check_against_sha1table(obj->idx.sha1);
+		} else {
+			check_against_sha1table(obj->idx.sha1);
+			sha1_object(data, NULL, obj->size, obj->type,
+				    obj->idx.sha1);
+		}
 		free(data);
 		display_progress(progress, i+1);
 	}
-- 
1.8.2.83.gc99314b
