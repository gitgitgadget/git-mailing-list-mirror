Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13BF52023D
	for <e@80x24.org>; Mon, 22 May 2017 19:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761729AbdEVTsY (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:48:24 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33001 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757691AbdEVTsV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:48:21 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so91774295pfh.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yzw3Gk6VUn/cTsIbqZgKLm8sNZbGw3RRlYHdwviSyfI=;
        b=IOdq1PxT3KA8KRhSjAROUd7mD4+WkwVoA5ZagAZaXYNNuKn0IrrLFaeawOy2lqJkkR
         iGIsaGlGFFRVaCV3ggaJlEm2jygqqFvcsq/DK4vngNeo6ZBU9E20fct5FIt4q8MiEkMa
         I26Poi4ztnThB5hbrHP/LZMeE1TmYIHhs2qVCuH+NP6iH/TFmsZ+sYC3bItAKQnauWOH
         3E2OJ6/oIOXrYr0ymSQHXfQ/5dsQfovaS1GRj63mD7XPuv1a70solvTB2gwAH0Wmhr4L
         WCWzCKxZPIPB/oKX8B5ZnRTWdfk6/35y4bdxcz3jPXzsV85WxaUos0iiyTU0DSjE07Gc
         u9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yzw3Gk6VUn/cTsIbqZgKLm8sNZbGw3RRlYHdwviSyfI=;
        b=uKKXswm1neRHLQ8I2Wd7PkcFYUarbjzl3n+IHfNjtLHmzB36F/iwwDtiRXgyuEOVfT
         6niAeeBD2Yz6JgEs6zeHpfFJ/QTbXJcS8GTyaGpQduJuKVbtLYreBlS5HQ96AulfXYJD
         mOgzWxoYzJMuaXNUOoDSxuCChwZxTiRWLvU4lUiwd+6r1HfxHB5ki7V1umVXpAd/HTiy
         31ZRvb9HIzMQ3ziDhzcFSEg2cafoWd+WlgvLc1QLqK2ZcvFyZThqrmMlWS2eQaXTWEPL
         mhSFR/jKPYq+tC4sb5umHCdfYDaR2XRSQZeox38bme52ZpovwG0PJtlSltgXkufRBlbV
         +0nA==
X-Gm-Message-State: AODbwcCoeWIHNe5c8rrtgiAoKC+qdbninpMqnGCJ2BatGITGVQxJc0pc
        4R/QbFn6Fz4euZ8BkTg7/A==
X-Received: by 10.98.147.67 with SMTP id b64mr27407649pfe.145.1495482495785;
        Mon, 22 May 2017 12:48:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id o89sm33235401pfj.88.2017.05.22.12.48.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 12:48:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/6] builtin/grep.c: respect 'submodule.recurse' option
Date:   Mon, 22 May 2017 12:48:05 -0700
Message-Id: <20170522194806.13568-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170522194806.13568-1-sbeller@google.com>
References: <20170522194806.13568-1-sbeller@google.com>
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
---
 builtin/grep.c                     |  3 +++
 t/t7814-grep-recurse-submodules.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 65070c52fc..7b998801fe 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -291,6 +291,9 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 			    num_threads, var);
 	}
 
+	if (!strcmp(var, "submodule.recurse"))
+		recurse_submodules = git_config_bool(var, value);
+
 	return st;
 }
 
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 5b6eb3a65e..234d2d188b 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -33,6 +33,24 @@ test_expect_success 'grep correctly finds patterns in a submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep finds patterns in a submodule via config' '
+	test_config submodule.recurse true &&
+	# expect from previous test
+	git grep -e "bar" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --no-recurse-submodules overrides config' '
+	test_config submodule.recurse true &&
+	cat >expect <<-\EOF &&
+	a:foobar
+	b/b:bar
+	EOF
+
+	git grep -e "bar" --no-recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep and basic pathspecs' '
 	cat >expect <<-\EOF &&
 	submodule/a:foobar
-- 
2.13.0.18.g7d86cc8ba0

