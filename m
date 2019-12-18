Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22D9C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 17:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17AF206D7
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 17:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfLRR6s convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 18 Dec 2019 12:58:48 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39002 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRR6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 12:58:48 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so1482122ioh.6
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 09:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1uQvNs7n8BYFecDMKYvaLcfBbmVumJkhLoZArOSeVeM=;
        b=okDs44Zs7ijZGXBhUh7uV7+DRynPDxeESqMouahVpL5N+lx+neFiATVqhms6mbdr4J
         wT6ekPfbccvVRSLPQuNCE+9Two6DCPxYZ3iLwSMWpDzRAFzRonuakp/AAg0A1ZNjb7o8
         r9Ld6/Ii8r8LEZ9DM80ssEFwZlGC5OpPAGFJ4XAPKrlNBE5QEvRg0w5g4KqPenIBwPGd
         0HpFMAZSpTpSnWKEmtUx1btodG3WseXGUZsloiTRHRPkphLLKlYyYlt0QoT78a0OXgxD
         Q798lRS2oQ/8Ka4PMiaBCpTi3x/uKbkNd4FM8UWQ1in3iCnKBONcM+uLPlCVRJ1/VZhf
         u3Yg==
X-Gm-Message-State: APjAAAUSa8YyguoQ+m02rK6mBWreC3yV75M0KguRd4Q8qKfYVEVq62lR
        q9dbQ+Pt05V+QVvWylYfus+IZwS6njKsR+KLmZI=
X-Google-Smtp-Source: APXvYqwsTWeBpSjqNGkZ8HwGlzhgdAIFzRvAxZ1k9a7lQL8BtADfRX73bkfldidG7ZfFc9JCLVEnL5LPi4TfzuVkto0=
X-Received: by 2002:a05:6638:41d:: with SMTP id q29mr3481792jap.128.1576691927815;
 Wed, 18 Dec 2019 09:58:47 -0800 (PST)
MIME-Version: 1.0
References: <CAPyFy2AsmaxU-BDf_teZJE5hiaVpTSZc8fftnuXPb_4-j7j5Fw@mail.gmail.com>
 <D4C58338-10C6-4E5A-BF1F-F48EC2EBDAD5@icloud.com>
In-Reply-To: <D4C58338-10C6-4E5A-BF1F-F48EC2EBDAD5@icloud.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Wed, 18 Dec 2019 05:23:06 -0500
Message-ID: <CAPyFy2AKSVQJtSY0RNgJDJ5k1P=-gjNXVjDgPh+CdghhZtJXDw@mail.gmail.com>
Subject: Re: git-subtree split misbehaviour with a commit having empty ls-tree
 for the specified subdir
To:     Tom Clarkson <tqclarkson@icloud.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Dec 2019 at 19:17, Tom Clarkson <tqclarkson@icloud.com> wrote:
>
> The algorithm I am looking at to replace the file based mainline detection is
>
>  - If subtree root is unknown (as on the initial split), everything is mainline.
>
>  - If subtree root is reachable and mainline root is not, it’s a subtree commit
>
>  - Otherwise, treat as mainline. This will also pick up commits from other subtrees but they hopefully won’t contain the subtree folder. I don’t think there is an unambiguous way to distinguish a subtree merge from a regular merge - the message produced is pretty generic. It may be possible to check reachability of all known subtrees, but that adds a fair bit of complexity.
>
> That leaves us with the question of how to record the empty mainline commits. The most correct result for your repro is probably four commits (add/delete everything/restore/modify), but I can see that falling over in a scenario where deleting a subtree is more like unlinking a library than editing that library to do nothing.
>
> Is it sufficiently correct for your scenario to treat ‘restore file1’ as the initial subtree commit?

My reproduction scenario is really a demonstration of the real issue I
encountered. Running the initial "subtree split" on the real repo
takes about 40 minutes so I wanted something trivial that shows the
same issue. In the demonstration case (i.e., actually removing and
readding the subtree) I think it's reasonable to start with the commit
that added it back.

Overall I think your proposed algorithm is reasonable (even though I
think it won't address some of the cases in our repo). Will your
algorithm allow us to pass $dir to git rev-list, for the initial
split?

My actual issue stems from the way svn2git converted some odd svn
history, and is described in more detail on the freebsd-git mailing
list at https://lists.freebsd.org/pipermail/freebsd-git/2019-November/000218.html.

Perhaps we can have some command-line options to provide metadata for
cases that cannot be inferred? The cases in our repo come from svn2git
creating subtree merges to represent updates from vendor code. AFAIK
these should be basically identical to what subtree creates, except
that we don't have any of the metadata it adds.

For a concrete example (from the repo at
https://github.com/freebsd/freebsd), 7f3a50b3b9f8 is a mainline commit
that added a new subtree, from 9ee787636908. I think that if I could
inform subtree split that 9ee787636908 is the root it would work for
me.
