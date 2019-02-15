Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2271F453
	for <e@80x24.org>; Fri, 15 Feb 2019 16:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfBOQmq (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 11:42:46 -0500
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:58764
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbfBOQmq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Feb 2019 11:42:46 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id ugZUgFUoobtsnugZYgWHcO; Fri, 15 Feb 2019 09:42:45 -0700
From:   Max Kirillov <max@max630.net>
To:     "Randall S . Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Cc:     Max Kirillov <max@max630.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        'Junio C Hamano' <gitster@pobox.com>
Subject: [PATCH] t5562: do not depend on /dev/zero
Date:   Fri, 15 Feb 2019 18:42:37 +0200
Message-Id: <20190215164237.12250-1-max@max630.net>
X-Mailer: git-send-email 2.19.0.1202.g68e1e8f04e
In-Reply-To: <20190209185930.5256-4-randall.s.becker@rogers.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKOk/3L17VTbeEhiz0ikNCK1yqUIGafH8bmC2SryVujsBjyWJMjmL52UrD/RCzS1xYcK2k60loLVVMS79/j/dZVZ1pfKtTs1YRECETlPqvZAkqGce03H
 b9lXB1dVNNYRZEUBx6Fas0ZO33Lzm9cC2JhpWzHmppv1vdI4hkMx1g+ZpdXeMnbjGoGZSwMr9i7yEr4bj7RApuEI/ky2FTHb/ZO3l0OwFdEXSddONmvb3dyA
 xnikEJyP3jKZUM0LeHK11uu2PfbDNaRKsgsGwjj7zRSIoTv9zkZp81PBfYTJt5ut
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported [1] that NonStop platform does not have /dev/zero.

The test uses /dev/zero as a dummy input. Passing case (http-backed
failed because of too big input size) should not be reading anything
from it. If http-backend would erroneously try to read any data
returning EOF probably would be even safer than providing some
meaningless data.

Replace /dev/zero with /dev/null to avoid issues with platforms which do
not have /dev/zero.

[1] https://public-inbox.org/git/20190209185930.5256-4-randall.s.becker@rogers.com/

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Max Kirillov <max@max630.net>
---
By the way, I don't think this requires such sofisticated
fix. In the success case the input would not be read at all.
You could replace it with /dev/null, the in failure (not 
immediate fail) git would fail due to truncated input or
something.

Also, as you experience hang issue [2] in earlier tests, this 
one should not have contributed to it.

[2] https://public-inbox.org/git/001901d4c22b$194bfe60$4be3fb20$@nexbridge.com/
 t/t5562-http-backend-content-length.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 90d890d02f..436c261c86 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -150,7 +150,7 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 		GIT_HTTP_EXPORT_ALL=TRUE \
 		REQUEST_METHOD=POST \
 		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
-		git http-backend </dev/zero >/dev/null 2>err &&
+		git http-backend </dev/null >/dev/null 2>err &&
 	grep "fatal:.*CONTENT_LENGTH" err
 '
 
-- 
2.19.0.1202.g68e1e8f04e

