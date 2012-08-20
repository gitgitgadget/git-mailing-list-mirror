From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 1/4] svndump: move struct definitions to .h
Date: Mon, 20 Aug 2012 23:57:54 +0200
Message-ID: <1345499877-16024-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499877-16024-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:58:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZzI-0003Al-W6
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883Ab2HTV6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:58:15 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44474 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768Ab2HTV6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:58:13 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so4179693wey.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tN+rycPEFsGcUQFsYfbK4p7Isiie3a/Nuxvdc13lA3U=;
        b=AybRW8qe6TAmzk7IDBBoOd/KRoMWVHkfDYmWtScO1RIxmN1nxMpest5B0Dnot0t2iF
         VxkSWD8X3EMWTr243/DAnlFNz8Zd35I4zCQwGqcMs9BhgZ4b4gGZcbmiP/uE0lr8EWwB
         nhgcr0LG8YMJNW1PrbrWYHBNvKs0J0p+3HUG8ojKAIsCpWCgt3MGzMBbaThtWisiq6xV
         JLTxjg80v6P3i2a+7NGBGT9MKwf3e99e/rV5f8o5A0m7L5W8hfWinNnTM2PLT3YYOJX0
         y1P+W2QlRKhn8eQvsGQOdBLcXdCQ3eju8f8wxTdLtFFBbdpfpheL4w0mknlxi3CB+9rP
         BSFQ==
Received: by 10.180.77.34 with SMTP id p2mr13341759wiw.0.1345499893248;
        Mon, 20 Aug 2012 14:58:13 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id o2sm44859731wiz.11.2012.08.20.14.58.11
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:58:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499877-16024-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203894>

This is a preparation for adding branch detection code in separate
.c files.

External branch detection functions will need to use these.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 vcs-svn/svndump.c |   19 +++----------------
 vcs-svn/svndump.h |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 31d1d83..6ca94de 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -38,23 +38,10 @@
 
 static struct line_buffer input = LINE_BUFFER_INIT;
 
-static struct {
-	uint32_t action, srcRev, type;
-	off_t prop_length, text_length;
-	struct strbuf src, dst;
-	uint32_t text_delta, prop_delta;
-} node_ctx;
+static struct node_ctx_t node_ctx;
+static struct rev_ctx_t rev_ctx;
+static struct dump_ctx_t dump_ctx;
 
-static struct {
-	uint32_t revision;
-	unsigned long timestamp;
-	struct strbuf log, author, note;
-} rev_ctx;
-
-static struct {
-	uint32_t version;
-	struct strbuf uuid, url;
-} dump_ctx;
 
 static void reset_node_ctx(char *fname)
 {
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index b8eb129..d545453 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,5 +1,6 @@
 #ifndef SVNDUMP_H_
 #define SVNDUMP_H_
+#include "cache.h"
 
 int svndump_init(const char *filename);
 int svndump_init_fd(int in_fd, int back_fd);
@@ -7,4 +8,22 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 void svndump_deinit(void);
 void svndump_reset(void);
 
+struct node_ctx_t {
+	uint32_t action, srcRev, type;
+	off_t prop_length, text_length;
+	struct strbuf src, dst;
+	uint32_t text_delta, prop_delta;
+};
+
+struct rev_ctx_t {
+	uint32_t revision;
+	unsigned long timestamp;
+	struct strbuf log, author, note;
+};
+
+struct dump_ctx_t {
+	uint32_t version;
+	struct strbuf uuid, url;
+};
+
 #endif
-- 
1.7.9.5
