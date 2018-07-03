Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88031F660
	for <e@80x24.org>; Tue,  3 Jul 2018 12:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeGCMil (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 08:38:41 -0400
Received: from thoth.sbs.de ([192.35.17.2]:39898 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752935AbeGCMij (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 08:38:39 -0400
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w63CcNNR014610
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 14:38:23 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id w63CcME4008580;
        Tue, 3 Jul 2018 14:38:23 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 1/8] builtin/receive-pack: use check_signature from gpg-interface
Date:   Tue,  3 Jul 2018 14:38:13 +0200
Message-Id: <f9e371c8dd2a17ddb5fd5989a7fdad1c0d1bb6e7.1530616446.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The combination of verify_signed_buffer followed by parse_gpg_output is
available as check_signature. Use that instead of implementing it again.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 builtin/receive-pack.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 68d36e0a5..9f0583deb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -629,8 +629,6 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		return;
 
 	if (!already_done) {
-		struct strbuf gpg_output = STRBUF_INIT;
-		struct strbuf gpg_status = STRBUF_INIT;
 		int bogs /* beginning_of_gpg_sig */;
 
 		already_done = 1;
@@ -639,22 +637,11 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 			oidclr(&push_cert_oid);
 
 		memset(&sigcheck, '\0', sizeof(sigcheck));
-		sigcheck.result = 'N';
 
 		bogs = parse_signature(push_cert.buf, push_cert.len);
-		if (verify_signed_buffer(push_cert.buf, bogs,
-					 push_cert.buf + bogs, push_cert.len - bogs,
-					 &gpg_output, &gpg_status) < 0) {
-			; /* error running gpg */
-		} else {
-			sigcheck.payload = push_cert.buf;
-			sigcheck.gpg_output = gpg_output.buf;
-			sigcheck.gpg_status = gpg_status.buf;
-			parse_gpg_output(&sigcheck);
-		}
+		check_signature(push_cert.buf, bogs, push_cert.buf + bogs,
+				push_cert.len - bogs, &sigcheck);
 
-		strbuf_release(&gpg_output);
-		strbuf_release(&gpg_status);
 		nonce_status = check_nonce(push_cert.buf, bogs);
 	}
 	if (!is_null_oid(&push_cert_oid)) {
-- 
2.16.4

