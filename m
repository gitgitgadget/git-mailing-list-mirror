Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEE2C4345B
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB5320715
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DeV01fO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgGZTzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40666 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727955AbgGZTyx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:53 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7231160CF6;
        Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793292;
        bh=e0GG4MGDDPBIn8sVOpdBt+JTBrciFKCG4qAUcFp9kSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DeV01fO71GmT2GORiDW3oan1elzwe24i7AsqB0jyD0O/Z/HXYQKDgc3UX10TWNOPl
         vV/weThqslaIC3Kyr/PvtVVEXipi+0j9baj/06aY9X73+Cx7Ek9GMuhqnagIfpOemN
         fCtYTc29Dgo8pTGvEAFQJy3Zv3MBu0FnxNiH1Yld3aPfsS34q+4ZX+mMQ1L+5UXP84
         2ChVxEFnhDobbo7J1FROgC3AB+QZ4ffJ0Q7SZ0jboEnZLcnlKvEadtMe/mXlBDiesj
         IsHdKGVipoD2mbL6oeF43BPIlJkogBXyXwANNBzSr1xJu8S01hhO5rDG1H13IISY4D
         NNUx1gHZAyViMWviFS8chRgR0Ie3r/Iii3R2iZ5J3BhbnwvmSdT6QHb5rWT2IhKhrP
         S6clOI3OGbzXle7+csuZ1sN9g95RaEqbxuO2CpKVIV7Fj2QW/W9p/Ac5q0lB5C1aYb
         wC7TQrxfSWCELisYPkc/HzQlmm24E9DjvgCQ3BP0jSbpKq1Hyh4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 25/39] t9500: ensure that algorithm info is preserved in config
Date:   Sun, 26 Jul 2020 19:54:10 +0000
Message-Id: <20200726195424.626969-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we use a hash algorithm other than SHA-1, it's important to
preserve the hash-related values in the config file, but this test
overwrites the config file with a new one. Ensure we copy these values
properly from the old config to the new one so that the repository can
be read if it's using SHA-256.

Note that if there is no extensions.objectFormat value set, git config
will return unsuccessfully if we try to read it; since this is not an
error for us, use test_might_fail.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9500-gitweb-standalone-no-errors.sh | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 267ddc997d..b484e3e250 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -621,12 +621,22 @@ test_expect_success \
 	 git config gitweb.snapshot "zip,tgz, tbz2" &&
 	 gitweb_run "p=.git;a=tree"'
 
-cat >.git/config <<\EOF
-# testing noval and alternate separator
-[gitweb]
-	blame
-	snapshot = zip tgz
-EOF
+test_expect_success 'setup' '
+	version=$(git config core.repositoryformatversion) &&
+	algo=$(test_might_fail git config extensions.objectformat) &&
+	cat >.git/config <<-\EOF &&
+	# testing noval and alternate separator
+	[gitweb]
+		blame
+		snapshot = zip tgz
+	EOF
+	git config core.repositoryformatversion "$version" &&
+	if test -n "$algo"
+	then
+		git config extensions.objectformat "$algo"
+	fi
+'
+
 test_expect_success \
 	'config override: tree view, features enabled in repo config (2)' \
 	'gitweb_run "p=.git;a=tree"'
