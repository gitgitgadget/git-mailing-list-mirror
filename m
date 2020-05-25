Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CADC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7B52071C
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgEYV6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 17:58:06 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:31794 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgEYV6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 17:58:02 -0400
Received: from localhost.localdomain ([89.243.191.101])
        by smtp.talktalk.net with SMTP
        id dL6djC8oOIndsdL6ejhPZq; Mon, 25 May 2020 22:58:00 +0100
X-Originating-IP: [89.243.191.101]
X-Spam: 0
X-OAuthority: v=2.3 cv=QYIYQfTv c=1 sm=1 tr=0 a=5KGm1Kp77X3djDixdaHiLg==:117
 a=5KGm1Kp77X3djDixdaHiLg==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=U4Oy5JjFRyMzyq9slzkA:9
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Philip Oakley <philipoakley@iee.email>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] blame: test the -b option, use blank oid for boundary commits.
Date:   Mon, 25 May 2020 22:57:51 +0100
Message-Id: <20200525215751.1735-5-philipoakley@iee.email>
X-Mailer: git-send-email 2.26.2.windows.1.13.g9dddff6983
In-Reply-To: <20200525215751.1735-1-philipoakley@iee.email>
References: <20200525215751.1735-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIegZ2fgzUsizcTil/8DQ9rxdXgn30ulXqPed8sdVaX5AGlnLCLsAxoyfzuPPPTlx0QnZ+VfjWe06qkWsio26m2cwdRq1DFDY9hya0+lP8KkZP5uZlJY
 cYpzWw5KCkMFrT+6RxZhFdYX3Cv3+fQj0KgwR48YoedDizgTnUZhy6rbrMeqAJhVR6vKAdQDCEb9EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

4c10a5caa7 (blame: -b (blame.blankboundary) and --root (blame.showroot),
2006-12-18) introduced the -b option. Add a test.

The sed script removes the last hex digit from boundary commit oids
'^hexx msg' -> '^hex  msg' until all leading hex's are gone, finally
removing the boundary commit marker.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 t/t8002-blame.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index d4877c7c54..de0f81abe9 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -129,4 +129,16 @@ test_expect_success 'test --blame-only, exclude boundary commits' '
 	test_cmp expected actual
 '
 
+test_expect_success 'test -b option, blank oid for boundary commits' '
+	git blame -b branch1.. -- file >actual &&
+	git blame branch1.. -- file >full &&
+	sed -e "/^\^/{
+		:loop;
+		s/^\(\^[0-9a-f]*\)[0-9a-f] \(.*\)/\1  \2/g;
+		tloop;
+		s/^\^/ /;
+	}" full >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.26.2.windows.1.13.g9dddff6983

