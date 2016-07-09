Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E062018E
	for <e@80x24.org>; Sat,  9 Jul 2016 22:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbcGIWSi (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 18:18:38 -0400
Received: from imap.thunk.org ([74.207.234.97]:48194 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756855AbcGIWSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 18:18:38 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=Message-Id:Date:Subject:Cc:To:From; bh=HQSjarz5smhQypwunRtCw0hoI0MgRV953ecZAcPgLzA=;
	b=jz2CXHNOvVmmgSlyDLPjGK5iD04oYEbQ8AN+BaMbT6PGRc2Q+08zMqeRqTiF/hB7DhQMfOUKQDDEQmvM/jBmE0KD+gwJWqcczEEi4927yamFZuFsGPKiwGGbOUDJnAwbQ4wfB1/3tc/lPli9VjcUoyVHbfcNk+HY3dznt4pSxps=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bM0a5-0005Wr-Ch; Sat, 09 Jul 2016 22:18:37 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id A157682030B; Sat,  9 Jul 2016 18:18:36 -0400 (EDT)
From:	Theodore Ts'o <tytso@mit.edu>
To:	Git Mailing List <git@vger.kernel.org>
Cc:	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] guilt: fix portability problem with using find -perm +111
Date:	Sat,  9 Jul 2016 18:18:35 -0400
Message-Id: <1468102715-465-1-git-send-email-tytso@mit.edu>
X-Mailer: git-send-email 2.5.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

GNU find no longers accepts -perm +111, even though the rest of the
world (MacOS, Solaris, BSD) still do.  Workaround this problem by
using -executable if the system find utility will accept it.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 guilt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/guilt b/guilt
index 38d426b..b90f02d 100755
--- a/guilt
+++ b/guilt
@@ -73,8 +73,17 @@ GUILT_PATH="$(dirname "$0")"
 
 guilt_commands()
 {
-	find "$GUILT_PATH/../lib/guilt" -maxdepth 1 -name "guilt-*" -type f -perm +111 2> /dev/null | sed -e "s/.*\\/$GUILT-//"
-	find "$GUILT_PATH" -maxdepth 1 -name "guilt-*" -type f -perm +111 | sed -e "s/.*\\/$GUILT-//"
+	# GNU Find no longer accepts -perm +111, even though the rest
+	# world (MacOS, Solaris, BSD, etc.) does.  Sigh.  Using -executable
+	# is arugably better, but it is a GNU extension.  Since this isn't
+	# a fast path and guilt doesn't use autoconf, test for it as needed.
+	if find . -maxdepth 0 -executable > /dev/null 2>&1 ; then
+		exe_test="-executable"
+	else
+		exe_test="-find +111"
+	fi
+	find "$GUILT_PATH/../lib/guilt" -maxdepth 1 -name "guilt-*" -type f $exe_test 2> /dev/null | sed -e "s/.*\\/$GUILT-//"
+	find "$GUILT_PATH" -maxdepth 1 -name "guilt-*" -type f $exe_test | sed -e "s/.*\\/$GUILT-//"
 }
 
 # by default, we shouldn't fail
-- 
2.5.0

