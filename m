Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C176C433F8
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D5A2065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SvK3dZXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgGZTzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40746 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728001AbgGZTy6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DEFD460CF6;
        Sun, 26 Jul 2020 19:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793297;
        bh=2wb0pxNxxHB8AyR/+6fbiG1mvbjofu/+IuiJcIxweiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SvK3dZXmeH5K9iLKS+kp1LVQHIGBNd1EBCuCn7NO7ffzVgqcibqKuX8MfoS+1t3z8
         zzaCEHUlYA9rOXspvRcNkWxdgJqqC4I61S0DQtJT3U+Ij3lTOerIl0Zlot9IT5hh0l
         5w2+tO5HJGFcADZziWClowJkCuNsYluyK1R1ZcKm4aRvTyK2F8e3YnWs+LTw5Gnrs4
         ibjXgSrWx4sOnvcGBSIRttXYUI+TUFUz7gFl+J9WzlVtw2dRMU3MGUEOXtqwc9ZLFU
         zdjnQhEY4WvTj2QHSr94m2epcC2Ag6QLew+iNjSl5HfGvWJkK4ufIA9USRkNIFXrhP
         ITbvY4O6RKL0vGc03rJcPSpe9tUrXbW/IQXe65jhjONCINcjprsvD6JKINRpFWmxWZ
         ikMUfMnwuBbWFzpKFJjO80LVcrL3D60CCagDG6Go6r4j8HTorFj+tinNQda8tAUXvf
         53jwUkyK2NJS2w018wl04H3jAc+M0kgeYsByep4E9GjJUBaHM+P
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 35/39] t: allow testing different hash algorithms via environment
Date:   Sun, 26 Jul 2020 19:54:20 +0000
Message-Id: <20200726195424.626969-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To allow developers to run the testsuite with a different algorithm than
the default, provide an environment variable, GIT_TEST_DEFAULT_HASH, to
specify the algorithm to use. Compute the fixed constants using
test_oid. Move the constant initialization down below the point where
test-lib-functions.sh is loaded so the functions are defined.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib-functions.sh | 4 +---
 t/test-lib.sh           | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2608e80f11..2e01bb2c2b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1417,9 +1417,7 @@ test_set_hash () {
 
 # Detect the hash algorithm in use.
 test_detect_hash () {
-	# Currently we only support SHA-1, but in the future this function will
-	# actually detect the algorithm in use.
-	test_hash_algo='sha1'
+	test_hash_algo="${GIT_TEST_DEFAULT_HASH:-sha1}"
 }
 
 # Load common hash metadata and common placeholder object IDs for use with
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 618a7c8d5b..307bb2207e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -452,6 +452,9 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
+GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-sha1}"
+export GIT_DEFAULT_HASH
+
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
 GIT_TRACE_BARE=1
 export GIT_TRACE_BARE
