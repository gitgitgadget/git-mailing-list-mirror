From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 05/28] builtin: add rewrite helper
Date: Fri, 30 Aug 2013 00:55:59 -0500
Message-ID: <1377842182-18724-6-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHn3-00081l-Iq
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496Ab3H3GBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:17 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:44919 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab3H3GBN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:13 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so1759761oah.25
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LUcDOPRW5p+WtPXMS3LO3F5IW0BBR+f4TiCkCAsO89Y=;
        b=Lcs4xtpXYTfzkYaJkET6RN4iD3eSh6ODBYfGmtlnddt9IYqBEky9of+/QEFxcjMAd8
         EXSpgbXzsY+UuYMQL/Tn+r44Da5QCO/EQlal+c3XBhQfcBk4qfQytWbcsFwWbzf+xKoO
         mEcqHkEnss9879yILWfdhF3/RpL/qOiHVZbYzlVCSdfmeHzlolQlXD5M9/uuQ7U+bpZ1
         ImZJz6SHtOJ5R7glzUm7Kd0zWXbZfZlvcfODRwdDWoN6WuVhnv/D2A4ab4VKC9mFKX7h
         eYK/7i1hIfZM72Mb72aQRV34f4UVMd3331/4neHTL0/RuyqLXIyMjLoTuw48sHpNg9Im
         qtuA==
X-Received: by 10.182.246.99 with SMTP id xv3mr5445171obc.47.1377842472904;
        Thu, 29 Aug 2013 23:01:12 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d8sm25696859oeu.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233424>

So that we can load and store rewrites, as well as other operations on a
list of rewritten commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile  |  2 ++
 rewrite.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rewrite.h | 18 ++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 rewrite.c
 create mode 100644 rewrite.h

diff --git a/Makefile b/Makefile
index 3588ca1..9396d57 100644
--- a/Makefile
+++ b/Makefile
@@ -716,6 +716,7 @@ LIB_H += remote.h
 LIB_H += rerere.h
 LIB_H += resolve-undo.h
 LIB_H += revision.h
+LIB_H += rewrite.h
 LIB_H += run-command.h
 LIB_H += send-pack.h
 LIB_H += sequencer.h
@@ -860,6 +861,7 @@ LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
+LIB_OBJS += rewrite.o
 LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
 LIB_OBJS += sequencer.o
diff --git a/rewrite.c b/rewrite.c
new file mode 100644
index 0000000..2793688
--- /dev/null
+++ b/rewrite.c
@@ -0,0 +1,71 @@
+#include "cache.h"
+#include "rewrite.h"
+
+void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to)
+{
+	struct rewritten_item *item;
+	ALLOC_GROW(list->items, list->nr, list->alloc);
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
diff --git a/rewrite.h b/rewrite.h
new file mode 100644
index 0000000..09e7222
--- /dev/null
+++ b/rewrite.h
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
1.8.4-fc
