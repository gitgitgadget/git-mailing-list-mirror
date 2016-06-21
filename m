Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 656691F744
	for <e@80x24.org>; Tue, 21 Jun 2016 11:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbcFULXG (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:23:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47154 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbcFULXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:23:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD0F20189;
	Tue, 21 Jun 2016 11:23:03 +0000 (UTC)
Date:	Tue, 21 Jun 2016 11:23:03 +0000
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Cc:	Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>
Subject: http-backend fatal error message on shallow clone
Message-ID: <20160621112303.GA21973@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I noticed "fatal: The remote end hung up unexpectedly" in server
logs from shallow clones.  Totally reproducible in the test
cases, too.  The following change shows it:

diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 90e0d6f..cfa55ce 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -132,5 +132,11 @@ test_expect_success 'server request log matches test results' '
 	test_cmp exp act
 '
 
+test_expect_success 'shallow clone' '
+	config http.uploadpack true &&
+	git clone --depth=1 "$HTTPD_URL/smart/repo.git" shallow &&
+	tail "$HTTPD_ROOT_PATH"/error.log | grep fatal
+'
+
 stop_httpd
 test_done


And the last test ends like this:

expecting success: 
	config http.uploadpack true &&
	git clone --depth=1 "$HTTPD_URL/smart/repo.git" shallow &&
	tail "$HTTPD_ROOT_PATH"/error.log | grep fatal

Cloning into 'shallow'...
[Tue Jun 21 11:07:41.391269 2016] [cgi:error] [pid 21589] [client 127.0.0.1:37518] AH01215: fatal: The remote end hung up unexpectedly
ok 15 - shallow clone

It doesn't show above, but I think http-backend exits
with a non-zero status, too, which might cause some CGI
implementations to complain or break.

Not sure if it's just a corner case that wasn't tested
or something else, but the clone itself seems successful...
