Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF41A1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 07:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeKXSkY (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 13:40:24 -0500
Received: from p3plsmtpa06-01.prod.phx3.secureserver.net ([173.201.192.102]:35711
        "EHLO p3plsmtpa06-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbeKXSkX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Nov 2018 13:40:23 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id QSk8gCUSSTdR5QSkCgo8km; Sat, 24 Nov 2018 00:52:49 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org, peff@peff.net
Subject: [PATCH v2] t5562: do not reuse output files
Date:   Sat, 24 Nov 2018 09:52:43 +0200
Message-Id: <20181124075243.27372-1-max@max630.net>
X-Mailer: git-send-email 2.19.0.1202.g68e1e8f04e
In-Reply-To: <xmqqbm6f2ajn.fsf@gitster-ct.c.googlers.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfA+1iErnJIEvp12DbUcTSk8woACvngyqOf1AVbm/J0cd335Tq9YE8CuuGC2ZCIO5SDZYD/mjT0pE1QW2dz8iuRLqH3EiwlK2U0BnLKpZvO4lDQyi3dWp
 IrpMypfADVMNdQjinsLpFy8MMM8wuCahlwpRYYCdudl9unu/4Es2/aaZvlJ/IL1gz55LcRg1amQ/cCUD9shUrEDHU5OIO4zrz/jq56ust2Ezvh3iiNr7i5rP
 DuhySlNF4RSBp1yO5/RpYvklkV5qrqTqCOYHhBXHe+0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some expected failures of git-http-backend leaves running its children
(receive-pack or upload-pack) which still hold opened descriptors
to act.err and with some probability they live long enough to write
there their failure messages after next test has already truncated
the files. This causes occasional failures of the test script.

Avoid the issue by unlinking the older files before writing to them.

Reported-by: Carlo Arenas <carenas@gmail.com>
Helped-by: Carlo Arenas <carenas@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Max Kirillov <max@max630.net>
---
Thanks. Updated
 t/t5562-http-backend-content-length.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 90d890d02f..3a9f7a14e2 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -25,6 +25,7 @@ test_http_env() {
 	handler_type="$1"
 	request_body="$2"
 	shift
+	rm -f act.out act.err &&
 	env \
 		CONTENT_TYPE="application/x-git-$handler_type-pack-request" \
 		QUERY_STRING="/repo.git/git-$handler_type-pack" \
@@ -155,6 +156,7 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 '
 
 test_expect_success 'empty CONTENT_LENGTH' '
+	rm -f act.out act.err &&
 	env \
 		QUERY_STRING="service=git-receive-pack" \
 		PATH_TRANSLATED="$PWD"/.git/info/refs \
-- 
2.19.0.1202.g68e1e8f04e

