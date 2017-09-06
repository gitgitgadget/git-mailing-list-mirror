Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AC5E208CD
	for <e@80x24.org>; Wed,  6 Sep 2017 07:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdIFHD3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 03:03:29 -0400
Received: from 6.mo176.mail-out.ovh.net ([46.105.44.204]:35662 "EHLO
        6.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdIFHD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 03:03:28 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 909628890A
        for <git@vger.kernel.org>; Wed,  6 Sep 2017 08:48:10 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 6 Sep
 2017 08:48:10 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCHv3 2/2] pull: honor submodule.recurse config option
To:     <git@vger.kernel.org>
References: <884cd3b0-7eeb-b711-2c7f-f93a57a009ee@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <0b4728b5-7a07-6a0f-5906-db04368c6686@morey-chaisemartin.com>
Date:   Wed, 6 Sep 2017 08:48:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <884cd3b0-7eeb-b711-2c7f-f93a57a009ee@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS1.indiv2.local (172.16.1.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 11108691433565120477
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrvdelgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git pull" supports a --recurse-submodules option but does not parse the
submodule.recurse configuration item to set the default for that option.
Meanwhile "git fetch" does support submodule.recurse, producing
confusing behavior: when submodule.recurse is enabled, "git pull"
recursively fetches submodules but does not update them after fetch.

Handle submodule.recurse in "git pull" to fix this.

Reported-by: Magnus Homann <magnus@homann.se>
Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 builtin/pull.c            |  4 ++++
 t/t5572-pull-submodule.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 9ef1ab501..6f772e8a2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -325,6 +325,10 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "rebase.autostash")) {
 		config_autostash = git_config_bool(var, value);
 		return 0;
+	} else if (!strcmp(var, "submodule.recurse")) {
+		recurse_submodules = git_config_bool(var, value) ?
+			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
+		return 0;
 	}
 	return git_default_config(var, value, cb);
 }
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 077eb07e1..321bd37de 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -65,6 +65,38 @@ test_expect_success 'recursive pull updates working tree' '
 	test_path_is_file super/sub/merge_strategy.t
 '
 
+test_expect_success "submodule.recurse option triggers recursive pull" '
+	test_commit -C child merge_strategy_2 &&
+	git -C parent submodule update --remote &&
+	git -C parent add sub &&
+	git -C parent commit -m "update submodule" &&
+
+	git -C super -c submodule.recurse pull --no-rebase &&
+	test_path_is_file super/sub/merge_strategy_2.t
+'
+
+test_expect_success " --[no-]recurse-submodule and submodule.recurse" '
+	test_commit -C child merge_strategy_3 &&
+	git -C parent submodule update --remote &&
+	git -C parent add sub &&
+	git -C parent commit -m "update submodule" &&
+
+	git -C super -c submodule.recurse pull --no-recurse-submodules --no-rebase &&
+	test_path_is_missing super/sub/merge_strategy_3.t &&
+	git -C super -c submodule.recurse=false pull --recurse-submodules --no-rebase &&
+	test_path_is_file super/sub/merge_strategy_3.t &&
+
+	test_commit -C child merge_strategy_4 &&
+	git -C parent submodule update --remote &&
+	git -C parent add sub &&
+	git -C parent commit -m "update submodule" &&
+
+	git -C super -c submodule.recurse=false pull --no-recurse-submodules --no-rebase &&
+	test_path_is_missing super/sub/merge_strategy_4.t &&
+	git -C super -c submodule.recurse=true pull --recurse-submodules --no-rebase &&
+	test_path_is_file super/sub/merge_strategy_4.t
+'
+
 test_expect_success 'recursive rebasing pull' '
 	# change upstream
 	test_commit -C child rebase_strategy &&
-- 
2.14.1.461.g503560879

