From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v6 3/4] tests: add new test for the url_normalize function
Date: Fri, 19 Jul 2013 05:48:44 -0700
Message-ID: <b14087a83b5a669dd8b6e3d6a4dd6c4@f74d39fa044aa309eaea14b9f57fe79>
References: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 14:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0A7W-000881-6X
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 14:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760301Ab3GSMtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 08:49:06 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54109 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab3GSMtB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 08:49:01 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq12so1060174pab.25
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WaCrMy8YVNFiRTwd/VYyw6my8PQaU05a4HLJcmgdFg4=;
        b=xylzdKc3CvYVSJ8v1+sVsrjjygSmyPuH56J0CRUQ1mTASuXmyD0GY6Y8IjIisYtuhA
         tW1lx+61K6vaTS81tnnbfx/nCCRBCwjcQvxEnkGi5EpOtZy6ydUd57eB2CEPXZkszNr2
         Uo8rwbIaoTpO7Viaa8lB/0yYsRJzFLtqxpf5g1Pj4PLGVPPbACfsW05TJf8Oqs4dIgig
         eSoVg2t16QC5+bS4KWcwNU4+DWMp9QsGYqUTkekQw1oivslgHVIg4YF6fhOHgo41j23r
         +tRgL8JG7QtQDIVzhfiJunLrNjCGbxRZb3IDgu3zPuUOaBb4CUGVgIhLVRuW6iZuKhKk
         +uYQ==
X-Received: by 10.68.164.225 with SMTP id yt1mr16733359pbb.195.1374238140899;
        Fri, 19 Jul 2013 05:49:00 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ry2sm19426942pbc.41.2013.07.19.05.48.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 05:49:00 -0700 (PDT)
In-Reply-To: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230803>

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
 Makefile                 |   5 ++
 t/t5200-url-normalize.sh | 161 +++++++++++++++++++++++++++++++++++++++++++++++
 test-url-normalize.c     |  61 ++++++++++++++++++
 4 files changed, 228 insertions(+)
 create mode 100755 t/t5200-url-normalize.sh
 create mode 100644 test-url-normalize.c

diff --git a/.gitignore b/.gitignore
index 6669bf0..cd97e16 100644
--- a/.gitignore
+++ b/.gitignore
@@ -198,6 +198,7 @@
 /test-string-list
 /test-subprocess
 /test-svn-fe
+/test-url-normalize
 /test-wildmatch
 /common-cmds.h
 *.tar.gz
diff --git a/Makefile b/Makefile
index 0f931a2..f83879c 100644
--- a/Makefile
+++ b/Makefile
@@ -567,6 +567,7 @@ TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
+TEST_PROGRAMS_NEED_X += test-url-normalize
 TEST_PROGRAMS_NEED_X += test-wildmatch
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
@@ -2235,6 +2236,10 @@ test-parse-options$X: parse-options.o parse-options-cb.o
 
 test-svn-fe$X: vcs-svn/lib.a
 
+test-url-normalize$X: test-url-normalize.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+
 .PRECIOUS: $(TEST_OBJS)
 
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
diff --git a/t/t5200-url-normalize.sh b/t/t5200-url-normalize.sh
new file mode 100755
index 0000000..82d78ce
--- /dev/null
+++ b/t/t5200-url-normalize.sh
@@ -0,0 +1,161 @@
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
+	! test-url-normalize "file://:555" &&
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
+test_expect_success 'url port checks' '
+	test-url-normalize "xyz://q@some.host:" &&
+	test-url-normalize "xyz://q@some.host:456/" &&
+	! test-url-normalize "xyz://q@some.host:0" &&
+	! test-url-normalize "xyz://q@some.host:0000000" &&
+	test-url-normalize "xyz://q@some.host:0000001?" &&
+	test-url-normalize "xyz://q@some.host:065535#" &&
+	test-url-normalize "xyz://q@some.host:65535" &&
+	! test-url-normalize "xyz://q@some.host:65536" &&
+	! test-url-normalize "xyz://q@some.host:99999" &&
+	! test-url-normalize "xyz://q@some.host:100000" &&
+	! test-url-normalize "xyz://q@some.host:100001" &&
+	test-url-normalize "http://q@some.host:80" &&
+	test-url-normalize "https://q@some.host:443" &&
+	test-url-normalize "http://q@some.host:80/" &&
+	test-url-normalize "https://q@some.host:443?" &&
+	! test-url-normalize "http://q@:8008" &&
+	! test-url-normalize "http://:8080" &&
+	! test-url-normalize "http://:" &&
+	test-url-normalize "xyz://q@some.host:456/" &&
+	test-url-normalize "xyz://[::1]:456/" &&
+	test-url-normalize "xyz://[::1]:/" &&
+	! test-url-normalize "xyz://[::1]:000/" &&
+	! test-url-normalize "xyz://[::1]:0%300/" &&
+	! test-url-normalize "xyz://[::1]:0x80/" &&
+	! test-url-normalize "xyz://[::1]:4294967297/" &&
+	! test-url-normalize "xyz://[::1]:030f/"
+'
+
+test_expect_success 'url port normalization' '
+	test "$(test-url-normalize -p "http://x:800")" = "http://x:800/" &&
+	test "$(test-url-normalize -p "http://x:0800")" = "http://x:800/" &&
+	test "$(test-url-normalize -p "http://x:00000800")" = "http://x:800/" &&
+	test "$(test-url-normalize -p "http://x:065535")" = "http://x:65535/" &&
+	test "$(test-url-normalize -p "http://x:1")" = "http://x:1/" &&
+	test "$(test-url-normalize -p "http://x:80")" = "http://x/" &&
+	test "$(test-url-normalize -p "http://x:080")" = "http://x/" &&
+	test "$(test-url-normalize -p "http://x:000000080")" = "http://x/" &&
+	test "$(test-url-normalize -p "https://x:443")" = "https://x/" &&
+	test "$(test-url-normalize -p "https://x:0443")" = "https://x/" &&
+	test "$(test-url-normalize -p "https://x:000000443")" = "https://x/"
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
+	test "$(test-url-normalize -l "http://@x.y/^")" = 15
+'
+
+test_expect_success 'url . and .. segments' '
+	test "$(test-url-normalize -p "x://y/.")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/./")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/a/.")" = "x://y/a" &&
+	test "$(test-url-normalize -p "x://y/a/./")" = "x://y/a/" &&
+	test "$(test-url-normalize -p "x://y/.?")" = "x://y/?" &&
+	test "$(test-url-normalize -p "x://y/./?")" = "x://y/?" &&
+	test "$(test-url-normalize -p "x://y/a/.?")" = "x://y/a?" &&
+	test "$(test-url-normalize -p "x://y/a/./?")" = "x://y/a/?" &&
+	test "$(test-url-normalize -p "x://y/a/./b/.././../c")" = "x://y/c" &&
+	test "$(test-url-normalize -p "x://y/a/./b/../.././c/")" = "x://y/c/" &&
+	test "$(test-url-normalize -p "x://y/a/./b/.././../c/././.././.")" = "x://y/" &&
+	! test-url-normalize "x://y/a/./b/.././../c/././.././.." &&
+	test "$(test-url-normalize -p "x://y/a/./?/././..")" = "x://y/a/?/././.." &&
+	test "$(test-url-normalize -p "x://y/%2e/")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/%2E/")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/a/%2e./")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/b/.%2E/")" = "x://y/" &&
+	test "$(test-url-normalize -p "x://y/c/%2e%2E/")" = "x://y/"
+'
+
+# http://@foo specifies an empty user name but does not specify a password
+# http://foo  specifies neither a user name nor a password
+# So they should not be equivalent
+test_expect_success 'url equivalents' '
+	test-url-normalize "httP://x" "Http://X/" &&
+	test-url-normalize "Http://%4d%65:%4d^%70@The.Host" "hTTP://Me:%4D^p@the.HOST:80/" &&
+	! test-url-normalize "https://@x.y/^" "httpS://x.y:443/^" &&
+	test-url-normalize "https://@x.y/^" "httpS://@x.y:0443/^" &&
+	test-url-normalize "https://@x.y/^/../abc" "httpS://@x.y:0443/abc" &&
+	test-url-normalize "https://@x.y/^/.." "httpS://@x.y:0443/"
+'
+
+test_done
diff --git a/test-url-normalize.c b/test-url-normalize.c
new file mode 100644
index 0000000..d68312d
--- /dev/null
+++ b/test-url-normalize.c
@@ -0,0 +1,61 @@
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
+#define url_normalize(u) http_options_url_normalize(u)
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
+		url1 = url_normalize(argv[1]);
+		if (!url1)
+			return 1;
+		if (opt_p)
+			printf("%s\n", url1);
+		if (opt_l)
+			printf("%u\n", (unsigned)strlen(url1));
+		return 0;
+	}
+
+	if (opt_p || opt_l)
+		die(usage);
+
+	url1 = url_normalize(argv[1]);
+	url2 = url_normalize(argv[2]);
+	return (url1 && url2 && !strcmp(url1, url2)) ? 0 : 1;
+}
+
+#endif /* !NO_CURL */
-- 
1.8.3
