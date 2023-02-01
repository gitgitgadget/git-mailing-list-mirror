Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF0AC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 11:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjBALhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 06:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjBALhX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 06:37:23 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A723430F
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 03:37:22 -0800 (PST)
Received: (qmail 31500 invoked by uid 109); 1 Feb 2023 11:37:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 11:37:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19331 invoked by uid 111); 1 Feb 2023 11:37:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 06:37:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 06:37:21 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>
Subject: [PATCH 1/4] t/lib-httpd: bump required apache version to 2.2
Message-ID: <Y9pO8bBZjXjEZhR/@coredump.intra.peff.net>
References: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apache 2.2 was released in 2005, almost 18 years ago. We can probably
assume that people are running a version at least that old (and the
stakes for removing it are fairly low, as the worst case is that they
would not run the http tests against their ancient version).

Dropping support for the older versions cleans up the config file a
little, and will also enable us to bump the required version further
(with more cleanups) in a future patch.

Note that the file actually checks for version 2.1. In apache's
versioning scheme, odd numbered versions are for development and even
numbers are for stable releases. So 2.1 and 2.2 are effectively the same
from our perspective.

Older versions would just fail to start, which would generally cause us
to skip the tests. However, we do have version detection code in
lib-httpd.sh which produces a nicer error message, so let's update that,
too. I didn't bother handling the case of "3.0", etc. Apache has been on
2.x for 21 years, with no signs of bumping the major version.  And if
they eventually do, I suspect there will be enough breaking changes that
we'd need to update more than just the numeric version check. We can
worry about that hypothetical when it happens.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh          | 11 +++++++----
 t/lib-httpd/apache.conf |  8 --------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 608949ea80..8fc411ff41 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -99,16 +99,19 @@ then
 fi
 
 HTTPD_VERSION=$($LIB_HTTPD_PATH -v | \
-	sed -n 's/^Server version: Apache\/\([0-9]*\)\..*$/\1/p; q')
+	sed -n 's/^Server version: Apache\/\([0-9.]*\).*$/\1/p; q')
+HTTPD_VERSION_MAJOR=$(echo $HTTPD_VERSION | cut -d. -f1)
+HTTPD_VERSION_MINOR=$(echo $HTTPD_VERSION | cut -d. -f2)
 
-if test -n "$HTTPD_VERSION"
+if test -n "$HTTPD_VERSION_MAJOR"
 then
 	if test -z "$LIB_HTTPD_MODULE_PATH"
 	then
-		if ! test $HTTPD_VERSION -ge 2
+		if ! test "$HTTPD_VERSION_MAJOR" -eq 2 ||
+		   ! test "$HTTPD_VERSION_MINOR" -ge 2
 		then
 			test_skip_or_die GIT_TEST_HTTPD \
-				"at least Apache version 2 is required"
+				"at least Apache version 2.2 is required"
 		fi
 		if ! test -d "$DEFAULT_HTTPD_MODULE_PATH"
 		then
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0294739a77..35f5e28507 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -38,13 +38,6 @@ Protocols h2c
 LockFile accept.lock
 </IfVersion>
 
-<IfVersion < 2.1>
-<IfModule !mod_auth.c>
-	LoadModule auth_module modules/mod_auth.so
-</IfModule>
-</IfVersion>
-
-<IfVersion >= 2.1>
 <IfModule !mod_auth_basic.c>
 	LoadModule auth_basic_module modules/mod_auth_basic.so
 </IfModule>
@@ -57,7 +50,6 @@ LockFile accept.lock
 <IfModule !mod_authz_host.c>
 	LoadModule authz_host_module modules/mod_authz_host.so
 </IfModule>
-</IfVersion>
 
 <IfVersion >= 2.4>
 <IfModule !mod_authn_core.c>
-- 
2.39.1.767.gb4615b3bd3

