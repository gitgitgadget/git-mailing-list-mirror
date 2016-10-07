Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEED320986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbcJGSRJ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 7 Oct 2016 14:17:09 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:54883 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932269AbcJGSRH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:17:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 9F8D2100054
        for <git@vger.kernel.org>; Fri,  7 Oct 2016 18:17:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id urRAiSDPu72r for <git@vger.kernel.org>;
        Fri,  7 Oct 2016 18:17:05 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 8F6CE80035
        for <git@vger.kernel.org>; Fri,  7 Oct 2016 18:17:05 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Fri, 7 Oct 2016 18:17:05 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Fri, 7 Oct 2016 18:17:05 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Uninitialized submodules as symlinks
Thread-Topic: Uninitialized submodules as symlinks
Thread-Index: AdIgxgX2aZUXw1O6SWms0VMYgKmgtQ==
Date:   Fri, 7 Oct 2016 18:17:05 +0000
Message-ID: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Presently, uninitialized submodules are materialized in the working tree as empty directories.  We would like to consider having them be symlinks.  Specifically, we'd like them to be symlinks into a FUSE filesystem which retrieves files on demand.

We've actually already got a FUSE filesystem written, but we use a different (semi-manual) means to connect it to the initialized submodules.  We hope to release this FUSE filesystem as free software at some point soon, but we do not yet have a fixed schedule for doing so.  Having to run a command to create the symlink-based "union" filesystem is not optimal (since we have to re-run it every time we initialize or deinitialize a submodule).

But if the uninitialized submodules could be symlinks into the FUSE filesystem, we wouldn't have this problem.  This solution isn't necessarily FUSE-specific -- perhaps someone would want copies of the same submodule in multiple repos, and would want to save disk space by having all copies point to the same place.  So the symlinks would be configured by a per-submodule config variable.

Naturally, this would require some changes to code that examines the working tree -- git status, git diff, etc.  They would have to report "unchanged" for submodules which were still symlinks to the configured location.  I have not yet looked at the implementation details beyond this.

Does this idea make any sense?  If I were to implement it (probably in a few months, but no official timeline yet), would patches be considered?
