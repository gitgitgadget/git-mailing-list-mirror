From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 15/45] builtin: add rewrite helper
Date: Sun,  9 Jun 2013 11:40:27 -0500
Message-ID: <1370796057-25312-16-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UliiS-0006ex-2P
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686Ab3FIQng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:36 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:53278 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3FIQnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:33 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so8939730obc.10
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iLdsMCnnpajp8jLkXlZEta4o0bZnGI+78HlM4a4AcXA=;
        b=T/2HFHoQFSZljOC7twnp1rXvuZT8jjBwdEhClvp2NEfVGilMAEq9FfrmiSlGbieQOv
         rJdRM6kSUjagkn8o73MBfRGfse5NLiVcZ8a0ntwManhpVLMli033AsACRYV/ygEnTnh8
         SdIOKSnctWaIbIG9KwDu9I9OD9UIZ3lCFi/n8MRzsLkaR4G/SdEMEK9yOZGrWADtDbUX
         nByItAIGDgNiU+/UuMte0F3Cnat0IlW26se01fCzTyUpXcdmjSVqq7BOZpFw62bsabLi
         JUUal+jIMa+Ewitrc7afxVXgPpxctJd7TQ9G2hdMEiaRyLO5dC+dg9rexCQH0X8E1JtR
         HGwQ==
X-Received: by 10.182.233.227 with SMTP id tz3mr5341890obc.23.1370796213355;
        Sun, 09 Jun 2013 09:43:33 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm215762oed.5.2013.06.09.09.43.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226984>

So that we can load and store rewrites, as well as other operations on a
list of rewritten commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile          |  1 +
 builtin/rewrite.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin/rewrite.h | 18 ++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 builtin/rewrite.c
 create mode 100644 builtin/rewrite.h

diff --git a/Makefile b/Makefile
index 4c7bb88..a167e68 100644
--- a/Makefile
+++ b/Makefile
@@ -991,6 +991,7 @@ BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/write-tree.o
 
 BUILTIN_LIB_OBJS += builtin/sequencer.o
+BUILTIN_LIB_OBJS += builtin/rewrite.o
 BUILTIN_LIB_OBJS += $(BUILTIN_OBJS)
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
diff --git a/builtin/rewrite.c b/builtin/rewrite.c
new file mode 100644
index 0000000..2519352
--- /dev/null
+++ b/builtin/rewrite.c
@@ -0,0 +1,74 @@
+#include "cache.h"
+#include "rewrite.h"
+
+void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to)
+{
+	struct rewritten_item *item;
+	if (list->nr + 1 >= list->alloc) {
+		list->alloc += 32;
+		list->items = xrealloc(list->items, list->alloc * sizeof(*list->items));
+	}
+	item = &list->items[list->nr];
+	hashcpy(item->from, from);
+	hashcpy(item->to, to);
+	list->nr++;
+}
+
+int store_rewritten(struct rewritten *list, const char *file)
+{
+	static struct lock_file lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd, i, ret = 0;
+
+	fd = hold_lock_file_for_update(&lock, file, LOCK_DIE_ON_ERROR);
+	for (i = 0; i < list->nr; i++) {
+		struct rewritten_item *item = &list->items[i];
+		strbuf_addf(&buf, "%s %s\n", sha1_to_hex(item->from), sha1_to_hex(item->to));
+	}
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		error(_("Could not write to %s"), file);
+		ret = 1;
+		goto leave;
+	}
+	if (commit_lock_file(&lock) < 0) {
+		error(_("Error wrapping up %s."), file);
+		ret = 1;
+		goto leave;
+	}
+leave:
+	strbuf_release(&buf);
+	return ret;
+}
+
+void load_rewritten(struct rewritten *list, const char *file)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *p;
+	int fd;
+
+	fd = open(file, O_RDONLY);
+	if (fd < 0)
+		return;
+	if (strbuf_read(&buf, fd, 0) < 0) {
+		close(fd);
+		strbuf_release(&buf);
+		return;
+	}
+	close(fd);
+
+	for (p = buf.buf; *p;) {
+		unsigned char from[20];
+		unsigned char to[20];
+		char *eol = strchrnul(p, '\n');
+		if (eol - p != 81)
+			/* wrong size */
+			break;
+		if (get_sha1_hex(p, from))
+			break;
+		if (get_sha1_hex(p + 41, to))
+			break;
+		add_rewritten(list, from, to);
+		p = *eol ? eol + 1 : eol;
+	}
+	strbuf_release(&buf);
+}
diff --git a/builtin/rewrite.h b/builtin/rewrite.h
new file mode 100644
index 0000000..09e7222
--- /dev/null
+++ b/builtin/rewrite.h
@@ -0,0 +1,18 @@
+#ifndef REWRITE_H
+#define REWRITE_H
+
+struct rewritten_item {
+	unsigned char from[20];
+	unsigned char to[20];
+};
+
+struct rewritten {
+	struct rewritten_item *items;
+	unsigned int nr, alloc;
+};
+
+void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to);
+int store_rewritten(struct rewritten *list, const char *file);
+void load_rewritten(struct rewritten *list, const char *file);
+
+#endif
-- 
1.8.3.698.g079b096
