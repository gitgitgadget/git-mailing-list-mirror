Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994EA20314
	for <e@80x24.org>; Thu,  9 Mar 2017 04:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbdCIERt (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 23:17:49 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36667 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbdCIERt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 23:17:49 -0500
Received: by mail-pg0-f43.google.com with SMTP id g2so3943044pge.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 20:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TWui1u2i3D6X1ifs/gv5ejwiZ/OQkc6XqclVkwm92qY=;
        b=SMVcq1U92kJr6xycxh2jO5zOv2WVsl/7aSoAeamniyLLLcfQbOqZxnZxOmXCt4p7jI
         EPjfbgLcaK6aWDzrpWcDDdwt2RFjeE61Bp8JPACKjQt9XEb3DYUD7l/WvaIByZrvcJx6
         WfXd4/TjhlfrchvsISfdkrk9nQ4wJkxfnUE5TzWjKwkLGVEGom2SF4A/7xViqnZK7scC
         vcE3YG5GXIk58eCswqIudTJ5ZyiIEOdkRPYn/6bYxlVYd+tgu0qZ6BpMSGG51C1CZJeQ
         wqDqhqVnc4oA0/4ZghzHvoYIsiX+YaMRz075HNy4ubP3iczCQ5Sqv2J8DxCWcAaE1xtc
         18Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TWui1u2i3D6X1ifs/gv5ejwiZ/OQkc6XqclVkwm92qY=;
        b=jnylxYQS+hobAGBIRkkdKHg7hb1KzX/oxyK4hkskpRa0GtG/DbImRoPlHBdqO3GozB
         FmIOfb+VVYI5xr8h5ET3v7psB8XVa5ZZAOeIZWucE6fxZnkDrBk/StgIJIGUYnxSc3X+
         Xw6g58lfMKgBuMYwzC+zq9Icemdx8nHTssnbOnWMgKILmo33OWh5uEhANYhWSfzNrYMn
         wCEo8Krey4b1VCxD1cTlPuCfP7KGY28DOr/IOi4mL8AKIUoLO1EDn9JcRxinpig/aHHv
         7T/6fXEli4qRsXqLlf3OblUNEDU5HuOqKKOGNV+gSsncng6uvk55F7CA/Z23xwqYV6jr
         xEpQ==
X-Gm-Message-State: AMke39nggRsKCQ3gWGRo05MNiEjg8TEBPOBOMqisGkarUlE1cL8gatDuLmr1gGVLntol0SAD
X-Received: by 10.84.140.131 with SMTP id 3mr13020244plt.151.1489022637930;
        Wed, 08 Mar 2017 17:23:57 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:23:56 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 03/11] submodule deinit: use most reliable url
Date:   Wed,  8 Mar 2017 17:23:37 -0800
Message-Id: <20170309012345.180702-4-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The user could have configured the submodule to have a different URL
from the one in the superproject's config.  To account for this read
what the submodule has configured for remote.origin.url and use that
instead.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 19660b9c0..1c2064cc1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -455,7 +455,7 @@ Submodule work tree '\$displaypath' contains a .git directory
 		then
 			# Remove the whole section so we have a clean state when
 			# the user later decides to init this submodule again
-			url=$(git config submodule."$name".url)
+			url=$(GIT_DIR="$(git rev-parse --git-path modules/$name)" git config remote.origin.url)
 			git config --remove-section submodule."$name" 2>/dev/null &&
 			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
 		fi
-- 
2.12.0.246.ga2ecc84866-goog

