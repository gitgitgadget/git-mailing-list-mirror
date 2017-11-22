Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B625520954
	for <e@80x24.org>; Wed, 22 Nov 2017 14:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbdKVOjH (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 09:39:07 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:41941 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdKVOjG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 09:39:06 -0500
Received: by mail-wm0-f46.google.com with SMTP id b189so10813737wmd.0
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IYS+zHObdtsIq34+7gBGtPSZOiTlHCToW7DhOLD2Xik=;
        b=BXO9EMAjMvoSAY83qYLhF56DfhCa9b4L+/QsSxhm5DcmCJW5N8hm0ITFBkAKPLmRiX
         FekjX0oWPFEW5jzv0hJ9Vs0MxyFzfGOdQnPzt294LAvoMbs8fzPSN0LobytpYPu9Sp+w
         BQbAbP2I7Oqh/JoHKyBka54gqhKU8QSclTT5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IYS+zHObdtsIq34+7gBGtPSZOiTlHCToW7DhOLD2Xik=;
        b=mcDoeyaj7+rnbarZr2n52NVJ/ycRvlt6JJn+o30ciDkpF63UE4umlZgivEX2JEajOK
         9F8G8tndSnPsi/aLWdhlUWg7V/39wmLpwZxMIuyt9XsWZAcKPpu6nJM7OK1sz7gHYzpL
         GNuDqm6XrQasAYQAs/F/MRODY4dqrSPJV22g9A85WxG/d9q1qYxOQRY5OjGNMrLJKQLQ
         s1UDE+alotOUqgaDR2YMg/SzTAmhgHa4SuIncE9yYMq95nP1LkBUOgmKjIOMnPBb/rhk
         kR84iJcbh1icIMpLuZlPGyAEEF7+gjawc/o8ucQ3OSkrFbJGFZ9jx5tldNBTeul5D9Mp
         Lsuw==
X-Gm-Message-State: AJaThX5b/8Evka0D1KTjU+BVVzEzkrmdGAROQIQ5Zxcwm0P5y99+9DRn
        m6S23pKN5fH/7YHs2i+xO/phdUx8I5g=
X-Google-Smtp-Source: AGs4zMZSKkyc5pPusU/mFywjHEYDqcibnB/bsKk6gWLjZV57QrBvCcnHKdTxhjpRvuDVO6CRrzTqBA==
X-Received: by 10.80.226.198 with SMTP id q6mr7786665edl.290.1511361545109;
        Wed, 22 Nov 2017 06:39:05 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id o64sm11506912edb.14.2017.11.22.06.39.04
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 06:39:04 -0800 (PST)
Date:   Wed, 22 Nov 2017 14:39:02 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Subject: Bisect marking new commits incorrectly
Message-ID: <20171122143902.GO20681@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In trying to do a bisect on the Git repository, I seem to have come
across surprising behavior where the order in which `git bisect` appears
to forget that previous commits were marked as new.

You can see this behaviour in the following commands, run on the Git
repository, where the order of the `git bisect new` commands affects the
results.

Case 1:

    $ git bisect start; git bisect old v2.15.0

    $ git bisect new 95a731ce
    Bisecting: 40 revisions left to test after this (roughly 5 steps)
    [934e330c9d0d12f7a0dd82b9699456c891e4dd4a] Merge branch 'ad/5580-unc-tests-on-cygwin' into maint

    $ git bisect new 14c63a9d
    Bisecting: 153 revisions left to test after this (roughly 7 steps)
    [421f21c98f8b515412ca683ae3743013a8b3bda2] Merge branch 'js/mingw-redirect-std-handles'

    $ for h in 95a731ce 14c63a9d; do git log -1 --format=oneline --decorate "$h"; done
    95a731ce92c7576d927f0d8a9b27c206cb58c2e6 (origin/maint) Almost ready for 2.15.1
    14c63a9dc093d6738454f6369a4f5663ca732cf7 (origin/master, origin/HEAD, refs/bisect/new) Sync with maint

Case 2:

    $ git bisect start; git bisect old v2.15.0

    $ git bisect new 14c63a9d
    Bisecting: 153 revisions left to test after this (roughly 7 steps)
    [421f21c98f8b515412ca683ae3743013a8b3bda2] Merge branch 'js/mingw-redirect-std-handles'

    $ git bisect new 95a731ce
    Bisecting: 40 revisions left to test after this (roughly 5 steps)
    [934e330c9d0d12f7a0dd82b9699456c891e4dd4a] Merge branch 'ad/5580-unc-tests-on-cygwin' into maint

    $ for h in 95a731ce 14c63a9d; do git log -1 --format=oneline --decorate "$h"; done
    95a731ce92c7576d927f0d8a9b27c206cb58c2e6 (origin/maint, refs/bisect/new) Almost ready for 2.15.1
    14c63a9dc093d6738454f6369a4f5663ca732cf7 (origin/master, origin/HEAD) Sync with maint

As you can see, in both cases, only the most recent "new" command
appears to have any effect.  I'd have expected that both commits would
have been marked as "new", and the bisect run would use both facts to
work out which commit is the target of the bisection.

This is using v2.15.0.  It's possibly relevant that 95a731ce is a
direct parent of 14c63a9d.

Is this a bug, or intentional behaviour?  Am I missing something that
means it's actually sensible to have Git silently discard some bisect
commands in this sort of circumstance?
