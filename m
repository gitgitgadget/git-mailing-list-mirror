From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: [PATCH V2 1/3] strbuf: add tests
Date: Mon,  6 Jun 2016 17:13:38 +0200
Message-ID: <20160606151340.22424-2-william.duclot@ensimag.grenoble-inp.fr>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
Cc: antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, peff@peff.net, mh@glandium.org,
	gitster@pobox.com,
	Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 17:14:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9wEr-0008Rd-EH
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 17:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbcFFPOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 11:14:38 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:43043 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752194AbcFFPOa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 11:14:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4EA64259A;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJJVDz_GDN71; Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3EE712597;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 39F3A2079;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id orOcu0FBwM-1; Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
Received: from Messiaen.grenet.fr (eduroam-032048.grenet.fr [130.190.32.48])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 186D62066;
	Mon,  6 Jun 2016 17:14:27 +0200 (CEST)
X-Mailer: git-send-email 2.9.0.rc1.1.geac644e
In-Reply-To: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296517>

Test the strbuf API. Being used throughout all Git the API could be
considered tested, but adding specific tests makes it easier to improve
and extend the API.

Signed-off-by: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Signed-off-by: Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
Changes since V1:
    * Use the parser API
    * Coding style fix
    * New test for string size

 Makefile               |   1 +
 t/helper/test-strbuf.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0082-strbuf.sh      |  19 ++++++++++
 3 files changed, 121 insertions(+)
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
index 0000000..271592e
--- /dev/null
+++ b/t/helper/test-strbuf.c
@@ -0,0 +1,101 @@
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "parse-options.h"
+#include "builtin.h"
+
+/*
+ * Check behavior on usual use cases
+ */
+static int strbuf_check_behavior(struct strbuf *sb)
+{
+	char *str_test = xstrdup("test"), *res, *old_buf;
+	size_t size, old_alloc;
+
+	strbuf_grow(sb, 1);
+	old_alloc = sb->alloc;
+	strbuf_grow(sb, sb->alloc - sb->len + 1000);
+	if (old_alloc == sb->alloc)
+		die("strbuf_grow does not realloc the buffer as expected");
+	old_buf = sb->buf;
+	res = strbuf_detach(sb, &size);
+	if (res != old_buf)
+		die("strbuf_detach does not return the expected buffer");
+	free(res);
+
+	str_test = xstrdup("test");
+	strbuf_attach(sb, str_test, strlen(str_test), strlen(str_test) + 1);
+	res = strbuf_detach(sb, &size);
+	if (size != strlen(str_test)) 
+		die ("size is not as expected");
+
+	if (res != str_test)
+		die("strbuf_detach does not return the expected buffer");
+	free(res);
+	strbuf_release(sb);
+
+	return 0;
+}
+
+static int basic_grow(struct strbuf *sb) 
+{
+	strbuf_init(sb, 0);
+	strbuf_grow(sb, 0);
+	if (sb->buf == strbuf_slopbuf)
+		die("strbuf_grow failed to alloc memory");
+	strbuf_release(sb);
+	if (sb->buf != strbuf_slopbuf)
+		die("strbuf_release does not reinitialize the strbuf");
+
+	return 0;
+}
+
+static void grow_overflow(struct strbuf *sb)
+{
+	strbuf_init(sb, 1000);
+	strbuf_grow(sb, maximum_unsigned_value_of_type((size_t)1));
+}
+
+int main(int argc, const char *argv[])
+{
+	struct strbuf sb;
+	enum {
+		MODE_UNSPECIFIED = 0,
+		MODE_BASIC_GROW ,
+		MODE_STRBUF_CHECK,
+		MODE_GROW_OVERFLOW
+	} cmdmode = MODE_UNSPECIFIED;
+	struct option options[] = {
+		OPT_CMDMODE(0, "basic_grow", &cmdmode,
+			    N_(" basic grow test"),
+			    MODE_BASIC_GROW),
+		OPT_CMDMODE(0, "strbuf_check_behavior", &cmdmode,
+			    N_("check the strbuf's behavior"),
+			    MODE_STRBUF_CHECK),
+		OPT_CMDMODE(0, "grow_overflow", &cmdmode,
+			    N_("test grow expecting overflow"),
+			    MODE_GROW_OVERFLOW),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options, NULL, 0);
+
+	if (cmdmode == MODE_BASIC_GROW) {
+		/*
+		 * Check if strbuf_grow(0) allocate a new NUL-terminated buffer
+		 */
+		return basic_grow(&sb);
+	} else if (cmdmode == MODE_STRBUF_CHECK) {
+		strbuf_init(&sb, 0);
+		return strbuf_check_behavior(&sb);
+	} else if (cmdmode == MODE_GROW_OVERFLOW) {
+		/*
+		 * size_t overflow: should die().
+		 * If this does not die(), fall through to returning success.
+		 */
+		grow_overflow(&sb);
+	} else {
+		usage("test-strbuf mode");
+	}
+
+	return 0;
+}
diff --git a/t/t0082-strbuf.sh b/t/t0082-strbuf.sh
new file mode 100755
index 0000000..6a579a3
--- /dev/null
+++ b/t/t0082-strbuf.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='Test the strbuf API.'
+
+. ./test-lib.sh
+
+test_expect_success 'basic test on strbuf_grow()' '
+	test-strbuf --basic_grow
+'
+
+test_expect_success 'check strbuf behavior in usual use cases ' '
+	test-strbuf --strbuf_check_behavior
+'
+
+test_expect_success 'overflow while calling strbuf_grow' '
+	test_must_fail test-strbuf --grow_overflow
+'
+
+test_done
-- 
2.9.0.rc1.1.geac644e
