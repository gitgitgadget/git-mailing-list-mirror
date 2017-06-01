Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34EAB20D12
	for <e@80x24.org>; Thu,  1 Jun 2017 00:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbdFAAbM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 20:31:12 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33822 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdFAAbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 20:31:10 -0400
Received: by mail-pf0-f174.google.com with SMTP id 9so21576104pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 17:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9eQqt/6AKSQekHwwkkpI8IZMA04ESZ7rDbPm0Rb2sQ=;
        b=cIGLQVxtA0J4HCKAg7yN4wbSK+toqbQiBt6XtCcW0drwfTNdwmWsolBqQR2B0mHSI/
         6sS0pz/8WB5RwhQ+OXgVadOnOAYa3q75lyp0WyhLZq826hEZHRd9FREHkTB3o3vxITgV
         QP8IjVpFzo6odYcZ6VBrlqLsyOhI/xitMwL7/CUADRtpDEt2czfpT1ptr0KNg+AYostd
         OT4H/0GYCjDlCbOa4sMp6i7dk+qmzKggNqHGNx/mtiCfLkvvxFKm0Zq/N23DLU7lDn1G
         sjRxJIILHVQMQDTjPukn7JRFxO2pZNQNpBOeZStx837LA8RYw5QZMkEuux6QgZvHII//
         NLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x9eQqt/6AKSQekHwwkkpI8IZMA04ESZ7rDbPm0Rb2sQ=;
        b=EPnS0sat/JS6Iwkmwezm5jp04A+u2GvAg9Dw0Q85jSLgkuGDbayI+70XoeTvk2n5pW
         YHSvOz2S3OHUlO5VxwxkulEehGTOgw0guUFEQN/rleukPFTXhs/U2xV79N3mDE2txGFv
         FYazEd3qMTdS2w4eM+QpByzRzOc+cLI/eOgyK59klqPmKxCoI5c8/6NqPyuv3v8CUwQm
         foxh2PakYApR4qIXI071JDrQ1Xy4bpsShJhVqAk0sOjicPF8GArr3hVmhrkBK8Yih4Nc
         sCaToTMGNeZMGZNXdcuuqBm0/+//YGCpCwRa4BpUfrbSKZn8pVtJ7p7RPX27n95t0A7U
         5egQ==
X-Gm-Message-State: AODbwcCX7su6lQSwpA2wOZMOm+mSPBS956Tdh29FwMwYrzlAhKF7BIzw
        7fQLrOCCJCYbo6Z9
X-Received: by 10.99.109.9 with SMTP id i9mr35338282pgc.56.1496277060001;
        Wed, 31 May 2017 17:31:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7872:b8ac:87ee:2203])
        by smtp.gmail.com with ESMTPSA id 71sm6549832pgd.57.2017.05.31.17.30.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 17:30:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, sbeller@google.com
Subject: [PATCHv3 2/4] builtin/grep.c: respect 'submodule.recurse' option
Date:   Wed, 31 May 2017 17:30:48 -0700
Message-Id: <20170601003050.4221-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gab62347cd9
In-Reply-To: <20170601003050.4221-1-sbeller@google.com>
References: <xmqqa85udi92.fsf@gitster.mtv.corp.google.com>
 <20170601003050.4221-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In builtin/grep.c we parse the config before evaluating the command line
options. This makes the task of teaching grep to respect the new config
option 'submodule.recurse' very easy by just parsing that option.

As an alternative I had implemented a similar structure to treat
submodules as the fetch/push command have, including
* aligning the meaning of the 'recurse_submodules' to possible submodule
  values RECURSE_SUBMODULES_* as defined in submodule.h.
* having a callback to parse the value and
* reacting to the RECURSE_SUBMODULES_DEFAULT state that was the initial
  state.

However all this is not needed for a true boolean value, so let's keep
it simple. However this adds another place where "submodule.recurse" is
parsed.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c                     |  3 +++
 t/t7814-grep-recurse-submodules.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index b1095362fb..454e263820 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -302,6 +302,9 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 #endif
 	}
 
+	if (!strcmp(var, "submodule.recurse"))
+		recurse_submodules = git_config_bool(var, value);
+
 	return st;
 }
 
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 3a58197f47..7184113b9b 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -33,6 +33,24 @@ test_expect_success 'grep correctly finds patterns in a submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep finds patterns in a submodule via config' '
+	test_config submodule.recurse true &&
+	# expect from previous test
+	git grep -e "(3|4)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --no-recurse-submodules overrides config' '
+	test_config submodule.recurse true &&
+	cat >expect <<-\EOF &&
+	a:(1|2)d(3|4)
+	b/b:(3|4)
+	EOF
+
+	git grep -e "(3|4)" --no-recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep and basic pathspecs' '
 	cat >expect <<-\EOF &&
 	submodule/a:(1|2)d(3|4)
-- 
2.13.0.17.gab62347cd9

