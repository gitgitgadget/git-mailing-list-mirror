From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v8 2/2] test-config: add tests for the config_set API
Date: Thu, 10 Jul 2014 20:34:15 -0700
Message-ID: <1405049655-4265-3-git-send-email-tanayabh@gmail.com>
References: <1405049655-4265-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 05:38:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Rf0-0004RX-5K
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 05:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbaGKDiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 23:38:05 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:43995 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaGKDiC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 23:38:02 -0400
Received: by mail-pa0-f47.google.com with SMTP id kq14so670903pab.6
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 20:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/q93dy0W2kHRxBgegIuWdrZhPWvV+eYeSKiXK7THljo=;
        b=szttQgYSpmz1vSgSQvCoVWz1gCLUVMo4QblQyUCLMohgO4PGObLAZJV//iwo5v+VOC
         qP8+y7OmCWMUXF5AuVhTTEPomVBV2Pfv5TyXwES0l/UnCqCiTxPaXAWJsmQdOwcB74b8
         9uRHFDCAv7WGU9OPvpai6sWn9FzVOHzlLqDNPDkHjUJq12yPila6xztq084u4hCYU2zT
         u+E7JRmP8IsoonfRcS4pxOwPhnlyiIkHeYeotuhXhOhtwXHpHZCs2aDL9zTe9kGJ4Uic
         qDKXPmwebSw7fgG8X3S03v2BxZyC2xR4KxsWPdafRBGW53GPLNZCL1ms95QXGWjEC/kV
         WBSQ==
X-Received: by 10.66.246.229 with SMTP id xz5mr11512861pac.119.1405049881461;
        Thu, 10 Jul 2014 20:38:01 -0700 (PDT)
Received: from localhost.localdomain ([117.254.220.141])
        by mx.google.com with ESMTPSA id ek2sm721627pbd.30.2014.07.10.20.37.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jul 2014 20:38:01 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1405049655-4265-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253250>

Expose the `config_set` C API as a set of simple commands in order to
facilitate testing. Add tests for the `config_set` API as well as for
`git_config_get_*()` family for the usual config files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 .gitignore            |   1 +
 Makefile              |   1 +
 t/t1308-config-set.sh | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++
 test-config.c         | 125 +++++++++++++++++++++++++++++++++++++
 4 files changed, 297 insertions(+)
 create mode 100755 t/t1308-config-set.sh
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
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
new file mode 100755
index 0000000..87a29f1
--- /dev/null
+++ b/t/t1308-config-set.sh
@@ -0,0 +1,170 @@
+#!/bin/sh
+
+test_description='Test git config-set API in different settings'
+
+. ./test-lib.sh
+
+# 'check section.key value' verifies that the entry for section.key is
+# 'value'
+check() {
+	echo "$2" >expected &&
+	test-config get_value "$1" >actual 2>&1 &&
+	test_cmp expected actual
+}
+
+test_expect_success 'setup default config' '
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
+	check core.penguin "very blue"
+'
+
+test_expect_success 'get value for a key with value as an empty string' '
+	check core.my ""
+'
+
+test_expect_success 'get value for a key with value as NULL' '
+	check core.foo "(NULL)"
+'
+
+test_expect_success 'upper case key' '
+	check core.UPPERCASE "true"
+'
+
+test_expect_success 'mixed case key' '
+	check core.MixedCase "true"
+'
+
+test_expect_success 'key and value with mixed case' '
+	check core.Movie "BadPhysics"
+'
+
+test_expect_success 'key with case sensitive subsection' '
+	check "my.Foo bAr.hi" "mixed-case" &&
+	check "my.FOO BAR.hi" "upper-case" &&
+	check "my.foo bar.hi" "lower-case"
+'
+
+test_expect_success 'key with case insensitive section header' '
+	check cores.baz "ball" &&
+	check Cores.baz "ball" &&
+	check CORES.baz "ball" &&
+	check coreS.baz "ball"
+'
+
+test_expect_success 'find value with misspelled key' '
+	echo "Value not found for \"my.fOo Bar.hi\"" >expect &&
+	test_must_fail test-config get_value "my.fOo Bar.hi" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find value with the highest priority' '
+	check core.baz "hask"
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
index 0000000..dc313c2
--- /dev/null
+++ b/test-config.c
@@ -0,0 +1,125 @@
+#include "cache.h"
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
+	int i, val;
+	const char *v;
+	const struct string_list *strptr;
+	struct config_set cs;
+	git_configset_init(&cs);
+
+	if (argc < 2) {
+		fprintf(stderr, "Please, provide a command name on the command-line\n");
+		return 1;
+	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
+		if (!git_config_get_value(argv[2], &v)) {
+			if (!v)
+				printf("(NULL)\n");
+			else
+				printf("%s\n", v);
+			return 0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			return 1;
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
+			return 1;
+		}
+	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
+		if (!git_config_get_int(argv[2], &val)) {
+			printf("%d\n", val);
+			return 0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			return 1;
+		}
+	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
+		if (!git_config_get_bool(argv[2], &val)) {
+			printf("%d\n", val);
+			return 0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			return 1;
+		}
+	} else if (!strcmp(argv[1], "configset_get_value")) {
+		for (i = 3; i < argc; i++) {
+			if (git_configset_add_file(&cs, argv[i]))
+				return 2;
+		}
+		if (!git_configset_get_value(&cs, argv[2], &v)) {
+			if (!v)
+				printf("(NULL)\n");
+			else
+				printf("%s\n", v);
+			return 0;
+		} else {
+			printf("Value not found for \"%s\"\n", argv[2]);
+			return 1;
+		}
+	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
+		for (i = 3; i < argc; i++) {
+			if (git_configset_add_file(&cs, argv[i]))
+				return 2;
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
+			return 1;
+		}
+	}
+
+	fprintf(stderr, "%s: Please check the syntax and the function name\n", argv[0]);
+	return 1;
+}
-- 
1.9.0.GIT
