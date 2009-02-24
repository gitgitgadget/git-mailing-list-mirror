From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 10/23] string-list: new for_each_string_list() function
Date: Tue, 24 Feb 2009 04:50:58 -0500
Message-ID: <66b5906b903b73ab022cdfdb7038035311fa5548.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzy-0002Ej-JI
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbZBXJvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbZBXJvq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:46 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:58685 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586AbZBXJvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:40 -0500
Received: by mail-gx0-f174.google.com with SMTP id 22so6475210gxk.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vwS0WwgZ09zuMdxJ/aVsIgB/WiNyFVfOEp6+SqaVY4g=;
        b=jE7Xd+ea+wO2+9eGb/SpJ37SP5bzDt2KjSuEqC4uMujwVuAXvtlGm0xqoPd7hSTA1R
         2MyzKVlY8Q0NoadocitUU8FgUSkPgym9FqRowpncsEZdfUShiYjjahSZLNzhIlLeI0kK
         0cZS4YIJG8sHuqKuKXb6RcFsGPXyBVDETcFx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JFZsBenspREC7A/1lKymeRGo4VWYY8VUj56SNjL/1hPMzKYbq5DJFXRIbLfqpJOVyq
         23EWHEkA/3NAaaD5oVKT9CE4TyRvbP7BMpKsGUbrzaPWEvPUMM/WJ+D2kUTLVupXGyvo
         97O6a6bKMq6mCdK7yOj5akVCLcOQocEHujbcU=
Received: by 10.100.143.14 with SMTP id q14mr5454429and.47.1235469099137;
        Tue, 24 Feb 2009 01:51:39 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d29sm9073044and.54.2009.02.24.01.51.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:38 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111263>

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
