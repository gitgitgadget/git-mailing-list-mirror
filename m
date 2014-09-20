From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v15 01/11] trailer: add data structures and basic functions
Date: Sat, 20 Sep 2014 15:45:04 +0200
Message-ID: <20140920134515.18999.40219.chriscool@tuxfamily.org>
References: <20140920134048.18999.79434.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 15:48:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVL1x-0006m9-P7
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 15:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbaITNsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 09:48:37 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:63920 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbaITNsf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 09:48:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 5994A72;
	Sat, 20 Sep 2014 15:48:33 +0200 (CEST)
X-git-sha1: 0130b5daeb0be31e79f50bb8e19c1ad82b21ca64 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140920134048.18999.79434.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257313>

We will use a doubly linked list to store all information
about trailers and their configuration.

This way we can easily remove or add trailers to or from
trailer lists while traversing the lists in either direction.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile  |  1 +
 trailer.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 trailer.c

diff --git a/Makefile b/Makefile
index 63a210d..ef82972 100644
--- a/Makefile
+++ b/Makefile
@@ -888,6 +888,7 @@ LIB_OBJS += submodule-config.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
+LIB_OBJS += trailer.o
 LIB_OBJS += transport.o
 LIB_OBJS += transport-helper.o
 LIB_OBJS += tree-diff.o
diff --git a/trailer.c b/trailer.c
new file mode 100644
index 0000000..ac323b1
--- /dev/null
+++ b/trailer.c
@@ -0,0 +1,69 @@
+#include "cache.h"
+/*
+ * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
+ */
+
+enum action_where { WHERE_END, WHERE_AFTER, WHERE_BEFORE, WHERE_START };
+enum action_if_exists { EXISTS_ADD_IF_DIFFERENT_NEIGHBOR, EXISTS_ADD_IF_DIFFERENT,
+			EXISTS_ADD, EXISTS_REPLACE, EXISTS_DO_NOTHING };
+enum action_if_missing { MISSING_ADD, MISSING_DO_NOTHING };
+
+struct conf_info {
+	char *name;
+	char *key;
+	char *command;
+	enum action_where where;
+	enum action_if_exists if_exists;
+	enum action_if_missing if_missing;
+};
+
+static struct conf_info default_conf_info;
+
+struct trailer_item {
+	struct trailer_item *previous;
+	struct trailer_item *next;
+	const char *token;
+	const char *value;
+	struct conf_info conf;
+};
+
+static struct trailer_item *first_conf_item;
+
+static char *separators = ":";
+
+static int after_or_end(enum action_where where)
+{
+	return (where == WHERE_AFTER) || (where == WHERE_END);
+}
+
+/*
+ * Return the length of the string not including any final
+ * punctuation. E.g., the input "Signed-off-by:" would return
+ * 13, stripping the trailing punctuation but retaining
+ * internal punctuation.
+ */
+static size_t token_len_without_separator(const char *token, size_t len)
+{
+	while (len > 0 && !isalnum(token[len - 1]))
+		len--;
+	return len;
+}
+
+static int same_token(struct trailer_item *a, struct trailer_item *b)
+{
+	size_t a_len = token_len_without_separator(a->token, strlen(a->token));
+	size_t b_len = token_len_without_separator(b->token, strlen(b->token));
+	size_t min_len = (a_len > b_len) ? b_len : a_len;
+
+	return !strncasecmp(a->token, b->token, min_len);
+}
+
+static int same_value(struct trailer_item *a, struct trailer_item *b)
+{
+	return !strcasecmp(a->value, b->value);
+}
+
+static int same_trailer(struct trailer_item *a, struct trailer_item *b)
+{
+	return same_token(a, b) && same_value(a, b);
+}
-- 
2.0.3.960.g41c6e4c
