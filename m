From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 12/17] rebase-todo: introduce rebase_todo_item
Date: Sat, 12 Mar 2016 18:46:32 +0800
Message-ID: <1457779597-6918-13-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh5J-0006B3-Gm
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbcCLKrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:40 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35884 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbcCLKrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:32 -0500
Received: by mail-pa0-f49.google.com with SMTP id tt10so119743308pab.3
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kY4QLux9RLJXiI+8wSlP4OZAZl1vhkVuHpN/7OEJI1o=;
        b=UJIql7JS4106vqPqNRDZncGNOqmuUkJHULo1qtwCU/p2MujkCiIAoVf/u2sguqqO7i
         I5k1/LGXtkHrHLhPC4hl59QtbSaR2pcCYOIBYMd4rlrFoN6bR1dvkJcasXeEJPz9K/uk
         F7bfP82w4aGaopclqKYsRVA6aenMjyzaoayqS1NpIv46gmhxw3BMyB6KiXxwmoianS+D
         ZxNzbJSs7ycD/SQ3y8VJ/HHqqw5Bjg6GMwysiBNm8gNUMQ0mjTcTOYb9TNcftPjNjxkf
         6dw9iEyL+REaGNHN6LU7G7KP9AhD5/A3XxYj8vE8XtUu5Q46gVw2uCb6N7QrmA0ffqzW
         aoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kY4QLux9RLJXiI+8wSlP4OZAZl1vhkVuHpN/7OEJI1o=;
        b=YTjFVItkFAVniUgyM6xcDMcMHQT29MKAVV7MRIiRT2ffsmG+lQ9EqL6THAUp6oSUTy
         xR8bZT4JSBcIc3+Gx1+mWKQfENG42aQV50Orjkqj1WjiGRphz8lF09liaf8AMJrHlA71
         1ifrzhLl9PPymFk9b+bFgWk4TWl1lbWZD4oUqWwWuvE6j+JsW6u9y1Ic50axpYcXHFBV
         iPVL217gUDdGebpU39QNgwcBV31mks7luiYxSVPk9rp/OEtssHbd0Z4XTzp9vDSxJ0wJ
         fz/CjNpPRT0Rt5SOi5ajtiqXoscMs8r+cQJklmyaUMIti7+6khK3bd09bLrRNaOR7NsT
         x0Qw==
X-Gm-Message-State: AD7BkJLHn+qogbFVcDiUZROWgylT6KtPaxRx4XE+iFqyaJWrjW7qAZht2AJxKgZ1EQtivQ==
X-Received: by 10.66.97.8 with SMTP id dw8mr22930942pab.28.1457779652121;
        Sat, 12 Mar 2016 02:47:32 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:31 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288741>

In an interactive rebase, commands are read and executed from a todo
list (.git/rebase-merge/git-rebase-todo) to perform the rebase.

In the upcoming re-implementation of git-rebase -i in C, it is useful to
be able to parse each command into a data structure which can then be
operated on. Implement rebase_todo_item for this.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile      |   1 +
 rebase-todo.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rebase-todo.h |  28 ++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 rebase-todo.c
 create mode 100644 rebase-todo.h

diff --git a/Makefile b/Makefile
index d43e068..8b928e4 100644
--- a/Makefile
+++ b/Makefile
@@ -782,6 +782,7 @@ LIB_OBJS += read-cache.o
 LIB_OBJS += rebase-am.o
 LIB_OBJS += rebase-common.o
 LIB_OBJS += rebase-merge.o
+LIB_OBJS += rebase-todo.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/files-backend.o
diff --git a/rebase-todo.c b/rebase-todo.c
new file mode 100644
index 0000000..ac6b222
--- /dev/null
+++ b/rebase-todo.c
@@ -0,0 +1,144 @@
+#include "cache.h"
+#include "rebase-todo.h"
+
+/*
+ * Used as the default `rest` value, so that users can always assume `rest` is
+ * non NULL and `rest` is NUL terminated even for a freshly initialized
+ * rebase_todo_item.
+ */
+static char rebase_todo_item_slopbuf[1];
+
+void rebase_todo_item_init(struct rebase_todo_item *item)
+{
+	item->action = REBASE_TODO_NONE;
+	oidclr(&item->oid);
+	item->rest = rebase_todo_item_slopbuf;
+}
+
+void rebase_todo_item_release(struct rebase_todo_item *item)
+{
+	if (item->rest != rebase_todo_item_slopbuf)
+		free(item->rest);
+	rebase_todo_item_init(item);
+}
+
+void rebase_todo_item_copy(struct rebase_todo_item *dst, const struct rebase_todo_item *src)
+{
+	if (dst->rest != rebase_todo_item_slopbuf)
+		free(dst->rest);
+	*dst = *src;
+	dst->rest = xstrdup(src->rest);
+}
+
+static const char *next_word(struct strbuf *sb, const char *str)
+{
+	const char *end;
+
+	while (*str && isspace(*str))
+		str++;
+
+	end = str;
+	while (*end && !isspace(*end))
+		end++;
+
+	strbuf_reset(sb);
+	strbuf_add(sb, str, end - str);
+	return end;
+}
+
+int rebase_todo_item_parse(struct rebase_todo_item *item, const char *line, int abbrev)
+{
+	struct strbuf word = STRBUF_INIT;
+	const char *str = line;
+	int has_oid = 1, ret = 0;
+
+	while (*str && isspace(*str))
+		str++;
+
+	if (!*str || *str == comment_line_char) {
+		item->action = REBASE_TODO_NONE;
+		oidclr(&item->oid);
+		if (item->rest != rebase_todo_item_slopbuf)
+			free(item->rest);
+		item->rest = *str ? xstrdup(str) : rebase_todo_item_slopbuf;
+		return 0;
+	}
+
+	str = next_word(&word, str);
+	if (!strcmp(word.buf, "noop")) {
+		item->action = REBASE_TODO_NOOP;
+		has_oid = 0;
+	} else if (!strcmp(word.buf, "pick") || !strcmp(word.buf, "p")) {
+		item->action = REBASE_TODO_PICK;
+	} else {
+		ret = error(_("Unknown command: %s"), word.buf);
+		goto finish;
+	}
+
+	if (has_oid) {
+		str = next_word(&word, str);
+		if (abbrev) {
+			/* accept abbreviated object ids */
+			if (get_oid_commit(word.buf, &item->oid)) {
+				ret = error(_("Not a commit: %s"), word.buf);
+				goto finish;
+			}
+		} else {
+			if (word.len != GIT_SHA1_HEXSZ || get_oid_hex(word.buf, &item->oid)) {
+				ret = error(_("Invalid line: %s"), line);
+				goto finish;
+			}
+		}
+	} else {
+		oidclr(&item->oid);
+	}
+
+	if (*str && isspace(*str))
+		str++;
+	if (*str) {
+		if (item->rest != rebase_todo_item_slopbuf)
+			free(item->rest);
+		item->rest = xstrdup(str);
+	}
+
+finish:
+	strbuf_release(&word);
+	return ret;
+}
+
+void strbuf_add_rebase_todo_item(struct strbuf *sb,
+				 const struct rebase_todo_item *item, int abbrev)
+{
+	int has_oid = 1;
+
+	switch (item->action) {
+	case REBASE_TODO_NONE:
+		has_oid = 0;
+		break;
+	case REBASE_TODO_NOOP:
+		strbuf_addstr(sb, "noop");
+		has_oid = 0;
+		break;
+	case REBASE_TODO_PICK:
+		strbuf_addstr(sb, "pick");
+		break;
+	default:
+		die("BUG: invalid rebase_todo_item action %d", item->action);
+	}
+
+	if (has_oid) {
+		strbuf_addch(sb, ' ');
+		if (abbrev)
+			strbuf_addstr(sb, find_unique_abbrev((unsigned char *)&item->oid.hash, DEFAULT_ABBREV));
+		else
+			strbuf_addstr(sb, oid_to_hex(&item->oid));
+	}
+
+	if (*item->rest) {
+		if (item->action != REBASE_TODO_NONE)
+			strbuf_addch(sb, ' ');
+		strbuf_addstr(sb, item->rest);
+	}
+
+	strbuf_addch(sb, '\n');
+}
diff --git a/rebase-todo.h b/rebase-todo.h
new file mode 100644
index 0000000..2eedbb0
--- /dev/null
+++ b/rebase-todo.h
@@ -0,0 +1,28 @@
+#ifndef REBASE_TODO_H
+#define REBASE_TODO_H
+
+struct strbuf;
+
+enum rebase_todo_action {
+	REBASE_TODO_NONE = 0,
+	REBASE_TODO_NOOP,
+	REBASE_TODO_PICK
+};
+
+struct rebase_todo_item {
+	enum rebase_todo_action action;
+	struct object_id oid;
+	char *rest;
+};
+
+void rebase_todo_item_init(struct rebase_todo_item *);
+
+void rebase_todo_item_release(struct rebase_todo_item *);
+
+void rebase_todo_item_copy(struct rebase_todo_item *, const struct rebase_todo_item *);
+
+int rebase_todo_item_parse(struct rebase_todo_item *, const char *line, int abbrev);
+
+void strbuf_add_rebase_todo_item(struct strbuf *, const struct rebase_todo_item *, int abbrev);
+
+#endif /* REBASE_TODO_H */
-- 
2.7.0
