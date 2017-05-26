Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3521A1FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944657AbdEZTLc (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:11:32 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32858 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbdEZTK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:29 -0400
Received: by mail-pf0-f171.google.com with SMTP id e193so19467434pfh.0
        for <git@vger.kernel.org>; Fri, 26 May 2017 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C0eBdlwJP1m9w/4REgGT2W+RN6h+MWIH+tXv18DxRJc=;
        b=ZR45yYdZN5a9rI+i2WZhmfy70VKFq+QE9HHYxMCVmUKcG2sD5mSVyF2vxrPMeyNa+X
         hENjCy6AX82tHDR2ttgBfiQEyoOUlbSpjkrdBMSBa0dF4Bazd1Nkd/JwS1zx0HGFwNpV
         +qA4AIX2c+iMfLV3JiJfCrDx9oNP2howMxjWMaaSgUYoO7LIGmbSCK6PQGFlUHI4ADZR
         Ul2NQIocwP0/fbgWMr+vRcwA2JF4uQz0MOkkrfuC7i3V90SGTDN1fKBmXeCqeiuxm02F
         co6u7aDS9ASo2LF0jhOWrVKDpWAv+k1BBRGyfAFZrFCSVLLdnu3cf3Sz/Tfw0i8/e0rN
         wmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C0eBdlwJP1m9w/4REgGT2W+RN6h+MWIH+tXv18DxRJc=;
        b=F9m6l4SjZr4sCyxcn7rjH0Ue1AJ00IHDZwvMVvHIxV0ivNd06FZTn22b/t5A5/FaOJ
         QKfqnRX7tOJpZTH0ZExnwCrxY6p6Ho6zC4fpJq1Xvy1lURTRPNCH3UZBNL2xzutNVS7R
         HYezP7G0X2VxZrzzgi1R8G4W0U+lFNf8UUw0vReS2HxytNxWLAeK8TNHskfAb9QlbtSt
         mI7UVDEHXTjn1zgWcypNFiezn+xyeJzxe2M2jFyVOsg6e6ZVAKK3ywPwWL+WJs9A1EZC
         UbPjY6RBdc2VObxLVl+k9vKv6JhqP3mQQyGwRMGaW3FYL6yEO/ACy01m4HgYCAwLArQl
         QF/g==
X-Gm-Message-State: AODbwcB+V0G4WYXE6vRX1wNfEzrEJtbiYLu45uPrS1qFnrb/eaR5jlzE
        eYYfUHvH317iao0h
X-Received: by 10.84.229.78 with SMTP id d14mr59207408pln.15.1495825828487;
        Fri, 26 May 2017 12:10:28 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:818a:1f3a:57c6:8d29])
        by smtp.gmail.com with ESMTPSA id s75sm3069967pgs.54.2017.05.26.12.10.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 May 2017 12:10:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/8] builtin/grep.c: respect 'submodule.recurse' option
Date:   Fri, 26 May 2017 12:10:15 -0700
Message-Id: <20170526191017.19155-7-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.g582985b1e4
In-Reply-To: <20170526191017.19155-1-sbeller@google.com>
References: <20170526191017.19155-1-sbeller@google.com>
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
2.13.0.17.g582985b1e4

