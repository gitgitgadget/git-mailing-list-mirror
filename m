From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH 1/4] vcs-svn: add fast_export_note to create notes
Date: Wed, 11 Jul 2012 15:38:50 +0200
Message-ID: <1342013933-14381-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 15:40:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sox9G-0008Gl-9v
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 15:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757819Ab2GKNjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 09:39:44 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35780 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757676Ab2GKNjm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 09:39:42 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1074961bkw.19
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w1hdHYGQ6dBFpDvqOuwJZt+brG9ZaRWIzViPcA3+1lQ=;
        b=y3ZXxAxGZSCRIRRHIBf74NUUMrtVO6Dbm6/mpfQ0mCKLr3t3ZBdd3SD8CidpHjUoL0
         DP2JTZO5+o41NPuq7sSoTeohWVbXNfgtzVggYcrLvEqq833AzAkSnaFWD6KRhUC8+zd3
         41dYy3Xa/1Oy92/85bWj/5i71jiNRo50YuuvG9k+ircbQ+S1GE2KDFzwHTFwM8qHQ7AI
         6xKFJZBnnkaX5cZfBUNrqQQU9GDavgaWngD7L9nTE0a7qQBeFPM06zCYNAQC4m5NOdhA
         dpOlv51uoTvZ59wsu970Zem9ndGO/BQeCcQb0rLrFuUuHcdhbnNhZVqYpOCVWtfc1UYm
         TJ2g==
Received: by 10.205.123.133 with SMTP id gk5mr15911063bkc.140.1342013982008;
        Wed, 11 Jul 2012 06:39:42 -0700 (PDT)
Received: from flobuntu.lan (91-115-86-162.adsl.highway.telekom.at. [91.115.86.162])
        by mx.google.com with ESMTPS id fu8sm1207082bkc.5.2012.07.11.06.39.34
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Jul 2012 06:39:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201295>

From: Dmitry Ivankov <divanorama@gmail.com>

fast_export lacked a method to writes notes to fast-import stream.
Add two new functions fast_export_note which is similar to
fast_export_modify. And also add fast_export_buf_to_data to be able
to write inline blobs that don't come from a line_buffer or from delta
application.

To be used like this:
fast_export_begin_commit("refs/notes/somenotes", ...)

fast_export_note("refs/heads/master", "inline")
fast_export_buf_to_data(&data)
or maybe
fast_export_note("refs/heads/master", sha1)

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 vcs-svn/fast_export.c |   13 +++++++++++++
 vcs-svn/fast_export.h |    2 ++
 2 files changed, 15 insertions(+)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index b823b85..ec7a1c1 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -73,11 +73,17 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 	putchar('\n');
 }
 
+void fast_export_note(const char *committish, const char *dataref)
+{
+	printf("N %s %s\n", dataref, committish);
+}
+
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log,
 			const char *uuid, const char *url,
 			unsigned long timestamp)
+
 {
 	static const struct strbuf empty = STRBUF_INIT;
 	if (!log)
@@ -227,6 +233,13 @@ static long apply_delta(off_t len, struct line_buffer *input,
 	return ret;
 }
 
+void fast_export_buf_to_data(const struct strbuf *data)
+{
+	printf("data %"PRIuMAX"\n", (uintmax_t)data->len);
+	fwrite(data->buf, data->len, 1, stdout);
+	fputc('\n', stdout);
+}
+
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input)
 {
 	assert(len >= 0);
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index aa629f5..62bac44 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -10,11 +10,13 @@ void fast_export_reset(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
+void fast_export_note(const char *committish, const char *dataref);
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,
 			const char *url, unsigned long timestamp);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
+void fast_export_buf_to_data(const struct strbuf *data);
 void fast_export_blob_delta(uint32_t mode,
 			uint32_t old_mode, const char *old_data,
 			off_t len, struct line_buffer *input);
-- 
1.7.9.5
