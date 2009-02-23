From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 06/13] string-list: new for_each_string_list() function
Date: Mon, 23 Feb 2009 01:28:54 -0500
Message-ID: <a9a03697661905ebaa836d19eb03762c046e4a7a.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULM-00072Y-Jh
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbZBWG3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbZBWG3X
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:23 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:65371 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbZBWG3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:18 -0500
Received: by yw-out-2324.google.com with SMTP id 5so749063ywh.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KyiIr7WhLzPxz9wThFosb8ubGQj4NC5WrSSwYSAZNRs=;
        b=Kxbo4o1PcKnFcpISSwYOUL5wdcIyIberJHmGxsXa3dskNKPvjFq/jfFqpHNr+vJYE2
         5eO6epXMKkAIf8UWv/JamRX0cFICO7Q+oQuQtajHcu5GCJDO5hmQS3tNqUZOystrD8nS
         eEBw/BhY4UJtsJ4IxgZMs+Im7iV6ajzJPMfu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CFvVMup1LJSqsGhIN0skm1zVrH2xF5swabjoGIZIkF2Kc26NTq2sIRdbWxkGqcJ12u
         rRqBOjltrATm6zWnIQd0UtPhZ5ukT1qvticeZpKbBYGQcv9jkD/Ba8O3uC/1qdZkZ/uL
         DjFzy7ETsqQ3nKUU30gjxw8peP6+fosp2yCck=
Received: by 10.100.45.5 with SMTP id s5mr1484733ans.14.1235370558350;
        Sun, 22 Feb 2009 22:29:18 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c40sm7787940anc.48.2009.02.22.22.29.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:17 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111093>

Add a convenience function for iterating over a string_list's items via
a callback.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 string-list.c |   10 ++++++++++
 string-list.h |    5 +++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/string-list.c b/string-list.c
index 15e14cf..1ac536e 100644
--- a/string-list.c
+++ b/string-list.c
@@ -92,6 +92,16 @@ struct string_list_item *string_list_lookup(const char *string, struct string_li
 	return list->items + i;
 }
 
+int for_each_string_list(string_list_each_func_t fn,
+			 struct string_list *list, void *cb_data)
+{
+	int i, ret = 0;
+	for (i = 0; i < list->nr; i++)
+		if ((ret = fn(&list->items[i], cb_data)))
+			break;
+	return ret;
+}
+
 void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
diff --git a/string-list.h b/string-list.h
index d32ba05..14bbc47 100644
--- a/string-list.h
+++ b/string-list.h
@@ -20,6 +20,11 @@ void string_list_clear(struct string_list *list, int free_util);
 typedef void (*string_list_clear_func_t)(void *p, const char *str);
 void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc);
 
+/* Use this function to iterate over each item */
+typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
+int for_each_string_list(string_list_each_func_t,
+			 struct string_list *list, void *cb_data);
+
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
-- 
1.6.2.rc1.223.gfed32
