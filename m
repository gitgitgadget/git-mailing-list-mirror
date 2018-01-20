Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC8A1F424
	for <e@80x24.org>; Sat, 20 Jan 2018 20:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756653AbeATUdh (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 15:33:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58162 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756624AbeATUdg (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Jan 2018 15:33:36 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 52F8560402;
        Sat, 20 Jan 2018 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516480413;
        bh=6iSVF3PJbef1aeoxruEacBSLP55FNOSCH1zUMy1A8Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ekanK/JBcpUSrYlXG5jvkpphsYPkcJdAhrg1QgdYa3icN/WqsE3Ul1Kmj2hHCJBg+
         1s9/TonvdL8lAIvuBR9NB+XoPhWE4BAv2xcScWB+h/87wSuuIilB9AE/5bhqC5BKbZ
         d7zxlWPFWJjcyACHRs+1TZ+HygpxzAGohRODUdU+MTpQp2yV11x3L4/tsG7fScTM9z
         Aa7EMj/EMtdEa+0xQo62f6I5kySfKmzc7KOlSJ6zQmGMMKFOPvzZxcjmOJPfantnlI
         QZ9csINqVcj8di2KLD5s4lrDpgApKTIV0lSgZIWa8DyCeNPxsZo37MCNH84GPZNAbR
         WbmipDbDIgAwlfxmngUVjf6XlEjXY3yf4yX8XKEeHGnHqkHZqpU0I9RS4S/bAG7Bei
         htVAjkClCdoiyDb4+BIBPbRjLE842eJhaTU+N7NsrZQTcyDqEGsRw6mnWvK4fqMmi3
         lqyhUjA4F6hTjpLPmIKFX9UJSTBmzmPD7Z/+EBQlqneVN5DgkOL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80=20=D0=91=D1=83=D0=BB=D0=B0=D0=B5=D0=B2?= 
        <aleks.bulaev@gmail.com>
Subject: [PATCH] t: add clone test for files differing only in case
Date:   Sat, 20 Jan 2018 20:33:24 +0000
Message-Id: <20180120203324.112522-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.0.rc2.280.g09355b536d
In-Reply-To: <20180119041825.727904-1-sandals@crustytoothpaste.net>
References: <20180119041825.727904-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recently introduced a regression in cloning repositories onto
case-insensitive file systems where the repository contains multiple
files differing only in case.  In such a case, we would segfault.  This
segfault has already been fixed (repository: pre-initialize hash algo
pointer), but it's not the first time similar problems have arisen.
Introduce a test to catch this case and ensure the behavior does not
regress.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5601-clone.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

I've verified that the test does fail without the patch on a vfat file
system.  However, many other tests also fail on a vfat file system on
Linux, so unfortunately that doesn't look like a viable testing strategy
going forward.

I didn't include an object ID for the commit referenced simply because I
didn't see one yet and I didn't want to insert a local one that wouldn't
work for anyone else.

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0f895478f0..53b2dda9d2 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -611,4 +611,17 @@ test_expect_success 'GIT_TRACE_PACKFILE produces a usable pack' '
 	git -C replay.git index-pack -v --stdin <tmp.pack
 '
 
+hex2oct() {
+	perl -ne 'printf "\\%03o", hex for /../g'
+}
+
+test_expect_success 'clone on case-insensitive fs' '
+	o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
+	t=$(printf "100644 X\0${o}100644 x\0${o}" |
+		git hash-object -w -t tree --stdin) &&
+	c=$(git commit-tree -m bogus $t) &&
+	git update-ref refs/heads/bogus $c &&
+	git clone -b bogus . bogus
+'
+
 test_done
