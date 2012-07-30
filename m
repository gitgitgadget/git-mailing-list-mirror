From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 08/16] vcs-svn: add fast_export_note to create notes
Date: Mon, 30 Jul 2012 16:31:15 +0200
Message-ID: <1343658683-10713-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:39:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr85-0007vB-Es
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745Ab2G3Oj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:26 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53245 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab2G3OjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:25 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859181bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vAFOST64AB6xXkSpJ33xknC9dc3y1wRiGEdbAtdkQR0=;
        b=hlz5L4wU2KDM/e+RT5vu4nJ3CyaFpVZv6/Wnzt1vzQE47CbzlTXbUq5tqE+7AWPs56
         8o+jp6Ks5a3UiO8gPU/lpjDkO5/KbvqWY0UscIGk8mpXGglvk5qwSg+f/00nEEXXVXvF
         OQf6d0rzpq+0iUjna9gLgO9rViGb1a6uMgASXJ2wSgmjNDfi81nkSBLiXwgL747wFCou
         f/i+bQBfR2ORN+WuXO9ek6NWveHireziugFA/fa4VN1Ngdx3p1k1jkIq93O8wbRSba/9
         tUhCgy7HOM5AtUvcnqulPBIqU7SQtIQf8HHhNz/dyuiLSRh9Pd5uUzEnr43jM/RoPofJ
         Qv7Q==
Received: by 10.205.125.4 with SMTP id gq4mr3930929bkc.109.1343659164494;
        Mon, 30 Jul 2012 07:39:24 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.22
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202549>

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
