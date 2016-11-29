Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69DBD1FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 09:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756762AbcK2JkE (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 04:40:04 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34658 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756702AbcK2JiL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 04:38:11 -0500
Received: by mail-pg0-f52.google.com with SMTP id x23so67841646pgx.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 01:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=e/xs3LsHZW2MvJaV9y7XtqWxCLZW46k2itVg1q1wsHc=;
        b=DaccO/SELm29uPkwppgJ3OaAv4l1HGsZHrOU++pb2xAIopnHzP7HM2gkc+htYKohim
         EkVAoKi3Marb4a82EYT7oNKABS/nzQ2308pGrOJ/7PKPXfunZxQP3wYVdTi1vxAXM/ss
         mSZU3CkCQ3Lu7Rg4J2B05isrUG5eGHCbL3T/GIR8NcIr3fp/1+HyqVCUHttjIOGLX8HI
         9HrrhzOX7JoznfC4wD0kAEGLOqxCnJjQNyYfpKxy+u0SgLtMPUenAnmi//sdw34EZTpq
         gmP+ghpnkF9CgmBTWExOYRmYmOtyBAjjTXeIpdVc1vmADdnXuE3agu1w4mIRJxagmT9g
         TWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e/xs3LsHZW2MvJaV9y7XtqWxCLZW46k2itVg1q1wsHc=;
        b=mRciATe/xa6EPRykJb6Q0Avg21DwQNMUQJRhxgyiM4IMtJwBPnne8R43ttYk/o0moz
         SOIeBAO1YRWxB3sk6Ddq20eMFqlS1aES+8zk4wYaSuCEEkcTO4FTANNBqkGdeMgBKlrT
         jJjzczYmt0u0jzohfkwvIP/nk7xf3/7SyobPEMg712OTnKXHjpWpQmgSBqXMhu24FWIt
         juTpwHuW5fEbAI6kBDfxDSqB7oqKeNOEtNaO8SVtk6ovQucLlsGPXH/44BIpXTuZQHX/
         E8ECR85lSIzt+uo4mDoKbRJdDCff5NqnvMVhZrO2BuG0jXOqX8vnPIGCZtyTBTl3JT0N
         51Bg==
X-Gm-Message-State: AKaTC03uR998yQ547e1C1m+t1L6xft4g8RK7FZoDkU/SI7wNOvaUcQKJShgc82LECYnR9Q==
X-Received: by 10.98.99.197 with SMTP id x188mr26337203pfb.179.1480412290498;
        Tue, 29 Nov 2016 01:38:10 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id r1sm93435829pfg.56.2016.11.29.01.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 01:38:09 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Dun Peal <dunpealer@gmail.com>
Subject: [PATCH 1/2] mergetool: honor mergetool.$tool.trustExitCode for built-in tools
Date:   Tue, 29 Nov 2016 01:38:07 -0800
Message-Id: <20161129093807.24637-1-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.rc3.6.g2e567fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Built-in merge tools contain a hard-coded assumption about
whether or not a tool's exit code can be trusted to determine
the success or failure of a merge.  Tools whose exit codes are
not trusted contain calls to check_unchanged() in their
merge_cmd() functions.

A problem with this is that the trustExitCode configuration is
not honored for built-in tools.

Teach built-in tools to honor the trustExitCode configuration.
Extend run_merge_cmd() so that it is responsible for calling
check_unchanged() when a tool's exit code cannot be trusted.
Remove check_unchanged() calls from scriptlets since they are no
longer responsible for calling it.

When no configuration is present, exit_code_trustable() is
checked to see whether the exit code should be trusted.
The default implementation returns false.

Tools whose exit codes can be trusted override
exit_code_trustable() to true.

Reported-by: Dun Peal <dunpealer@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh    | 56 ++++++++++++++++++++++++++++++++++++++----------
 mergetools/araxis        |  2 --
 mergetools/bc            |  2 --
 mergetools/codecompare   |  2 --
 mergetools/deltawalker   |  6 +++++-
 mergetools/diffmerge     |  4 ++++
 mergetools/diffuse       |  2 --
 mergetools/ecmerge       |  2 --
 mergetools/emerge        |  4 ++++
 mergetools/examdiff      |  2 --
 mergetools/kdiff3        |  4 ++++
 mergetools/kompare       |  4 ++++
 mergetools/meld          |  3 +--
 mergetools/opendiff      |  2 --
 mergetools/p4merge       |  2 --
 mergetools/tkdiff        |  4 ++++
 mergetools/tortoisemerge |  2 --
 mergetools/vimdiff       |  2 --
 mergetools/winmerge      |  2 --
 mergetools/xxdiff        |  2 --
 20 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 9abd00be2..9a8b97a2a 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -125,16 +125,7 @@ setup_user_tool () {
 	}
 
 	merge_cmd () {
-		trust_exit_code=$(git config --bool \
-			"mergetool.$1.trustExitCode" || echo false)
-		if test "$trust_exit_code" = "false"
-		then
-			touch "$BACKUP"
-			( eval $merge_tool_cmd )
-			check_unchanged
-		else
-			( eval $merge_tool_cmd )
-		fi
+		( eval $merge_tool_cmd )
 	}
 }
 
@@ -162,6 +153,28 @@ setup_tool () {
 		echo "$1"
 	}
 
+	# Most tools' exit codes cannot be trusted, so By default we ignore
+	# their exit code and check the merged file's modification time in
+	# check_unchanged() to determine whether or not the merge was
+	# successful.  The return value from run_merge_cmd, by default, is
+	# determined by check_unchanged().
+	#
+	# When a tool's exit code can be trusted then the return value from
+	# run_merge_cmd is simply the tool's exit code, and check_unchanged()
+	# is not called.
+	#
+	# The return value of exit_code_trustable() tells us whether or not we
+	# can trust the tool's exit code.
+	#
+	# User-defined and built-in tools default to false.
+	# Built-in tools advertise that their exit code is trustable by
+	# redefining exit_code_trustable() to true.
+
+	exit_code_trustable () {
+		false
+	}
+
+
 	if ! test -f "$MERGE_TOOLS_DIR/$tool"
 	then
 		setup_user_tool
@@ -197,6 +210,19 @@ get_merge_tool_cmd () {
 	fi
 }
 
+trust_exit_code () {
+	if git config --bool "mergetool.$1.trustExitCode"
+	then
+		:; # OK
+	elif exit_code_trustable
+	then
+		echo true
+	else
+		echo false
+	fi
+}
+
+
 # Entry point for running tools
 run_merge_tool () {
 	# If GIT_PREFIX is empty then we cannot use it in tools
@@ -225,7 +251,15 @@ run_diff_cmd () {
 
 # Run a either a configured or built-in merge tool
 run_merge_cmd () {
-	merge_cmd "$1"
+	mergetool_trust_exit_code=$(trust_exit_code "$1")
+	if test "$mergetool_trust_exit_code" = "true"
+	then
+		merge_cmd "$1"
+	else
+		touch "$BACKUP"
+		merge_cmd "$1"
+		check_unchanged
+	fi
 }
 
 list_merge_tool_candidates () {
diff --git a/mergetools/araxis b/mergetools/araxis
index 64f97c5e9..e2407b65b 100644
--- a/mergetools/araxis
+++ b/mergetools/araxis
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" -wait -merge -3 -a1 \
@@ -12,7 +11,6 @@ merge_cmd () {
 		"$merge_tool_path" -wait -2 \
 			"$LOCAL" "$REMOTE" "$MERGED" >/dev/null 2>&1
 	fi
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/bc b/mergetools/bc
index b6319d206..3a69e60fa 100644
--- a/mergetools/bc
+++ b/mergetools/bc
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
@@ -12,7 +11,6 @@ merge_cmd () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE" \
 			-mergeoutput="$MERGED"
 	fi
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/codecompare b/mergetools/codecompare
index 3f0486bc8..9f60e8da6 100644
--- a/mergetools/codecompare
+++ b/mergetools/codecompare
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" -MF="$LOCAL" -TF="$REMOTE" -BF="$BASE" \
@@ -12,7 +11,6 @@ merge_cmd () {
 		"$merge_tool_path" -MF="$LOCAL" -TF="$REMOTE" \
 			-RF="$MERGED"
 	fi
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/deltawalker b/mergetools/deltawalker
index b3c71b623..ee6f374bc 100644
--- a/mergetools/deltawalker
+++ b/mergetools/deltawalker
@@ -16,6 +16,10 @@ merge_cmd () {
 	fi >/dev/null 2>&1
 }
 
-translate_merge_tool_path() {
+translate_merge_tool_path () {
 	echo DeltaWalker
 }
+
+exit_code_trustable () {
+	true
+}
diff --git a/mergetools/diffmerge b/mergetools/diffmerge
index f138cb4e7..9b6355b98 100644
--- a/mergetools/diffmerge
+++ b/mergetools/diffmerge
@@ -12,3 +12,7 @@ merge_cmd () {
 			--result="$MERGED" "$LOCAL" "$REMOTE"
 	fi
 }
+
+exit_code_trustable () {
+	true
+}
diff --git a/mergetools/diffuse b/mergetools/diffuse
index 02e0843f4..5a3ae8b56 100644
--- a/mergetools/diffuse
+++ b/mergetools/diffuse
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" \
@@ -13,5 +12,4 @@ merge_cmd () {
 		"$merge_tool_path" \
 			"$LOCAL" "$MERGED" "$REMOTE" | cat
 	fi
-	check_unchanged
 }
diff --git a/mergetools/ecmerge b/mergetools/ecmerge
index 13c2e439d..6c5101c4f 100644
--- a/mergetools/ecmerge
+++ b/mergetools/ecmerge
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
@@ -12,5 +11,4 @@ merge_cmd () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE" \
 			--default --mode=merge2 --to="$MERGED"
 	fi
-	check_unchanged
 }
diff --git a/mergetools/emerge b/mergetools/emerge
index 7b895fdb1..d1ce513ff 100644
--- a/mergetools/emerge
+++ b/mergetools/emerge
@@ -20,3 +20,7 @@ merge_cmd () {
 translate_merge_tool_path() {
 	echo emacs
 }
+
+exit_code_trustable () {
+	true
+}
diff --git a/mergetools/examdiff b/mergetools/examdiff
index 7b524d408..e72b06fc4 100644
--- a/mergetools/examdiff
+++ b/mergetools/examdiff
@@ -3,14 +3,12 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" -merge "$LOCAL" "$BASE" "$REMOTE" -o:"$MERGED" -nh
 	else
 		"$merge_tool_path" -merge "$LOCAL" "$REMOTE" -o:"$MERGED" -nh
 	fi
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
index 793d1293b..0264ed5b2 100644
--- a/mergetools/kdiff3
+++ b/mergetools/kdiff3
@@ -21,3 +21,7 @@ merge_cmd () {
 		>/dev/null 2>&1
 	fi
 }
+
+exit_code_trustable () {
+	true
+}
diff --git a/mergetools/kompare b/mergetools/kompare
index 433686c12..e8c0bfa67 100644
--- a/mergetools/kompare
+++ b/mergetools/kompare
@@ -5,3 +5,7 @@ can_merge () {
 diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 }
+
+exit_code_trustable () {
+	true
+}
diff --git a/mergetools/meld b/mergetools/meld
index 83ebdfb4c..bc178e888 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -7,7 +7,7 @@ merge_cmd () {
 	then
 		check_meld_for_output_version
 	fi
-	touch "$BACKUP"
+
 	if test "$meld_has_output_option" = true
 	then
 		"$merge_tool_path" --output "$MERGED" \
@@ -15,7 +15,6 @@ merge_cmd () {
 	else
 		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
 	fi
-	check_unchanged
 }
 
 # Check whether we should use 'meld --output <file>'
diff --git a/mergetools/opendiff b/mergetools/opendiff
index 0942b2a73..b608dd6de 100644
--- a/mergetools/opendiff
+++ b/mergetools/opendiff
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" "$LOCAL" "$REMOTE" \
@@ -12,5 +11,4 @@ merge_cmd () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE" \
 			-merge "$MERGED" | cat
 	fi
-	check_unchanged
 }
diff --git a/mergetools/p4merge b/mergetools/p4merge
index 5a608abf9..7a5b291dd 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -20,14 +20,12 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if ! $base_present
 	then
 		cp -- "$LOCAL" "$BASE"
 		create_virtual_base "$BASE" "$REMOTE"
 	fi
 	"$merge_tool_path" "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
-	check_unchanged
 }
 
 create_empty_file () {
diff --git a/mergetools/tkdiff b/mergetools/tkdiff
index 618c438e8..eee5cb57e 100644
--- a/mergetools/tkdiff
+++ b/mergetools/tkdiff
@@ -10,3 +10,7 @@ merge_cmd () {
 		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
 	fi
 }
+
+exit_code_trustable () {
+	true
+}
diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index 3b89f1c82..d7ab666a5 100644
--- a/mergetools/tortoisemerge
+++ b/mergetools/tortoisemerge
@@ -5,7 +5,6 @@ can_diff () {
 merge_cmd () {
 	if $base_present
 	then
-		touch "$BACKUP"
 		basename="$(basename "$merge_tool_path" .exe)"
 		if test "$basename" = "tortoisegitmerge"
 		then
@@ -17,7 +16,6 @@ merge_cmd () {
 				-base:"$BASE" -mine:"$LOCAL" \
 				-theirs:"$REMOTE" -merged:"$MERGED"
 		fi
-		check_unchanged
 	else
 		echo "$merge_tool_path cannot be used without a base" 1>&2
 		return 1
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 74ea6d547..a841ffdb4 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -4,7 +4,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	case "$1" in
 	gvimdiff|vimdiff)
 		if $base_present
@@ -31,7 +30,6 @@ merge_cmd () {
 		fi
 		;;
 	esac
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/winmerge b/mergetools/winmerge
index f3819d316..74d03259f 100644
--- a/mergetools/winmerge
+++ b/mergetools/winmerge
@@ -6,10 +6,8 @@ diff_cmd () {
 merge_cmd () {
 	# mergetool.winmerge.trustExitCode is implicitly false.
 	# touch $BACKUP so that we can check_unchanged.
-	touch "$BACKUP"
 	"$merge_tool_path" -u -e -dl Local -dr Remote \
 		"$LOCAL" "$REMOTE" "$MERGED"
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/xxdiff b/mergetools/xxdiff
index 05b443394..e284811ff 100644
--- a/mergetools/xxdiff
+++ b/mergetools/xxdiff
@@ -6,7 +6,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" -X --show-merged-pane \
@@ -21,5 +20,4 @@ merge_cmd () {
 			-R 'Accel.SearchForward: "Ctrl-G"' \
 			--merged-file "$MERGED" "$LOCAL" "$REMOTE"
 	fi
-	check_unchanged
 }
-- 
2.11.0.rc3.6.g2e567fd

