From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 1/2] sha1-array: add test-sha1-array and basic tests
Date: Wed, 01 Oct 2014 11:40:12 +0200
Message-ID: <542BCBFC.5000509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 11:41:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZGPQ-00072X-OT
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 11:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbaJAJlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 05:41:17 -0400
Received: from mout.web.de ([212.227.15.4]:62877 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbaJAJlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 05:41:16 -0400
Received: from [192.168.178.27] ([79.250.168.13]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MCvVz-1XPg153Afb-009i2k; Wed, 01 Oct 2014 11:41:04
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-Provags-ID: V03:K0:4kaXLIT3RWR+NA80B0KpfH6D5z3dayVv9qbQeCsnmkDo4UaBgrd
 X/F+qZ6uE019VXX3tu3YnTAuY2WOt++14CRRn0XHb7Adb7n6pc3q7W7ZSEvYdz4ZjXSrWml
 R3hddGrbllmg7FqWC/UC+PXOuOb5ftP6Vnt1ybo3BFc+t2Wrwunv2ae1wB8irVJgO9x955d
 VlkT0Bfvpc6MGk1r5bfOQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257694>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 .gitignore            |  1 +
 Makefile              |  1 +
 t/t0064-sha1-array.sh | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 test-sha1-array.c     | 34 +++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100755 t/t0064-sha1-array.sh
 create mode 100644 test-sha1-array.c

diff --git a/.gitignore b/.gitignore
index 5bfb234..9ec40fa 100644
--- a/.gitignore
+++ b/.gitignore
@@ -199,6 +199,7 @@
 /test-revision-walking
 /test-run-command
 /test-sha1
+/test-sha1-array
 /test-sigchain
 /test-string-list
 /test-subprocess
diff --git a/Makefile b/Makefile
index f34a2d4..356feb5 100644
--- a/Makefile
+++ b/Makefile
@@ -568,6 +568,7 @@ TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
+TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-subprocess
diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
new file mode 100755
index 0000000..bd68789
--- /dev/null
+++ b/t/t0064-sha1-array.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='basic tests for the SHA1 array implementation'
+. ./test-lib.sh
+
+echo20() {
+	prefix="$1"
+	shift
+	while test $# -gt 0
+	do
+		echo "$prefix$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1"
+		shift
+	done
+}
+
+test_expect_success 'ordered enumeration' '
+	echo20 "" 44 55 88 aa >expect &&
+	{
+		echo20 "append " 88 44 aa 55 &&
+		echo for_each_unique
+	} | test-sha1-array >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ordered enumeration with duplicate suppression' '
+	echo20 "" 44 55 88 aa >expect &&
+	{
+		echo20 "append " 88 44 aa 55 &&
+		echo20 "append " 88 44 aa 55 &&
+		echo for_each_unique
+	} | test-sha1-array >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'lookup' '
+	{
+		echo20 "append " 88 44 aa 55 &&
+		echo20 "lookup " 55
+	} | test-sha1-array >actual &&
+	n=$(cat actual) &&
+	test "$n" -eq 1
+'
+
+test_expect_success 'lookup non-existing entry' '
+	{
+		echo20 "append " 88 44 aa 55 &&
+		echo20 "lookup " 33
+	} | test-sha1-array >actual &&
+	n=$(cat actual) &&
+	test "$n" -lt 0
+'
+
+test_expect_success 'lookup with duplicates' '
+	{
+		echo20 "append " 88 44 aa 55 &&
+		echo20 "append " 88 44 aa 55 &&
+		echo20 "lookup " 55
+	} | test-sha1-array >actual &&
+	n=$(cat actual) &&
+	test "$n" -ge 2 &&
+	test "$n" -le 3
+'
+
+test_done
diff --git a/test-sha1-array.c b/test-sha1-array.c
new file mode 100644
index 0000000..ddc491e
--- /dev/null
+++ b/test-sha1-array.c
@@ -0,0 +1,34 @@
+#include "cache.h"
+#include "sha1-array.h"
+
+static void print_sha1(const unsigned char sha1[20], void *data)
+{
+	puts(sha1_to_hex(sha1));
+}
+
+int main(int argc, char **argv)
+{
+	struct sha1_array array = SHA1_ARRAY_INIT;
+	struct strbuf line = STRBUF_INIT;
+
+	while (strbuf_getline(&line, stdin, '\n') != EOF) {
+		const char *arg;
+		unsigned char sha1[20];
+
+		if (skip_prefix(line.buf, "append ", &arg)) {
+			if (get_sha1_hex(arg, sha1))
+				die("not a hexadecimal SHA1: %s", arg);
+			sha1_array_append(&array, sha1);
+		} else if (skip_prefix(line.buf, "lookup ", &arg)) {
+			if (get_sha1_hex(arg, sha1))
+				die("not a hexadecimal SHA1: %s", arg);
+			printf("%d\n", sha1_array_lookup(&array, sha1));
+		} else if (!strcmp(line.buf, "clear"))
+			sha1_array_clear(&array);
+		else if (!strcmp(line.buf, "for_each_unique"))
+			sha1_array_for_each_unique(&array, print_sha1, NULL);
+		else
+			die("unknown command: %s", line.buf);
+	}
+	return 0;
+}
-- 
2.1.2
