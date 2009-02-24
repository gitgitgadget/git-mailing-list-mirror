From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 19/23] test scripts: refactor start_httpd helper
Date: Tue, 24 Feb 2009 04:51:07 -0500
Message-ID: <3149d7f0af526b2e0654c88b4aba6e47f2ffab7c.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu04-0002Ej-4y
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbZBXJwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756064AbZBXJwJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:52:09 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:23009 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225AbZBXJwF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:52:05 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1006909ywh.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ml+GRJHKVAK12cIjcErnX39/YpGlrAiGhzcTanh8kKI=;
        b=Pz2wI9QSsM1NPLgSspuLnrzgOqRxjt9l/pYtwQ5I9p8ngGmM4XAA98fyLm/tqdto3R
         BCOAv5yjAShP059/whx1BvWNeXsgF1PUgCuyiEiau9lgBiTq3pnhQ7HmKQ7Tr/qvWQ7F
         Mt3ZuhVOFfaF8+3ivqKEix3yb+3WITWfjdjbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eEi3uWk8dp9OkVMRw538tZRsK0ICpRgvvB6DbaqDa6AHKyEYqKGjKwB4zNWbL04yU9
         t+4LyBhfI/bzhwFfXWkS3S6cgFkUfMBkc0d8EjdYuGD5dqs+S25eVW/v3jJ5rb9InWeJ
         ZplkwlRBfFCEcV8yoUmm87dip4ivLYc/mS+sg=
Received: by 10.100.91.3 with SMTP id o3mr5369892anb.158.1235469123197;
        Tue, 24 Feb 2009 01:52:03 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d24sm10629814and.30.2009.02.24.01.52.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:52:02 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111270>

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
