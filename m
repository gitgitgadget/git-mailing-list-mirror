From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH 3/4] Create a note for every imported commit containing svn metadata.
Date: Wed, 11 Jul 2012 15:38:52 +0200
Message-ID: <1342013933-14381-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342013933-14381-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342013933-14381-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 15:41:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoxA3-0000x3-SY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 15:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757837Ab2GKNj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 09:39:56 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35780 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757677Ab2GKNjx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 09:39:53 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1074961bkw.19
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C5Gq7OziqMWq0JqzwZhOR52JqhFemAP2Dj4foJj+soo=;
        b=dS+k5ou54zgfvnKc/1Xcbb0eSY79NXfPUfP7diKneM857e2ZN5faWoKQ97ov35YL3D
         hDHYXmRDuZwJvcZiOGQI6AHBXypd2V29hasH4KCW9bKDlsTCT/yW63OGSue1zGrI7hQ3
         6oYsx0X4z32hclebOQ4aIBUlrSQkG1ScslYFVuM0VwoRGf9+M1DS9RPG/WpOTBibeell
         LEFXZenXIH1ypRK/i68VaUEO4sOYegIMVO4o/cw2tR+BsHwYVBkNXWAfTRb9L87EB1Ub
         ypZjG5fenUCqdKMHHbZc7Yl7UzloGLpczRYUmpf6cLW9MemMlQMRH039ZiumPe7z5/lC
         jwlQ==
Received: by 10.205.132.12 with SMTP id hs12mr16442893bkc.47.1342013992987;
        Wed, 11 Jul 2012 06:39:52 -0700 (PDT)
Received: from flobuntu.lan (91-115-86-162.adsl.highway.telekom.at. [91.115.86.162])
        by mx.google.com with ESMTPS id fu8sm1207082bkc.5.2012.07.11.06.39.50
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jul 2012 06:39:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342013933-14381-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201298>

To provide metadata from svn dumps for further processing, e.g.
branch detection, attach a note to each imported commit that
stores additional information.
The notes are currently hard-coded in refs/notes/svn/revs.
Currently the following lines from the svn dump are directly
accumulated in the note. This can be refined on purpose, of course.
- "Revision-number"
- "Node-path"
- "Node-kind"
- "Node-action"
- "Node-copyfrom-path"
- "Node-copyfrom-rev"

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 vcs-svn/fast_export.c |   13 +++++++++++++
 vcs-svn/fast_export.h |    2 ++
 vcs-svn/svndump.c     |   21 +++++++++++++++++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index ec7a1c1..7774ab0 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -12,6 +12,7 @@
 #include "svndiff.h"
 #include "sliding_window.h"
 #include "line_buffer.h"
+#include "cache.h"
 
 #define MAX_GITSVN_LINE_LEN 4096
 
@@ -73,6 +74,18 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 	putchar('\n');
 }
 
+void fast_export_begin_note(uint32_t revision, const char *author,
+		const char *log, unsigned long timestamp)
+{
+	timestamp = 1341914616;
+	size_t loglen = strlen(log);
+	printf("commit refs/notes/svn/revs\n");
+	printf("committer %s <%s@%s> %ld +0000\n", author, author, "local", timestamp);
+	printf("data %"PRIuMAX"\n", loglen);
+	fwrite(log, loglen, 1, stdout);
+	fputc('\n', stdout);
+}
+
 void fast_export_note(const char *committish, const char *dataref)
 {
 	printf("N %s %s\n", dataref, committish);
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 62bac44..febab6e 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -11,6 +11,8 @@ void fast_export_reset(void);
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
 void fast_export_note(const char *committish, const char *dataref);
+void fast_export_begin_note(uint32_t revision, const char *author,
+		const char *log, unsigned long timestamp);
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,
 			const char *url, unsigned long timestamp);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index eb76bf8..61f1449 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -49,7 +49,7 @@ static struct {
 static struct {
 	uint32_t revision;
 	unsigned long timestamp;
-	struct strbuf log, author;
+	struct strbuf log, author, note;
 } rev_ctx;
 
 static struct {
@@ -78,6 +78,7 @@ static void reset_rev_ctx(uint32_t revision)
 	rev_ctx.timestamp = 0;
 	strbuf_reset(&rev_ctx.log);
 	strbuf_reset(&rev_ctx.author);
+	strbuf_reset(&rev_ctx.note);
 }
 
 static void reset_dump_ctx(const char *url)
@@ -311,8 +312,15 @@ static void begin_revision(void)
 
 static void end_revision(void)
 {
-	if (rev_ctx.revision)
+	struct strbuf mark = STRBUF_INIT;
+	if (rev_ctx.revision) {
 		fast_export_end_commit(rev_ctx.revision);
+		fast_export_begin_note(rev_ctx.revision, "remote-svn",
+				"Note created by remote-svn.", rev_ctx.timestamp);
+		strbuf_addf(&mark, ":%"PRIu32, rev_ctx.revision);
+		fast_export_note(mark.buf, "inline");
+		fast_export_buf_to_data(&rev_ctx.note);
+	}
 }
 
 void svndump_read(const char *url)
@@ -359,6 +367,7 @@ void svndump_read(const char *url)
 				end_revision();
 			active_ctx = REV_CTX;
 			reset_rev_ctx(atoi(val));
+			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			break;
 		case sizeof("Node-path"):
 			if (prefixcmp(t, "Node-"))
@@ -370,10 +379,12 @@ void svndump_read(const char *url)
 					begin_revision();
 				active_ctx = NODE_CTX;
 				reset_node_ctx(val);
+				strbuf_addf(&rev_ctx.note, "%s\n", t);
 				break;
 			}
 			if (constcmp(t + strlen("Node-"), "kind"))
 				continue;
+			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			if (!strcmp(val, "dir"))
 				node_ctx.type = REPO_MODE_DIR;
 			else if (!strcmp(val, "file"))
@@ -384,6 +395,7 @@ void svndump_read(const char *url)
 		case sizeof("Node-action"):
 			if (constcmp(t, "Node-action"))
 				continue;
+			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			if (!strcmp(val, "delete")) {
 				node_ctx.action = NODEACT_DELETE;
 			} else if (!strcmp(val, "add")) {
@@ -402,11 +414,13 @@ void svndump_read(const char *url)
 				continue;
 			strbuf_reset(&node_ctx.src);
 			strbuf_addstr(&node_ctx.src, val);
+			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			break;
 		case sizeof("Node-copyfrom-rev"):
 			if (constcmp(t, "Node-copyfrom-rev"))
 				continue;
 			node_ctx.srcRev = atoi(val);
+			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			break;
 		case sizeof("Text-content-length"):
 			if (!constcmp(t, "Text-content-length")) {
@@ -472,6 +486,7 @@ static void init(int report_fd)
 	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
 	strbuf_init(&rev_ctx.author, 4096);
+	strbuf_init(&rev_ctx.note, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
 	reset_dump_ctx(NULL);
@@ -503,6 +518,8 @@ void svndump_deinit(void)
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	strbuf_release(&rev_ctx.log);
+	strbuf_release(&rev_ctx.author);
+	strbuf_release(&rev_ctx.note);
 	strbuf_release(&node_ctx.src);
 	strbuf_release(&node_ctx.dst);
 	if (buffer_deinit(&input))
-- 
1.7.9.5
