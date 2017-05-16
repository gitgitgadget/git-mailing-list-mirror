Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B951FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbdEPRRG (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:17:06 -0400
Received: from kitenet.net ([66.228.36.95]:37042 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752214AbdEPRRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:17:03 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 May 2017 13:17:03 EDT
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1494954628; bh=/0KajLr+vCVCgp+Qa4aGAAfkFdQzgwE4YfWN35/EIlU=;
        h=Date:From:To:Cc:Subject:From;
        b=Gn0UTbAb9BOhNz2O/4wXfkHSG0zNNVXipyMEMZKU+YSSk6VTHcFg7g1Ce8THOeGIX
         LwEB8bU9py5OCXhNMzKI5pfm0aiuet6t817OsVkOJJfPqv7Gql2rKpsr7G5WOUEw6k
         GWUC4rL717q08vvQlYT7r9NKT5MnkZLgAimlB3Sk=
Date:   Tue, 16 May 2017 13:10:28 -0400
From:   Joey Hess <id@joeyh.name>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Peter Simons <simons@cryp.to>
Subject: reversion in GIT_COMMON_DIR refs path
Message-ID: <20170516171028.5eagqr2sw5a2i77d@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bisecting this test suite failure
https://git-annex.branchable.com/git-annex_in_nixpkgs_fails_with_git-2.13.0/
I landed on commit f57f37e2e1bf11ab4cdfd221ad47e961ba9353a0 to git.

It seems that changed resolving refs paths when GIT_DIR and GIT_COMMON_DIR
are both set. While before refs were looked for in GIT_COMMON_DIR,
now they're not.

Test case:

#!/bin/sh
set -e
set -x
rm -rf testdir
git init testdir
cd testdir
echo 1 > foo
git add foo
git commit -m add
mkdir dummy
mkdir dummy/overlay
cp .git/index .git/HEAD dummy/overlay
#cp .git/refs .git/packed-refs dummy/overlay -a
cd dummy
export GIT_COMMON_DIR=`pwd`/../.git
export GIT_DIR=`pwd`/overlay
git rev-parse --git-path refs/heads/master
git show refs/heads/master

This script succeeds with git 2.11.0, but with 2.13.0, it fails:

fatal: ambiguous argument 'refs/heads/master': unknown revision or path not in the working tree.

It seems to be failing to look up refs in GIT_COMMON_DIR.
Note that uncommenting the commented out line in the script, to copy the refs
into GIT_DIR, makes it succeed.

git rev-parse --git-path refs/heads/master shows the GIT_COMMON_DIR/refs path
still (as gitrepository-layout documents). So this reversion made
different parts of git disagreeing about the refs path.
