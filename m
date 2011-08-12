From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 27/56] string-list: Add API to remove an item from an unsorted list
Date: Thu, 11 Aug 2011 23:20:00 -0600
Message-ID: <1313126429-17368-28-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBp-00051N-J0
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab1HLFVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:35 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab1HLFV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:29 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aP1oxEYKmfXk4EeaPzeQ/a22zj9X6/GpmgNAZhY9VX0=;
        b=jUvT3ZN0grWas1j2mnQfMznBUcs29rtANhs/bElBC6BsIivhVtvgHoFXNp7ns8xCFj
         tS457MiWDMJKG1g0sxTR14hNNM2rXnqJucwy2CaUSFosdEjU/KF06PeGtU7ZtiebMd5P
         QgLqCBpnOcDtp6yv/nQRWzDGZGwgFEWa8+HQA=
Received: by 10.42.74.130 with SMTP id w2mr528510icj.462.1313126488635;
        Thu, 11 Aug 2011 22:21:28 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.26
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179180>

From: Johannes Sixt <j.sixt@viscovery.net>

Here's an attempt for a delete_item API (note: only compile-tested).
Bike-shed painters welcome: delete_item, remove_item, free_item?

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
New patch that wasn't part of v1, submitted by Johannes.

 Documentation/technical/api-string-list.txt |   10 ++++++++++
 string-list.c                               |    9 +++++++++
 string-list.h                               |    1 +
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 3f575bd..ce24eb9 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -29,6 +29,9 @@ member (you need this if you add things later) and you should set the
 
 . Can sort an unsorted list using `sort_string_list`.
 
+. Can remove individual items of an unsorted list using
+  `unsorted_string_list_delete_item`.
+
 . Finally it should free the list using `string_list_clear`.
 
 Example:
@@ -112,6 +115,13 @@ write `string_list_insert(...)->util = ...;`.
 The above two functions need to look through all items, as opposed to their
 counterpart for sorted lists, which performs a binary search.
 
+`unsorted_string_list_delete_item`::
+
+	Remove an item from a string_list. The `string` pointer of the items
+	will be freed in case the `strdup_strings` member of the string_list
+	is set. The third parameter controls if the `util` pointer of the
+	items should be freed or not.
+
 Data structures
 ---------------
 
diff --git a/string-list.c b/string-list.c
index 5168118..d9810ab 100644
--- a/string-list.c
+++ b/string-list.c
@@ -185,3 +185,12 @@ int unsorted_string_list_has_string(struct string_list *list,
 	return unsorted_string_list_lookup(list, string) != NULL;
 }
 
+void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util)
+{
+	if (list->strdup_strings)
+		free(list->items[i].string);
+	if (free_util)
+		free(list->items[i].util);
+	list->items[i] = list->items[list->nr-1];
+	list->nr--;
+}
diff --git a/string-list.h b/string-list.h
index bda6983..0684cb7 100644
--- a/string-list.h
+++ b/string-list.h
@@ -44,4 +44,5 @@ void sort_string_list(struct string_list *list);
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string);
+void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
 #endif /* STRING_LIST_H */
-- 
1.7.6.100.gac5c1
