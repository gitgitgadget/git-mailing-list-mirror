Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C23C202B1
	for <e@80x24.org>; Fri,  7 Jul 2017 00:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbdGGAcl (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 20:32:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48940 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753081AbdGGAcl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 20:32:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 15E92202AE;
        Fri,  7 Jul 2017 00:32:40 +0000 (UTC)
Date:   Fri, 7 Jul 2017 00:32:39 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 6/6] reflog-walk: stop using fake parents
Message-ID: <20170707003239.GA13431@untitled>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080904.idlpm6ecslzfbm75@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170705080904.idlpm6ecslzfbm75@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not sure why, but this is causing t1414.8 failures on 32-bit
x86 with the latest pu with Debian jessie (oldstable).

Reverting this (beafb2c62947a6d4a97b9c3baf99fe62ec8e830f) in pu
seems to fix the test for me.

+Cc: Ramsay since he also had a 32-bit environment.

--8<--
ok 7 - --parents shows true parents

expecting success: 
	{
		do_walk HEAD &&
		do_walk side
	} >expect &&
	do_walk HEAD side >actual &&
	test_cmp expect actual

--- expect	2017-07-07 00:30:57.796325232 +0000
+++ actual	2017-07-07 00:30:57.796325232 +0000
@@ -3,6 +3,8 @@
 HEAD@{2} checkout: moving from master to side
 HEAD@{3} commit: two
 HEAD@{4} commit (initial): one
-side@{0} commit (merge): Merge branch 'master' into side
-side@{1} commit: three
-side@{2} branch: Created from HEAD^
+HEAD@{0} commit (merge): Merge branch 'master' into side
+HEAD@{1} commit: three
+HEAD@{2} checkout: moving from master to side
+HEAD@{3} commit: two
+HEAD@{4} commit (initial): one
not ok 8 - walking multiple reflogs shows both
#	
#		{
#			do_walk HEAD &&
#			do_walk side
#		} >expect &&
#		do_walk HEAD side >actual &&
#		test_cmp expect actual
#	

expecting success: 
	head=$(git rev-parse HEAD) &&
	one=$(git rev-parse one) &&
	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
	echo "$head $one $ident	broken reflog entry" >>.git/logs/HEAD &&

	echo $one >expect &&
	git log -g --format=%H -1 >actual &&
	test_cmp expect actual

ok 9 - walk prefers reflog to ref tip
