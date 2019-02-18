Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F422F1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfBRUui (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 15:50:38 -0500
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net ([173.201.192.230]:38961
        "EHLO p3plsmtpa07-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727682AbfBRUuh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 15:50:37 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id vps0ginbXAlQNvps3gVCe9; Mon, 18 Feb 2019 13:50:37 -0700
From:   Max Kirillov <max@max630.net>
To:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Max Kirillov <max@max630.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>
Subject: [PATCH] t5562: chunked sleep to avoid lost SIGCHILD
Date:   Mon, 18 Feb 2019 22:50:28 +0200
Message-Id: <20190218205028.32486-1-max@max630.net>
X-Mailer: git-send-email 2.19.0.1202.g68e1e8f04e
In-Reply-To: <20190215130213.GK1622@szeder.dev>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfM0VbMkelwd3oLxJLcCAlr7CBsgwVSn/XLxPXQ+QPVXzXnTkbyEKxpxPo+UfkJFbRC2GIdGHy/mdmrlFwBoFos3ZHGrD5ZyRl/qpi67re8Uu+JkjLPPa
 E3F7Q7Hv7OI34ngg4aXoulkGk8prUcYFwtDo/ulVCQLuN+PlI0oSDGM2zmYUju7sbHkw3YVJt+WNeqSoKnpPfb2hyDxn2CUasQXhg3/QnjtptDUZOWiMJlDD
 NiPEMbt5JikcD934LBooLYqG9NQ2JJAoEaJ6Aov37qk7zZU666FsU5FCkXQvG+AzGCO1n0Ezk3UQPq/4FXSS7mPi3buheS1QKzSYcUbdxIw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If was found during stress-test run that a test may hang by 60 seconds.
It supposedly happens because SIGCHILD was received before sleep has
started.

Fix by looping by smaller chunks, checking $exited after each of them.
Then lost SIGCHILD would not cause longer delay than 1 second.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Max Kirillov <max@max630.net>
---
Submitting as proper patch. Note: I believe it does not relate to other issues
discussed in this thread.
 t/t5562/invoke-with-content-length.pl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
index 0943474af2..257e280e3b 100644
--- a/t/t5562/invoke-with-content-length.pl
+++ b/t/t5562/invoke-with-content-length.pl
@@ -29,7 +29,12 @@
 }
 print $out $body_data or die "Cannot write data: $!";
 
-sleep 60; # is interrupted by SIGCHLD
+my $counter = 0;
+while (not $exited and $counter < 60) {
+        sleep 1;
+        $counter = $counter + 1;
+}
+
 if (!$exited) {
         close($out);
         die "Command did not exit after reading whole body";
-- 
2.19.0.1202.g68e1e8f04e

