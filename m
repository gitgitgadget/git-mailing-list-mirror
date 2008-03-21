Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 2710 invoked by uid 111); 21 Mar 2008 07:27:41 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 21 Mar 2008 03:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbYCUH1i (ORCPT <rfc822;peff@peff.net>);
	Fri, 21 Mar 2008 03:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753705AbYCUH1i
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 03:27:38 -0400
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:53026 "EHLO
	randymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753620AbYCUH1h (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2008 03:27:37 -0400
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a12.g.dreamhost.com (Postfix) with ESMTP id 4C78AA6EE9;
	Fri, 21 Mar 2008 00:27:36 -0700 (PDT)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: [PATCH] Make git-svn tests behave better on OS X
Date:	Fri, 21 Mar 2008 03:27:35 -0400
Message-Id: <1206084455-2793-1-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.5.rc0.23.gf91eb
In-Reply-To: <7vod98r210.fsf@gitster.siamese.dyndns.org>
References: <7vod98r210.fsf@gitster.siamese.dyndns.org>
To:	Eric Wong <normalperson@yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch works fine for me.

-->8--

Give lib-git-svn.sh a few alternate paths to look for apache2.
Explicitly define the LockFile so httpd will actually start under OS X

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 t/lib-git-svn.sh |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 9ee35e7..9decd2e 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -49,8 +49,28 @@ poke() {
 	test-chmtime +1 "$1"
 }
 
-SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
-SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
+for d in \
+	"$SVN_HTTPD_PATH" \
+	/usr/sbin/apache2 \
+	/usr/sbin/httpd \
+; do
+	if test -f "$d"
+	then
+		SVN_HTTPD_PATH="$d"
+		break
+	fi
+done
+for d in \
+	"$SVN_HTTPD_MODULE_PATH" \
+	/usr/lib/apache2/modules \
+	/usr/libexec/apache2 \
+; do
+	if test -d "$d"
+	then
+		SVN_HTTPD_MODULE_PATH="$d"
+		break
+	fi
+done
 
 start_httpd () {
 	if test -z "$SVN_HTTPD_PORT"
@@ -66,6 +86,7 @@ ServerName "git-svn test"
 ServerRoot "$GIT_DIR"
 DocumentRoot "$GIT_DIR"
 PidFile "$GIT_DIR/httpd.pid"
+LockFile logs/accept.lock
 Listen 127.0.0.1:$SVN_HTTPD_PORT
 LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
 LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
-- 
1.5.5.rc0.23.gf91eb

