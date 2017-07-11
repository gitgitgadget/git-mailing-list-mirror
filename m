Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913C3202DD
	for <e@80x24.org>; Tue, 11 Jul 2017 03:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755190AbdGKDcn (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 23:32:43 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34832 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755118AbdGKDcn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 23:32:43 -0400
Received: by mail-pg0-f54.google.com with SMTP id j186so59279254pge.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 20:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vI62rzjL8du/4OQLpmpSGKPKIpVt4vY34YufXTGMkqk=;
        b=bGAKCkE+gs4p/9miWLW6Em+rT/bEoh4E7TC9KHRsiZl1DlQza8xCsVbpFaZJTTYg3M
         lYXSRIFHWts3xTVBnkE0C2ZyszZ+Thgsh+gLG69GCO/mURJ8Tvq5qp5NuWt0L139nmEC
         IMqWj7+o/Cwny20cncN4LJgFSRbmwCy5S48cBthpqAp/Q70uKkdegeNz5eMWLulaHPNG
         h8zXIp5ToOdacPYU2SgEDg0Ipf+UGRW2vWF+wLBCuG0oDZvBsAt8EzOoCXN9EZDD9tJ8
         p3OaL/ydpD78rxextIjsmGZq6EZq/9l1O8zAQC2eIkOnAF6/rwJbGvremizbGr+t2Jey
         xJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vI62rzjL8du/4OQLpmpSGKPKIpVt4vY34YufXTGMkqk=;
        b=WSsQRhYmWUlAeuIn2NLpJjuyNn6qK+DksUjdKPQ7aDaw3J+M1qa9NM4Y6c2x2TC+XN
         ZZemzzXe+QZ1g8pd/3t5by91mFdKnbUvZyycLVwE5Y19Z2dyl/aJPU7yfPf4zqsjVrdw
         tRa6pmktFcVPfo5Z/l8Gxq4co7WktZTl5ant2NyX6jhYhjhgMvUbd/yK7T4SX2mk40l7
         Kt5HBcqDBAbJ5859GsEVDDTD+Clf2zRg3A8NfUHYMS2C0ryLauoYjyKUdDYyufS3fyi0
         taLBiD37/FOjFzmVEx/llaNN+Vfj/uejOQH4/lfo8wir3EfAvAb2irOQNJvrovHYcP+S
         FpfQ==
X-Gm-Message-State: AIVw112OgX+YaI2Rs3YpuYo/z7UgQ/1QTgvHYeLnzC8HdhatW1NMQnVi
        YTkenM/U6MWANwM6
X-Received: by 10.99.5.130 with SMTP id 124mr17777200pgf.51.1499743962028;
        Mon, 10 Jul 2017 20:32:42 -0700 (PDT)
Received: from lenny.localdomain ([136.24.158.154])
        by smtp.gmail.com with ESMTPSA id k19sm18596892pfk.16.2017.07.10.20.32.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jul 2017 20:32:41 -0700 (PDT)
Date:   Mon, 10 Jul 2017 20:32:36 -0700
From:   Kenneth Hsu <kennethhsu@gmail.com>
To:     git@vger.kernel.org
Subject: bug: HEAD vs. head on case-insensitive filesystems
Message-ID: <20170711033236.GA11492@lenny.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not sure what the general consensus is regarding the use of "head"
vs. "HEAD" on case insensitive filesystems, but it appears that some
confusing behavior (bug?) may have arisen.

To summarize, "HEAD" and "head" may resolve to different revisions when
in a worktree.  The following example was generated using git version
2.13.1 for Mac (HFS+):

$ git --version
git version 2.13.1
$ git init
Initialized empty Git repository in /Users/ken/Desktop/test/.git/

$ echo "Hello" > hello.txt
$ git add . && git commit -qm "Add hello."

$ echo "Bye" > bye.txt
$ git add . && git commit -qm "Add bye."

Note that at this point, both HEAD and head (correctly) resolve to the
same revision:

$ git rev-parse HEAD
4a71a947fb683698f80f543f9cd27acd066e2659

$ git rev-parse head
4a71a947fb683698f80f543f9cd27acd066e2659

However, if we create (and cd into) a worktree based on "master~", "HEAD" and
"head" resolve to _different_ revisions:

$ git worktree add -b feature/branch ../branch master~
Preparing ../branch (identifier branch)
HEAD is now at f752545 Add hello.
$ cd ../branch/

$ git rev-parse HEAD
f7525451640f6f5e8842cc00b6639c80558dd6c2

$ git rev-parse head
4a71a947fb683698f80f543f9cd27acd066e2659

$ git rev-parse master
4a71a947fb683698f80f543f9cd27acd066e2659

$ git rev-parse master~
f7525451640f6f5e8842cc00b6639c80558dd6c2

$ git rev-parse feature/branch
f7525451640f6f5e8842cc00b6639c80558dd6c2

Note that "HEAD" resolves to the same revision as "master~" and
"feature/branch" (which seems correct since that is what the worktree
was based on), while "head" resolves to the same revision as "master".

This appears to affect other case-insensitive filesystems (Windows) as
well.  See the following bug report:

https://github.com/git-for-windows/git/issues/1225

I'm not sure if the behavior is well-defined when using "head", but the
above example may illustrate a case where users should not assume that
they resolve to the same thing.

Thanks.

