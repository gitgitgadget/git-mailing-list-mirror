From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/18] rerere: explain the rerere I/O abstraction
Date: Fri, 17 Jul 2015 15:24:30 -0700
Message-ID: <1437171880-21590-9-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE4k-0004VS-Ay
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222AbbGQWZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:46 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35708 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139AbbGQWYz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:55 -0400
Received: by pactm7 with SMTP id tm7so67787709pac.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=sIi7TZPlrbTesKmZuY8YhtKrCIkl9GCKzss2C90t824=;
        b=iz7cjSiPdZCONPAtk/VdNT3uutvyeYsqICEaLXW6i3EOBuSj1L1GX33qpE2kqmoowX
         bYR4Rs1nDNhxPTcuJNlhRSMkdv7dmg6iqYRVpehEAndgz3genmoZJ1rG9tzhlMmwEFdV
         F1gWPkXCwO5MRXVhpKQbU4hPrDX1TNPsI6khS+Pxy3jsCptK8AWBhh8+VikUYIudl3Ab
         W5tFa+0VySfsPlCsbKl7xPH1e04Md2V4DqJgB0OLtY//o4pVjgTu15HZKE4EldRiYoON
         hVVXNhx1rQZTutvsobZbQG4LFrySAoXUGt69KKoNkAArqLRLMSP0cTtEFPABFXpRHFpm
         yivQ==
X-Received: by 10.68.228.193 with SMTP id sk1mr33453587pbc.18.1437171894963;
        Fri, 17 Jul 2015 15:24:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id fu2sm12354391pdb.32.2015.07.17.15.24.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:54 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274123>

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
2.5.0-rc2-340-g0cccc16
