Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400B31F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 07:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeKXRv6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 12:51:58 -0500
Received: from p3plsmtpa11-09.prod.phx3.secureserver.net ([68.178.252.110]:54392
        "EHLO p3plsmtpa11-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbeKXRv6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Nov 2018 12:51:58 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id QRzSgP2BnkXzSQRzWgUmqH; Sat, 24 Nov 2018 00:04:35 -0700
From:   Max Kirillov <max@max630.net>
To:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Cc:     Max Kirillov <max@max630.net>, peff@peff.net
Subject: [PATCH] t5562: do not reuse output files
Date:   Sat, 24 Nov 2018 09:04:28 +0200
Message-Id: <20181124070428.18571-1-max@max630.net>
X-Mailer: git-send-email 2.19.0.1202.g68e1e8f04e
In-Reply-To: <CAPUEspi67=Kt=mx21bjG2oCATnU+byO5nkvbMdQkN03yBGZMsA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfH+X1TFNxxvG0iyw3kl7XlJ+2bpf10HndJZ2wUaaTKIGM1ELfQm1rc4VQgljxS0beIgnPTJj+6ZnERaa0KCbzlWLeDmRfhvTlm8bWBuUVdr4u67FmC4u
 dJrywSJus58nUDsqKrEnH/vvZvJPgPwqd+3f3IwDEsFZwmW8knG+d4RGo98rey0qlT/IojFVQyVa4o6ORXVJ2LQKC6/zd7KkXPgWhNKYO9vzypccVFyQSFl7
 Qg74mop89H5fAS3iBB/0Ew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some expected failures of git-http-backend leave running its children
(receive-pack or upload-pack) which still hold opened descriptors
to act.err and with some probability they live long enough to write
their failure messages after next test has already truncated
the files. This causes occasional failures of the test script.

Avoid the issue by unlinking the older files before writing to them.

Reported-by: Carlo Arenas <carenas@gmail.com>
Helped-by: Carlo Arenas <carenas@gmail.com>
Signed-off-by: Max Kirillov <max@max630.net>
---
Thanks for the analysis. I seem to have guessed the reason.
This patch should prevent it.

I think the tests should somehow make sure there are no such late
processes. I can see 2 options:
* somehow find out in the tests all children and wait for them. I have no idea how.
* make http-backend close handle to its child and wait for it to exit before dying.
  This would not prevent childrenc in general, because http-backend may be killed,
  but not in our expected failure cases

Actually, don't the children receive some SIGHUP? Maybe thy should. However, it
would still take some time for them to handle it, so it does not fully solve the issue
 t/t5562-http-backend-content-length.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 90d890d02f..bb53f82c0c 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -25,6 +25,8 @@ test_http_env() {
 	handler_type="$1"
 	request_body="$2"
 	shift
+	(rm -f act.out || true) &&
+	(rm -f act.err || true) &&
 	env \
 		CONTENT_TYPE="application/x-git-$handler_type-pack-request" \
 		QUERY_STRING="/repo.git/git-$handler_type-pack" \
@@ -155,6 +157,8 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 '
 
 test_expect_success 'empty CONTENT_LENGTH' '
+	(rm -f act.out || true) &&
+	(rm -f act.err || true) &&
 	env \
 		QUERY_STRING="service=git-receive-pack" \
 		PATH_TRANSLATED="$PWD"/.git/info/refs \
-- 
2.19.0.1202.g68e1e8f04e

