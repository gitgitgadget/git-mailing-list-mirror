From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 08/16] vcs-svn: add fast_export_note to create notes
Date: Thu, 26 Jul 2012 09:32:29 +0200
Message-ID: <1343287957-22040-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:35:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIbC-0005DO-4w
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab2GZHei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:38 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab2GZHeg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:36 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vAFOST64AB6xXkSpJ33xknC9dc3y1wRiGEdbAtdkQR0=;
        b=wDzUZjQjR/YvwkQLfR0gm7Upm/03vhSnFOgoVIRIQ5foWX5lCldCJfBtfA1m42Z4Nm
         pagQdgskGs2lZcpoPnC3KloqeCL7yV89vrTC45AaWDk06Z4fiZW8wUAj7XLagk+sle6F
         3rbXsFmDhHPyeOehPYfCefF/F4VZJBt4WcKK+dUHQxgK4yviPYBbBOoE7aCTMvgZbv5S
         sH/k9Pvh2iEZ8rnaTuhoHb3ptUFpof1dQ/knGX2/XYB+f0WeriSGfDgcjPfem2uM7m+2
         Q4ApMEnN483t/Y6SgUz6ccrsIHg2Jb6k3kPFoeyTl4JxvnQQcNBxj3h9yx0DdnxNQaGl
         fQUA==
Received: by 10.204.152.211 with SMTP id h19mr13633116bkw.45.1343288076076;
        Thu, 26 Jul 2012 00:34:36 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.34
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202238>

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
 vcs-svn/fast_export.c |   12 ++++++++++++
 vcs-svn/fast_export.h |    2 ++
 2 files changed, 14 insertions(+)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 11f8f94..1ecae4b 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -68,6 +68,11 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
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
@@ -222,6 +227,13 @@ static long apply_delta(off_t len, struct line_buffer *input,
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
index 17eb13b..9b32f1e 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -9,11 +9,13 @@ void fast_export_deinit(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
+void fast_export_note(const char *committish, const char *dataref);
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,
 			const char *url, unsigned long timestamp, const char *local_ref);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
+void fast_export_buf_to_data(const struct strbuf *data);
 void fast_export_blob_delta(uint32_t mode,
 			uint32_t old_mode, const char *old_data,
 			off_t len, struct line_buffer *input);
-- 
1.7.9.5
