From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: repack_without_refs may be called without error string buffer
Date: Thu, 20 Nov 2014 10:10:40 -0800
Message-ID: <1416507040-6576-1-git-send-email-sbeller@google.com>
References: <1416506666-5989-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, sahlberg@google.com,
	jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 20 19:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWBr-0001gY-Km
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860AbaKTSKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:10:43 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:51081 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbaKTSKn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:10:43 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so5233897igd.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 10:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T1HJoYrIQAzJbW2v4PE9h7BmmvVnr2sTNA96aphybio=;
        b=PFZsgbkOFQPzwalHF1wXXr0k2o/qlddQ2LPJrR4vccLOd/eqWs8juHFUHatMaZC5eN
         WVtXpndMHa5xiiEl8Fwljqh4tjJ52SnmaLnmyiUXNbkWS8719y4UTYGhLMgUtNxNVXca
         rnvkZn40PO99tXtXPdErOIoWzmAneyuuCw9LeazsrvcVgpx4iDmsijbVth7XU8Sr8oQK
         aIaeVJE9mvQWsu0SPgUFJM2xIzuaD3lma+60f0/0lxK+xEHTWZVamW8Z1AjHOoU3m0Po
         iEV5pOuRm+aRlPftGh9oZd5tVGOoXY/eix9ptTr4dHQTUmwgthM0x8+XOQIr+LrS6A7g
         BELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T1HJoYrIQAzJbW2v4PE9h7BmmvVnr2sTNA96aphybio=;
        b=Ld1JaGe/yNcsz7z2IhSRcevJnUv4jD9G+ka3RutpniUejldN7bfh42lGdkhlMCYbPS
         AgevYUiVEB5BVjp4mJMW/1oCgQ+gmWQQNuHGNeL3TfylTurjcqMyXgQ+uUJGlqui5uIn
         ew6Z/qnggJ81HLEe6neFNeb9HaJu7jqy+SXBvJkp+EO4cHbe7ywwBOc1WU399vdb5r0f
         2+AEHD6+0GYt1DX8S8q2ln9Q/B+BOqeE9RmKwklIMUq7cN3cbg++JuWhNzvKapZvdYY4
         bii5SLTqAUJzW7EWqBanEGXtGSBZ2MsB7tKkSr0hhqnjJJCZoLh8E+gOI5o0d0c71Nbo
         a7XA==
X-Gm-Message-State: ALoCoQmUSAJOsEmai5X92/0CvavA3IQEMWNpvn9aUdDcc8WbgIc7TpnnneBoTwBAvVVhQL1cUuGu
X-Received: by 10.50.138.166 with SMTP id qr6mr8598798igb.17.1416507042525;
        Thu, 20 Nov 2014 10:10:42 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:2878:9312:86d2:4f27])
        by mx.google.com with ESMTPSA id am5sm1859631igc.12.2014.11.20.10.10.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 10:10:42 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.23.gca0107e
In-Reply-To: <1416506666-5989-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we don't pass in the error string buffer, we skip over all
parts dealing with preparing error messages.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This goes ontop of [PATCH v5] refs.c: use a stringlist for repack_without_refs
if that makes sense.

 refs.c | 8 ++++----
 refs.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index ebcd90f..3c85ea6 100644
--- a/refs.c
+++ b/refs.c
@@ -2646,8 +2646,6 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
 	struct string_list_item *ref_to_delete;
 	int ret, needs_repacking = 0, removed = 0;
 
-	assert(err);
-
 	/* Look for a packed ref */
 	for_each_string_list_item(ref_to_delete, without) {
 		if (get_packed_ref(ref_to_delete->string)) {
@@ -2661,7 +2659,9 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
 		return 0;
 
 	if (lock_packed_refs(0)) {
-		unable_to_lock_message(git_path("packed-refs"), errno, err);
+		if (err)
+			unable_to_lock_message(git_path("packed-refs"),
+					       errno, err);
 		return -1;
 	}
 	packed = get_packed_refs(&ref_cache);
@@ -2688,7 +2688,7 @@ int repack_without_refs(struct string_list *without, struct strbuf *err)
 
 	/* Write what remains */
 	ret = commit_packed_refs();
-	if (ret)
+	if (ret && err)
 		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
 			    strerror(errno));
 	return ret;
diff --git a/refs.h b/refs.h
index c7323ff..b71fb79 100644
--- a/refs.h
+++ b/refs.h
@@ -170,7 +170,6 @@ int pack_refs(unsigned int flags);
  * strbuf.
  *
  * The refs in 'without' may have any order.
- * The err buffer must not be omitted.
  */
 extern int repack_without_refs(struct string_list *without, struct strbuf *err);
 
-- 
2.2.0.rc2.23.gca0107e
