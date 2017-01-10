Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7387A20A93
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdAJUnD (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:03 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34892 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbdAJUmu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:50 -0500
Received: by mail-qk0-f178.google.com with SMTP id u25so571714375qki.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jRChVO5c05zzO/HwwuEMBqtCFjT8mqA8TWgpsd1B67U=;
        b=uF489KwQU+QrN9fl651QkGcieBzeNQFmOhX9iKqvPpUoz98IM6WfTrKE1YFjRi0uEe
         n6epYHIjQ5GQCYJWu1WSJgXWkLFS/fdhA7nhMOOWIW7PIsg52pxnljKqDVKnxPaUylRu
         rhB30082VJ9jQX6nmkvUW+j6SjoHTvaOcBx25eG2zy3VyiUuvXfRCvz/hjJbHPhfW8gT
         /jhSYfWyVKNtgWBffJDr+XXRNHFc13geRRMgv8HX58FRvLheX0D6SH2meE1HGCO2RASL
         nTA7CEo0pMa91MT2476EcVge0+uGmJJP5Srfd9zb2HjIwl6Gl0PM8l2Y68/wDxN+j45X
         OnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jRChVO5c05zzO/HwwuEMBqtCFjT8mqA8TWgpsd1B67U=;
        b=T+op4cjhRgoehzIRWpeAXn2jxXsQeGvB6LzKl6Yg0VPdvRXffHjR/SJO5ID4AFPlak
         lqkLdXlrwG7f3Xj+lSdqu+p+W05srEY9wj2Wyd7yeQrM8z14aam0pzZZy2zd5fOtBB6K
         WK9AiEIzAeKu0DDTNeUzIWrhrSYt9CxnnH623ArJHPlDmGescz6fX0t/6LQn0+1STddR
         PDNfbrDe4yvLxabgnHWHAdr7IxumX1+ohG6q2ehiZoMLx+otcy9A4R4w4xarypv+RlEF
         XViIQxRzVceiAwpEnuEEjJSoDOWQUthclkkujoJQIA4c5d3qLotj6yTna22PYtgYwdJA
         TPJA==
X-Gm-Message-State: AIkVDXKezSlNTLGtAswRqDRWqYAuQTo916/oQcJPc6YRYCtofQBnYjb+2kDDBH8hidQEcqEz
X-Received: by 10.55.220.199 with SMTP id v190mr4805200qki.42.1484080969416;
        Tue, 10 Jan 2017 12:42:49 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:48 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 14/14] mergetool: fix running in subdir when rerere enabled
Date:   Tue, 10 Jan 2017 15:42:02 -0500
Message-Id: <20170110204202.21779-15-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pathnames output by the 'git rerere remaining' command are
relative to the top-level directory but the 'git diff --name-only'
command expects its pathname arguments to be relative to the current
working directory.  Run cd_to_toplevel before running 'git diff
--name-only' and adjust any relative pathnames so that 'git mergetool'
does not fail when run from a subdirectory with rerere enabled.

This fixes a regression introduced in
57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Richard Hansen <hansenr@google.com>
---
 git-mergetool.sh     | 17 +++++++++++++++--
 t/t7610-mergetool.sh |  7 ++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index b506896dc..c062e3de3 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -454,6 +454,17 @@ main () {
 	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 
+	prefix=$(git rev-parse --show-prefix) || exit 1
+	cd_to_toplevel
+
+	if test -n "$orderfile"
+	then
+		orderfile=$(
+			git rev-parse --prefix "$prefix" -- "$orderfile" |
+			sed -e 1d
+		)
+	fi
+
 	if test $# -eq 0 && test -e "$GIT_DIR/MERGE_RR"
 	then
 		set -- $(git rerere remaining)
@@ -461,14 +472,16 @@ main () {
 		then
 			print_noop_and_exit
 		fi
+	elif test $# -ge 0
+	then
+		# rev-parse provides the -- needed for 'set'
+		eval "set $(git rev-parse --sq --prefix "$prefix" -- "$@")"
 	fi
 
 	files=$(git -c core.quotePath=false \
 		diff --name-only --diff-filter=U \
 		${orderfile:+"-O$orderfile"} -- "$@")
 
-	cd_to_toplevel
-
 	if test -z "$files"
 	then
 		print_noop_and_exit
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index b36fde1c0..820fc8597 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -234,7 +234,7 @@ test_expect_success 'mergetool merges all from subdir (rerere disabled)' '
 	)
 '
 
-test_expect_failure 'mergetool merges all from subdir (rerere enabled)' '
+test_expect_success 'mergetool merges all from subdir (rerere enabled)' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config rerere.enabled true &&
@@ -677,6 +677,11 @@ test_expect_success 'diff.orderFile configuration is honored' '
 		b
 		a
 	EOF
+
+	# make sure "order-file" that is ambiguous between
+	# rev and path is understood correctly.
+	git branch order-file HEAD &&
+
 	git mergetool --no-prompt --tool myecho >output &&
 	git grep --no-index -h -A2 Merging: output >actual &&
 	test_cmp expect actual
-- 
2.11.0.390.gc69c2f50cf-goog

