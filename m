From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Allow HTTP tests to run on Darwin
Date: Wed, 25 Feb 2009 03:28:15 -0500
Message-ID: <1235550495-94709-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:29:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcF9K-0007AQ-JQ
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470AbZBYI2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757426AbZBYI2W
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:28:22 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:44019 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049AbZBYI2V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:28:21 -0500
Received: by an-out-0708.google.com with SMTP id c2so1347519anc.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ckWP1p1yHymwZ6qsLHboKtnVGOBQoBp3S9pAsKaRUn8=;
        b=BEAVwZQPtHoM7XbIPjWyTdGkB3t4szWNz+X1eBfUC8t1Lb4nxKC8YvF/nwKE3wKs+B
         bVhJHzCaqsykPl3y3DwCK+9F6MRxxRws+1XYOO7bIct4EBN5xG8xPbk0UqaR36iZ95QN
         vAkCAWzmxUVReBJ0Fb+18Llufo+b9E+6DOe1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=uIsQQkxhVxDu5/1k2uUhH9VzHeFlCPG7hQz3gadxc4Y+nf6cRpqIwJCgesovMOo4p1
         xjj+6Rlcx6hd5aI8wcHUCv5Qiv2fRh6XrQRWQUf9pa3ffpk9zTZThfOouNQ2QiistTZb
         4/Y4D94rrN8rli23qtBe9CGl4C/9v3yGs2w04=
Received: by 10.100.8.17 with SMTP id 17mr849644anh.40.1235550498261;
        Wed, 25 Feb 2009 00:28:18 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c1sm13843541ana.20.2009.02.25.00.28.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:28:17 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111391>

This patch allows the HTTP tests to run on OS X 10.5. It is not
sufficient to be able to pass in LIB_HTTPD_PATH and
LIB_HTTPD_MODULE_PATH alone, as the apache.conf also needs a couple
tweaks.

These changes are put into an <IfDefine> to keep them Darwin specific,
but this means lib-httpd.sh needs to be modified to pass -DDarwin to
apache when running on Darwin. As long as we're making this change to
lib-httpd.sh, we may as well set LIB_HTTPD_PATH and
LIB_HTTPD_MODULE_PATH to appropriate default values for the platform.

Note that we now pass HTTPD_PARA to apache at shutdown as well.
Otherwise apache will emit a harmless, but noisy warning that LogFormat
is an unknown directive.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 t/lib-httpd.sh          |   22 +++++++++++++++++-----
 t/lib-httpd/apache.conf |    6 ++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 3824020..86cdebc 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -11,7 +11,21 @@ then
 	exit
 fi
 
-LIB_HTTPD_PATH=${LIB_HTTPD_PATH-'/usr/sbin/apache2'}
+HTTPD_PARA=""
+
+case $(uname) in
+	Darwin)
+		DEFAULT_HTTPD_PATH='/usr/sbin/httpd'
+		DEFAULT_HTTPD_MODULE_PATH='/usr/libexec/apache2'
+		HTTPD_PARA="$HTTPD_PARA -DDarwin"
+	;;
+	*)
+		DEFAULT_HTTPD_PATH='/usr/sbin/apache2'
+		DEFAULT_HTTPD_MODULE_PATH='/usr/lib/apache2/modules'
+	;;
+esac
+
+LIB_HTTPD_PATH=${LIB_HTTPD_PATH-"$DEFAULT_HTTPD_PATH"}
 LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'8111'}
 
 TEST_PATH="$TEST_DIRECTORY"/lib-httpd
@@ -39,14 +53,12 @@ then
 			exit
 		fi
 
-		LIB_HTTPD_MODULE_PATH='/usr/lib/apache2/modules'
+		LIB_HTTPD_MODULE_PATH="$DEFAULT_HTTPD_MODULE_PATH"
 	fi
 else
 	error "Could not identify web server at '$LIB_HTTPD_PATH'"
 fi
 
-HTTPD_PARA=""
-
 prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 
@@ -95,5 +107,5 @@ stop_httpd() {
 	trap 'die' EXIT
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
-		-f "$TEST_PATH/apache.conf" -k stop
+		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
 }
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index fdb19a5..af6e5e1 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -5,6 +5,12 @@ LogFormat "%h %l %u %t \"%r\" %>s %b" common
 CustomLog access.log common
 ErrorLog error.log
 
+<IfDefine Darwin>
+	LoadModule log_config_module modules/mod_log_config.so
+	LockFile accept.lock
+	PidFile httpd.pid
+</IfDefine>
+
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
 
-- 
1.6.2.rc1.291.g83eb
