From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 2/2] test-config: Add tests for the config_set API
Date: Tue,  1 Jul 2014 23:01:45 -0700
Message-ID: <1404280905-26763-3-git-send-email-tanayabh@gmail.com>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 08:03:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2DdK-0003TF-FB
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 08:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbaGBGDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 02:03:01 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:52433 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaGBGDA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 02:03:00 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so11352690pdj.15
        for <git@vger.kernel.org>; Tue, 01 Jul 2014 23:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+GIcmeqlqqbyopbxz5jNC75duekWwz9ePNuDEu/04GA=;
        b=pZfg1+hmGSYVeVPOCYcts7TBOGs+g3YQxjbxAybz4m1TzfafyWq18ghHHu6mFIa4TX
         WkKgy4lxKlfKQd88MCXcyPiciyuKTCDfWL/cob21veQV1ySz2bz9e6vFMJWN9qcEOlsw
         i1Zv5DzAD+glvbUaCTB+OnN27VyHufuByUFsYux5WTXpxDlZGW1rG7ZbCn2ngEHJiwcj
         UjtgJw5jo17eYPebNMmMLf6TpyoX6xwpIwr4PAelkTff90ijaY3ZQZhWQZEIiEk9UQ83
         UaEYdOB/608ERAXqPG90ZKe1DtYq/MNWPzMGNDq8upKZp8J6CR/cOuDWkoOYdI2aDw/a
         gJjA==
X-Received: by 10.66.122.135 with SMTP id ls7mr1639662pab.84.1404280979847;
        Tue, 01 Jul 2014 23:02:59 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.26])
        by mx.google.com with ESMTPSA id ek2sm35417795pbd.30.2014.07.01.23.02.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 23:02:59 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252769>

Expose the `config_set` C API as a set of simple commands in order to
facilitate testing. Add tests for the `config_set` API as well as for
`git_config_get_*()` family for the usual config files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 .gitignore             |   1 +
 Makefile               |   1 +
 t/t1308-config-hash.sh | 163 +++++++++++++++++++++++++++++++++++++++++++++++++
 test-config.c          | 129 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 294 insertions(+)
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
index 0000000..6c059c5
--- /dev/null
+++ b/t/t1308-config-hash.sh
@@ -0,0 +1,163 @@
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
+cat > .git/config << EOF
+[core]
+	penguin = very blue
+	Movie = BadPhysics
+	UPPERCASE = true
+	MixedCase = true
+	my =
+	foo
+	baz = sam
+[Cores]
+	WhatEver = Second
+[my "Foo bAr"]
+	hi = hello
+[core]
+	baz = bat
+	baz = hask
+[lamb]
+	chop = 65
+	head = none
+[goat]
+	legs = 4
+	head = true
+	skin = false
+	nose = 1
+	horns
+EOF
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
+test_expect_success 'upper case key' '
+	echo "true" >expect &&
+	test-config get_value core.UPPERCASE >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'mixed case key' '
+	echo "true" >expect &&
+	test-config get_value core.MixedCase >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'key and value with mixed case' '
+	echo "BadPhysics" >expect &&
+	test-config get_value core.Movie >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'key with case sensitive subsection' '
+	echo "hello" >expect &&
+	test-config get_value "my.Foo bAr.hi">actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find value with misspelled key' '
+	echo "Value not found for \"my.fOo Bar.hi\"" >expect &&
+	test_must_fail test-config get_value "my.fOo Bar.hi">actual &&
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
+cat > expect << EOF
+1
+0
+1
+1
+1
+EOF
+
+test_expect_success 'find bool value for the entered key' '
+	test-config get_bool goat.head >>actual &&
+	test-config get_bool goat.skin >>actual &&
+	test-config get_bool goat.nose >>actual &&
+	test-config get_bool goat.horns >>actual &&
+	test-config get_bool goat.legs >>actual &&
+	test_cmp expect actual
+'
+
+cat > expect << EOF
+sam
+bat
+hask
+EOF
+
+test_expect_success 'find multiple values' '
+	test-config get_value_multi "core.baz">actual &&
+	test_cmp expect actual
+'
+
+cat > config2 << EOF
+[core]
+	baz = lama
+[my]
+	new = silk
+[core]
+	baz = ball
+EOF
+
+test_expect_success 'find value from a configset' '
+	echo silk > expect &&
+	test-config configset_get_value 2 config2 .git/config my.new >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find value with highest priority from a configset' '
+	echo hask > expect &&
+	test-config configset_get_value 2 config2 .git/config core.baz >actual &&
+	test_cmp expect actual
+'
+
+cat > except << EOF
+sam
+bat
+hask
+lama
+ball
+EOF
+
+test_expect_success 'find value_list for a key from a configset' '
+	test-config configset_get_value 2 config2 .git/config core.baz >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/test-config.c b/test-config.c
new file mode 100644
index 0000000..32c912a
--- /dev/null
+++ b/test-config.c
@@ -0,0 +1,129 @@
+#include "cache.h"
+#include "hashmap.h"
+#include "string-list.h"
+
+/*
+ * This program exposes the C API of the `config_set` mechanism
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
+ * configset_get_value -> first makes a config-set of files entered as arguments
+ *			 and then returns value with the highest priority for the
+ *			 entered key.
+ *
+ * configset_get_value_multi -> first makes a config-set of files entered as
+ * 				arguments and then returns value_list for the entered
+ *				key sorted in ascending order of priority.
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
+	struct config_set cs = CONFIG_SET_INIT;
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
+		no_of_files = git_config_int("unused", argv[2]);
+		for (i = 1; i <= no_of_files; i++) {
+			ret = git_configset_add_file(&cs, argv[i + 2]);
+			if (ret)
+				return -1;
+		}
+		if (!git_configset_get_value(&cs, argv[3 + no_of_files], &v)) {
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
+		no_of_files = git_config_int("unused", argv[2]);
+		for (i = 1; i <= no_of_files; i++) {
+			ret = git_configset_add_file(&cs, argv[i + 2]);
+			if (ret)
+				return -1;
+		}
+		strptr = git_configset_get_value_multi(&cs, argv[3 + no_of_files]);
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
