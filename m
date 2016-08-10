Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3BE91FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 21:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbcHJV1f (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 17:27:35 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33508 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932321AbcHJSCo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:02:44 -0400
Received: by mail-pf0-f179.google.com with SMTP id y134so18217890pfg.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:02:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h71S/gFrgI4jQQcSch67h3Q5waaLx5sDoKbrTy8SoQs=;
        b=h3qeLLhF9ICTlm92wI0sgGH7cedE/xnc4QBGlHi/35JTvIpZct2red4mEQ8ssnb12g
         9nN2ZS2eZeEc6KlfnW2H69OX0XhwEHCf9PsPzFm3bUiGNwolHJE8ry+w+Z0i2b584243
         4MEW06qxmibLiAfsWpQe3QNPmwnpHucvUWGXaV/CNCUIZUKnhS7Bh6kkmnbcLfI6pvN8
         Q5mVmsj97AIfZg4oMtYBmg3AqqPkKY31zVW4zi07v0lAFD7mgDyJFV9o7CHmWCoXi0QO
         D/HKvPyfNpXvuC5k0m8GIn9RGsLE5S0LQTY2hRBXAKnhczPddIrh+dbmdvHNUc8h3xNE
         0ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h71S/gFrgI4jQQcSch67h3Q5waaLx5sDoKbrTy8SoQs=;
        b=keKuXv5jbHF8IYgTTLU6mzy+WYYqXblNtqdv2KOXhU4YpIvlc94YzliS0/OXLL37b0
         ofXMlak88slbgDr0UjQJujF0dLsUyk151N48ryRLQ+zE14GYH+z+g9i+Ho3JK3NAHyox
         rVMtH6X39lhi1V5LmuGZiQkRa3jynhmV3/kBYsZLNdoLfxNyIF/8WjtjzTudPFapKRxf
         VPrSnT4MZkzvprb6wQ8gYQTU7/huAVr6hJ1ihR1LnPD5Nb9xCLQ+OfuZEV82adN7GMfx
         g+T4AjWxdueEqN509kWrAiZCYPsa10b9FlzuNsJsny0QusAa7U9OhkifGEEyny4lfl+y
         Z1Kw==
X-Gm-Message-State: AEkooutG/ENxF9+Ih3L/nWy+/+owTnt4cV6DqWyYgkOCG8YxkFnDfFO08hmieRhc8BcXPddy
X-Received: by 10.98.129.5 with SMTP id t5mr9409212pfd.32.1470851771512;
        Wed, 10 Aug 2016 10:56:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1d6:11b1:1dbd:105])
        by smtp.gmail.com with ESMTPSA id d3sm65556083pfk.37.2016.08.10.10.56.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 10:56:10 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, larsxschneider@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH] t7406: fix breakage on OSX
Date:	Wed, 10 Aug 2016 10:56:07 -0700
Message-Id: <20160810175607.30826-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.665.gdb8bb2f
In-Reply-To: <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com>
References: <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On OSX `wc` prefixes the output of numbers with whitespace, such that
the `commit_count` would be "SP <NUMBER>". When using that in

    git submodule update --init --depth=$commit_count

the depth would be empty and the number is interpreted as the pathspec.
Fix this by not using `wc` and rather instruct rev-list to count.

Another way to fix this is to remove the `=` sign after the `--depth`
argument as then we are allowed to have more than just one whitespace
between `--depth` and the actual number. Prefer the solution of rev-list
counting as that is expected to be slightly faster and more self-sustained
within Git.

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>,
Signed-off-by: Stefan Beller <sbeller@google.com>
---

  origin/sb/submodule-update-dot-branch

 t/t7406-submodule-update.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index d7983cf..64f322c 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -877,7 +877,7 @@ test_expect_success 'submodule update clone shallow submodule' '
 	test_when_finished "rm -rf super3" &&
 	first=$(git -C cloned submodule status submodule |cut -c2-41) &&
 	second=$(git -C submodule rev-parse HEAD) &&
-	commit_count=$(git -C submodule rev-list $first^..$second | wc -l) &&
+	commit_count=$(git -C submodule rev-list --count $first^..$second) &&
 	git clone cloned super3 &&
 	pwd=$(pwd) &&
 	(
-- 
2.9.2.665.gdb8bb2f

