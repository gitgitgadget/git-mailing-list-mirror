Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AEC12022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdBWXtG (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:49:06 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34017 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbdBWXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:48:58 -0500
Received: by mail-pg0-f53.google.com with SMTP id 1so2732988pgi.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WW3/9YOIeukfcgDWtG0nKneXk1Y4xOa6eQIo/q3X1Dk=;
        b=vONGaWb1baSNzMkWIBDGcBe0vanSCqWxnhZerdNBvyEdzS7MUcnQ8OyjlnaAKoxqvZ
         0swM8VnXZ0GBu8ZnMAPIW4L6q5MwCUG8NQUqkBDLIQOwUsni9I6no6XqtWbmkixYr8PG
         5166MwiENUqfzoyF7HR8034gBQeiF3s+CCvDrgW/PJz6D4mPFzQXycUHTONdtq3WI879
         zCUisMepfo3joccN9wS/YdhMkMl9SFOkY/qLQuUV/mnsQV1sLQIb/iPJdZBaqNQBKB8z
         vIuoesmhlhBAB7uSUr9w3bytdlr1j8mJs2r5WHGPsrOCrYSYijYPSFqAylrxcRrPygcY
         M/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WW3/9YOIeukfcgDWtG0nKneXk1Y4xOa6eQIo/q3X1Dk=;
        b=RRe8xXWLtPnf8FG7AIpLcnseDVUzE9GGcEXg0nScm5P6Hk+Jh0PJ875764FMY0jwji
         mBEgiHWS5GjahvzdFZLcGczKGMbKsOwwexd8wQ/vpN40jPlwidHQF/mu22oYkJstgV2l
         oNcNishSxDvY7AnqmZpoqn+fJgLCBzYBp4NaglorvYaxg38TVw8BQYuYQSvrDp20qa/Z
         eOU9jej4nxdSmdSX4jVt8MicrI6CTB62ouzXM/ATykA7JHfjbypFjwstnwcaMFILMkmd
         mXoLo7+yCn3ywmyKiSX+uLdNP9C89fuDhM1L6YqSj9bbdJhxq3hUi7b/62VIyJkY9D/l
         3XGg==
X-Gm-Message-State: AMke39n1pUjGHs1vCK7U83FLktjgKx7IV0KHKRYGGXaH48mPP2/BpdMYkRhlKPP9UeQWmWUQ
X-Received: by 10.98.13.203 with SMTP id 72mr48783455pfn.64.1487893662018;
        Thu, 23 Feb 2017 15:47:42 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r74sm11660300pfb.67.2017.02.23.15.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:47:41 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 02/10] submodule update: add `--init-active` switch
Date:   Thu, 23 Feb 2017 15:47:20 -0800
Message-Id: <20170223234728.164111-3-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new switch `--init-active` initializes the submodules which are
configured in `submodule.active` instead of those given as
command line arguments before updating. In the first implementation this
is made incompatible with further command line arguments as it is
unclear what the user means by

    git submodule update --init --init-active <paths>

This new switch allows users to record more complex patterns as it saves
retyping them whenever you invoke update.

Based on a patch by Stefan Beller <sbeller@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-submodule.txt | 11 ++++++++++-
 git-submodule.sh                | 21 ++++++++++++++++++---
 t/t7400-submodule-basic.sh      | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 918bd1d1b..626b9760a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
+'git submodule' [--quiet] update [--init[-active]] [--remote] [-N|--no-fetch]
 	      [--[no-]recommend-shallow] [-f|--force] [--rebase|--merge]
 	      [--reference <repository>] [--depth <depth>] [--recursive]
 	      [--jobs <n>] [--] [<path>...]
@@ -195,6 +195,10 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 
+You can configure a set of submodules using pathspec syntax in
+submodule.active you can use `--init-active` to initialize
+those before updating.
+
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
@@ -378,6 +382,11 @@ the submodule itself.
 	Initialize all submodules for which "git submodule init" has not been
 	called so far before updating.
 
+--init-active::
+	This option is only valid for the update command.
+	Initialize all submodules configured in "`submodule.active`"
+	that have not been updated before.
+
 --name::
 	This option is only valid for the add command. It sets the submodule's
 	name to the given string instead of defaulting to its path. The name
diff --git a/git-submodule.sh b/git-submodule.sh
index 554bd1c49..e5b9a8920 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init[-active]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -499,7 +499,12 @@ cmd_update()
 			progress="--progress"
 			;;
 		-i|--init)
-			init=1
+			test -z $init || test $init = by_args || die "$(gettext "Only one of --init or --init-active may be used.")"
+			init=by_args
+			;;
+		--init-active)
+			test -z $init || test $init = by_config || die "$(gettext "Only one of --init or --init-active may be used.")"
+			init=by_config
 			;;
 		--remote)
 			remote=1
@@ -568,7 +573,17 @@ cmd_update()
 
 	if test -n "$init"
 	then
-		cmd_init "--" "$@" || return
+		if test "$init" = "by_config"
+		then
+			if test $# -gt 0
+			then
+				die "$(gettext "path arguments are incompatible with --init-active")"
+			fi
+			cmd_init "--" $(git config --get-all submodule.active) || return
+		else
+			cmd_init "--" "$@" || return
+		fi
+
 	fi
 
 	{
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b77cce8e4..f5df0a5b4 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1116,5 +1116,44 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup superproject with submodules' '
+	git init sub1 &&
+	test_commit -C sub1 test &&
+	test_commit -C sub1 test2 &&
+	git init multisuper &&
+	git -C multisuper submodule add ../sub1 sub0 &&
+	git -C multisuper submodule add ../sub1 sub1 &&
+	git -C multisuper submodule add ../sub1 sub2 &&
+	git -C multisuper submodule add ../sub1 sub3 &&
+	git -C multisuper commit -m "add some submodules"
+'
+
+cat >expect <<-EOF
+-sub0
+ sub1 (test2)
+ sub2 (test2)
+ sub3 (test2)
+EOF
+
+test_expect_success 'submodule update --init with a specification' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone submodule update --init . ":(exclude)sub0" &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule update --init-active' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	git -C multisuper_clone config submodule.active "." &&
+	git -C multisuper_clone config --add submodule.active ":(exclude)sub0" &&
+	git -C multisuper_clone submodule update --init-active &&
+	git -C multisuper_clone submodule status |cut -c 1,43- >actual &&
+	test_must_fail git -C multisuper_clone submodule update --init-active sub0 &&
+	test_cmp expect actual
+'
 
 test_done
-- 
2.11.0.483.g087da7b7c-goog

