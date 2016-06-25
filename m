Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EB441FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 01:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbcFYBOw (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 21:14:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33160 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbcFYBOw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 21:14:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3FA1FE4E;
	Sat, 25 Jun 2016 01:14:51 +0000 (UTC)
Date:	Sat, 25 Jun 2016 01:14:50 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: [RFC] gc: correct gc.autoPackLimit documentation
Message-ID: <20160625011450.GA14293@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I'm not sure if this is the best approach, or if changing
too_many_packs can be done without causing problems for
hosts of big repos.

-------8<-----
Subject: [PATCH] gc: correct gc.autoPackLimit documentation

I want to ensure there is only one pack in my repo to take
advantage of pack bitmaps.  Based on my reading of the
documentation, I configured gc.autoPackLimit=1 which led to
"gc --auto" constantly trying to repack on every invocation.

Update the documentation to reflect what is probably a
long-standing off-by-one bug in builtin/gc.c::too_many_packs:

	-	return gc_auto_pack_limit <= cnt;
	+	return gc_auto_pack_limit < cnt;

However, changing gc itself at this time may cause problems
for people who are already using gc.autoPackLimit=2 and
expect bitmaps to work for them.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/config.txt | 2 +-
 Documentation/git-gc.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e1b2e4..b0de3f1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1345,7 +1345,7 @@ gc.auto::
 	default value is 6700.  Setting this to 0 disables it.
 
 gc.autoPackLimit::
-	When there are more than this many packs that are not
+	When there at least this many packs that are not
 	marked with `*.keep` file in the repository, `git gc
 	--auto` consolidates them into one larger pack.  The
 	default	value is 50.  Setting this to 0 disables it.
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index fa15104..658612d 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -54,7 +54,7 @@ all loose objects are combined into a single pack using
 `git repack -d -l`.  Setting the value of `gc.auto` to 0
 disables automatic packing of loose objects.
 +
-If the number of packs exceeds the value of `gc.autoPackLimit`,
+If the number of packs matches or exceeds the value of `gc.autoPackLimit`,
 then existing packs (except those marked with a `.keep` file)
 are consolidated into a single pack by using the `-A` option of
 'git repack'. Setting `gc.autoPackLimit` to 0 disables
-- 
EW
