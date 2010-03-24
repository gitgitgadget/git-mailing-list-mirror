From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 5/7] string-list: add unsorted_string_list_lookup()
Date: Wed, 24 Mar 2010 00:16:02 -0700
Message-ID: <1269414964-9518-6-git-send-email-bebarino@gmail.com>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 08:17:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuKpx-0006wZ-DY
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 08:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab0CXHQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 03:16:30 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:51811 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0CXHQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 03:16:20 -0400
Received: by mail-gx0-f217.google.com with SMTP id 9so1364583gxk.8
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9+TREnZaw/QXftMbV7CQj2sZkavXAiJnqQRBjuZkP3E=;
        b=x26nJhIMsYeP52Ix7KbzNQi3QxL3Ymxlvq+UhaptHbHRr4PE471r9itAtmjLuYmfEj
         XFCbXFNd2ZGaVe1I+sSzmB21gpz71hjMriY0LO2W9kbtP4p20OYP0eI6IRvcDZf1OiRl
         9J5c2gyoskS3shP1W1wUx2AhuUX0P2uCEEolE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rOAaG4pojodTvrzO2mpvyRL6ySwAxqKeFSua4qdcOgLV9HAuV8Z3K7J1IlNpcvDiFW
         Zx1cfIrg42Mj9bv9Kp4j2HCrBtHRcYCbhOcf5L4Q/sgFxs6IXJGUEJASBZ0WHMcvEeFV
         1T8DZ/ylflF/TA9EJ00sl6Zguq9b1MQ+3Twec=
Received: by 10.90.38.27 with SMTP id l27mr1691702agl.6.1269414980495;
        Wed, 24 Mar 2010 00:16:20 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm5248344iwn.8.2010.03.24.00.16.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 00:16:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.254.g4503b
In-Reply-To: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143072>

Sometimes users need to lookup a string in an unsorted string_list. In
that case they should use this function instead of the version for
sorted strings.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/technical/api-string-list.txt |    6 +++++-
 string-list.c                               |   13 ++++++++++---
 string-list.h                               |    3 ++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 293bb15..6d8c24b 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -104,8 +104,12 @@ write `string_list_insert(...)->util = ...;`.
 `unsorted_string_list_has_string`::
 
 	It's like `string_list_has_string()` but for unsorted lists.
+
+`unsorted_string_list_lookup`::
+
+	It's like `string_list_lookup()` but for unsorted lists.
 +
-This function needs to look through all items, as opposed to its
+The above two functions need to look through all items, as opposed to their
 counterpart for sorted lists, which performs a binary search.
 
 Data structures
diff --git a/string-list.c b/string-list.c
index 1ac536e..c9ad7fc 100644
--- a/string-list.c
+++ b/string-list.c
@@ -168,12 +168,19 @@ void sort_string_list(struct string_list *list)
 	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
 }
 
-int unsorted_string_list_has_string(struct string_list *list, const char *string)
+struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
+						     const char *string)
 {
 	int i;
 	for (i = 0; i < list->nr; i++)
 		if (!strcmp(string, list->items[i].string))
-			return 1;
-	return 0;
+			return list->items + i;
+	return NULL;
+}
+
+int unsorted_string_list_has_string(struct string_list *list,
+				    const char *string)
+{
+	return unsorted_string_list_lookup(list, string) != NULL;
 }
 
diff --git a/string-list.h b/string-list.h
index 6569cf6..63b69c8 100644
--- a/string-list.h
+++ b/string-list.h
@@ -38,5 +38,6 @@ struct string_list_item *string_list_lookup(const char *string, struct string_li
 struct string_list_item *string_list_append(const char *string, struct string_list *list);
 void sort_string_list(struct string_list *list);
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
-
+struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
+						     const char *string);
 #endif /* STRING_LIST_H */
-- 
1.7.0.3.254.g4503b
