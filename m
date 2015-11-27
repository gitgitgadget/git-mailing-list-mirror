From: larsxschneider@gmail.com
Subject: [PATCH v1 1/2] implement test_might_fail using a refactored test_must_fail
Date: Fri, 27 Nov 2015 10:15:13 +0100
Message-ID: <1448615714-43768-2-git-send-email-larsxschneider@gmail.com>
References: <1448615714-43768-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, ramsay@ramsayjones.plus.com,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 10:15:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2F7r-0003Hh-UI
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 10:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbbK0JP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 04:15:26 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37019 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbbK0JPU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 04:15:20 -0500
Received: by wmww144 with SMTP id w144so50132503wmw.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 01:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LGvHXbAUE/e3bqNeWYKXR5OS+ySSJn9tjm/lVgy8SV0=;
        b=gdwcD4dwq7sZnFzyV/gNiJ2a5RY8JY1N7RnJjZ5vlGeo1vzX5Y7CRPbvOiExy56ubo
         0PMmxCVTtip9oSTaJOQLCxAB85D+8/PHtMZoqTXT3+S6NZOJpS9kdmSAu5ODDvz+HYPj
         4jY52KWep3wj6K2oShnFnN5xF/6bqtqUNFLLRlFcFxpVlAenOuJr5HYDhIX+l9UUBvww
         2A1dDlIpItucePvXGPY18AvGHHGCk1jXE8edCTeXjpXPg2MzS7I/x+aPYY1lzvM0+Sue
         FXDole/8HwZrsqkr92H4wdT2t7YB7pgq93M5D5WnsRHcDJcvBuW/LDCXXYjJqKOsFAzp
         r9DQ==
X-Received: by 10.28.18.9 with SMTP id 9mr8738489wms.96.1448615719644;
        Fri, 27 Nov 2015 01:15:19 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB75CD.dip0.t-ipconnect.de. [93.219.117.205])
        by smtp.gmail.com with ESMTPSA id lf10sm18438731wjb.23.2015.11.27.01.15.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Nov 2015 01:15:19 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1448615714-43768-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281770>

From: Lars Schneider <larsxschneider@gmail.com>

Add an (optional) first parameter "ok=<special case>" to test_must_fail
and return success for "<special case>". Add "success" as
"<special case>" and use it to implement "test_might_fail". This removes
redundancies in test-lib-function.sh.

You can pass multiple <special case> arguments divided by comma (e.g.
"test_must_fail ok=success,something")

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/test-lib-functions.sh | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 73e37a1..94c449a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -569,6 +569,21 @@ test_line_count () {
 	fi
 }
 
+# Returns success if a comma separated string of keywords ($1) contains a
+# given keyword ($2).
+# Examples:
+# `list_contains "foo,bar" bar` returns 0
+# `list_contains "foo" bar` returns 1
+
+list_contains () {
+	case ",$1," in
+	*,$2,*)
+		return 0
+		;;
+	esac
+	return 1
+}
+
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
 #
@@ -582,18 +597,31 @@ test_line_count () {
 # the failure could be due to a segv.  We want a controlled failure.
 
 test_must_fail () {
+	case "$1" in
+	ok=*)
+		_test_ok=${1#ok=}
+		shift
+		;;
+	*)
+		_test_ok=
+		;;
+	esac
 	"$@"
 	exit_code=$?
-	if test $exit_code = 0; then
+	if ! list_contains "$_test_ok" success && test "$exit_code" -eq 0
+	then
 		echo >&2 "test_must_fail: command succeeded: $*"
 		return 1
-	elif test $exit_code -gt 129 && test $exit_code -le 192; then
+	elif test $exit_code -gt 129 && test $exit_code -le 192
+	then
 		echo >&2 "test_must_fail: died by signal: $*"
 		return 1
-	elif test $exit_code = 127; then
+	elif test $exit_code -eq 127
+	then
 		echo >&2 "test_must_fail: command not found: $*"
 		return 1
-	elif test $exit_code = 126; then
+	elif test $exit_code -eq 126
+	then
 		echo >&2 "test_must_fail: valgrind error: $*"
 		return 1
 	fi
@@ -612,16 +640,7 @@ test_must_fail () {
 # because we want to notice if it fails due to segv.
 
 test_might_fail () {
-	"$@"
-	exit_code=$?
-	if test $exit_code -gt 129 && test $exit_code -le 192; then
-		echo >&2 "test_might_fail: died by signal: $*"
-		return 1
-	elif test $exit_code = 127; then
-		echo >&2 "test_might_fail: command not found: $*"
-		return 1
-	fi
-	return 0
+	test_must_fail ok=success "$@"
 }
 
 # Similar to test_must_fail and test_might_fail, but check that a
-- 
2.5.1
