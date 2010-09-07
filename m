From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v3] Add test-string-list.c
Date: Tue,  7 Sep 2010 09:00:37 -0300
Message-ID: <1283860837-7375-1-git-send-email-tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 14:00:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oswr7-0004zM-Qr
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 14:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316Ab0IGMAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 08:00:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64199 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0IGMAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 08:00:47 -0400
Received: by gyd8 with SMTP id 8so1926803gyd.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=2rCIIAwNu0ZXJqdx1S2vvW0D5IpGHTnZ+H4uOwXmxRY=;
        b=eb+Wzcp/1Pw9nAauckeD58yUiV/mfhQL81y1v9xPutMaf6m8wdvr24KPKxPjsifJZr
         SC/GE58FpqCKAlwsizAT29Y0KRVFjffu6h6CT+cAXuNPQIToggl9PUuoGSor9rKdh6TB
         XeeNhXxDJYkp+N0wH2bUJoxyPHAvRSvRvYGUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=QnU760aKmFL6TfYQnSMVHP1AeLXj/0ylXWYpmEz8fsoglb7Lg+jY3w0D6WLtIvG8Zs
         3V4c0qSbY1pJZogwBEGBh6LWYx5PezZQ5UorrGJXmhGYRAvLghRmkU+RALxXaqeCOhwh
         44+tWY6gTlcy0XV2lyU9c4YHm7JpTui0RRVds=
Received: by 10.150.57.9 with SMTP id f9mr16780yba.341.1283860845998;
        Tue, 07 Sep 2010 05:00:45 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id q31sm7290660ybk.13.2010.09.07.05.00.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 05:00:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155698>

Add a simple test that demonstrates how to create and manipulate
a list of strings using the string-list.h API.

To see the test, call it by:
./bin-wrappers/test-string-list

Or to run it on the git test suite:
cd t && sh t0070-fundamental.sh

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Makefile               |    1 +
 t/t0070-fundamental.sh |    3 +
 test-string-list.c     |  110 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 0 deletions(-)
 create mode 100644 test-string-list.c

diff --git a/Makefile b/Makefile
index 40fbcae..287bc2c 100644
--- a/Makefile
+++ b/Makefile
@@ -422,6 +422,7 @@ TEST_PROGRAMS_NEED_X += test-string-pool
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-treap
 TEST_PROGRAMS_NEED_X += test-index-version
+TEST_PROGRAMS_NEED_X += test-string-list
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 680d7d6..c163a40 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -11,5 +11,8 @@ Verify wrappers and compatibility functions.
 test_expect_success 'character classes (isspace, isalpha etc.)' '
 	test-ctype
 '
+test_expect_success 'string list manipulation' '
+	test-string-list
+'
 
 test_done
diff --git a/test-string-list.c b/test-string-list.c
new file mode 100644
index 0000000..b3a6d3f
--- /dev/null
+++ b/test-string-list.c
@@ -0,0 +1,110 @@
+#include "git-compat-util.h"
+#include "string-list.h"
+
+#define TEST(name) \
+	static void test_##name(void)
+
+TEST(print_string_list)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	string_list_append(&list, "foo");
+	string_list_append(&list, "bar");
+
+	print_string_list(&list, "");
+
+	string_list_clear(&list, 0);
+	assert(list.nr == 0);
+}
+
+TEST(string_list_append)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	int i;
+	assert(list.nr == 0);
+
+	for (i = 0; i < 10; ++i)
+		string_list_append(&list, "foo" + i);
+
+	assert(list.nr == 10);
+
+	string_list_clear(&list, 0);
+	assert(list.nr == 0);
+}
+
+TEST(string_list_has_string)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	assert(!string_list_has_string(&list, "foo"));
+	string_list_append(&list, "foo");
+	assert(string_list_has_string(&list, "foo"));
+	assert(!string_list_has_string(&list, "blah"));
+
+	string_list_clear(&list, 0);
+	assert(list.nr == 0);
+}
+
+TEST(unsorted_string_list_lookup)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	assert(!unsorted_string_list_lookup(&list, "bazr"));
+
+	string_list_append(&list, "blah");
+	string_list_append(&list, "monalisa");
+	string_list_append(&list, "bzr");
+	string_list_append(&list, "barz");
+	string_list_append(&list, "john");
+
+	assert(unsorted_string_list_lookup(&list, "bzr"));
+
+	string_list_clear(&list, 0);
+	assert(list.nr == 0);
+}
+
+TEST(string_list_lookup)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	int i;
+	const char *letters[] = { "a", "b", "c", "d", "e", "f" };
+	for (i = 0; i < ARRAY_SIZE(letters); ++i)
+		string_list_append(&list, letters[i]);
+
+	assert(!string_list_lookup(&list, "A"));
+	assert(string_list_lookup(&list, "a"));
+	assert(!string_list_lookup(&list, "F"));
+	assert(string_list_lookup(&list, "f"));
+
+	string_list_clear(&list, 0);
+	assert(list.nr == 0);
+}
+
+TEST(string_list_insert)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	int i;
+	const char *letters[] = { "a", "b", "c", "e", "f" };
+	int index;
+	for (i = 0; i < ARRAY_SIZE(letters); ++i)
+		string_list_append(&list, letters[i]);
+
+	/* This should insert the string d between c and e.
+	 * (i.e in the index = 3.)
+	 */
+	index = string_list_find_insert_index(&list, "d", 0);
+	assert(index == 3);
+	string_list_insert(&list, "d");
+	assert(list.nr == 6);
+
+	string_list_clear(&list, 0);
+	assert(list.nr == 0);
+}
+
+int main(int argc, const char **argv)
+{
+	test_print_string_list();
+	test_string_list_append();
+	test_string_list_has_string();
+	test_unsorted_string_list_lookup();
+	test_string_list_lookup();
+	test_string_list_insert();
+	return 0;
+}
-- 
1.7.2.3.313.gcd15
