From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/14] fetch-pack: Add negotiate_capabilities
Date: Fri, 29 Apr 2016 16:34:42 -0700
Message-ID: <1461972887-22100-10-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwO-0000u4-4u
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbcD2XfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:11 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35447 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbcD2XfI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:08 -0400
Received: by mail-pa0-f54.google.com with SMTP id iv1so51226888pac.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lql+MFDHLur4LSLNvtHTmqCGWYbH6ATgKQrEPtH1CLI=;
        b=npJnbGQapyVvNgNUU44/6izczLHTNxtfoPmnfAr3K1bu3bcSuYWZSz61mCUsfq9ioR
         WByycRAU8/kL1PsB/2qUHqix1EEC5KEk8TtaJQLjloGcezoXGx4fUlKXoNzCEEfiJnIY
         ZRNPKkxxTQZeS2MHry7fHSc+ghymMf7f871r4kTYeaM+HH0qlUEdNdt6fTnESiYo2mu9
         ACI00EMXaCfxXzFBSa1Y7ug+CqZR9XooibZLgUA2fPyxPJ/YH5KAbyTUEnmTShBkDsI8
         EspGbRsz3tqne12yPoK7NSANSDELk2VVF5Qh+D6lnxdj5ar8Co8//d4r+g1UiFE9oAfI
         qk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lql+MFDHLur4LSLNvtHTmqCGWYbH6ATgKQrEPtH1CLI=;
        b=Gy79m3EuJemDI3jwO7/ufrod66lZZym/XV3ofMkHeA6N89AQ94F+PFHJUzRAyeax9c
         i3bp0YOE2idp3M7naXNKMeYsixTisHTLEpsrC3ZiEMk2RyMBPMOxJVwWl8zNHmoQOm3f
         hUAKnKzCQffE9ixnSayZGMpSJ8pV+++f1iPxPfEnXIxfx4rQPo5GwIxopRsaxcCT9M1W
         tuIeQXktMCiVxMavYCeJnGyhzrKOEbpuKjTL81SFjudaI82/eHQZLZppK4y72Y8trECr
         ObpEZUeq1WhHdN3YtYr4dVW/L/sVQ7NgmJBlNtiSMKdQuwkdKcr1ssjhVv6ZLJqWsoE8
         m5fg==
X-Gm-Message-State: AOPr4FUBaPg5rZx122UuAdG4Hhazz/rRACMytGrhuhnI+4wQ7LC05G/alIkQGorAWFY5Zl2Q
X-Received: by 10.66.122.100 with SMTP id lr4mr31798566pab.99.1461972907155;
        Fri, 29 Apr 2016 16:35:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id d78sm26189167pfb.59.2016.04.29.16.35.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:35:06 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293075>

As in the pack protocol version 2 we want to
negotiate the capabilities before any other exchange
we will have a function which will take care of the
whole negotiation process.

It will be placed in fetch-pack.c for now as there
we have access to its internal variables and we'll
work on a `struct fetch_pack_args`. Eventually we
want to move it to a better place such as transport.c

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 fetch-pack.c | 14 ++++++++++++++
 fetch-pack.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index b43490f..1544629 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -888,6 +888,20 @@ static void get_selected_capabilities_list(struct string_list *list,
 	}
 }
 
+void negotiate_capabilities(int fd[2], struct fetch_pack_args *args)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+
+	get_remote_capabilities(fd[0], NULL, 0);
+
+	select_capabilities(args);
+	get_selected_capabilities_list(&list, args);
+
+	request_capabilities(fd[1], &list);
+
+	string_list_clear(&list, 1);
+}
+
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
diff --git a/fetch-pack.h b/fetch-pack.h
index 3314362..198498a 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -29,6 +29,12 @@ struct fetch_pack_args {
 };
 
 /*
+ * In version 2 of the pack protocol we negotiate the capabilities
+ * before the actual transfer of refs and packs.
+ */
+void negotiate_capabilities(int fd[2], struct fetch_pack_args *args);
+
+/*
  * sought represents remote references that should be updated from.
  * On return, the names that were found on the remote will have been
  * marked as such.
-- 
2.8.0.32.g71f8beb.dirty
