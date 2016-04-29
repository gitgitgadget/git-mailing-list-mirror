From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/14] fetch-pack: factor out get_selected_capabilities_list
Date: Fri, 29 Apr 2016 16:34:41 -0700
Message-ID: <1461972887-22100-9-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwn-000190-2i
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbcD2Xfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:41 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34603 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbcD2XfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:07 -0400
Received: by mail-pf0-f173.google.com with SMTP id y69so54012983pfb.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DdjkGMBCevBsvk/GaH3wHmt1jBeNpOMZUbwTTA1ztzM=;
        b=HyiXB7ye+HfyZDfaxj+iwxN9cSye8lFkUqE9IQy3MS8DLqjykDJ56VDNmzlGzqg2+D
         DxPwn8LLn4t+83HH+N/UVs/glXnH/meY2RwrMCLCkDjh2SfQDFl/ddmFIR+ErRUkt6oK
         A/0WKZT9yvuyGENINjAKCZRYnTLRW/lnmrXiLM8RYBX7YKMDmV1wMpR0gNvzQnlOjp0f
         no4vHGt6Gf/frwU6IUW/T8JYNE8aomixIIRwDfpEqhJkId6NPggsB16+Zi1/SfCQVXPA
         3mSin+9YFwDvsEz/sSSsZm+e8+rrd3QaUTvJKMpGrfpYc45oOA7Ht68Y4cA/IPxkpPdN
         epEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DdjkGMBCevBsvk/GaH3wHmt1jBeNpOMZUbwTTA1ztzM=;
        b=akYanSA+tL2oSRfUui5T1b4vhoCAXpjM5lN2SRRsP7gbcvRyhkPfRmVjRaHbYAFh3w
         vWBwBSdqf0ee0SYAcY/cO5x0zjGCLAijwlXtA4WhWwoA9OJvHI8TQSfh/BsA7EAfF6Ix
         KZjI2S3hxPspgdj6P3F8PJozZGScU7de3oBJuGsF7lf71YYjkO8SOu6VYEp754RewBGB
         9KhRNO6EQ7Fp1uaTQtypwlWy2YLoVJkE8c0NBtWaToHCy6ou4j1Eci8/MuC1x3t7CXCU
         nYltqGIHNq0dIslXikPtJ8xbYod5yOIBhZ9S1f4r3PPFaNhHp6R105Ax7JoatDCYDQaS
         dM0A==
X-Gm-Message-State: AOPr4FX+XJYfYRrf1xI3atgDrak7zXLCacTXcK0nQVVDZ11BF36azTxuuLoZ74fOQOX+2tNF
X-Received: by 10.98.3.4 with SMTP id 4mr955965pfd.33.1461972905762;
        Fri, 29 Apr 2016 16:35:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id uw2sm26511870pac.10.2016.04.29.16.35.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:35:05 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293082>

This will be used later by both versions of the transport protocol.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 fetch-pack.c | 51 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 53f6384..b43490f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -257,6 +257,9 @@ static int next_flush(struct fetch_pack_args *args, int count)
 	return count;
 }
 
+static void get_selected_capabilities_list(struct string_list *list,
+					   struct fetch_pack_args *args);
+
 static int find_common(struct fetch_pack_args *args,
 		       int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
@@ -302,18 +305,15 @@ static int find_common(struct fetch_pack_args *args,
 
 		remote_hex = sha1_to_hex(remote);
 		if (!fetching) {
+			struct string_list list = STRING_LIST_INIT_NODUP;
 			struct strbuf c = STRBUF_INIT;
-			if (multi_ack == 2)     strbuf_addstr(&c, " multi_ack_detailed");
-			if (multi_ack == 1)     strbuf_addstr(&c, " multi_ack");
-			if (no_done)            strbuf_addstr(&c, " no-done");
-			if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
-			if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
-			if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
-			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
-			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
-			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
-			if (agent_supported)    strbuf_addf(&c, " agent=%s",
-							    git_user_agent_sanitized());
+			struct string_list_item *item;
+			get_selected_capabilities_list(&list, args);
+			for_each_string_list_item(item, &list) {
+				strbuf_addstr(&c, " ");
+				strbuf_addstr(&c, item->string);
+			}
+
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
 			strbuf_release(&c);
 		} else
@@ -859,6 +859,35 @@ static void select_capabilities(struct fetch_pack_args *args)
 	}
 }
 
+static void get_selected_capabilities_list(struct string_list *list,
+					   struct fetch_pack_args *args)
+{
+	if (multi_ack == 2)
+		string_list_append(list, "multi_ack_detailed");
+	if (multi_ack == 1)
+		string_list_append(list, "multi_ack");
+	if (no_done)
+		string_list_append(list, "no-done");
+	if (use_sideband == 2)
+		string_list_append(list, "side-band-64k");
+	if (use_sideband == 1)
+		string_list_append(list, "side-band");
+	if (args->use_thin_pack)
+		string_list_append(list, "thin-pack");
+	if (args->no_progress)
+		string_list_append(list, "no-progress");
+	if (args->include_tag)
+		string_list_append(list, "include-tag");
+	if (prefer_ofs_delta)
+		string_list_append(list, "ofs-delta");
+	if (agent_supported) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "agent=%s", git_user_agent_sanitized());
+		string_list_append(list, buf.buf);
+		strbuf_release(&buf);
+	}
+}
+
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
-- 
2.8.0.32.g71f8beb.dirty
