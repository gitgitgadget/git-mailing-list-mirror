From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/13] rerere: explain the rerere I/O abstraction
Date: Tue, 30 Jun 2015 23:04:54 -0700
Message-ID: <1435730699-9124-9-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:05:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB9N-0004LR-PY
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbbGAGFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:33 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35510 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbGAGFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:14 -0400
Received: by iecuq6 with SMTP id uq6so27810297iec.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=YP+LMV1A92II6+k5TzVkiIfVg8mP/I4ZK3liZ0kEj0o=;
        b=pdV4Sim3UG9GAuZ1CoWWlufXKnKYUx/vtpRgX52O/+gtksNVNc6maUWlwS0ZXvd+Ag
         yHeaIXGnpPM14FVcobGu4PRnONXTekX6+WGOrIjPPOHEcJ6hT9uPiDa8E5YrJfSmBPGf
         bbqYu8WURp5HbVxGQ4WUef+kcYXRktqCx26WhufTmDyc53GQbE4dZ+OpPmXHkdjau1T3
         0GuSXEHmXgceVKshct8o2Tl1IjNyS00LbmGyErkgChBfcQiqF6J+hQPjavXDD/pZhUDH
         SJ15tVdgzG57+m7qrN5oUutuGgihSSHcFtuldBSuu572BH2nG6nXrjhX00oG3JyRRL9A
         P0Kg==
X-Received: by 10.42.131.202 with SMTP id a10mr1979408ict.49.1435730713814;
        Tue, 30 Jun 2015 23:05:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id p138sm670137ioe.35.2015.06.30.23.05.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273125>

Explain the internals of rerere as in-code comments.

This one covers our thin I/O abstraction to read from either
a file or a memory while optionally writing out to a file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/rerere.c b/rerere.c
index 7b1419c..7ed20f1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -83,6 +83,21 @@ static int write_rr(struct string_list *rr, int out_fd)
 	return 0;
 }
 
+/*
+ * "rerere" interacts with conflicted file contents using this I/O
+ * abstraction.  It reads a conflicted contents from one place via
+ * "getline()" method, and optionally can write it out after
+ * normalizing the conflicted hunks to the "output".  Subclasses of
+ * rerere_io embed this structure at the beginning of their own
+ * rerere_io object.
+ */
+struct rerere_io {
+	int (*getline)(struct strbuf *, struct rerere_io *);
+	FILE *output;
+	int wrerror;
+	/* some more stuff */
+};
+
 static void ferr_write(const void *p, size_t count, FILE *fp, int *err)
 {
 	if (!count || *err)
@@ -96,19 +111,15 @@ static inline void ferr_puts(const char *s, FILE *fp, int *err)
 	ferr_write(s, strlen(s), fp, err);
 }
 
-struct rerere_io {
-	int (*getline)(struct strbuf *, struct rerere_io *);
-	FILE *output;
-	int wrerror;
-	/* some more stuff */
-};
-
 static void rerere_io_putstr(const char *str, struct rerere_io *io)
 {
 	if (io->output)
 		ferr_puts(str, io->output, &io->wrerror);
 }
 
+/*
+ * Write a conflict marker to io->output (if defined).
+ */
 static void rerere_io_putconflict(int ch, int size, struct rerere_io *io)
 {
 	char buf[64];
@@ -137,11 +148,17 @@ static void rerere_io_putmem(const char *mem, size_t sz, struct rerere_io *io)
 		ferr_write(mem, sz, io->output, &io->wrerror);
 }
 
+/*
+ * Subclass of rerere_io that reads from an on-disk file
+ */
 struct rerere_io_file {
 	struct rerere_io io;
 	FILE *input;
 };
 
+/*
+ * ... and its getline() method implementation
+ */
 static int rerere_file_getline(struct strbuf *sb, struct rerere_io *io_)
 {
 	struct rerere_io_file *io = (struct rerere_io_file *)io_;
@@ -286,11 +303,18 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 	return hunk_no;
 }
 
+/*
+ * Subclass of rerere_io that reads from an in-core buffer that is a
+ * strbuf
+ */
 struct rerere_io_mem {
 	struct rerere_io io;
 	struct strbuf input;
 };
 
+/*
+ * ... and its getline() method implementation
+ */
 static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
 {
 	struct rerere_io_mem *io = (struct rerere_io_mem *)io_;
-- 
2.5.0-rc0-209-g5e1f148
