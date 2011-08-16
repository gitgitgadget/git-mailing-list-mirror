From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 10/10] vcs-svn: add fast_export_note to create notes
Date: Tue, 16 Aug 2011 15:54:55 +0600
Message-ID: <1313488495-2203-11-git-send-email-divanorama@gmail.com>
References: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 11:54:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGM4-0008Ps-PH
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 11:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab1HPJyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 05:54:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126Ab1HPJyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 05:54:13 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3585259bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 02:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r30Ohx74QxAD8RnvAYejh64z0CF5SZBbib7V56cDvs0=;
        b=X75p63Gz+LdWQmAsUC+YXVxIHUeKnYX/qH/+SBcyrv+gz+p1bm3s+9Ud6LwNY9Rumn
         EXZ5aMvEbk8veRH5o+KVKngvJIFNQWB23U7mEl6Ky6te6hJhXTHvl/d8xzM8vhhTyZ8v
         WSe0XOBGel5iF9iCiv0vLWhBBPsbLadKD60Ro=
Received: by 10.204.203.2 with SMTP id fg2mr1412407bkb.26.1313488453252;
        Tue, 16 Aug 2011 02:54:13 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zx9sm1841723bkb.61.2011.08.16.02.54.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 02:54:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179422>

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
---
 vcs-svn/fast_export.c |   11 +++++++++++
 vcs-svn/fast_export.h |    2 ++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 3dfccd2..07220b0 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -69,6 +69,10 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 	putchar('\n');
 }
 
+void fast_export_note(const char *committish, const char *dataref) {
+	printf("N %s %s\n", dataref, committish);
+}
+
 void fast_export_begin_commit(const char *ref, uint32_t mark, const char *from,
 			const char *author_name, const char *author_email,
 			const struct strbuf *log, unsigned long timestamp)
@@ -206,6 +210,13 @@ static long apply_delta(off_t len, struct line_buffer *input,
 	return ret;
 }
 
+void fast_export_buf_to_data(const struct strbuf *data)
+{
+	printf("data %"PRIuMAX"\n", (uintmax_t)data->len);
+	fwrite(data->buf, data->len, 1, stdout);
+	fputc('\n', stdout);
+}
+
 void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input)
 {
 	if (mode == REPO_MODE_LNK) {
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index bf58880..d17e5d3 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -10,10 +10,12 @@ void fast_export_reset(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
+void fast_export_note(const char *committish, const char *dataref);
 void fast_export_begin_commit(const char *ref, uint32_t mark, const char *from,
 			const char *author_name, const char *author_email,
 			const struct strbuf *log, unsigned long timestamp);
 void fast_export_progress(uint32_t revision);
+void fast_export_buf_to_data(const struct strbuf *data);
 void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input);
 void fast_export_blob_delta(uint32_t mode,
 			uint32_t old_mode, const char *old_data,
-- 
1.7.3.4
