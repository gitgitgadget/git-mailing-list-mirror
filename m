From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 1/3] string-list: add string_list initialiser helper functions
Date: Mon, 23 Jun 2014 03:11:38 -0700
Message-ID: <1403518300-23053-2-git-send-email-tanayabh@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 12:13:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1Fa-0001uH-8c
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbaFWKNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:13:16 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:52301 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaFWKNP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:13:15 -0400
Received: by mail-pb0-f50.google.com with SMTP id rp16so5755302pbb.9
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uqLqIxodazqoM/TbIiEFmxMT40nttKXNpuFS+4IR4RE=;
        b=JB0njxRUiUPMlqKc90RzPXLXJBhPetOrL9lBsc0QFZ2ivUdqfpJIvsYfUIhHpd1jpw
         p8fm9MaTmPwh3pwRp7ZtJzJuFai6LMy12Pcj5R/SqNPD1ATEn4UwnwI/RGRqavJtVYKH
         4+04d9RGCH2Q7taU/sVCEM5fk9mrvutOjCSWXyEMpSQXDz3cArAyfK3IyNFzTrV0NGOv
         J9QnPvKUuSN5IYTOKlTBkejJ+42vZR4jIoucCvIatTigpm9yk+I37pwJ809MJ7TjXQEY
         0hKkpv06N/A1p+3OFLUWfcH5NvXmsOPb+wGZ4DdebcgYiq7c6YLAqjSi+I+xyZDqi/Lj
         cjMA==
X-Received: by 10.69.31.138 with SMTP id km10mr27766416pbd.93.1403518393833;
        Mon, 23 Jun 2014 03:13:13 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.81])
        by mx.google.com with ESMTPSA id io8sm26085321pbc.96.2014.06.23.03.13.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 03:13:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252331>

The string-list API has STRING_LIST_INIT_* macros to be used
to define variables with initialisers, but lacks functions
to initialise an uninitialised piece of memory to be used as
a string-list at the run-time.
Introduce string_list_init_{dup,nodup}() functions for that.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 string-list.c | 18 ++++++++++++++++++
 string-list.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/string-list.c b/string-list.c
index aabb25e..8c3a4eb 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,6 +1,24 @@
 #include "cache.h"
 #include "string-list.h"
 
+void string_list_init_nodup(struct string_list *list)
+{
+	list->items = NULL;
+	list->nr = 0;
+	list->alloc = 0;
+	list->strdup_strings = 0;
+	list->cmp = NULL;
+}
+
+void string_list_init_dup(struct string_list *list)
+{
+	list->items = NULL;
+	list->nr = 0;
+	list->alloc = 0;
+	list->strdup_strings = 1;
+	list->cmp = NULL;
+}
+
 /* if there is no exact match, point to the index where the entry could be
  * inserted */
 static int get_entry_index(const struct string_list *list, const char *string,
diff --git a/string-list.h b/string-list.h
index dd5e294..c90d6c1 100644
--- a/string-list.h
+++ b/string-list.h
@@ -18,6 +18,9 @@ struct string_list {
 #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
 #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
 
+void string_list_init_nodup(struct string_list *list);
+void string_list_init_dup(struct string_list *list);
+
 void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
 
-- 
1.9.0.GIT
