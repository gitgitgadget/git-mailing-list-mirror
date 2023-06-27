Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AA4EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjF0QTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjF0QT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:19:26 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4900835BD
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:19:13 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 886935B41B;
        Tue, 27 Jun 2023 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687882752;
        bh=5rqWhIMYQaEpvu6WVeVyxDSh8oTmcDWswhMznNJtt3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=oBZ5kHnv1zqShVmL+JNKMTd0e60xBqy024v4wc574JhujxNSdb4NHswW/1XB+dDVT
         dIHGnsU15iOCzu3Y2N7GjT8YnmBNXM35lDGlFkHYkJLbhY3KJsQBV3xpOaOMVQyK/8
         OFcaLmuyvWZloZx8Bj6X+/Tmv8cWafw7tOiItnm2qAmiSThDAf32aaC5hjpWZXpk1q
         HMI4iU8gvwxTRYfIs3vNqSBi59TwcFfoZopvQq5ROSEuEc4HjeTNsdW4kXy4A7IPSD
         fn6gS/I0qtkg0+8i4t2ZmewSFF3qJiyCJ6CY+Sd+7zghNUT/LbEuWv33mkuBcs1MOb
         YSWliBCpHfvodiCqFMljfxyx903yCqdXlcJ6IlzN+Ea3r1z5PMw8XCLacMe67RJHdu
         emrTtIrTRMPEk0QoZfm08aIm/kAhYGHKTGfAJh/wp60nzutPPD/OPUAKeQZ+cBE5re
         smME6GNomq7I/5VB/3MAaIgbWYD4JuXSdUyaQVz3I01YULnK9FS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 2/8] t: add a function to check executable bit
Date:   Tue, 27 Jun 2023 16:18:56 +0000
Message-ID: <20230627161902.754472-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230627161902.754472-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230627161902.754472-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

In line with our other helper functions for paths, let's add a function
to check whether a path is executable, and if not, print a suitable
error message.  Document this function, and note that it must only be
used under the POSIXPERM prerequisite, since it doesn't otherwise work
on Windows.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 t/README                | 6 ++++++
 t/test-lib-functions.sh | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/t/README b/t/README
index bdfac4cceb..3e155011de 100644
--- a/t/README
+++ b/t/README
@@ -1098,6 +1098,12 @@ see test-lib-functions.sh for the full list and their options.
    the symbolic link in the file system and a part that does; then only
    the latter part need be protected by a SYMLINKS prerequisite (see below).
 
+ - test_path_is_executable
+
+   This tests whether a file is executable and prints an error message
+   if not. This must be used only under the POSIXPERM prerequisite
+   (see below).
+
  - test_oid_init
 
    This function loads facts and useful object IDs related to the hash
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b3864e22e9..2fa716c567 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -910,6 +910,15 @@ test_path_is_symlink () {
 	fi
 }
 
+test_path_is_executable () {
+	test "$#" -ne 1 && BUG "1 param"
+	if ! test -x "$1"
+	then
+		echo "$1 is not executable"
+		false
+	fi
+}
+
 # Check if the directory exists and is empty as expected, barf otherwise.
 test_dir_is_empty () {
 	test "$#" -ne 1 && BUG "1 param"
