From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http-push: add regression tests
Date: Sat, 23 Feb 2008 22:28:44 +0100
Message-ID: <20080223212843.GA30054@localhost>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT1vx-0003vj-Ta
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 22:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbYBWV2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 16:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbYBWV2t
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 16:28:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:62132 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbYBWV2s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 16:28:48 -0500
Received: by fg-out-1718.google.com with SMTP id e21so688266fga.17
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 13:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=YGhfJl7Y4flsS8fmj2GjZMPW4pZAUEbmL+5ul8o8NcI=;
        b=PEyG4qnEG+8YadMKoDwQfC5PxLurfhEtlPVo59hUQXZ/s/WomCkAu1JA6jGQQUAFDfa3mkGNlAtdGv0m/NoHnh6a9mvymECtW9EPEgSiri624SN/w5vO5Ak2sFL38X0BqJtGCVQTR0FtT+4D7ZlSJfvnkVuI3qXni6sTWG2q+MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=npxRM42wRHlY673mTqrLSgSof6a4/zt56q6MvhFiU0ropmWPudq4QKwbnRwQtPQWJfMMSMMthqlEvS3hYE9H8h1hYy+P51NDfgHydYlPq/3caku2WHayg7w213RjYFWDgwENQMMCyx+5+z/cwXupK8IyonjEIvxGHoZac/ft7RY=
Received: by 10.86.1.1 with SMTP id 1mr842231fga.2.1203802125698;
        Sat, 23 Feb 2008 13:28:45 -0800 (PST)
Received: from darc.dyndns.org ( [88.117.111.126])
        by mx.google.com with ESMTPS id l12sm3007722fgb.8.2008.02.23.13.28.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Feb 2008 13:28:43 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JT1vI-0007yt-2x; Sat, 23 Feb 2008 22:28:44 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802181733400.30505@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74855>

These tests require a webserver. The executable path and listening port
are configured using the environment variables

HTTPD_PATH (default: /usr/sbin/apache2) and
HTTPD_PORT (default: 8111),

respectively.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t5540-http-push.sh |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 t/t5540-http-push.sh

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
new file mode 100644
index 0000000..60210ff
--- /dev/null
+++ b/t/t5540-http-push.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
+#
+
+test_description='test http-push
+
+This test runs various sanity checks on http-push.'
+
+. ./test-lib.sh
+
+HTTPD_PATH=${HTTPD_PATH-'/usr/sbin/apache2'}
+HTTPD_PORT=${HTTPD_PORT-'8111'}
+
+if ! test -x "$HTTPD_PATH"
+then
+        test_expect_success 'skipping http-push tests, no suitable webserver' :
+        test_done
+        exit
+fi
+
+TRASH_PATH=$PWD
+
+start_httpd() {
+	cat > "$TRASH_PATH/httpd.conf" <<EOF
+ServerRoot "$TRASH_PATH"
+PidFile "$TRASH_PATH/httpd.pid"
+DocumentRoot "$TRASH_PATH"
+ErrorLog "$TRASH_PATH/error.log"
+Listen 127.0.0.1:$HTTPD_PORT
+LoadModule dav_module /usr/lib/apache2/modules/mod_dav.so
+LoadModule dav_fs_module /usr/lib/apache2/modules/mod_dav_fs.so
+DAVLockDB DAVLock
+<Location />
+	Dav on
+</Location>
+EOF
+
+	"$HTTPD_PATH" -f "$TRASH_PATH"/httpd.conf -k start
+}
+
+stop_httpd() {
+	"$HTTPD_PATH" -f "$TRASH_PATH"/httpd.conf -k stop
+}
+
+test_expect_success 'setup webserver' '
+	start_httpd
+'
+
+test_expect_success 'setup remote repository' '
+	cd "$TRASH_PATH" &&
+	mkdir test_repo &&
+	cd test_repo &&
+	git init &&
+	: >path1 &&
+	git add path1 &&
+	test_tick &&
+	git commit -m initial &&
+	cd - &&
+	git clone --bare test_repo test_repo.git &&
+	cd test_repo.git &&
+	git --bare update-server-info &&
+	chmod +x hooks/post-update
+'
+	
+test_expect_success 'clone remote repository' '
+	cd "$TRASH_PATH" &&
+	git clone http://127.0.0.1:$HTTPD_PORT/test_repo.git test_repo_clone
+'
+
+test_expect_success 'push to remote repository' '
+	cd "$TRASH_PATH"/test_repo_clone &&
+	: >path2 &&
+	git add path2 &&
+	test_tick &&
+	git commit -m path2 &&
+	git push
+'
+
+test_expect_success 'create and delete remote branch' '
+	cd "$TRASH_PATH"/test_repo_clone &&
+	git checkout -b dev &&
+	: >path3 &&
+	git add path3 &&
+	test_tick &&
+	git commit -m dev &&
+	git push origin dev &&
+	git fetch &&
+	git push origin :dev &&
+	git branch -d -r origin/dev &&
+	git fetch &&
+	! git show-ref --verify refs/remotes/origin/dev
+'
+
+stop_httpd
+
+test_done
-- 
1.5.4.2.156.ge3c5
