Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A001F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJPWxE (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 18:53:04 -0400
Received: from smtpbg298.qq.com ([184.105.67.102]:49316 "EHLO smtpbg298.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPWxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 18:53:04 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2018 18:53:03 EDT
X-QQ-mid: Xesmtp4t1539701683tpj4v6ee8
Received: from localhost.localdomain (unknown [180.165.118.30])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 16 Oct 2018 22:54:42 +0800 (CST)
X-QQ-SSF: B1000000000000F0F5100000000000Z
X-QQ-FEAT: JOVh5Yj1n8YiGvnJRN/Dx0GVy00d8+ISLbZaHRmkIYDJZoN2c6CH8paaki5vr
        LOHiVMsaFF+Ek26xgikZLiGX6b+unENZn94i4+JW/4rY4uRwWmDXBUS+jZ3eizuyHOEu0/x
        HZkvAazN2I0BgmazhBCjQc5+QNlXFRYy9TyPKKoWXUAa40FxcQSYlgjDWMgYUayReRIsl0m
        f9O30MTtiLkm6EI+HeXKBKKcoVL+IRa7YlELMSbSYK9uRhrz9qwqijt5SsEbAXMJ7KqGlqK
        SR6B2TZRtLuGnHaUh7/PZftXrQ9FyDlLsIgw==
X-QQ-GoodBg: 0
From:   Tao Qingyun <taoqy@ls-a.me>
To:     peff@peff.net
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Tao Qingyun <taoqy@ls-a.me>
Subject: [PATCH v2] builtin/branch.c: remove useless branch_get
Date:   Tue, 16 Oct 2018 22:54:28 +0800
Message-Id: <20181016145428.2901-1-taoqy@ls-a.me>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181015171707.GB1301@sigill.intra.peff.net>
References: <20181015171707.GB1301@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
X-QQ-FName: 46F629798DA84E4DAEF77E5849CC8D75
X-QQ-LocalIP: 10.198.131.167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

branch_get sometimes returns current_branch, which can be NULL (e.g., if
you're on a detached HEAD). Try:

  $ git branch HEAD
  fatal: no such branch 'HEAD'

  $ git branch ''
  fatal: no such branch ''

However, it seems weird that we'd check those cases here (and provide
such lousy messages). And indeed, dropping that and letting us
eventually hit create_branch() gives a much better message:

  $ git branch HEAD
  fatal: 'HEAD' is not a valid branch name.

  $ git branch ''
  fatal: '' is not a valid branch name.

Signed-off-by: Tao Qingyun <taoqy@ls-a.me>
---
 builtin/branch.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c396c41533..2367703034 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -809,11 +809,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
-		struct branch *branch = branch_get(argv[0]);
-
-		if (!branch)
-			die(_("no such branch '%s'"), argv[0]);
-
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 
-- 
2.19.0

