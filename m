From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v5 2/2] test-config: Add tests for the config_set API
Date: Sun,  6 Jul 2014 00:19:22 -0700
Message-ID: <1404631162-18556-3-git-send-email-tanayabh@gmail.com>
References: <1404631162-18556-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 09:21:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3glL-00051y-7Y
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 09:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbaGFHVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 03:21:16 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:43711 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaGFHVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 03:21:15 -0400
Received: by mail-pd0-f174.google.com with SMTP id y10so3751881pdj.33
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=krGhpkXygT0MXaEmvPY09dVvNBWhZltGdldXj9pzuaE=;
        b=mJ16L5tgzeVB2iTTp7x0sULqzrpieGCQ6aj3WA8cEoVPTABepOG7pwlWRfOe2ZNFtA
         PBWrmKy6Hr9FOE/XDCcpk7wxyRf4ytOk/rGV6FY8+XhQmRqkQJ5J2lScEAWS6H0YUTDz
         7sEBxYkGKFkpx6T0MniIw4dKVPeT9cMgPnOQyt/uzlBfK+2HtYgcCbFP1MVEoadvsFHC
         2W6VqUDjc/OEmsyCPynZyMj3n41ITKP8sUf0iAM4E00DNIjWZfw8k4N/MafRiJo4ah50
         awKh/m+1GfWbULTdMXIz4GrnzDSf4BuItRSMwin6bA2jIeQOdjDigqyd4cVFseeu6XYz
         PsrQ==
X-Received: by 10.68.102.3 with SMTP id fk3mr11208059pbb.95.1404631274788;
        Sun, 06 Jul 2014 00:21:14 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.206])
        by mx.google.com with ESMTPSA id ix7sm48970544pbd.36.2014.07.06.00.21.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 06 Jul 2014 00:21:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1404631162-18556-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252930>

Expose the `config_set` C API as a set of simple commands in order to
facilitate testing. Add tests for the `config_set` API as well as for
`git_config_get_*()` family for the usual config files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 .gitignore             |   1 +
 Makefile               |   1 +
 t/t1308-config-hash.sh | 187 +++++++++++++++++++++++++++++++++++++++++++++++++
 test-config.c          | 127 +++++++++++++++++++++++++++++++++
 4 files changed, 316 insertions(+)
 create mode 100755 t/t1308-config-hash.sh
 create mode 100644 test-config.c

diff --git a/.gitignore b/.gitignore
index 42294e5..eeb66e2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -176,6 +176,7 @@
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
 /test-chmtime
+/test-config
 /test-ctype
 /test-date
 /test-delta
diff --git a/Makefile b/Makefile
index d503f78..e875070 100644
--- a/Makefile
+++ b/Makefile
@@ -548,6 +548,7 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
+TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
diff --git a/t/t1308-config-hash.sh b/t/t1308-config-hash.sh
new file mode 100755
index 0000000..eba7102
--- /dev/null
+++ b/t/t1308-config-hash.sh
@@ -0,0 +1,187 @@
+#!/bin/sh
+
+test_description='Test git config-hash API in different settings'
+
+. ./test-lib.sh
+
+test_expect_success 'clear default config' '
+	rm -f .git/config
+'
+
+test_expect_success 'initialize default config' '
+	cat >.git/config << EOF
+	[core]
+		penguin = very blue
+		Movie = BadPhysics
+		UPPERCASE = true
+		MixedCase = true
+		my =
+		foo
+		baz = sam
+	[Cores]
+		WhatEver = Second
+		baz = bar
+	[cores]
+		baz = bat
+	[CORES]
+		baz = ball
+	[my "Foo bAr"]
+		hi = mixed-case
+	[my "FOO BAR"]
+		hi = upper-case
+	[my "foo bar"]
+		hi = lower-case
+	[core]
+		baz = bat
+		baz = hask
+	[lamb]
+		chop = 65
+		head = none
+	[goat]
+		legs = 4
+		head = true
+		skin = false
+		nose = 1
+		horns
+	EOF
+'
+
+test_expect_success 'get value for a simple key' '
+	echo "very blue" >expect &&
+	test-config get_value core.penguin >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get value for a key with value as an empty string' '
+	echo "" >expect &&
+	test-config get_value core.my >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get value for a key with value as NULL' '
+	echo "(NULL)" >expect &&
+	test-config get_value core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'upper case key' '
+	echo "true" >expect &&
+	test-config get_value core.UPPERCASE >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mixed case key' '
+	echo "true" >expect &&
+	test-config get_value core.MixedCase >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'key and value with mixed case' '
+	echo "BadPhysics" >expect &&
+	test-config get_value core.Movie >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'key with case sensitive subsection' '
+	echo "mixed-case" >expect &&
+	echo "upper-case" >>expect &&
+	echo "lower-case" >>expect &&
+	test-config get_value "my.Foo bAr.hi" >actual &&
+	test-config get_value "my.FOO BAR.hi" >>actual &&
+	test-config get_value "my.foo bar.hi" >>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'key with case insensitive section header' '
+	echo "ball" >expect &&
+	echo "ball" >>expect &&
+	echo "ball" >>expect &&
+	test-config get_value cores.baz >actual &&
+	test-config get_value Cores.baz >>actual &&
+	test-config get_value CORES.baz >>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find value with misspelled key' '
+	echo "Value not found for \"my.fOo Bar.hi\"" >expect &&
+	test_must_fail test-config get_value "my.fOo Bar.hi" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find value with the highest priority' '
+	echo hask >expect &&
+	test-config get_value "core.baz">actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find integer value for a key' '
+	echo 65 >expect &&
+	test-config get_int lamb.chop >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find integer if value is non parse-able' '
+	echo 65 >expect &&
+	test_must_fail test-config get_int lamb.head >actual &&
+	test_must_fail test_cmp expect actual
+'
+
+test_expect_success 'find bool value for the entered key' '
+	cat >expect <<-\EOF &&
+	1
+	0
+	1
+	1
+	1
+	EOF
+	test-config get_bool goat.head >actual &&
+	test-config get_bool goat.skin >>actual &&
+	test-config get_bool goat.nose >>actual &&
+	test-config get_bool goat.horns >>actual &&
+	test-config get_bool goat.legs >>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find multiple values' '
+	cat >expect <<-\EOF &&
+	sam
+	bat
+	hask
+	EOF
+	test-config get_value_multi "core.baz">actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find value from a configset' '
+	cat >config2 <<-\EOF &&
+	[core]
+		baz = lama
+	[my]
+		new = silk
+	[core]
+		baz = ball
+	EOF
+	echo silk >expect &&
+	test-config configset_get_value my.new config2 .git/config >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find value with highest priority from a configset' '
+	echo hask > expect &&
+	test-config configset_get_value core.baz config2 .git/config  >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find value_list for a key from a configset' '
+	cat >except <<-\EOF &&
+	sam
+	bat
+	hask
+	lama
+	ball
+	EOF
+	test-config configset_get_value core.baz config2 .git/config  >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/test-config.c b/test-config.c
new file mode 100644
index 0000000..45ccd0a
--- /dev/null
+++ b/test-config.c
@@ -0,0 +1,127 @@
+#include "cache.h"
+#include "hashmap.h"
+#include "string-list.h"
+
+/*
+ * This program exposes the C API of the configuration mechanism
+ * as a set of simple commands in order to facilitate testing.
+ *
+ * Reads stdin and prints result of command to stdout:
+ *
+ * get_value -> prints the value with highest priority for the entered key
+ *
+ * get_value_multi -> prints all values for the entered key in increasing order
+ *		     of priority
+ *
+ * get_int -> print integer value for the entered key or die
+ *
+ * get_bool -> print bool value for the entered key or die
+ *
+ * configset_get_value -> returns value with the highest priority for the entered key
+ * 			from a config_set constructed from files entered as arguments.
+ *
+ * configset_get_value_multi -> returns value_list for the entered key sorted in
+ * 				ascending order of priority from a config_set 
+ * 				constructed from files entered as arguments.
+ *
+ * Examples:
+ *
+ * To print the value with highest priority for key "foo.bAr Baz.rock":
+ * 	test-config get_value "foo.bAr Baz.rock"
+ *
+ */
+
+
+int main(int argc, char **argv)
+{
+	int i, no_of_files;
+	int ret = 0;
+	const char *v;
+	int val;
+	const struct string_list *strptr;
+	struct config_set cs;
+	git_configset_init(&cs);
+	if (argc == 3 && !strcmp(argv[1], "get_value")) {
+		if (!git_config_get_value(argv[2], &v)) {
+			if (!v)
+				printf("(NULL)\n");
+			else
+				printf("%s\n", v);
+			return 0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			return -1;
+		}
+	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
+		strptr = git_config_get_value_multi(argv[2]);
+		if (strptr) {
+			for (i = 0; i < strptr->nr; i++) {
+				v = strptr->items[i].string;
+				if (!v)
+					printf("(NULL)\n");
+				else
+					printf("%s\n", v);
+			}
+			return 0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			return -1;
+		}
+	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
+		if (!git_config_get_int(argv[2], &val)) {
+			printf("%d\n", val);
+			return 0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			return -1;
+		}
+	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
+		if (!git_config_get_bool(argv[2], &val)) {
+			printf("%d\n", val);
+			return 0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			return -1;
+		}
+	} else if (!strcmp(argv[1], "configset_get_value")) {
+		for (i = 3; i < argc; i++) {
+			ret = git_configset_add_file(&cs, argv[i]);
+			if (ret)
+				return -1;
+		}
+		if (!git_configset_get_value(&cs, argv[2], &v)) {
+			if (!v)
+				printf("(NULL)\n");
+			else
+				printf("%s\n", v);
+			return 0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			return -1;
+		}
+
+	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
+		for (i = 3; i < argc; i++) {
+			ret = git_configset_add_file(&cs, argv[i]);
+			if (ret)
+				return -1;
+		}
+		strptr = git_configset_get_value_multi(&cs, argv[2]);
+		if (strptr) {
+			for (i = 0; i < strptr->nr; i++) {
+				v = strptr->items[i].string;
+				if (!v)
+					printf("(NULL)\n");
+				else
+					printf("%s\n", v);
+			}
+			return 0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			return -1;
+		}
+	}
+
+	fprintf(stderr, "%s: Please check the syntax and the function name\n", argv[0]);
+	return 1;
+}
-- 
1.9.0.GIT
