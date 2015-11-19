From: larsxschneider@gmail.com
Subject: [PATCH v6 1/6] implement test_might_fail using a refactored test_must_fail
Date: Thu, 19 Nov 2015 09:58:06 +0100
Message-ID: <1447923491-15330-2-git-send-email-larsxschneider@gmail.com>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 09:58:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzL31-0001tC-Vg
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 09:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918AbbKSI6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 03:58:18 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33071 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230AbbKSI6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 03:58:16 -0500
Received: by wmec201 with SMTP id c201so14474957wme.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 00:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bso5DdwcMoU+5Li+xmBNZyuFKRCBIyXAdib5K3PH+qw=;
        b=BAvvaooo+wEZKWrSTOxWq6kHvgsgAKxfJ7L6n8znn6vg629aduooW/WJnS8h0z5R16
         oLgZ5rj+mW14nQu96E7qf72rcybZLUFt/xQXpc7y+ogmGocsBskuQEnx+wkHttXq7bOL
         9rzN8txeZk874HAJKbvEdUW8ePvT58hr4gokHSlxwWyosPej/PlVgBF2hUZLkC2R+E0n
         MG+HjNj/jO3ngpVS3fVum9a6TD18Hc+xHWOf0WAgTLFXiZx/lHdVup9Hso0wDLcsC/3o
         rNaFflKYluMHQGCfgUcSEAIi1ir+OFUGQXSNjClLXrha1NGuJvp+3FSHucSmE1zuSN0u
         enww==
X-Received: by 10.194.175.230 with SMTP id cd6mr122412wjc.100.1447923495854;
        Thu, 19 Nov 2015 00:58:15 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB77F3.dip0.t-ipconnect.de. [93.219.119.243])
        by smtp.gmail.com with ESMTPSA id m64sm7237965wmf.14.2015.11.19.00.58.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Nov 2015 00:58:15 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281467>

From: Lars Schneider <larsxschneider@gmail.com>

Add an (optional) first parameter "ok=<special case>" to test_must_fail
and return success for "<special case>". Add "success" as
"<special case>" and use it to implement "test_might_fail". This removes
redundancies in test-lib-function.sh.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/test-lib-functions.sh | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 73e37a1..1e762da 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -582,18 +582,32 @@ test_line_count () {
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
+	if ! case ",$_test_ok," in *,success,*) false;; esac &&
+		test $exit_code = 0
+	then
 		echo >&2 "test_must_fail: command succeeded: $*"
-		return 1
-	elif test $exit_code -gt 129 && test $exit_code -le 192; then
+		return 0
+	elif test $exit_code -gt 129 && test $exit_code -le 192
+	then
 		echo >&2 "test_must_fail: died by signal: $*"
 		return 1
-	elif test $exit_code = 127; then
+	elif test $exit_code = 127
+	then
 		echo >&2 "test_must_fail: command not found: $*"
 		return 1
-	elif test $exit_code = 126; then
+	elif test $exit_code = 126
+	then
 		echo >&2 "test_must_fail: valgrind error: $*"
 		return 1
 	fi
@@ -612,16 +626,7 @@ test_must_fail () {
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
