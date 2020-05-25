Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCDEC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3062071C
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgEYV6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 17:58:02 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:20067 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEYV6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 17:58:01 -0400
Received: from localhost.localdomain ([89.243.191.101])
        by smtp.talktalk.net with SMTP
        id dL6djC8oOIndsdL6ejhPZo; Mon, 25 May 2020 22:58:00 +0100
X-Originating-IP: [89.243.191.101]
X-Spam: 0
X-OAuthority: v=2.3 cv=QYIYQfTv c=1 sm=1 tr=0 a=5KGm1Kp77X3djDixdaHiLg==:117
 a=5KGm1Kp77X3djDixdaHiLg==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=oimc2BXduHynNlwWpvgA:9
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Philip Oakley <philipoakley@iee.email>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] blame: do not show boundary commits, only those blamed
Date:   Mon, 25 May 2020 22:57:50 +0100
Message-Id: <20200525215751.1735-4-philipoakley@iee.email>
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

Make the option functional and add tests

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 builtin/blame.c  | 1 +
 t/t8002-blame.sh | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index b699c777c4..61e5a7ff44 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -475,6 +475,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			fputs(color, stdout);
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
+			if (blame_only) continue;
 			if (blank_boundary)
 				memset(hex, ' ', length);
 			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index eea048e52c..d4877c7c54 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -122,4 +122,11 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git blame --exclude-promisor-objects one
 '
 
+test_expect_success 'test --blame-only, exclude boundary commits' '
+	git blame --blame-only branch1.. -- file >actual &&
+	git blame branch1.. -- file >full &&
+	sed -e "/^\^/d" full >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.26.2.windows.1.13.g9dddff6983

