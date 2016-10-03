Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3869120987
	for <e@80x24.org>; Mon,  3 Oct 2016 21:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbcJCVLn (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:11:43 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36531 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbcJCVLm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:11:42 -0400
Received: by mail-oi0-f65.google.com with SMTP id h186so8181841oia.3
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=Tgx2LGSznL858zV3c5XZ6DIhT8eEkcpl5XSAn+LnKF8=;
        b=RCh+rrR0isaic1UuXI3JFH18qI+ShcaB7IlNoyM1IfZ4pMVhn5FobbOuRkBcB0EQzO
         OQHew25/TZ30n5FyEejsZt8H/n4tOXnOTdZ/P1V7mpiX45uqaMBx5RXiXPZYuFF9F/sA
         LBW9PwKnkTe5WSDdH+QOEOT4aA7okgBOmk+WjIC4j8simCym0+dgNE2kghsbGI/2YqDj
         VzJ0vbon8V4FwKG4QwCrD+kTMvGAZYJ0dthSNpzOId84uOA0X74nS7qclQtMIA6obEw+
         xsIMiv3MEyZuyB4h9rGKxDXU5OhejfD+PWagbnBwVhVLG7U1XwIjNcra6n7N5yvJaVBp
         +Eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=Tgx2LGSznL858zV3c5XZ6DIhT8eEkcpl5XSAn+LnKF8=;
        b=BWRduQfYFERNWdvSG8OFlxG1vxuS1vMep5Lt+X2IgRk45XQq3Pwg2ElSVicUK2ekHK
         sne0qDWaUWj51WpmulaSFOEoWq0pttusGsk4/2nLQTxUJkHBGWCrmO0bHpvScRUn4m2w
         QhJo6bwasya/JT48SJ8+TNUuio2UySScXwJ0GvJMTOpw430+Uli//SHcGWCpewxLX3yC
         1aNhbez/d9fJqL1tNPOrbXZOO+av2se4DFGEaSY7ByXS3E506CvNlWOZLaQl90jSjc7Y
         s6MRokSt50HpBlM15pBVSJTLv5GhAEajsbAQS0MEuN9UQX0gkrkBOnvoMmb0biAtbqgK
         XcNg==
X-Gm-Message-State: AA6/9Rn2n2jfd0Gg/Ud3htK3RdXDbtcvkOFjgTtYmqSiW5+llJhqy6fRIlRZTVqZYdkH6fddPJHAiKPMNWdNxg==
X-Received: by 10.157.43.124 with SMTP id f57mr47991otd.83.1475529096526; Mon,
 03 Oct 2016 14:11:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.21.198 with HTTP; Mon, 3 Oct 2016 14:11:36 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Oct 2016 14:11:36 -0700
X-Google-Sender-Auth: 7FwThxscbStWIwEDl1U3CoD4gXg
Message-ID: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
Subject: Slow pushes on 'pu' - even when up-to-date..
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This seems to be because I'm now on 'pu' as of a day or two ago in
order to test the abbrev logic, but lookie here:

    time git ls-remote ra.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux
    .. shows all the branches and tags ..
    real 0m0.655s
    user 0m0.011s
    sys 0m0.004s

so the remote is fast to connect to, and with network connection
overhead and everything, it's just over half a second. But then:

    time git push ra.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux

and it just sits there, and it's at 100% CPU the whole time, until it says:

    Everything up-to-date

    real 1m7.307s
    user 1m2.761s
    sys 0m0.475s

Whaa? It took a *minute* of CPU time to decide that everything was up-to-date?

That's just not right. The branch is entirely up-to-date:

    git rev-parse HEAD
    af79ad2b1f337a00aa150b993635b10bc68dc842

    git ls-remote ra.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux master
    af79ad2b1f337a00aa150b993635b10bc68dc842 refs/heads/master

so there should be no need for any history walking. But it sure is
doing *something*. A minute of CPU time on my machine is actually a
pretty damn big deal.

Looking at the trace, there's no IO - there's no back-and-forth about
"I have this, do you have it?" or anything like that. The system call
trace is just a lot of allocations, which I think means that "git
push" is walking a lot of objects but not doing anything useful.

I bisected it to commit 60cd66f "push: change submodule default to
check", which makes little sense since I have no submodules, but there
you go.. Apparently RECURSE_SUBMODULES_CHECK is just terminally
broken.

                Linus
