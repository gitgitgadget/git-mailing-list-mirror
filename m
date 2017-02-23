Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8AA2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdBWXtI (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:49:08 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36007 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdBWXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:48:58 -0500
Received: by mail-pg0-f48.google.com with SMTP id s67so2688046pgb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFQDhvWjPtszUDKGzeD+dpNk/N/GTpxHEo46C04b+rA=;
        b=j2Gz6paQgsu8tdGafzqWs+E/miUesHb9vtgHhbHgiKEE9K/0uyJWt/mGo3SYh4nVFm
         M+fHtgfa1eLVjS5eu4axL579FYNEDPfTjF6CppUl9hcabHuqdFrufpc7zRrDzG/oG/UW
         d5Ox0cUQ899DD09WI/io0vJIr4X5jep1Dpv2FnAN0X0nYzxiNa0pimCRT/sxw/0bM3Ge
         7+r2mNnEMPzAYYtt5yMOQgz9qg96VjI1BucUtl1YSXu0611TBFqSmghFbQFG6aq12TLl
         1T49OpYa7X3AQ1dqzmudUlXbfq4EppmN/ZLdfTifXYGJ1rd4Bs3+pCx/fnU3UgbgJi7n
         9Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFQDhvWjPtszUDKGzeD+dpNk/N/GTpxHEo46C04b+rA=;
        b=jV+GIVFAVQfNEaeMtuT4AYbCfHhido+JVj38v6cvv02OYujJZJ2B3XqmjShugJj6zR
         P1o38rzqft1n1+z3+HZgsmvWM2l++yglbekzrX6EgC44G7TvciJ4fPyc8eQGi8D11665
         VYVomYkrOZNPfUW9+PQib0gWok5Co8y8dzzkRpJmj1U42TGGlfExx0RxhJrjYzh/HT1d
         9e2Knlj2zAhzPKLdu5tMhYuSPQxoVRUEfjHfN56M6xg7WDZUy458JjaiPnCB54ixxyCH
         RflGtcHR3shWCxKbD6l9hmYLfFerTAlgkPZjfLPfpGC6D8XfLM0HwpfH11bquGefLll2
         JcZA==
X-Gm-Message-State: AMke39nk3uzw52AVRd9Lijjv6Ja0lImrpBFpVUiH6EnPrW5iF68+HyEXe5mjZrb57x1U1Ndi
X-Received: by 10.98.6.133 with SMTP id 127mr13588398pfg.110.1487893670582;
        Thu, 23 Feb 2017 15:47:50 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r74sm11660300pfb.67.2017.02.23.15.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:47:49 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 08/10] submodule deinit: use most reliable url
Date:   Thu, 23 Feb 2017 15:47:26 -0800
Message-Id: <20170223234728.164111-9-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
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
index f8adfb179..02b85dceb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -466,7 +466,7 @@ Submodule work tree '\$displaypath' contains a .git directory
 		then
 			# Remove the whole section so we have a clean state when
 			# the user later decides to init this submodule again
-			url=$(git config submodule."$name".url)
+			url=$(GIT_DIR="$(git rev-parse --git-path modules/$name)" git config remote.origin.url)
 			git config --remove-section submodule."$name" 2>/dev/null &&
 			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
 		fi
-- 
2.11.0.483.g087da7b7c-goog

