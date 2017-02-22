Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2F4201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbdBVXin (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:38:43 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40250 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933785AbdBVXim (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 18:38:42 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 37A8F280AD;
        Wed, 22 Feb 2017 23:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487806721;
        bh=TQ85D+gyWlDuBtjdyTygaoXYlH5cGvlMJkmy9wOhCG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHh1ae0mZ4XFYjxf6nBt0CPiWoHz5jhz9qVHdmNOt4+flfBrcId8tiWDQN67PLWbl
         OMpA+EnkdXWbVTQEGZX2yh3+uyd0a4d9sePVOgPBF1kbrXLneBvTDro3UQ2xiBqKDs
         1EGjX9pTPO2fxALaQZSZAyelQZ5ZhCed7VvLCWYEJg4nc4ycPy6PMoi3EKfb20FNlU
         72/2v1WlynsQo9iw6+Cz7jMt9q5w6xdBCporMUuc6RPCeRes5HhaOShhQdWxmL6s3G
         7INmu/mU4UBumawiybSDr4bcIZ6uFNFkDCvE2c3Rc20XHoC65T7GAmj/zOuYHIzhs1
         2k9UY/2HMs/YPzhcWXtPEkpERFVepgLI5oCwjQJH9Gk7BLmXdC6WvVUeqUWe9n0ToA
         prC9TQkjZSq0c7oGnTn+pO2/9dJmKLM8dfvzVvfdEHcmKQMQQ4YJjNJy2/ywsmBQ9e
         9AycvLYBQVISD576/8+3D8ddWaGCwAGxqPRHvql3hoOxJ3oTbV5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] t: add multi-parent test of diff-tree --stdin
Date:   Wed, 22 Feb 2017 23:38:38 +0000
Message-Id: <20170222233838.925157-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170222232215.u2agozagwsyy2ooe@genre.crustytoothpaste.net>
References: <20170222232215.u2agozagwsyy2ooe@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were lacking a test that covered the multi-parent case for commits.
Add a basic test to ensure we do not regress this behavior in the
future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4013-diff-various.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

It's a little bit ugly to me that this test hard-codes so many values,
and I'm concerned that it may be unnecessarily brittle.  However, I
don't have a good idea of how to perform the kind of comprehensive test
we need otherwise.

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index d09acfe48e..e6c2a7a369 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -349,4 +349,23 @@ test_expect_success 'diff-tree --stdin with log formatting' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff-tree --stdin with two parent commits' '
+	cat >expect <<-\EOF &&
+	c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+	:040000 040000 da7a33fa77d8066d6698643940ce5860fe2d7fb3 f977ed46ae6873c1c30ab878e15a4accedc3618b M	dir
+	:100644 100644 01e79c32a8c99c557f0757da7cb6d65b3414466d f4615da674c09df322d6ba8d6b21ecfb1b1ba510 M	file0
+	:000000 100644 0000000000000000000000000000000000000000 7289e35bff32727c08dda207511bec138fdb9ea5 A	file3
+	9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+	:040000 040000 847b63d013de168b2de618c5ff9720d5ab27e775 65f5c9dd60ce3b2b3324b618ac7accf8d912c113 M	dir
+	:000000 100644 0000000000000000000000000000000000000000 b1e67221afe8461efd244b487afca22d46b95eb8 A	file1
+	1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+	:040000 040000 da7a33fa77d8066d6698643940ce5860fe2d7fb3 847b63d013de168b2de618c5ff9720d5ab27e775 M	dir
+	:100644 100644 01e79c32a8c99c557f0757da7cb6d65b3414466d b414108e81e5091fe0974a1858b4d0d22b107f70 M	file0
+	:100644 000000 01e79c32a8c99c557f0757da7cb6d65b3414466d 0000000000000000000000000000000000000000 D	file2
+	EOF
+	git rev-list --parents master | git diff-tree --stdin >actual &&
+	test_cmp expect actual
+'
+
+
 test_done
