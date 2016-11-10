Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B58203E2
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965895AbcKJUfa (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:30 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35916 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965758AbcKJUfU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:20 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so152175474pfz.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qpmDqm/fAO1tShimUBKfEKIIfWoRpyKCOO1QYoJ6SJI=;
        b=X8XoGKhvtZQLr/+ibGkjIqrqusnE3yax+pVL+mZ/WMj4ffGGt6CCCiDJWbhDhY+Qzg
         ZvgxYDNXDgq9Y2ZRqO/RMH1V7SLAAV8xTZG6hKd0JWUutONRC8FZ3L478zH+WbK/BLTm
         PnF7GGaHZlPAfuV3nengv9nI3Sa3yTeFFOFEJBJimYeCEASAMgGDKNdjdfWFPWiCtkxO
         KUdhm63F/41RPKhA0Vm2Uoo7EVYrNckmpFTxL7cm5jmaSuM9A85fGJ4CZBjJXkkzsP0/
         V61BRlsB9938rUKHcm6kCRddxi50hmtBLiPLEj/yL/VB4CQsKiBfUDbSECHucmNRoJX3
         dRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qpmDqm/fAO1tShimUBKfEKIIfWoRpyKCOO1QYoJ6SJI=;
        b=P884vvoR+4lB8zWqY36Qt4uBIo1ZJ3XR0E1jIqHbVXeHvI0GtIEBQIVRqEo0pbTtsm
         z7d6UxI5odTn0XupL7j7vRAXYzOgaMqAAGEURaH8bP/OtSjqgUrt4b7MnZrrEAC7I1QY
         APLrIVTWxw542nzcpiy54EC3WBtiLK9vKjqSQQfbOcDuabyiBxgPQyuMaansMIfvZ9qv
         64JhcmLSVJ9E9MfCOQAnlHRJM37xRQjVwwd0OtVlLli7nnmh5k2KOr+HIqmD26i0hcYX
         ogdeyFsW1mK4xU9Rmx65H+Qh4Pe1ShQQrXiZyH9MEBs+73BOaAErKuEkRO7+UHBjhWoQ
         mgoA==
X-Gm-Message-State: ABUngvcdlwnQjT7iakxzR3tDxEVnY4qx5WWPgm8LOkANKqZJQsqKmRnZwUiWig9WyYXWwqyR
X-Received: by 10.98.111.138 with SMTP id k132mr13543818pfc.108.1478810119160;
        Thu, 10 Nov 2016 12:35:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id af14sm9355732pac.13.2016.11.10.12.35.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 33/35] submodule update: add `--init-default-path` switch
Date:   Thu, 10 Nov 2016 12:34:26 -0800
Message-Id: <20161110203428.30512-34-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new switch `--init-default-path` initializes the submodules which are
configured in `submodule.defaultUpdatePath` instead of those given as
command line arguments before updating. In the first implementation this
is made incompatible with further command line arguments as it is
unclear what the user means by

    git submodule update --init --init-default-path <paths>

This new switch allows to record more complex patterns as it saves
retyping them whenever you invoke update.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt        |  5 ++++
 Documentation/git-submodule.txt | 17 +++++++++----
 git-submodule.sh                | 21 +++++++++++++---
 t/t7400-submodule-basic.sh      | 53 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a179474..290de3b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2885,6 +2885,11 @@ submodule.alternateErrorStrategy
 	as computed via `submodule.alternateLocation`. Possible values are
 	`ignore`, `info`, `die`. Default is `die`.
 
+submodule.defaultUpdatePath::
+	Specifies a set of submodules to initialize when calling
+	`git submodule --init-default-group` by using the pathspec
+	syntax.
+
 tag.forceSignAnnotated::
 	A boolean to specify whether annotated tags created should be GPG signed.
 	If `--annotate` is specified on the command line, it takes
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bf3bb37..503fec8 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,10 +14,10 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [--[no-]recommend-shallow] [-f|--force] [--rebase|--merge]
-	      [--reference <repository>] [--depth <depth>] [--recursive]
-	      [--jobs <n>] [--] [<path>...]
+'git submodule' [--quiet] update [--init[-default-path]] [--remote] [-N|--no-fetch]
+	      [--[no-]recommend-shallow]
+	      [-f|--force] [--rebase|--merge] [--reference <repository>]
+	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -194,6 +194,10 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 
+You can configure a set of submodules using pathspec syntax in
+submodule.defaultUpdatePath you can use `--init-default-path` to initialize
+those before updating.
+
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
@@ -361,6 +365,11 @@ the submodule itself.
 	Initialize all submodules for which "git submodule init" has not been
 	called so far before updating.
 
+--init-default-path::
+	This option is only valid for the update command.
+	Initialize all submodules configured in "`submodule.defaultUpdatePath`"
+	that have not been updated before.
+
 --name::
 	This option is only valid for the add command. It sets the submodule's
 	name to the given string instead of defaulting to its path. The name
diff --git a/git-submodule.sh b/git-submodule.sh
index a024a13..334cecc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init[-default-path]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -503,7 +503,12 @@ cmd_update()
 			progress="--progress"
 			;;
 		-i|--init)
-			init=1
+			test -z $init || test $init = by_args || die "$(gettext "Only one of --init or --init-default-path may be used.")"
+			init=by_args
+			;;
+		--init-default-path)
+			test -z $init || test $init = by_config || die "$(gettext "Only one of --init or --init-default-path may be used.")"
+			init=by_config
 			;;
 		--remote)
 			remote=1
@@ -572,7 +577,17 @@ cmd_update()
 
 	if test -n "$init"
 	then
-		cmd_init "--" "$@" || return
+		if test "$init" = "by_config"
+		then
+			if test $# -gt 0
+			then
+				die "$(gettext "path arguments are incompatible with --init-default-path")"
+			fi
+			cmd_init "--" $(git config --get-all submodule.defaultUpdatePath) || return
+		else
+			cmd_init "--" "$@" || return
+		fi
+
 	fi
 
 	{
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b77cce8..4699b1c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1116,5 +1116,58 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup superproject with submodules' '
+	mkdir sub1 &&
+	(
+		cd sub1 &&
+		git init &&
+		test_commit test &&
+		test_commit test2
+	) &&
+	mkdir multisuper &&
+	(
+		cd multisuper &&
+		git init &&
+		git submodule add ../sub1 sub0 &&
+		git submodule add ../sub1 sub1 &&
+		git submodule add ../sub1 sub2 &&
+		git submodule add ../sub1 sub3 &&
+		git commit -m "add some submodules"
+	)
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
+	(
+		cd multisuper_clone &&
+		git submodule update --init . ":(exclude)sub0" &&
+		git submodule status |cut -c 1,43- >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule update --init-default-path' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git config submodule.defaultUpdatePath "." &&
+		git config --add submodule.defaultUpdatePath ":(exclude)sub0" &&
+		git submodule update --init-default-path &&
+		git submodule status |cut -c 1,43- >../actual &&
+		test_must_fail git submodule update --init-default-path sub0
+	) &&
+	test_cmp expect actual
+'
 
 test_done
-- 
2.10.1.469.g00a8914

