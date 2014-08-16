From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 01/11] trailer: add data structures and basic functions
Date: Sat, 16 Aug 2014 18:06:11 +0200
Message-ID: <20140816160622.18221.91703.chriscool@tuxfamily.org>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 18:31:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIgse-0005Tz-R0
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 18:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbaHPQac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 12:30:32 -0400
Received: from gleek.ethostream.com ([66.195.129.15]:57330 "EHLO
	barracuda.ethostream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbaHPQab (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 12:30:31 -0400
X-ASG-Debug-ID: 1408205475-016a7707b5114cee0001-QuoKaX
Received: from relay.ethostream.com (www1.ethostream.com [66.195.129.11]) by barracuda.ethostream.com with ESMTP id 8sDd2Ek1DNofsvOD; Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-Barracuda-Envelope-From: chriscool@tuxfamily.org
X-Barracuda-Apparent-Source-IP: 66.195.129.11
Received: from ethoserver.ezone.net (unknown [10.230.15.218])
	by relay.ethostream.com (Postfix) with ESMTPA id 6E6E7890B0D;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
Received: from [127.0.1.1] (unknown [10.0.7.4])
	by ethoserver.ezone.net (Postfix) with ESMTP id 2C7CEC548A6;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-ASG-Orig-Subj: [PATCH v13 01/11] trailer: add data structures and basic functions
X-git-sha1: 55eb6b4cb8a91f576c6c9cbd8e443d019979eb3d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140816153440.18221.29179.chriscool@tuxfamily.org>
X-Barracuda-Connect: www1.ethostream.com[66.195.129.11]
X-Barracuda-Start-Time: 1408205475
X-Barracuda-URL: http://66.195.129.15:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ethostream.com
X-Barracuda-Spam-Score: 3.38
X-Barracuda-Spam-Status: No, SCORE=3.38 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=FH_DATE_PAST_20XX
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.138343
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	3.38 FH_DATE_PAST_20XX      The date is grossly in the future.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255329>

We will use a doubly linked list to store all information
about trailers and their configuration.

This way we can easily remove or add trailers to or from
trailer lists while traversing the lists in either direction.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile  |  1 +
 trailer.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
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
index 0000000..2adc1b7
--- /dev/null
+++ b/trailer.c
@@ -0,0 +1,64 @@
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
+/* Get the length of buf from its beginning until its last alphanumeric character */
+static size_t alnum_len(const char *buf, size_t len)
+{
+	while (len > 0 && !isalnum(buf[len - 1]))
+		len--;
+	return len;
+}
+
+static int same_token(struct trailer_item *a, struct trailer_item *b)
+{
+	size_t a_alnum_len = alnum_len(a->token, strlen(a->token));
+	size_t b_alnum_len = alnum_len(b->token, strlen(b->token));
+	size_t min_alnum_len = (a_alnum_len > b_alnum_len) ? b_alnum_len : a_alnum_len;
+
+	return !strncasecmp(a->token, b->token, min_alnum_len);
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
2.0.1.674.ga7f57b7
