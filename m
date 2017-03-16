Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A59320953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754664AbdCPWij (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:38:39 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34505 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753007AbdCPWii (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:38:38 -0400
Received: by mail-pg0-f45.google.com with SMTP id 141so31657946pgd.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IjeHk2rQoazae1YckkVE07RWNwYuw/6QWg6qaDRqkIA=;
        b=Z13FamuTWQT7JRARSdkLE5kqggqUW0G1qT0oZYwEyBkc6f3DSbCKCfpM2MhHTwxiXP
         1NlAK6SernKViI0BAEX0585Yg62cAmURxbizI8JmvnebWKlzIKaFa8pczu8vCPSgaF4z
         EZawcx8FtW1wmmb7avUWBYxQ1cCVNBRSp+LzqyfsN+n1tw9Q/m56+PbdwRKLw5e78zNV
         /A9eyfDrkRatjPaJx/VMyjpPnb8qBuK8EIfJmr6QLs1qkk0jPCiIlNTWq7iGs5San4ZW
         QhTI9ZTnGaLG8akp3wqUS3bv6z0m3fmNRJNtyEiOdImGuz6rop4ZY0QlnTncmvwplcy0
         Mxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IjeHk2rQoazae1YckkVE07RWNwYuw/6QWg6qaDRqkIA=;
        b=WjonYUy3jY0YWfQ2gD5/6wiy7f9cBD8Zbw9fUss17zb1B+nwPZOEGoLVfSmGUNFlb3
         pk7aBDW+N2jn1gOWwMnYBJE6OsBOsPyuQPHTErFbCUD5DACtvbEO8yJ+mqOZh70VoTdi
         nDj/Ctq0O83ra/Vp5NNORrOXyvRMki9k3RHazzur+4Kes07IYeNPRYPLkrrxdD6Yu76z
         SlUfjxWnVWCtptt1DECgscasJslemFFWE6QK9NBEkqFH1qJ21FPC+Dhe2A4valphjlJ1
         RMa7lauik/bbN64WYWG4GTFxk1aQWyVFt+VeqmVVoQDSm6DKFkz8H94IB3YRXD1rxc8q
         Meaw==
X-Gm-Message-State: AFeK/H3fRJ4nEn5S5JiA5LSWCmcAk/w2V5WS7YrIX8qW/ijTG8gvEulqOnqvvs1DvJAt7BRp
X-Received: by 10.84.232.143 with SMTP id i15mr5974720plk.143.1489703413986;
        Thu, 16 Mar 2017 15:30:13 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t5sm12520946pgb.36.2017.03.16.15.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:30:12 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 10/10] submodule add: respect submodule.active and submodule.<name>.active
Date:   Thu, 16 Mar 2017 15:29:52 -0700
Message-Id: <20170316222952.53801-11-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170316222952.53801-1-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to adding submodule.<name>.url to the config, set
submodule.<name>.active to true unless submodule.active is configured
and the submodule's path matches the configured pathspec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh               | 12 ++++++++++++
 t/t7413-submodule-is-active.sh | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index db94dea3b..6eca93416 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -278,6 +278,18 @@ or you are unsure what this means choose another name with the '--name' option."
 	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
+
+	if git config --get submodule.active >/dev/null
+	then
+		# If the submodule being adding isn't already covered by the
+		# current configured pathspec, set the submodule's active flag
+		if ! git submodule--helper is-active "$sm_path"
+		then
+			git config submodule."$sm_name".active "true"
+		fi
+	else
+		git config submodule."$sm_name".active "true"
+	fi
 }
 
 #
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index ea1644b58..9c785b07e 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -15,6 +15,12 @@ test_expect_success 'setup' '
 	test_commit -C super initial &&
 	git -C super submodule add ../sub sub1 &&
 	git -C super submodule add ../sub sub2 &&
+
+	# Remove submodule.<name>.active entries in order to test in an
+	# environment where only URLs are present in the conifg
+	git -C super config --unset submodule.sub1.active &&
+	git -C super config --unset submodule.sub2.active &&
+
 	git -C super commit -a -m "add 2 submodules at sub{1,2}"
 '
 
@@ -83,4 +89,19 @@ test_expect_success 'is-active with submodule.active and submodule.<name>.active
 	git -C super submodule--helper is-active sub2
 '
 
+test_expect_success 'is-active, submodule.active and submodule add' '
+	test_when_finished "rm -rf super2" &&
+	git init super2 &&
+	test_commit -C super2 initial &&
+	git -C super2 config --add submodule.active "sub*" &&
+
+	# submodule add should only add submodule.<name>.active
+	# to the config if not matched by the pathspec
+	git -C super2 submodule add ../sub sub1 &&
+	test_must_fail git -C super2 config --get submodule.sub1.active &&
+
+	git -C super2 submodule add ../sub mod &&
+	git -C super2 config --get submodule.mod.active
+'
+
 test_done
-- 
2.12.0.367.g23dc2f6d3c-goog

