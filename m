From: larsxschneider@gmail.com
Subject: [PATCH v5 1/6] implement test_might_fail using a refactored test_must_fail
Date: Sun, 15 Nov 2015 14:08:35 +0100
Message-ID: <1447592920-89228-2-git-send-email-larsxschneider@gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 14:09:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zxx3Y-0002cC-OS
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 14:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbbKONIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 08:08:53 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33207 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbbKONIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2015 08:08:45 -0500
Received: by wmec201 with SMTP id c201so140151168wme.0
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 05:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bso5DdwcMoU+5Li+xmBNZyuFKRCBIyXAdib5K3PH+qw=;
        b=sv3vb/rZrQ/rDkBLTq4tk4BN9rSHYFQ9bcmOf5RrI+eh/Bif8FoLm3DWxSSc/LrezW
         j4CTjujLE3SbZNsZ/jRBiDJkUxSTwFMO5MKUlvYmqWR39Uygx0LA08NXOTM8SDrLHNmF
         gW6wm09gcIT1dhJokhyGHOb5tf+ltALceW4gTkBgO8a5XM/zN7xaVc2cyWBa4YlWUDJi
         hltkU9+BA4MK9QeDlVqU1YHWhJdLRJN8iYnedY2LzlkQPxvaCe0Kwmd6czG5gfuRtBCx
         DVhjfX3QNn1fom6wlPOucH9lmka5FqRNKg0+8fQ/thxjsmSEfmuE0owvEJ5kk9C6QJCB
         BKtw==
X-Received: by 10.28.63.22 with SMTP id m22mr14328772wma.58.1447592923642;
        Sun, 15 Nov 2015 05:08:43 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB712F.dip0.t-ipconnect.de. [93.219.113.47])
        by smtp.gmail.com with ESMTPSA id t2sm13472567wme.0.2015.11.15.05.08.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Nov 2015 05:08:43 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281313>

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
