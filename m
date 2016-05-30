From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: [PATCH 1/2] strbuf: add tests
Date: Mon, 30 May 2016 12:36:41 +0200
Message-ID: <20160530103642.7213-2-william.duclot@ensimag.grenoble-inp.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
Cc: simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 12:37:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7KZa-0000bQ-TV
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542AbcE3Kg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 06:36:56 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:53075 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752561AbcE3Kgz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 06:36:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6D02D24D7;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r7569KkYnoAt; Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 541D324A7;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 519A42066;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AwCnfH2xMbK9; Mon, 30 May 2016 12:36:52 +0200 (CEST)
Received: from Messiaen.grenet.fr (eduroam-033086.grenet.fr [130.190.33.86])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 3242C2077;
	Mon, 30 May 2016 12:36:52 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.403.ge2646ba.dirty
In-Reply-To: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295876>

Test the strbuf API. Being used throughout all Git the API could be
considered tested, but adding specific tests makes it easier to improve
and extend the API.
---
 Makefile               |  1 +
 t/helper/test-strbuf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0082-strbuf.sh      | 19 ++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 t/helper/test-strbuf.c
 create mode 100755 t/t0082-strbuf.sh

diff --git a/Makefile b/Makefile
index 3f03366..dc84f43 100644
--- a/Makefile
+++ b/Makefile
@@ -613,6 +613,7 @@ TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
+TEST_PROGRAMS_NEED_X += test-strbuf
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
diff --git a/t/helper/test-strbuf.c b/t/helper/test-strbuf.c
new file mode 100644
index 0000000..622f627
--- /dev/null
+++ b/t/helper/test-strbuf.c
@@ -0,0 +1,69 @@
+#include "git-compat-util.h"
+#include "strbuf.h"
+
+/*
+ * Check behavior on usual use cases
+ */
+int test_usual(struct strbuf *sb)
+{
+	size_t size, old_alloc;
+	char *res, *old_buf, *str_test = malloc(5*sizeof(char));
+	strbuf_grow(sb, 1);
+	strcpy(str_test, "test");
+	old_alloc = sb->alloc;
+	strbuf_grow(sb, 1000);
+	if (old_alloc == sb->alloc)
+		die("strbuf_grow does not realloc the buffer as expected");
+	old_buf = sb->buf;
+	res = strbuf_detach(sb, &size);
+	if (res != old_buf)
+		die("strbuf_detach does not return the expected buffer");
+	free(res);
+
+	strcpy(str_test, "test");
+	strbuf_attach(sb, (void *)str_test, strlen(str_test), sizeof(str_test));
+	res = strbuf_detach(sb, &size);
+	if (res != str_test)
+		die("strbuf_detach does not return the expected buffer");
+	free(res);
+	strbuf_release(sb);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	size_t size = 1;
+	struct strbuf sb;
+	char str_test[5] = "test";
+	char str_foo[7] = "foo";
+
+	if (argc != 2)
+		usage("test-strbuf mode");
+
+	if (!strcmp(argv[1], "basic_grow")) {
+		/*
+		 * Check if strbuf_grow(0) allocate a new NUL-terminated buffer
+		 */
+		strbuf_init(&sb, 0);
+		strbuf_grow(&sb, 0);
+		if (sb.buf == strbuf_slopbuf)
+			die("strbuf_grow failed to alloc memory");
+		strbuf_release(&sb);
+		if (sb.buf != strbuf_slopbuf)
+			die("strbuf_release does not reinitialize the strbuf");
+	} else if (!strcmp(argv[1], "strbuf_check_behavior")) {
+		strbuf_init(&sb, 0);
+		return test_usual(&sb);
+	} else if (!strcmp(argv[1], "grow_overflow")) {
+		/*
+		 * size_t overflow: should die()
+		 */
+		strbuf_init(&sb, 1000);
+		strbuf_grow(&sb, maximum_unsigned_value_of_type((size_t)1));
+	} else {
+		usage("test-strbuf mode");
+	}
+
+	return 0;
+}
diff --git a/t/t0082-strbuf.sh b/t/t0082-strbuf.sh
new file mode 100755
index 0000000..0800d26
--- /dev/null
+++ b/t/t0082-strbuf.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description="Test the strbuf API.
+"
+. ./test-lib.sh
+
+test_expect_success 'basic test on strbuf_grow()' '
+	test-strbuf basic_grow
+'
+
+test_expect_success 'check strbuf behavior in usual use cases ' '
+	test-strbuf strbuf_check_behavior
+'
+
+test_expect_success 'overflow while calling strbuf_grow' '
+	test_must_fail test-strbuf grow_overflow
+'
+
+test_done
-- 
2.8.2.403.ge2646ba.dirty
