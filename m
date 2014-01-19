From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 01/16] Add data structures and basic functions for commit
 trailers
Date: Sun, 19 Jan 2014 09:53:39 +0100
Message-ID: <20140119085355.2734.62946.chriscool@tuxfamily.org>
References: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 09:55:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4oA3-0008KQ-1h
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 09:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbaASIyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 03:54:49 -0500
Received: from [194.158.98.15] ([194.158.98.15]:49872 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751358AbaASIyq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 03:54:46 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 7BB4231;
	Sun, 19 Jan 2014 09:54:25 +0100 (CET)
X-git-sha1: 30110001219dba8d15fff6dd029f7db13117168f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240676>

We will use a doubly linked list to store all information
about trailers and their configuration.

This way we can easily remove or add trailers to or from
trailer lists while traversing the lists in either direction.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile  |  1 +
 trailer.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 trailer.c

diff --git a/Makefile b/Makefile
index b4af1e2..ec90feb 100644
--- a/Makefile
+++ b/Makefile
@@ -871,6 +871,7 @@ LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
+LIB_OBJS += trailer.o
 LIB_OBJS += transport.o
 LIB_OBJS += transport-helper.o
 LIB_OBJS += tree-diff.o
diff --git a/trailer.c b/trailer.c
new file mode 100644
index 0000000..d80d047
--- /dev/null
+++ b/trailer.c
@@ -0,0 +1,47 @@
+#include "cache.h"
+/*
+ * Copyright (c) 2013 Christian Couder <chriscool@tuxfamily.org>
+ */
+
+enum action_where { WHERE_AFTER, WHERE_BEFORE };
+enum action_if_exist { EXIST_ADD_IF_DIFFERENT, EXIST_ADD_IF_DIFFERENT_NEIGHBOR,
+		       EXIST_ADD, EXIST_OVERWRITE, EXIST_DO_NOTHING };
+enum action_if_missing { MISSING_ADD, MISSING_DO_NOTHING };
+
+struct conf_info {
+	char *name;
+	char *key;
+	char *command;
+	enum action_where where;
+	enum action_if_exist if_exist;
+	enum action_if_missing if_missing;
+};
+
+struct trailer_item {
+	struct trailer_item *previous;
+	struct trailer_item *next;
+	const char *token;
+	const char *value;
+	struct conf_info *conf;
+};
+
+static int same_token(struct trailer_item *a, struct trailer_item *b, int alnum_len)
+{
+	return !strncasecmp(a->token, b->token, alnum_len);
+}
+
+static int same_value(struct trailer_item *a, struct trailer_item *b)
+{
+	return !strcasecmp(a->value, b->value);
+}
+
+static int same_trailer(struct trailer_item *a, struct trailer_item *b, int alnum_len)
+{
+	return same_token(a, b, alnum_len) && same_value(a, b);
+}
+
+/* Get the length of buf from its beginning until its last alphanumeric character */
+static size_t alnum_len(const char *buf, size_t len) {
+	while (--len >= 0 && !isalnum(buf[len]));
+	return len + 1;
+}
-- 
1.8.5.2.201.gacc5987
