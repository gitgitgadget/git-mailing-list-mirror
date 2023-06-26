Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA0EB64D9
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjFZTA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFZTAz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 15:00:55 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F83E75
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 12:00:52 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 532035B417;
        Mon, 26 Jun 2023 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687806051;
        bh=5rqWhIMYQaEpvu6WVeVyxDSh8oTmcDWswhMznNJtt3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hEb6H+t1aeY3yK/7w/6/dOnpIREPOkq7OWVUBqwsWn9UFeMPAs34al6RhaBiYfehi
         2UdSdT90aa0IXAlUQ0rVfb2ST1FM0ukPu5EoBPHv8NNLwHyV7O638/ScKLcsr2M9fN
         Qr/wawQLOO6N+xzoFB16ob3+ihXL4Gc4Hk/4hk2/rr3GzPbnMDokKNaA1jbA2koPKA
         1suBcv9/jdo6QZeBGLcl8EtVwLp75bQlR1GPax0wD1RWfk7VQoLUjmLsK0AlO3WGWv
         J4bVFHS8NdJGzS90qRJ6MRJrjoZwewkynhkMj9Bf40pH8PDkwVCpwTPf6/O9iYkDzM
         AVlWp6GBwMpeQ2HGSOsQtZN7MDVaE5NpDzrYLRMMJIdCOTY/ZDjFomtN5FLz8fpGM1
         XA8MYmTfxY5SJvE7tO5L4SS5KHwRAZhWWjkKKbNu409i+89r15u2yq8I1zqLPKs7T3
         RgUtmpqeHCiD0dPmH5eKS8hIVO6Dk9Svmd+DzQSjDq+slUXmVd+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 1/7] t: add a function to check executable bit
Date:   Mon, 26 Jun 2023 19:00:02 +0000
Message-ID: <20230626190008.644769-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230626190008.644769-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230626190008.644769-1-sandals@crustytoothpaste.net>
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
