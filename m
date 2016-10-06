Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE11C207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934743AbcJFThh (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:37:37 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34735 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934676AbcJFThg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:37:36 -0400
Received: by mail-pa0-f54.google.com with SMTP id rz1so12939938pab.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wrnoKKYXl9HVAR5elwYJ4OJJEytE/fzHTAZWvL8/bU4=;
        b=gDTeWZRYf6XrgOsmpwmOENJMkUP9dhHlRNUlk10x1Ifk7MxnZBvtodIfzRh6iPYeLj
         f3Z8FKcmTjYm4Hmzwe8W7yGbOVbuPR6Fl3l6hF3ik9zWoLnVxnM+gT/10xr8z8VUPS1/
         5GLrDr1+I+TPuYAPFFCCjCRo+bPfKe1qWbS/Fbt8YrbsUILW4an60hbZJJEZbbjdJhLN
         sG9Wh37iTiuI7MKE2cbxgUdYxesqO+2JA0RLSipo2Cjp7WZOObsGTQOoTG1FFjs8IBGJ
         TeZawtzCp+U4uYW1gcFBg2V7Nwz3GahOFIi0R0XAb6xJ62GCSIAKfuoiuPxYPm38RM4J
         rHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wrnoKKYXl9HVAR5elwYJ4OJJEytE/fzHTAZWvL8/bU4=;
        b=M6Z5wqV1FjDINirzfFQDwfDmYOL+Jh7BPi/zI2C2Tdb02m3q1YQg9k50/y6BCXPIGz
         hmD5sNBNitPIBD3NzKbD3DeKWqRSunJP2k+icmieWKfZkqZrHKik+fyS0Ymoo4qd5uN6
         8oFJY3D0jzhuV9bfml4d9TRDhREGtuBnXtPO3qOZZK6v3N1Uj5edXDMPbrlFAtkFwxv/
         cwu8Vm28X8oJWqQjYy7mcSncLrJNU5+RCpicQjgjw7DP4ljax5SHJn5cd4q8JrSzt4+8
         x3hAwOzMPpbQTvnZMTUVeU/UaQAbvXqgM+OuPWHyJx0yiyYQbdZ7GT2mYcqx7lCvhZAL
         3iOw==
X-Gm-Message-State: AA6/9Rkwy4x+TnXqYiFGZNtu37C8tlj41LY25Gc8JLBQE0KQGBqp1ev0I6WsVspXV+/58/8s
X-Received: by 10.66.142.169 with SMTP id rx9mr24461677pab.122.1475782655032;
        Thu, 06 Oct 2016 12:37:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9975:37b1:c0d3:285b])
        by smtp.gmail.com with ESMTPSA id p77sm7782363pfi.27.2016.10.06.12.37.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Oct 2016 12:37:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule add: extend force flag to add existing repos
Date:   Thu,  6 Oct 2016 12:37:24 -0700
Message-Id: <20161006193725.31553-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.353.g1629400
In-Reply-To: <20161006193725.31553-1-sbeller@google.com>
References: <20161006193725.31553-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the force flag in `git submodule add` takes care of possibly
ignored files or when a name collision occurs.

However there is another situation where submodule add comes in handy:
When you already have a gitlink recorded, but no configuration was
done (i.e. no .gitmodules file nor any entry in .git/config) and you
want to generate these config entries. For this situation allow
`git submodule add` to proceed if there is already a submodule at the
given path in the index.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh           | 10 ++++++++--
 t/t7400-submodule-basic.sh | 14 ++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a024a13..3762616 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -207,8 +207,14 @@ cmd_add()
 			tstart
 			s|/*$||
 		')
-	git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
-	die "$(eval_gettext "'\$sm_path' already exists in the index")"
+	if test -z "$force"
+	then
+		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
+		die "$(eval_gettext "'\$sm_path' already exists in the index")"
+	else
+		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
+		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
+	fi
 
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$sm_path" > /dev/null 2>&1
 	then
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b77cce8..c09ce0d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -152,6 +152,20 @@ test_expect_success 'submodule add to .gitignored path with --force' '
 	)
 '
 
+test_expect_success 'submodule add to reconfigure existing submodule with --force' '
+	(
+		cd addtest-ignore &&
+		git submodule add --force bogus-url submod &&
+		git submodule add -b initial "$submodurl" submod-branch &&
+		test "bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
+		test "bogus-url" = "$(git config submodule.submod.url)" &&
+		# Restore the url
+		git submodule add --force "$submodurl" submod
+		test "$submodurl" = "$(git config -f .gitmodules submodule.submod.url)" &&
+		test "$submodurl" = "$(git config submodule.submod.url)"
+	)
+'
+
 test_expect_success 'submodule add --branch' '
 	echo "refs/heads/initial" >expect-head &&
 	cat <<-\EOF >expect-heads &&
-- 
2.10.1.353.g1629400

