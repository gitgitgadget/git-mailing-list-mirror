From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v10 1/4] string-list: add string_list initializer helper function
Date: Fri, 18 Jul 2014 02:18:59 -0700
Message-ID: <1405675142-20300-2-git-send-email-tanayabh@gmail.com>
References: <1405675142-20300-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 11:19:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X84Kb-00068S-B6
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 11:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760616AbaGRJTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 05:19:51 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:53036 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761068AbaGRJTt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 05:19:49 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so4704864pdj.15
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/y41bdc+pSv74ffghfOlohq1rAOMoBCZ3fZt98x7GEI=;
        b=hXgTjyJXxl/EbCjBkSc26Cf8lq/i8cDUfkG2Zxt7rX3aCRK2lsarqOzxRNKmNxLYrK
         sklyA2DLcmWMTSM7HBxSGIaNymo55+2pPq4FogY8G74bdZlbGl4v6bCqqrfmdWHpve+S
         WKPaKr5EymKHQa6rOuWfxLIq0LFQAQ3dQM4jTmrDHpfI/hO6sYzPobMluBo0KWbvccrd
         65lyB8CX0o8rnKaYTAkgtZFcD2WYzgbbhxOltpTgWE+j918MntBlbG+xtUXyUKgttUww
         VqP0aFlUA6s1ZZB1WIlZNHyvVAvwSEKEhCt8pMgERP8+/FqAqzSgpbQ8Xlssr1I97I9O
         lF8A==
X-Received: by 10.70.48.42 with SMTP id i10mr3167310pdn.129.1405675189150;
        Fri, 18 Jul 2014 02:19:49 -0700 (PDT)
Received: from localhost.localdomain ([106.203.84.80])
        by mx.google.com with ESMTPSA id wn7sm20813928pab.18.2014.07.18.02.19.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 02:19:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1405675142-20300-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253800>

The string-list API has STRING_LIST_INIT_* macros to be used
to define variables with initializers, but lacks functions
to initialise an uninitialized piece of memory to be used as
a string-list at the run-time.
Introduce `string_list_init()` function for that.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-string-list.txt | 5 +++++
 string-list.c                               | 6 ++++++
 string-list.h                               | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index f1add51..d51a657 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -68,6 +68,11 @@ Functions
 
 * General ones (works with sorted and unsorted lists as well)
 
+`string_list_init`::
+
+	Initialize the members of the string_list, set `strdup_strings`
+	member according to the value of the second parameter.
+
 `filter_string_list`::
 
 	Apply a function to each item in a list, retaining only the
diff --git a/string-list.c b/string-list.c
index aabb25e..db38b62 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,6 +1,12 @@
 #include "cache.h"
 #include "string-list.h"
 
+void string_list_init(struct string_list *list, int strdup_strings)
+{
+	memset(list, 0, sizeof(*list));
+	list->strdup_strings = strdup_strings;
+}
+
 /* if there is no exact match, point to the index where the entry could be
  * inserted */
 static int get_entry_index(const struct string_list *list, const char *string,
diff --git a/string-list.h b/string-list.h
index dd5e294..494eb5d 100644
--- a/string-list.h
+++ b/string-list.h
@@ -18,6 +18,8 @@ struct string_list {
 #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
 #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
 
+void string_list_init(struct string_list *list, int strdup_strings);
+
 void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
 
-- 
1.9.0.GIT
