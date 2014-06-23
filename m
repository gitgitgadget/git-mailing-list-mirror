From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 3/3] test-config: add usage examples for non-callback query functions
Date: Mon, 23 Jun 2014 03:11:40 -0700
Message-ID: <1403518300-23053-4-git-send-email-tanayabh@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 12:13:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1Fh-0001yg-Aq
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbaFWKNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:13:22 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:44509 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaFWKNV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:13:21 -0400
Received: by mail-pb0-f52.google.com with SMTP id rq2so5713322pbb.39
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SKnV40+9xgqRQh5pElOlORKqSQqfbR59/vVSHNUUH0E=;
        b=mo3tPOHyqgCESUCw97WIyxGPZq4ZhXdWzxGwDPw7qR77Tuk+HyjVMUcl4QYe+kuRwy
         13OK+wM62UILLklUpW++ayWxS5nkzgWQPQbDZ9//S9r9aZKKmle36PF05LHTjRcXiCAf
         3IG/YwH9ASXJiHsHav87raR0KNp8Ie910JtnRFeQ1P3FY3xKizEM/fYIgFaBWIWVpCuD
         OXKZcn3PWG4WSqWgPqkV1cE68mfRH1SapbSSwfRCTNN5XEZbCDdD9oMqo9MhZ02xco1P
         Aa/z1IBYRO8cFBExZFdGKBS0MuZ+QdSzbfXkKgpZ/poqgDPFo1ILwRWiedgJpaoIpjut
         NN1g==
X-Received: by 10.68.194.229 with SMTP id hz5mr27360670pbc.91.1403518400830;
        Mon, 23 Jun 2014 03:13:20 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.81])
        by mx.google.com with ESMTPSA id io8sm26085321pbc.96.2014.06.23.03.13.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 03:13:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252332>

Add different usage examples for 'git_config_get_string' and
`git_config_get_string_multi`. They will serve as documentation
on how to query for config values in a non-callback manner.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 .gitignore    |  1 +
 Makefile      |  1 +
 test-config.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 test-config.c

diff --git a/.gitignore b/.gitignore
index 42294e5..7677533 100644
--- a/.gitignore
+++ b/.gitignore
@@ -177,6 +177,7 @@
 /gitweb/static/gitweb.min.*
 /test-chmtime
 /test-ctype
+/test-config
 /test-date
 /test-delta
 /test-dump-cache-tree
diff --git a/Makefile b/Makefile
index 07ea105..9544efb 100644
--- a/Makefile
+++ b/Makefile
@@ -549,6 +549,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
+TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
diff --git a/test-config.c b/test-config.c
new file mode 100644
index 0000000..ff24cb8
--- /dev/null
+++ b/test-config.c
@@ -0,0 +1,93 @@
+#include "cache.h"
+#include "hashmap.h"
+#include "string-list.h"
+
+/*
+ * This program gives examples on how to use non-callback based query
+ * functions like git_config_get_string & git_config_get_string_multi.
+ *
+ * Reads stdin and prints result of command to stdout:
+ *
+ * print_all -> prints all the key-value pairs contained in the hashmap
+ *		also checks if all entries in the hashmap matches with
+ *		the content of config files
+ *
+ * get_value -> prints the value with highest priority for the entered key
+ *
+ * get_all_values -> prints all values for the given key in increasing order
+ *		     of priority
+ * Examples:
+ *
+ * To print the value with highest priority for key "foo.bAr Baz.rock":
+ * 	test-config get_value "foo.bAr Baz.rock"
+ *
+ */
+
+static const char *v;
+static const struct string_list *strptr;
+static int i;
+static int *flag;
+
+static int config_cache_callback(const char *key, const char *value, void *unused)
+{
+	strptr = git_config_get_string_multi(key);
+	if (strptr) {
+		for (i = 0; i < strptr->nr; i++)
+		{
+			v = strptr->items[i].string;
+			flag = strptr->items[i].util;
+			/* NULL values are flagged as 1 */
+			if (*flag == 1)
+				printf("%s\n", key);
+			else if (*flag == 0)
+				printf("%s=%s\n", key, v);
+			/* key-value pair printed so flag them as done */
+			*flag = -1;
+		}
+		return 0;
+	} else {
+		printf("%s\n", "Config hashmap inconsistent\n");
+		return -1;
+	}
+}
+
+ int main(int argc, char **argv)
+{
+	if (argc == 2 && !strcmp(argv[1], "print_all")) {
+		git_config(config_cache_callback, NULL);
+		return 0;
+	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
+		/* enter key in canonical form enclosed in quotes */
+		if (!git_config_get_string(argv[2], &v)) {
+			printf("%s\n", v);
+			return 0;
+		} else {
+			printf("%s\n", "Value not found for the entered key\n");
+			return -1;
+		}
+	} else if (argc == 3 && !strcmp(argv[1], "get_all_values")) {
+		/* enter key in canonical form enclosed in quotes */
+		strptr = git_config_get_string_multi(argv[2]);
+		if (strptr) {
+			for (i = 0; i < strptr->nr; i++)
+			{
+				v = strptr->items[i].string;
+				flag = strptr->items[i].util;
+				/* prints NULL values as "-" */
+				if (*flag)
+					printf("%s ", "-");
+				else
+					printf("%s ", v);
+			}
+			printf("\n");
+			return 0;
+		} else {
+			printf("%s\n", "Value not found for the entered key\n");
+			return -1;
+		}
+	}
+
+	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
+		argv[1] ? argv[1] : "(there was none)");
+	return 1;
+}
-- 
1.9.0.GIT
