From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 2/5] svndump: move struct definitions to .h.
Date: Fri, 17 Aug 2012 22:40:07 +0200
Message-ID: <1345236010-1648-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345236010-1648-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2TLv-0006qS-3Y
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497Ab2HQUkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:40:53 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57580 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312Ab2HQUk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:40:29 -0400
Received: by wgbdr13 with SMTP id dr13so3671472wgb.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=u9wEk820Rvy2bDgD1SEW3Vc9sZvH/yZUYgyMJDY9Uiw=;
        b=ZQ8vIZiX3uVxJFYh9PYI01M81To/l0yHWleAx+U0OXLhaCMcVhusHAxkptDsN9RiJL
         qr//C/TId++B1VOst/gdONB58sFmxg05QfgRWqmeMWrbinDzgBbtfHQFFx9H4rjMPyeO
         FODxx66Az/a+l/OoQkwb3MD11gxiXSLv4s/07G40fH0EPf/9tbHUq4aL/WWttLLhaYq+
         y/m9sJ1YhTDf0lUTVTKllm3A4zYsLSWjY274Yg5UvBlIaQlbhKNpSG+s4dgNoQHIu12q
         3+Ci6rDgPUluoDvgzKntHQ4xrvkDkAukY7h3Ve7/75EcKjqu8rZnkV2wOv5QJqvJIPNQ
         WafQ==
Received: by 10.180.109.166 with SMTP id ht6mr7834507wib.11.1345236028038;
        Fri, 17 Aug 2012 13:40:28 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id b7sm17480686wiz.9.2012.08.17.13.40.25
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:40:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345236010-1648-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203661>

This is a preparation for adding branch detection code in seperate
.c files.
External branch detection functions will need to use these.
---
 vcs-svn/svndump.c |   19 +++----------------
 vcs-svn/svndump.h |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 7592c8e..296be8c 100644
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
