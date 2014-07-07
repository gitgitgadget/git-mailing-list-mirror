From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v6 2/2] test-config: Add tests for the config_set API
Date: Mon,  7 Jul 2014 00:52:46 -0700
Message-ID: <1404719566-3368-3-git-send-email-tanayabh@gmail.com>
References: <1404719566-3368-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 07 09:54:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X43kN-0002ot-Us
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 09:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbaGGHx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 03:53:56 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:49000 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbaGGHxz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 03:53:55 -0400
Received: by mail-pd0-f174.google.com with SMTP id y10so4924066pdj.19
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 00:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PHuxpoVeR4GIZY7krlmnT10FBqpxkBQJzg/uIHfev4o=;
        b=ZZY8qA7YJNMleGWbOrix0VVHps8T+hoWOBXaycIBYAV1sXq9VojRygvYrDgEzF+xyh
         F8lB/mguwQoQF6aChc/TE3u8wp7BGhWGapTXdPgHzyAIgOV6IaNelOfDa1wdx4iMDzHO
         VPVfEU8AomeZeXU0QjcPNTi+AywXWrUBe1a7xO8q9OlQXNzmcnRV0p5JweS6r+bp42fi
         mYFT/WnusVHWvjSCBRyKi5O9xgYXlHxbd8hCs5MCbrjb+vSbM86mHhH8UpgTw2m6T5hw
         kgrdL42bsmE1RVDZtotyECEMGz4HUbgQOimkwi8FswAvgWiaJNjnYT9EgT6o/Qe8Gesi
         D+zA==
X-Received: by 10.66.141.71 with SMTP id rm7mr1720455pab.120.1404719634648;
        Mon, 07 Jul 2014 00:53:54 -0700 (PDT)
Received: from localhost.localdomain ([117.254.219.20])
        by mx.google.com with ESMTPSA id v9sm19146890pdp.88.2014.07.07.00.53.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Jul 2014 00:53:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1404719566-3368-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252961>

Expose the `config_set` C API as a set of simple commands in order to
facilitate testing. Add tests for the `config_set` API as well as for
`git_config_get_*()` family for the usual config files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 .gitignore             |   1 +
 Makefile               |   1 +
 t/t1308-config-hash.sh | 168 +++++++++++++++++++++++++++++++++++++++++++++++++
 test-config.c          | 125 ++++++++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+)
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
index 0000000..ad99f8b
--- /dev/null
+++ b/t/t1308-config-hash.sh
@@ -0,0 +1,168 @@
+#!/bin/sh
+
+test_description='Test git config-hash API in different settings'
+
+. ./test-lib.sh
+
+#'check section.key value' verifies that the entry for section.key is
+#'value'
+check() {
+	echo "$2" >expected
+	test-config get_value "$1" >actual 2>&1
+	test_cmp actual expected
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
+	check "my.fOo Bar.hi" "Value not found for \"my.fOo Bar.hi\""
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
