Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF161F600
	for <e@80x24.org>; Sun, 23 Jul 2017 14:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbdGWO71 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 10:59:27 -0400
Received: from mail.mathema.de ([195.110.18.10]:56744 "EHLO mail.mathema.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbdGWO70 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 10:59:26 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jul 2017 10:59:26 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.mathema.de (Postfix) with ESMTP id 854311AC2A99
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 16:51:02 +0200 (CEST)
Received: from mail.mathema.de ([127.0.0.1])
        by localhost (mail.mathema.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1xqvbB0JngSo for <git@vger.kernel.org>;
        Sun, 23 Jul 2017 16:51:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.mathema.de (Postfix) with ESMTP id CE1A91AC2AF9
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 16:51:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail.mathema.de
Received: from mail.mathema.de ([127.0.0.1])
        by localhost (mail.mathema.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6MNTrrlCGLxM for <git@vger.kernel.org>;
        Sun, 23 Jul 2017 16:51:01 +0200 (CEST)
Received: from [192.168.178.20] (ppp-212-114-233-222.dynamic.mnet-online.de [212.114.233.222])
        by mail.mathema.de (Postfix) with ESMTPSA id 9EBA01AC2A99
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 16:51:01 +0200 (CEST)
To:     Git Mailing List <git@vger.kernel.org>
From:   Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Bug^Feature? fetch protects only current working tree branch
Message-ID: <cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathema.de>
Date:   Sun, 23 Jul 2017 16:50:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A `git fetch . origin/master:master` protects the currently checked out 
branch (HEAD) unless the `-u/--update-head-ok` is supplied. This avoids a
mismatch between the index and HEAD. BUT branches which are HEADs in other
working trees do not get that care - their state is silently screwed up.

Is this intended behaviour or and just an oversight while implementing
`git worktree`?


Steps to reproduce

    # setup

    git clone -b master $SOMETHING xtemp
    cd xtemp
    git reset --hard HEAD~5 # pretend to be back some time
    git worktree add ../xtemp-wt1
    git worktree add ../xtemp-wt2

    # test

    git fetch . origin/master:master
    
        fatal: Refusing to fetch into current branch refs/heads/master  of non-bare repository
        fatal: The remote end hung up unexpectedly

    # OK, current working tree is protected, try another one:

    git fetch . origin/master:xtemp-wt1

        From .
           b4d1278..6e7b60d  origin/master -> xtemp-wt1

    cd ../xtemp-wt1
    git status

        # admire messed up working tree here

    # The protection is really "current working tree", not "first/main working tree"!

    git fetch . origin/master:master

        From .
           b4d1278..6e7b60d  origin/master -> master

    cd ../xtemp
    git status

        # now it's messed up here too

    # Try with "--update-head-ok" but check first.

    cd ../xtemp-wt2

    git fetch . origin/master:xtemp-wt2

        fatal: Refusing to fetch into current branch refs/heads/xtemp-wt2 of non-bare repository
        fatal: The remote end hung up unexpectedly

    git fetch --update-head-ok . origin/master:xtemp-wt2
        
        From .
           b4d1278..6e7b60d  origin/master -> xtemp-wt2


