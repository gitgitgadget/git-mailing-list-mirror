Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0617D1F462
	for <e@80x24.org>; Thu, 23 May 2019 17:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfEWRni (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 13:43:38 -0400
Received: from smtp34.i.mail.ru ([94.100.177.94]:45562 "EHLO smtp34.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbfEWRnh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 13:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:To:From; bh=ocJQACdNnZ20tqJFkdCbg3q7yHAd3P1XjOkb4DNx4bE=;
        b=XQwBU+69viJBEp6ddf6E6N3eRMwG5a5hwctZs1UcmdzY4nJ4ThZXWaStaiONuOmhgCsB4f12LS2mkIXrkfKwd1M+EqFxooxOYZjSQWiqbtCRtGc8mWjJdH7/FJpGNjZ9RRb1w05G5f4XWCOT0X1W4a8Bc3Wc4j4AVcSn9havxcE=;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <odnoletkov@mail.ru>)
        id 1hTrkd-0005aI-1J
        for git@vger.kernel.org; Thu, 23 May 2019 20:43:35 +0300
From:   Maksim Odnoletkov <odnoletkov@mail.ru>
To:     git@vger.kernel.org
Subject: Problem using 'submodule.recurse'
Date:   Thu, 23 May 2019 18:42:14 +0100
Message-Id: <20190523174214.7447-1-odnoletkov@mail.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp34.i.mail.ru; auth=pass smtp.auth=odnoletkov@mail.ru smtp.mailfrom=odnoletkov@mail.ru
X-77F55803: BBE463BEF7A60BD05A78504BD2AC29418E23A805F02667948CF70DC37648559C4F94B2BACF553B6A649E9F66BB9B2253
X-7FA49CB5: 0D63561A33F958A5157208FA24B6769C517C673E33ACDFDA05D95A5D25037B9B8941B15DA834481FA18204E546F3947C21E93C0F2A571C7BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF80095D1E57F4578A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224975765671F80319073AA81AA40904B5D9CF19DD082D7633A093541453170D46FCD81D268191BDAD3D78DA827A17800CE78B25CD4253D1D611CD04E86FAF290E2DBBC930A3941E20C675ECD9A6C639B01B78DA827A17800CE7CED881E36CABC998B2C112EF77284E0375ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC852301B74F4230CB9127F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-Mailru-Sender: 19DA870CD1633C32D2D4C917A6A43E73B5C1438A167F40A6965853A961C68739640D58BC46D090736E44F38C8238B89B3DDE9B364B0DF28904E2E3863F77217AF25921C611F62F88AE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a problem using 'submodule.recurse' config option. I want to use
it and at the same time fine-tune behavior for individual commands with
more specific options. For example to keep 'on-demand' behavior for
'fetch' and 'pull'.

 * If I put 'fetch.recurseSubmodules = on-demand' *below*
   'submodule.recurse = true' in the config, it kinda works - fetch will
   use 'on-demand' behavior.
 * But with this setup 'fetch' within 'pull' will always recurse
   unconditionally. Looking at the code this happens because 'pull'
   reads 'submodule.recurse' and seeing it in non-default state forces
   this behavior on underlying 'fetch'.

As far as I understand there is no way currently to have 'on-demand'
recursing for 'fetch' within the 'pull' when 'submodule.recurse' is on
(outside of using command line args). Also with described setup 'fetch'
behaves differently from 'pull' which is unexpected.

Looking at the code quickly I see two ways this can be resolved:

 * Add 'pull.recurseSubmodules' option so it can be used to explicitly
   override 'submodule.recurse' for 'pull'.
 * Don't force recursing behavior from 'pull' to underlying 'fetch' if
   it comes from config and not from command line args.
