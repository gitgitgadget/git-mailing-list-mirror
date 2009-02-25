From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 11/21] string-list: new for_each_string_list() function
Date: Wed, 25 Feb 2009 03:32:18 -0500
Message-ID: <d92fee0cbe41f188d6eac44a3debc2372606a0d7.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:35:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFF7-0000Xo-3q
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759281AbZBYIdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759827AbZBYIdF
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:33:05 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:53623 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759609AbZBYIc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:58 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1285047yxm.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vwS0WwgZ09zuMdxJ/aVsIgB/WiNyFVfOEp6+SqaVY4g=;
        b=puWgzMDZLyiJ7fMz6aUqp9hNiYIief7S+gWk/Jja25xvYYfl6L35dcHD/9ZHhqZuMB
         rKzKfjS81Pfq1zqa7bcm7quwrBG2Q1Nj38+kiJWlg/YvC2ZEowZFfPGnNlmrWaPpm41U
         O44A9SUlFFsux/TA6nZ4LXGj7+uCAecYtewd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UdosiwTqTzZ3jnutpz0OJ6U3M81DlExqOSAAVijd3rz7OQCsXGI3XkEpNZveqCs4l1
         5XQb1W1fNUI3TslE42+vEBbu8T3HA8nOc07RSa3Cl7npFQCMiUsrffTtCqU7TnnBVzvV
         wQ2KMRnSev/xQnS3Pzpbl5zu609fOjx3imymE=
Received: by 10.100.196.20 with SMTP id t20mr780436anf.120.1235550776325;
        Wed, 25 Feb 2009 00:32:56 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c14sm13758015ana.21.2009.02.25.00.32.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:55 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111396>

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
1.6.2.rc1.291.g83eb
