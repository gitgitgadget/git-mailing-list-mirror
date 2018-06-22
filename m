Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7551F516
	for <e@80x24.org>; Fri, 22 Jun 2018 01:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934306AbeFVB5w (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 21:57:52 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:47193 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934292AbeFVB5u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 21:57:50 -0400
Received: by mail-io0-f202.google.com with SMTP id e6-v6so1475455iob.14
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=RQwkt2pXu8+ZMqid7NJwkaH+HAAxScqSJl9mZMznQrk=;
        b=hflpax9JcM7tay8uHecoWhlDN2qKnlFkzOwvgwDZHn090sHeMi4WzyRVJzXHqQMuLs
         h9mic0s+cXsUH/STKm8AyGgfaaVMzjIhDYdhD7kW4hNZFG8aYH4b9prykN1ITF0R0OKc
         GVxcEx0qiEZRgWzSY+2FHYu4AlLEraB0h3FGUXNSgp0iHBAjbn5MWhd1cfK78+W4un9S
         BP/at6Id5l7TOtdzBBNr1AJkBjf8+SKoZ/rR1gYFkmApFMPGM0AoZtnt2XBIbppL7EtK
         I+liMx+/+9ydLyEJqic68Qb3Gtf1dbsn9d6DKJIKBqIbpURU+J3LIkiXTO03Y5cNL+2K
         BAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=RQwkt2pXu8+ZMqid7NJwkaH+HAAxScqSJl9mZMznQrk=;
        b=dDA1e9sl8rODnXzLl2AFalq0ELgTFpOIDFMzbwOvyTZDXtECGfrfpkMLtMyYuhfPMr
         n628IcxRg3iYYlGtDbhTOZ24CH5EFrbKZ7TTwGy1wuTsafKi8MLC3DKDtG6H5JHYMc6i
         k+uqO36NLrBu6l0LNlz2Q+0Y0hcHnxAuibsA0ExTdxS3ubSrPXxQAi0bHOJwkPUiZrIZ
         7XeNjBvR/H8w4Ex7mZZ32JhOXNjueKUZ93LaI/d4BSsE+F4E5OxWi2oWcLu/OiFt1g+2
         1wH1NwhpRl9y1d3/Fz33PVheUyUPoIkkocfgyZXd+xIs35Kpc4//tXalVi0oHd4jhZ4r
         FJIA==
X-Gm-Message-State: APt69E3R1653SncmEq67vzXQu5qey4upqw7Luz6CjNuU5xvjupM8P9Ul
        mF9saC9H7c4tfoW/tsLhLtjUEas7ugWN
X-Google-Smtp-Source: ADUXVKIvuKBN2oYBsKMG6Buhor4r6ozG7nA/pImTshFulZzKZMMxcU6+REefxT6C11HkUTVvl5eQBd31MIja
X-Received: by 2002:a24:ac5:: with SMTP id 188-v6mr4114itw.50.1529632669362;
 Thu, 21 Jun 2018 18:57:49 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:57:22 -0700
In-Reply-To: <20180622015725.219575-1-sbeller@google.com>
Message-Id: <20180622015725.219575-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180622015725.219575-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v3 5/8] diff.c: add a blocks mode for moved code detection
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org,
        Junio C Hamano <gitster@pobox.com>
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
 t/t4015-diff-whitespace.sh     | 48 +++++++++++++++++++++++++++++++++-
 4 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.tx=
t
index 41064909ee4..2e20794f9ed 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -276,10 +276,14 @@ plain::
 	that are added somewhere else in the diff. This mode picks up any
 	moved line, but it is not very useful in a review to determine
 	if a block of code was moved without permutation.
-zebra::
+blocks:
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
index 2a1a21d3b7a..b9575901eb2 100644
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
index dedac472ca5..d8009597937 100644
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
index 17df491a3ab..45091abb192 100755
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
@@ -1271,6 +1271,52 @@ test_expect_success 'detect permutations inside move=
d code -- dimmed_zebra' '
 	test_config color.diff.newMovedDimmed "normal cyan" &&
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
+
+	git diff HEAD --no-renames --color-moved=3Dblocks --color |
+		grep -v "index" |
+		test_decode_color >actual &&
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
 	git diff HEAD --no-renames --color-moved=3Ddimmed_zebra --color |
 		grep -v "index" |
 		test_decode_color >actual &&
--=20
2.18.0.rc2.346.g013aa6912e-goog

