From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 06/12] builtin: add rewrite helper
Date: Wed, 23 Apr 2014 21:44:45 -0500
Message-ID: <1398307491-21314-7-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:55:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9pN-0007kP-UZ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbaDXCzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:55:44 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:44836 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaDXCzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:41 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so1975119obb.26
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vf3E+nfnVaRmonVQYcRq3DEAdZh4lmaWFzl9DiEYFMI=;
        b=KzDEDaOwm1okvtuFr59wLgifvCvfaT1d88R1e2rWq+NQm67pl+wWcu4S+2Syt8wcVp
         Vv0uL/hXrMlp2ninCfwk1hUtfT+uhKjABnKBysqtMBHP2izM/7xSasBd9QWFkxf599Y0
         9M9tSBO0zyyzBb4bHoknkILB7+Jc0P367hqx+pQW05Qrv/0sAhW/pHfI3aKaKIHM3uMt
         rcaJHVDilnQrWT0U9bnXN4wBIJBbUhcJ65fzY5iczgwwEXauqZFOVWGsyaaAohgnb9p1
         ZIWXVlcwsN4d0Hk7sCRrw9lerQhCwao77+jAyZ8h5x+whYoUXIwhN+0dToSyrB51Sz/9
         dJJg==
X-Received: by 10.60.229.228 with SMTP id st4mr45754484oec.16.1398308139991;
        Wed, 23 Apr 2014 19:55:39 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pa3sm5747833obb.6.2014.04.23.19.55.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246922>

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
index 33aa15b..d315b71 100644
--- a/Makefile
+++ b/Makefile
@@ -710,6 +710,7 @@ LIB_H += remote.h
 LIB_H += rerere.h
 LIB_H += resolve-undo.h
 LIB_H += revision.h
+LIB_H += rewrite.h
 LIB_H += run-command.h
 LIB_H += send-pack.h
 LIB_H += sequencer.h
@@ -855,6 +856,7 @@ LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
+LIB_OBJS += rewrite.o
 LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
 LIB_OBJS += sequencer.o
diff --git a/rewrite.c b/rewrite.c
new file mode 100644
index 0000000..436d54a
--- /dev/null
+++ b/rewrite.c
@@ -0,0 +1,71 @@
+#include "cache.h"
+#include "rewrite.h"
+
+void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to)
+{
+	struct rewritten_item *item;
+	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
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
1.9.2+fc1.2.gfbaae8c
