From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v5 5/5] tests: add new test for the url_normalize function
Date: Mon, 15 Jul 2013 02:51:02 -0700
Message-ID: <62be3b26b7b98206f330b9e6f833523@f74d39fa044aa309eaea14b9f57fe79>
References: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 11:51:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyfRJ-0006b8-4k
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782Ab3GOJvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:51:24 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:37651 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab3GOJvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:51:22 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so10683278pdj.28
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=31GXZT0EXz1RX0DGaMxHJG8zZGWudpWdLqJw7Og9e0Y=;
        b=uDtqxOWuGWnAOuuQ75/ni64f7qtmu06i8z5e2NCff9GFBywqpAc0Om6woDLaT9/bXM
         eTu6TgaZiirzIR5qnPRsYHlHaGuO8LtJ9yEP6DhC9H6Q+8DUZEekm0j2muvhWSHPHLQZ
         RDPeh7x0PwHnH1Fyg9xdWvmBg7jBgHpgVo6XCbD6+SQB1K7ewfaSbmN/ruuRDNzKHhNy
         Q2eUAy00EepxnbiXY2emKI9ofae2XnhNT9t76yBelLj+gUYTaUFBSjtQv9+krno9gKll
         olx0jLUkniMNWLNBYHEznbGjtqP3IyvdiomKmxBYrCtJof0zbXQYGLSEsttu/GhV+oUG
         1blQ==
X-Received: by 10.66.120.136 with SMTP id lc8mr37767513pab.182.1373881881444;
        Mon, 15 Jul 2013 02:51:21 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wr9sm60041274pbc.7.2013.07.15.02.51.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 02:51:20 -0700 (PDT)
In-Reply-To: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230453>

In order to perform sane URL matching for http.<url>.* options,
http.c normalizes URLs before performing matches.

A new test-url-normalize test program is introduced along with
a new t5200-url-normalize.sh script to run the tests.

Since the url_normalize function currently lives in http.c this
test will be skipped if NO_CURL is defined since http.c is skipped
in that case.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 .gitignore               |   1 +
 Makefile                 |   5 +++
 t/t5200-url-normalize.sh | 109 +++++++++++++++++++++++++++++++++++++++++++++++
 test-url-normalize.c     |  62 +++++++++++++++++++++++++++
 4 files changed, 177 insertions(+)
 create mode 100755 t/t5200-url-normalize.sh
 create mode 100644 test-url-normalize.c

diff --git a/.gitignore b/.gitignore
index efa8db0..b60a9df 100644
--- a/.gitignore
+++ b/.gitignore
@@ -201,6 +201,7 @@
 /test-string-list
 /test-subprocess
 /test-svn-fe
+/test-url-normalize
 /test-wildmatch
 /common-cmds.h
 *.tar.gz
diff --git a/Makefile b/Makefile
index 0600eb4..195c62a 100644
--- a/Makefile
+++ b/Makefile
@@ -580,6 +580,7 @@ TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
+TEST_PROGRAMS_NEED_X += test-url-normalize
 TEST_PROGRAMS_NEED_X += test-wildmatch
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
@@ -2278,6 +2279,10 @@ test-parse-options$X: parse-options.o parse-options-cb.o
 
 test-svn-fe$X: vcs-svn/lib.a
 
+test-url-normalize$X: test-url-normalize.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+
 .PRECIOUS: $(TEST_OBJS)
 
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
diff --git a/t/t5200-url-normalize.sh b/t/t5200-url-normalize.sh
new file mode 100755
index 0000000..40ebcd3
--- /dev/null
+++ b/t/t5200-url-normalize.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+
+test_description='url normalization'
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	skip_all='skipping test, git built without http support'
+	test_done
+fi
+
+# Note that only file: URLs should be allowed without a host
+
+test_expect_success 'url scheme' '
+	! test-url-normalize "" &&
+	! test-url-normalize "_" &&
+	! test-url-normalize "scheme" &&
+	! test-url-normalize "scheme:" &&
+	! test-url-normalize "scheme:/" &&
+	! test-url-normalize "scheme://" &&
+	! test-url-normalize "file" &&
+	! test-url-normalize "file:" &&
+	! test-url-normalize "file:/" &&
+	test-url-normalize "file://" &&
+	! test-url-normalize "://acme.co" &&
+	! test-url-normalize "x_test://acme.co" &&
+	! test-url-normalize "schem%6e://" &&
+	test-url-normalize "x-Test+v1.0://acme.co" &&
+	test "$(test-url-normalize -p "AbCdeF://x.Y")" = "abcdef://x.y/"
+'
+
+test_expect_success 'url authority' '
+	! test-url-normalize "scheme://user:pass@" &&
+	! test-url-normalize "scheme://?" &&
+	! test-url-normalize "scheme://#" &&
+	! test-url-normalize "scheme:///" &&
+	! test-url-normalize "scheme://:" &&
+	! test-url-normalize "scheme://:555" &&
+	test-url-normalize "file://user:pass@" &&
+	test-url-normalize "file://?" &&
+	test-url-normalize "file://#" &&
+	test-url-normalize "file:///" &&
+	test-url-normalize "file://:" &&
+	test-url-normalize "file://:555" &&
+	test-url-normalize "scheme://user:pass@host" &&
+	test-url-normalize "scheme://@host" &&
+	test-url-normalize "scheme://%00@host" &&
+	! test-url-normalize "scheme://%%@host" &&
+	! test-url-normalize "scheme://host_" &&
+	test-url-normalize "scheme://user:pass@host/" &&
+	test-url-normalize "scheme://@host/" &&
+	test-url-normalize "scheme://host/" &&
+	test-url-normalize "scheme://host?x" &&
+	test-url-normalize "scheme://host#x" &&
+	test-url-normalize "scheme://host/@" &&
+	test-url-normalize "scheme://host?@x" &&
+	test-url-normalize "scheme://host#@x" &&
+	test-url-normalize "scheme://[::1]" &&
+	test-url-normalize "scheme://[::1]/" &&
+	! test-url-normalize "scheme://hos%41/" &&
+	test-url-normalize "scheme://[invalid....:/" &&
+	test-url-normalize "scheme://invalid....:]/" &&
+	! test-url-normalize "scheme://invalid....:[/" &&
+	! test-url-normalize "scheme://invalid....:["
+'
+
+test_expect_success 'url port' '
+	test-url-normalize "xyz://q@some.host:" &&
+	test-url-normalize "xyz://q@some.host:456" &&
+	test-url-normalize "xyz://q@some.host:0" &&
+	test-url-normalize "xyz://q@some.host:99999" &&
+	test-url-normalize "http://q@some.host:80" &&
+	test-url-normalize "https://q@some.host:443"
+	! test-url-normalize "http://q@:8008" &&
+	! test-url-normalize "http://:8080" &&
+	! test-url-normalize "http://:" &&
+	test-url-normalize "xyz://q@some.host:456/" &&
+	test-url-normalize "xyz://[::1]:456/" &&
+	test-url-normalize "xyz://[::1]:/" &&
+	test-url-normalize "xyz://[::1]:000/" &&
+	! test-url-normalize "xyz://[::1]:0%300/" &&
+	! test-url-normalize "xyz://[::1]:030f/"
+'
+
+test_expect_success 'url general escapes' '
+	! test-url-normalize "http://x.y?%fg" &&
+	test "$(test-url-normalize -p "X://W/%7e%41^%3a")" = "x://w/~A%5E%3A" &&
+	test "$(test-url-normalize -p "X://W/:/?#[]@")" = "x://w/:/?#[]@" &&
+	test "$(test-url-normalize -p "X://W/$&()*+,;=")" = "x://w/$&()*+,;=" &&
+	test "$(test-url-normalize -p "X://W/'\''")" = "x://w/'\''" &&
+	test "$(test-url-normalize -p "X://W?'\!'")" = "x://w/?'\!'"
+';#'
+
+test_expect_success 'url username/password escapes' '
+	test "$(test-url-normalize -p "x://%41%62(^):%70+d@foo")" = "x://Ab(%5E):p+d@foo/"
+'
+
+test_expect_success 'url normalized lengths' '
+	test "$(test-url-normalize -l "Http://%4d%65:%4d^%70@The.Host")" = 25 &&
+	test "$(test-url-normalize -l "http://%41:%42@x.y/%61/")" = 17 &&
+	test "$(test-url-normalize -l "http://@x.y/^")" = 14
+'
+
+test_expect_success 'url equivalents' '
+	test-url-normalize "httP://x" "Http://X/" &&
+	test-url-normalize "Http://%4d%65:%4d^%70@The.Host" "hTTP://Me:%4D^p@the.HOST:80/" &&
+	test-url-normalize "https://@x.y/^" "httpS://x.y:443/^"
+'
+
+test_done
diff --git a/test-url-normalize.c b/test-url-normalize.c
new file mode 100644
index 0000000..1872964
--- /dev/null
+++ b/test-url-normalize.c
@@ -0,0 +1,62 @@
+#ifdef NO_CURL
+
+int main()
+{
+	return 125;
+}
+
+#else /* !NO_CURL */
+
+#include "http.c"
+
+#define url_normalize(u,s) http_options_url_normalize(u,s)
+
+int main(int argc, char **argv)
+{
+	const char *usage = "test-url-normalize [-p | -l] <url1> | <url1> <url2>";
+	char *url1, *url2;
+	int opt_p = 0, opt_l = 0;
+
+	/*
+	 * For one url, succeed if url_normalize succeeds on it, fail otherwise.
+	 * For two urls, succeed only if url_normalize succeeds on both and
+	 * the results compare equal with strcmp.  If -p is given (one url only)
+	 * and url_normalize succeeds, print the result followed by "\n".  If
+	 * -l is given (one url only) and url_normalize succeeds, print the
+	 * returned length in decimal followed by "\n".
+	 */
+
+	if (argc > 1 && !strcmp(argv[1], "-p")) {
+		opt_p = 1;
+		argc--;
+		argv++;
+	} else if (argc > 1 && !strcmp(argv[1], "-l")) {
+		opt_l = 1;
+		argc--;
+		argv++;
+	}
+
+	if (argc < 2 || argc > 3)
+		die(usage);
+
+	if (argc == 2) {
+		size_t s;
+		url1 = url_normalize(argv[1], &s);
+		if (!url1)
+			return 1;
+		if (opt_p)
+			printf("%s\n", url1);
+		if (opt_l)
+			printf("%u\n", (unsigned)s);
+		return 0;
+	}
+
+	if (opt_p || opt_l)
+		die(usage);
+
+	url1 = url_normalize(argv[1], NULL);
+	url2 = url_normalize(argv[2], NULL);
+	return (url1 && url2 && !strcmp(url1, url2)) ? 0 : 1;
+}
+
+#endif /* !NO_CURL */
-- 
1.8.3
