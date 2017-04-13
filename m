Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713CD20960
	for <e@80x24.org>; Thu, 13 Apr 2017 17:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754752AbdDMRbm (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 13:31:42 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:51247 "EHLO
        homiemail-a22.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755032AbdDMRbl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Apr 2017 13:31:41 -0400
Received: from homiemail-a22.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTP id 6A22B114066;
        Thu, 13 Apr 2017 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:content-type:mime-version:
        content-transfer-encoding; s=novalis.org; bh=PeY0MiB5nC4wMLZLcJ2
        i2p+qiKc=; b=qtQg67u20U15VGD3rSNQazZPD39J2kBX27tlK/AHr8FkC7TAQ9P
        aVJ7qRArgGDUbcWV9Agnr78zzIAhKzW6WaNErQmaglIwoOYMCIka1c+61gBIehp2
        lTwj55B3xDlsz7osQDotMaEXYAe6ZFuvWIsZpv97NFCPFVdfLNL96Iko=
Received: from corey (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTPSA id D8C92114065;
        Thu, 13 Apr 2017 10:31:39 -0700 (PDT)
Message-ID: <1492104698.1527.79.camel@novalis.org>
Subject: Simultaneous gc and repack
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Date:   Thu, 13 Apr 2017 13:31:38 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git gc locks the repository (using a gc.pid file) so that other gcs
don't run concurrently. But git repack doesn't respect this lock, so
it's possible to have a repack running at the same time as a gc.  This
makes the gc sad when its packs are deleted out from under it with:
"fatal: ./objects/pack/pack-$sha.pack cannot be accessed".  Then it
dies, leaving a large temp file hanging around.

Does the following seem reasonable?

1. Make git repack, by default, check for a gc.pid file (using the same
logic as git gc itself does).
2. Provide a --force option to git repack to ignore said check.
3. Make git gc provide that --force option when it calls repack under
its own lock.

This came up because Gitlab runs a repack after every N pushes and a gc
after every M commits, where M >> N.  Sometimes, when pushes come in
rapidly, the repack catches the still-running gc and the above badness
happens.  At least, that's my understanding: I don't run our Gitlab
servers, but I talked to the person who does and that's what he said.

Of course, Gitlab could do its own locking, but the general approach
seems like it would help other folks too.
