Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E967B1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 13:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeKYAhB (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 19:37:01 -0500
Received: from p3plsmtpa07-04.prod.phx3.secureserver.net ([173.201.192.233]:56614
        "EHLO p3plsmtpa07-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbeKYAhB (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Nov 2018 19:37:01 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id QYIOgBCcrpgijQYISgsj85; Sat, 24 Nov 2018 06:48:33 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Carlo Arenas <carenas@gmail.com>
Cc:     Max Kirillov <max@max630.net>, peff@peff.net
Subject: [PATCH] http-backend: enable cleaning up forked upload/receive-pack on exit
Date:   Sat, 24 Nov 2018 15:48:27 +0200
Message-Id: <20181124134827.13932-1-max@max630.net>
X-Mailer: git-send-email 2.19.0.1202.g68e1e8f04e
In-Reply-To: <20181124130337.GH5348@jessie.local>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOFdz6iW/lyceoaBfJDWUcjZ2DkmWycGy2PC0Q7S0Ga1sV4UzVIkdVE8fRlcYylSDBqdep4ItODv/aif1mJlYGf9eH0WJoueCFZzl1Y5z9j5IRbbTwXp
 qJ9Tz1AHEkOMdtSDkauJxVHaK5XrSP/76AmZ9dsMaReVRVrlWW9Jd4Vs/SQiNBuMEWYkiIjDH9ermyiR+rO+gFRSOjjkPIJZdGDg+EhHwIrQvdqxqV5DHQoc
 ut4T9LQPpLAAfEM5NgrbEO6X1T7YkzFobaIzSAEJrMw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If http-backend dies because of errors, started upload-pack or
receive-pack are not killed and waited, but rather stay running for somtime
until they exits because of closed stdin. It may be undesirable in working
environment, and it also causes occasional failure of t5562, because the
processes keep opened act.err, and sometimes write there errors after next test
started using the file.

Fix by enabling cleaning of the command at http-backed exit.

Reported-by: Carlo Arenas <carenas@gmail.com>
Helped-by: Carlo Arenas <carenas@gmail.com>
Signed-off-by: Max Kirillov <max@max630.net>
---
This seems to fix the issue at NetBSD. I verified it manually with strace but could
not catch the visible timing effect in tests at Linux. So no tests for it.

the "t5562: do not reuse output files" patches are not needed then
 http-backend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http-backend.c b/http-backend.c
index 9e894f197f..29e68e38b5 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -486,6 +486,8 @@ static void run_service(const char **argv, int buffer_input)
 	if (buffer_input || gzipped_request || req_len >= 0)
 		cld.in = -1;
 	cld.git_cmd = 1;
+	cld.clean_on_exit = 1;
+	cld.wait_after_clean = 1;
 	if (start_command(&cld))
 		exit(1);
 
-- 
2.19.0.1202.g68e1e8f04e

