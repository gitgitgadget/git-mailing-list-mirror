Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474621F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeGRULi (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:38 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:33043 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRULi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:38 -0400
Received: by mail-io0-f201.google.com with SMTP id s14-v6so4165663ioc.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=vfvtNmIujY9iP2g9Fvil0LCOBoZfAhIy/2m8ioeQH38=;
        b=KbxC4wmPqGpOB6jGN9UMawp13MhqjZT2YQc76MAJP+cRmfA02E/7f/qS0IYYnGXkKh
         8H8mQMBf983dHyvziZ52BMoM2uJ8YYKCt+csGud8PO8eEyGhz5zOSMzgeUfZqTGWddsW
         EPaAH9zPyktn4uOylN0yZVgZcxjEAkfXEFKVxdaORwSHVo/abuH0yLvsdg2S6ghgbLxO
         vQhNo2aY20g71mBG4mAp3DCuGUyKIQRmAIoV1w/yzgBmf+JcmD7t3zktne/ve10eU6nW
         4P7gAvvEg6dcP4DC0yNa2v3uOrh5dfGq5qAkGDXbG/eiGLYlmonRNI/meQ1VZSbuOM8a
         LuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=vfvtNmIujY9iP2g9Fvil0LCOBoZfAhIy/2m8ioeQH38=;
        b=ei6yskcSo7mq63JdhvpniMF5RuS5l9D06zPEav0DiGA0UwyEhHK8kIj2SfAeicjcRI
         Y5gcMxgm0MC5gqAnJcA2NFaQz8hOwUSQAkvKFfqcEooVBpi9+ApLwHNWFyj+VF2t2f6L
         Z/dXOK2X2ByT1OLXYUD8ON0APFR5o+ZYj4chU7jCCx33wSg1eMNAGJFPilpnTGJ7kAO/
         LFDDBaZcbXaoGpxJXtMCdTG+fKiTwwBBRRGA2YbwSK4RWSK8WbFWly1Jrvlx4zZvbPVi
         g4i5+W9v071hS1XrdTtLCbmELcpCZGMpjoAQ2ys/vzk/VVncjpHWkOfTI61xfWKw6DxU
         2xUA==
X-Gm-Message-State: AOUpUlE2VnYwbo8OqYFGGioZ11hrT3/ZXONbZb5O5RoyUGYZOmi3Q3xR
        WL3uGp8+CbPlLzrv8Okujf3v2N6fsQlF64gtzgUUjgQ4mpCQGN34yF83ZVdn7INhjfsi7dnwYoE
        dm7MME40uTouK/CXYcznIYthtKbti/rMBYAX/9jgAGLz7n0gwTTly5WZeTKwz
X-Google-Smtp-Source: AA+uWPxUlgeCDnETVokeAeYT7iP6pYUwjsAQwYfj7pFx8IqyUwrpV7GzmSbjqjX47ls20n5PzJNnARUmheg9
X-Received: by 2002:a6b:6518:: with SMTP id z24-v6mr2860629iob.20.1531942337758;
 Wed, 18 Jul 2018 12:32:17 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:52 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com>
Message-Id: <20180718193156.47365-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180718193156.47365-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 06/10] diff.c: add a blocks mode for moved code detection
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new "blocks" mode provides a middle ground between plain and zebra.
It is as intuitive (few colors) as plain, but still has the requirement
for a minimum of lines/characters to count a block as moved.

Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
 (https://public-inbox.org/git/87o9j0uljo.fsf@evledraar.gmail.com/)
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |  8 ++++--
 diff.c                         |  6 +++--
 diff.h                         |  5 ++--
 t/t4015-diff-whitespace.sh     | 49 ++++++++++++++++++++++++++++++++--
 4 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.tx=
t
index e3a44f03cdc..ba56169de31 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -276,10 +276,14 @@ plain::
 	that are added somewhere else in the diff. This mode picks up any
 	moved line, but it is not very useful in a review to determine
 	if a block of code was moved without permutation.
-zebra::
+blocks::
 	Blocks of moved text of at least 20 alphanumeric characters
 	are detected greedily. The detected blocks are
-	painted using either the 'color.diff.{old,new}Moved' color or
+	painted using either the 'color.diff.{old,new}Moved' color.
+	Adjacent blocks cannot be told apart.
+zebra::
+	Blocks of moved text are detected as in 'blocks' mode. The blocks
+	are painted using either the 'color.diff.{old,new}Moved' color or
 	'color.diff.{old,new}MovedAlternative'. The change between
 	the two colors indicates that a new block was detected.
 dimmed_zebra::
diff --git a/diff.c b/diff.c
index d1bae900cdc..95c51c0b7df 100644
--- a/diff.c
+++ b/diff.c
@@ -271,6 +271,8 @@ static int parse_color_moved(const char *arg)
 		return COLOR_MOVED_NO;
 	else if (!strcmp(arg, "plain"))
 		return COLOR_MOVED_PLAIN;
+	else if (!strcmp(arg, "blocks"))
+		return COLOR_MOVED_BLOCKS;
 	else if (!strcmp(arg, "zebra"))
 		return COLOR_MOVED_ZEBRA;
 	else if (!strcmp(arg, "default"))
@@ -278,7 +280,7 @@ static int parse_color_moved(const char *arg)
 	else if (!strcmp(arg, "dimmed_zebra"))
 		return COLOR_MOVED_ZEBRA_DIM;
 	else
-		return error(_("color moved setting must be one of 'no', 'default', 'zeb=
ra', 'dimmed_zebra', 'plain'"));
+		return error(_("color moved setting must be one of 'no', 'default', 'blo=
cks', 'zebra', 'dimmed_zebra', 'plain'"));
 }
=20
 int git_diff_ui_config(const char *var, const char *value, void *cb)
@@ -903,7 +905,7 @@ static void mark_color_as_moved(struct diff_options *o,
=20
 		block_length++;
=20
-		if (flipped_block)
+		if (flipped_block && o->color_moved !=3D COLOR_MOVED_BLOCKS)
 			l->flags |=3D DIFF_SYMBOL_MOVED_LINE_ALT;
 	}
 	adjust_last_block(o, n, block_length);
diff --git a/diff.h b/diff.h
index d29560f822c..7bd4f182c33 100644
--- a/diff.h
+++ b/diff.h
@@ -208,8 +208,9 @@ struct diff_options {
 	enum {
 		COLOR_MOVED_NO =3D 0,
 		COLOR_MOVED_PLAIN =3D 1,
-		COLOR_MOVED_ZEBRA =3D 2,
-		COLOR_MOVED_ZEBRA_DIM =3D 3,
+		COLOR_MOVED_BLOCKS =3D 2,
+		COLOR_MOVED_ZEBRA =3D 3,
+		COLOR_MOVED_ZEBRA_DIM =3D 4,
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index ddbc3901385..e54529f026d 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1223,7 +1223,7 @@ test_expect_success 'plain moved code, inside file' '
 	test_cmp expected actual
 '
=20
-test_expect_success 'detect permutations inside moved code -- dimmed_zebra=
' '
+test_expect_success 'detect blocks of moved code' '
 	git reset --hard &&
 	cat <<-\EOF >lines.txt &&
 		long line 1
@@ -1271,6 +1271,50 @@ test_expect_success 'detect permutations inside move=
d code -- dimmed_zebra' '
 	test_config color.diff.newMovedDimmed "normal cyan" &&
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
+	git diff HEAD --no-renames --color-moved=3Dblocks --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,16 +1,16 @@<RESET>
+	<MAGENTA>-long line 1<RESET>
+	<MAGENTA>-long line 2<RESET>
+	<MAGENTA>-long line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	 line 6<RESET>
+	 line 7<RESET>
+	 line 8<RESET>
+	 line 9<RESET>
+	<CYAN>+<RESET><CYAN>long line 1<RESET>
+	<CYAN>+<RESET><CYAN>long line 2<RESET>
+	<CYAN>+<RESET><CYAN>long line 3<RESET>
+	<CYAN>+<RESET><CYAN>long line 14<RESET>
+	<CYAN>+<RESET><CYAN>long line 15<RESET>
+	<CYAN>+<RESET><CYAN>long line 16<RESET>
+	 line 10<RESET>
+	 line 11<RESET>
+	 line 12<RESET>
+	 line 13<RESET>
+	<MAGENTA>-long line 14<RESET>
+	<MAGENTA>-long line 15<RESET>
+	<MAGENTA>-long line 16<RESET>
+	EOF
+	test_cmp expected actual
+
+'
+
+test_expect_success 'detect permutations inside moved code -- dimmed_zebra=
' '
+	# reuse setup from test before!
+	test_config color.diff.oldMoved "magenta" &&
+	test_config color.diff.newMoved "cyan" &&
+	test_config color.diff.oldMovedAlternative "blue" &&
+	test_config color.diff.newMovedAlternative "yellow" &&
+	test_config color.diff.oldMovedDimmed "normal magenta" &&
+	test_config color.diff.newMovedDimmed "normal cyan" &&
+	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
+	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
 	git diff HEAD --no-renames --color-moved=3Ddimmed_zebra --color >actual.r=
aw &&
 	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1669,7 +1713,8 @@ test_expect_success '--color-moved treats adjacent bl=
ocks as separate for MIN_AL
 	7charsA
 	EOF
=20
-	git diff HEAD --color-moved=3Dzebra --color --no-renames | grep -v "index=
" | test_decode_color >actual &&
+	git diff HEAD --color-moved=3Dzebra --color --no-renames >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/bar b/bar<RESET>
 	<BOLD>--- a/bar<RESET>
--=20
2.18.0.233.g985f88cf7e-goog

