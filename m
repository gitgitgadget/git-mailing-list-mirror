Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2821F4B7
	for <e@80x24.org>; Wed, 15 May 2019 20:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEOUik (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 16:38:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37354 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfEOUik (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 16:38:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 04D361F461;
        Wed, 15 May 2019 20:38:39 +0000 (UTC)
Date:   Wed, 15 May 2019 20:38:39 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [WIP] repack leaving stale entries in objects/info/packs
Message-ID: <20190515203839.zixx23bwzeyto6a3@dcvr>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <20190514115047.oncvfq24fhnp64re@dcvr>
 <87ftphw7mv.fsf@evledraar.gmail.com>
 <20190515004551.emrxvboqemwnqh4g@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515004551.emrxvboqemwnqh4g@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've also noticed objects/info/packs contains stale entries
after repack/gc runs on current git.

Tried adding reprepare_packed_git before update_server_info,
but that didn't seem to work; so maybe something isn't cleared.
Might have time to investigate more this week, might not...

diff --git a/builtin/repack.c b/builtin/repack.c
index 67f8978043..ec46f2099a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -559,8 +559,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			prune_shallow(PRUNE_QUICK);
 	}
 
-	if (!no_update_server_info)
+	if (!no_update_server_info) {
+		reprepare_packed_git(the_repository);
 		update_server_info(0);
+	}
 	remove_temporary_files();
 
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 7411bf7fec..867d4fb0c7 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -71,6 +71,7 @@ test_expect_success 'gc --keep-largest-pack' '
 		git gc --keep-largest-pack &&
 		( cd .git/objects/pack && ls *.pack ) >pack-list &&
 		test_line_count = 2 pack-list &&
+		test_line_count = 2 .git/objects/info/packs &&
 		test_path_is_file $BASE_PACK &&
 		git fsck
 	)

