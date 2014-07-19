From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v11 1/4] string-list: add string_list initializer helper function
Date: Fri, 18 Jul 2014 22:46:15 -0700
Message-ID: <1405748778-3755-2-git-send-email-tanayabh@gmail.com>
References: <1405748778-3755-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 07:47:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8NUz-0001zz-Hr
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 07:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbaGSFrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 01:47:49 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44728 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbaGSFrt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 01:47:49 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so6610954pab.2
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 22:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yVxKqPwLsyeJn0vbY7ekwt2ApZbq4sQhmzcjsSjKG04=;
        b=GbSbk18fMuj3idUHwRgqCdXoMmKkI2tLqKiZCp5HSkonV9ojard4xqzugScd3/Crt+
         bothXU69hnplRaMwfCQPJwMxUYmFYIk8B/8Pq1/uRoDAVjeXbNR1daa9t8CNXa9fQe0v
         z4JahhByLX2SPEqlqDOiGbCK/pYj4OkDaASiYg/RPotv+gPdlxX6FmS39l0f4CQ4qqby
         OrGh3W99KOhYk3ofY+d5KSoLp48S0c8UJYYDHYtN4Ca8LDtPgaDpII/XOD+nB/0O3FAQ
         H9OOiBXs6+44PQLHRDdujoydY5Yvi8sZ7tN0Fhzs4s70i0bhUAEXJrbTAYuyZyyc26VG
         1L4Q==
X-Received: by 10.66.65.204 with SMTP id z12mr10244648pas.97.1405748867714;
        Fri, 18 Jul 2014 22:47:47 -0700 (PDT)
Received: from localhost.localdomain ([223.176.228.151])
        by mx.google.com with ESMTPSA id mz8sm9919087pdb.62.2014.07.18.22.47.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 22:47:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1405748778-3755-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253863>

The string-list API has STRING_LIST_INIT_* macros to be used
to define variables with initializers, but lacks functions
to initialize an uninitialized piece of memory to be used as
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
