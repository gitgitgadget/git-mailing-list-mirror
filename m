Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CC11F4B6
	for <e@80x24.org>; Sat, 29 Jun 2019 19:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfF2TQB (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 15:16:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34860 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfF2TQB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 15:16:01 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BFBF51F461;
        Sat, 29 Jun 2019 19:16:00 +0000 (UTC)
Date:   Sat, 29 Jun 2019 19:16:00 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Janos Farkas <chexum@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 2/1] repack: warn if bitmaps are explicitly enabled with keep
 files
Message-ID: <20190629191600.nipp2ut37xd3mx56@dcvr>
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
 <875zow8i85.fsf@evledraar.gmail.com>
 <20190623180226.GA1100@sigill.intra.peff.net>
 <20190623180825.3ospajjgat3clwiu@dcvr>
 <20190623224244.GB1100@sigill.intra.peff.net>
 <20190628070211.hfweqcons6c6gy52@dcvr>
 <87zhm26uq9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhm26uq9.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> I have the feedback I posted before this patch in
> https://public-inbox.org/git/874l4f8h4c.fsf@evledraar.gmail.com/
> 
> In particular "b" there since "a" is clearly more work. I.e. shouldn't
> we at least in interactive mode on a "gc" print something about skipping
> what we'd otherwise do.
> 
> Maybe that's tricky with the gc.log functionality, but I think we should
> at least document this before the next guy shows up with "sometimes my
> .bitmap files aren't generated...".

I'm not sure if the warning should be present by default;
because we'll silently stop using bitmaps, now.  But warning
if '-b' is specified seems right:

-------8<----------
Subject: [PATCH] repack: warn if bitmaps are explicitly enabled with keep
 files

If a user explicitly enables bitmaps, we should warn if .keep
files exist or are specified via --keep-pack

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/repack.c  |  8 ++++++++
 t/t7700-repack.sh | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 73250b2431..b1eeee88a7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -359,7 +359,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				 is_bare_repository() &&
 				 keep_pack_list.nr == 0 &&
 				 !has_pack_keep_file();
+	} else if (write_bitmaps > 0) {
+		if (keep_pack_list.nr)
+			fprintf(stderr,
+				_("WARNING: --keep-pack is incompatible with bitmaps\n"));
+		if (has_pack_keep_file())
+			fprintf(stderr,
+				_("WARNING: .keep files are incompatible with bitmaps\n"));
 	}
+
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 0e9af832c9..839484c7dc 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -249,4 +249,20 @@ test_expect_success 'no bitmaps created if .keep files present' '
 	test_must_be_empty actual
 '
 
+test_expect_success '-b warns with .keep files present' '
+	pack=$(ls bare.git/objects/pack/*.pack) &&
+	test_path_is_file "$pack" &&
+	keep=${pack%.pack}.keep &&
+	>"$keep" &&
+	git -C bare.git repack -adb 2>err &&
+	test_i18ngrep -F ".keep files are incompatible" err &&
+	rm -f "$keep"
+'
+
+test_expect_success '-b warns with --keep-pack specified' '
+	keep=$(cd bare.git/objects/pack/ && ls *.pack) &&
+	git -C bare.git repack -adb --keep-pack="$keep" 2>err &&
+	test_i18ngrep -F "keep-pack is incompatible" err
+'
+
 test_done
-- 
EW
