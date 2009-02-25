From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 01/21] test scripts: refactor start_httpd helper
Date: Wed, 25 Feb 2009 03:32:08 -0500
Message-ID: <179378c3042852f42d554421b297daaebd8a649d.1235546707.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:34:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFDS-0008Sh-8W
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758142AbZBYIcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbZBYIcg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:32:36 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:33864 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757497AbZBYIcf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:35 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1288214ywh.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ml+GRJHKVAK12cIjcErnX39/YpGlrAiGhzcTanh8kKI=;
        b=Nw622Jjt6l4cijJrpBEDOb3hJsUFvvAqllkOfjvWg7A+RSdSUc8SV9Le032x6pJmA0
         0DcYbFfq7vw51VBb5Y7J+5KbDbg51tlTEl4lMn/CCAcRrxE2Y45ePfLjZnpauhe+/CqC
         m7p8166PJ0bSmQpbFX5WPz1mwUlWur7WT3hko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XJtUXa5OooKmb0sTey6/vuOXEgE1R1v6yNO39r6r4dkUTZF03Rf6/apc8q0WfFdsI/
         txG3V2M27LY+a0U7XIOIApMoPPe0+K4PeLN9EBDRk95BbGUQmmkffsNpV5L09aks4Wv+
         wEYzY36c+e1btmZEuT8mD4mbiq9UoIDIkTXYg=
Received: by 10.100.58.18 with SMTP id g18mr795588ana.26.1235550752500;
        Wed, 25 Feb 2009 00:32:32 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b32sm4809616ana.55.2009.02.25.00.32.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:31 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111393>

From: Jeff King <peff@peff.net>

There are some redirects and some error checking that need
to be done by the caller; let's move both into the
start_httpd function so that all callers don't have to
repeat them (there is only one caller now, but another will
follow in this series).

This doesn't violate any assumptions that aren't already
being made by lib-httpd, which is happy to say "skipping"
and call test_done for a number of other cases.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 t/lib-httpd.sh       |    9 +++++++--
 t/t5540-http-push.sh |    8 +-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 3824020..88cfc51 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -82,13 +82,18 @@ prepare_httpd() {
 }
 
 start_httpd() {
-	prepare_httpd
+	prepare_httpd >&3 2>&4
 
 	trap 'stop_httpd; die' EXIT
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
-		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start
+		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start \
+		>&3 2>&4
+	if ! test $? = 0; then
+		say "skipping test, web server setup failed"
+		test_done
+	fi
 }
 
 stop_httpd() {
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 11b3432..57a4411 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -20,13 +20,7 @@ then
 fi
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
-
-if ! start_httpd >&3 2>&4
-then
-	say "skipping test, web server setup failed"
-	test_done
-	exit
-fi
+start_httpd
 
 test_expect_success 'setup remote repository' '
 	cd "$ROOT_PATH" &&
-- 
1.6.2.rc1.291.g83eb
