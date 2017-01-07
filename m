Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6C9205C9
	for <e@80x24.org>; Sat,  7 Jan 2017 08:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754850AbdAGIsr (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 03:48:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:36396 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752103AbdAGIsq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 03:48:46 -0500
Received: (qmail 29552 invoked by uid 109); 7 Jan 2017 08:48:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 08:48:45 +0000
Received: (qmail 23742 invoked by uid 111); 7 Jan 2017 08:49:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 03:49:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Jan 2017 03:48:44 -0500
Date:   Sat, 7 Jan 2017 03:48:44 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [BUG] push sometimes omits status table when remote dies
Message-ID: <20170107084843.w3psqobh4yq6t6zb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I run t5504 under heavy load, it sometimes fails tests 8 and 9, which
make a broken push to the remote. The failure looks like this:

    expecting success: 
            rm -rf dst &&
            git init dst &&
            (
                    cd dst &&
                    git config transfer.fsckobjects true
            ) &&
            test_must_fail git push --porcelain dst master:refs/heads/test >act &&
            test_cmp exp act
    
    Initialized empty Git repository in /var/ram/git-stress/root-13/trash directory.t5504-fetch-receive-strict/dst/.git/
    remote: fatal: object of unexpected type        
    error: failed to push some refs to 'dst'
    --- exp 2017-01-07 08:44:24.465771756 +0000
    +++ act 2017-01-07 08:44:24.493771755 +0000
    @@ -1,2 +0,0 @@
    -To dst
    -!      refs/heads/master:refs/heads/test       [remote rejected] (unpacker error)
    not ok 9 - push with transfer.fsckobjects

So it looks like we correctly fail the push, but the expected porcelain
output is missing. I'm _guessing_ what happens is that the local
git-push sees SIGPIPE writing to the remote side, and dies before it
gets a chance to write the message.

I'm not sure if this is something we should be fixing, or if the test is
simply a bit flaky (and we should work around it).

-Peff
