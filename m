From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 02/21] add basic http clone/fetch tests
Date: Wed, 25 Feb 2009 03:32:09 -0500
Message-ID: <73de0a47c03ac622b4ef502e2534a2ce0cbc3d22.1235546707.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:34:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFDS-0008Sh-VW
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbZBYIcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758583AbZBYIcj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:32:39 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:29972 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZBYIch (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:37 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1288220ywh.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jlEWqjWhRrvJMQoGSMTumWTxkXx9u5nnjwQRdS2ZrwA=;
        b=Jjg+snBE01Qt5jHPYYGKk/Uhr3yZrwTBJ5on7PGD42yKfx0WRKx18Kn/owiMYDcXow
         f1VBNzRBR7S/u1jLMC93i/gNsCozn8lX0cVKNNXNkPAoCI8SvCUWAJ8ldyWkW48GSl2C
         f1fDpuxshXDqtXcWPBNJmvpJmh//WTv/xxlrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=V/ciV9SWChU1zLmYMfQ4O+50QdDxehmeADSjzRyGgAL9Cbsj+klFYDjlYzhihVhjse
         kmEpEPaRCDCjcEkKXpjxnKG9SVZPl2ApfqRx/5K37BwwwXXLqIFvttNVFrnqXGFauNXK
         iQ6sZD7RYwDKq/YuM140XbvOZ72RgLFouKo04=
Received: by 10.100.228.13 with SMTP id a13mr827200anh.110.1235550754710;
        Wed, 25 Feb 2009 00:32:34 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b7sm2217165ana.59.2009.02.25.00.32.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:34 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111395>

From: Jeff King <peff@peff.net>

This was mostly being tested implicitly by the "http push"
tests. But making a separate test script means that:

  - we will run fetch tests even when http pushing support
    is not built

  - when there are failures on fetching, they are easier to
    see and isolate, as they are not in the middle of push
    tests

This script defaults to running the webserver on port 5550,
and puts the original t5540 on port 5540, so that the two
can be run simultaneously without conflict (but both still
respect an externally set LIB_HTTPD_PORT).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Makefile              |    1 +
 t/t5540-http-push.sh  |    1 +
 t/t5550-http-fetch.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100755 t/t5550-http-fetch.sh

diff --git a/Makefile b/Makefile
index b040a96..5e54c9c 100644
--- a/Makefile
+++ b/Makefile
@@ -1363,6 +1363,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
+	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 57a4411..cefab45 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -11,6 +11,7 @@ This test runs various sanity checks on http-push.'
 
 ROOT_PATH="$PWD"
 LIB_HTTPD_DAV=t
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
 
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
 then
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
new file mode 100755
index 0000000..b6e6ec9
--- /dev/null
+++ b/t/t5550-http-fetch.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='test fetching over http'
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	say 'skipping test, git built without http support'
+	test_done
+fi
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
+start_httpd
+
+test_expect_success 'setup repository' '
+	echo content >file &&
+	git add file &&
+	git commit -m one
+'
+
+test_expect_success 'create http-accessible bare repository' '
+	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 git --bare init &&
+	 echo "exec git update-server-info" >hooks/post-update &&
+	 chmod +x hooks/post-update
+	) &&
+	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public master:master
+'
+
+test_expect_success 'clone http repository' '
+	git clone $HTTPD_URL/repo.git clone &&
+	test_cmp file clone/file
+'
+
+test_expect_success 'fetch changes via http' '
+	echo content >>file &&
+	git commit -a -m two &&
+	git push public
+	(cd clone && git pull) &&
+	test_cmp file clone/file
+'
+
+stop_httpd
+test_done
-- 
1.6.2.rc1.291.g83eb
