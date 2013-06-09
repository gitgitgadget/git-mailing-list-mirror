From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 15/36] builtin: add rewrite helper
Date: Sun,  9 Jun 2013 14:24:29 -0500
Message-ID: <1370805890-3453-16-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHI-0003fR-G2
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305Ab3FIT1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:30 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:45718 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab3FIT11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:27 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so9157224obb.32
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iLdsMCnnpajp8jLkXlZEta4o0bZnGI+78HlM4a4AcXA=;
        b=SrtuENPVDCFkCnIyfVXjDttnMu3GKQMjvtMcMJDgCwWuEiJ7Ib7aeOy4f0TCc1a42J
         3ZoFsO+FsU5XAZHWWCDJBC8EBuJMmK/p8gUViFDStz/3yuuXNAyMBW8mexEyh1oI5RIr
         Y91o/H0r5d0iSq3cpajde5MelWSxpoWUZ0be/UPsW6Tl9jpK8YPcZAHMA6AE/haFpYE/
         +ZddChF1v2bx/gktljFO7fyWMpoWuXqfDpHdCGKxUn/7VLhch4+j7qGV0Wtqy9SDnFks
         QNneY+9nTFlJb0xkjh6QAd7pyF7QEFv4uz+oMq6uUKirKsi+nZh+uiIRboK1CwSAYVxe
         oHTA==
X-Received: by 10.60.39.165 with SMTP id q5mr5475407oek.109.1370806047531;
        Sun, 09 Jun 2013 12:27:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm15944259oby.12.2013.06.09.12.27.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227123>

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
