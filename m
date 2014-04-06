From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v10 01/12] trailer: add data structures and basic functions
Date: Sun, 06 Apr 2014 19:01:52 +0200
Message-ID: <20140406170204.15116.49111.chriscool@tuxfamily.org>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:45:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEXS-0003za-M5
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbaDGSoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:44:00 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:46680 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755867AbaDGSn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:43:59 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 0BF4436;
	Mon,  7 Apr 2014 20:43:57 +0200 (CEST)
X-git-sha1: a978e1433f90eeea93c44498371326cfe34f7662 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140406163214.15116.91484.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245884>

We will use a doubly linked list to store all information
about trailers and their configuration.

This way we can easily remove or add trailers to or from
trailer lists while traversing the lists in either direction.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile  |  1 +
 trailer.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 trailer.c

diff --git a/Makefile b/Makefile
index c5316a3..179be0a 100644
--- a/Makefile
+++ b/Makefile
@@ -879,6 +879,7 @@ LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
+LIB_OBJS += trailer.o
 LIB_OBJS += transport.o
 LIB_OBJS += transport-helper.o
 LIB_OBJS += tree-diff.o
diff --git a/trailer.c b/trailer.c
new file mode 100644
index 0000000..db93a63
--- /dev/null
+++ b/trailer.c
@@ -0,0 +1,49 @@
+#include "cache.h"
+/*
+ * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
+ */
+
+enum action_where { WHERE_AFTER, WHERE_BEFORE };
+enum action_if_exists { EXISTS_ADD_IF_DIFFERENT, EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
+			EXISTS_ADD, EXISTS_OVERWRITE, EXISTS_DO_NOTHING };
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
+struct trailer_item {
+	struct trailer_item *previous;
+	struct trailer_item *next;
+	const char *token;
+	const char *value;
+	struct conf_info conf;
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
+static size_t alnum_len(const char *buf, size_t len)
+{
+	while (len > 0 && !isalnum(buf[len - 1]))
+		len--;
+	return len;
+}
-- 
1.9.0.163.g8ca203c
