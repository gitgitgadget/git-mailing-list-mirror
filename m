From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 1/2] string-list: Add string_list initializer helper functions
Date: Mon, 16 Jun 2014 01:27:11 -0700
Message-ID: <1402907232-24629-2-git-send-email-tanayabh@gmail.com>
References: <1402907232-24629-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 10:29:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwSIM-00061p-LR
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 10:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbaFPI3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 04:29:35 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:53800 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbaFPI3e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 04:29:34 -0400
Received: by mail-pb0-f50.google.com with SMTP id rp16so4233121pbb.37
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=en577bOO3lQu2NGeBob1AwX+AqsRg+k+3HhyrAHvIwE=;
        b=duIQVZSex7eXkvkNby/NOuyAXr/0HEjTDIwIVRAIfHr4w6KK2YGddARELhAscj5JaM
         BrrlyeNre0q+MtOXLy26o41gd2hWWU0cTvq+JZEhM52+hZBSqbva2FpQI6hH0LPkbzow
         N2ctyqhAkLcRXpgS+/BWMNZKK585mGCzKFLZlSMdiZM9KOeHijTkH2DaiERwYaXd+pHn
         jK6lP4pcSNXgHCuxyXwhqd+l43WflLCkCA4XKRIBn9/OELhufLTILpM14KKfcNPrPihP
         6aoqfpuQXEf/HtC39Y0/UxaHS08kptY290ERE23y1EOuGJcR6C1gz8q0dJ3hqpYGDI5P
         TZ6Q==
X-Received: by 10.66.132.81 with SMTP id os17mr22291830pab.137.1402907373933;
        Mon, 16 Jun 2014 01:29:33 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.96])
        by mx.google.com with ESMTPSA id ja8sm17290853pbd.3.2014.06.16.01.29.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 01:29:33 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1402907232-24629-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251705>

When a compound construct like a string_list within another
struct is used, the default initializer macros are useless.
For such cases add helper functions for string_list
initialization for both DUP and NODUP modes.

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
index de6769c..8ae3376 100644
--- a/string-list.h
+++ b/string-list.h
@@ -18,6 +18,9 @@ struct string_list {
 #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
 #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1 }
 
+void string_list_init_nodup(struct string_list *list);
+void string_list_init_dup(struct string_list *list);
+
 void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
 
-- 
1.9.0.GIT
