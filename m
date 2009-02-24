From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 20/23] add basic http clone/fetch tests
Date: Tue, 24 Feb 2009 04:51:08 -0500
Message-ID: <0e92666b696fa7044bb44108015de6b9325ca57e.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu07-0002Ej-Or
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbZBXJw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756084AbZBXJwL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:52:11 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:15777 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389AbZBXJwH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:52:07 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005621yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jlEWqjWhRrvJMQoGSMTumWTxkXx9u5nnjwQRdS2ZrwA=;
        b=nC29N2W8zCVKlfLxGZnAMuFbBt3hzASqJpf8EIwycLCg3bcUifY8FMaZ0iF/JjFZIm
         gX3ZoUNH1+XylAiD9O6HA6Ov6VRQm1x4cvFxwRSem1XuVGbwa+Pt8NhdNcNywOGdDNEo
         CMH2S0r5AtMVJ5/Fux4KYzZom/NwQgVDNn9kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WCwBz3epurfydvRgYN+mMwqUNuHtaoocp6nhPMRtHVrX8ayAS6aM/8b5jPu26MUZ7L
         Q6mHEqB+F3IPFQqRetAfn3kQ9ykNnu5+uQoTZklV9WXurtznpaAIIedCUJPZVczJtmDF
         tD+V+lrukw2LEnBA1eIWZEuMfY5qAibxWXc/M=
Received: by 10.100.135.16 with SMTP id i16mr2066357and.99.1235469125464;
        Tue, 24 Feb 2009 01:52:05 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d35sm2235242and.58.2009.02.24.01.52.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:52:04 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111266>

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
