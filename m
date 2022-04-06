Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED6C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 15:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiDFPjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 11:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiDFPiP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 11:38:15 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971D92FC303
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 05:52:32 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id q11so2756710iod.6
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 05:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q9zykDOCPLrc59G9qom+2kLHbADW/Yopw5OXwca9GxU=;
        b=aOHMrhLuRio1NGiMz3PHI10quvKj/QhunRBQ8ciClusmrqGkXftkbO6Fj28pTPS3Eq
         kkJWCLUCBpEUbSl64kml4qgLCERbWa8JJkEkljdKeMVQ8pBGY8/2kIkTpRMNZTs/tT4m
         BwMM6IL5SXQnbpahGxK7rIYWHMoIVG3BbhTAXeMF1VuS4woyNrLag/I9Oi5/o3WTRIpX
         WpTK1M8KqT0torjrGyrNsl2C3oubfIN0P9xAO51Ygl4E8s6DiLTgIDLGvt7RbrUw+Xlx
         VCLZBv5j4m6DLmtDzVnjCVnourAdETZrbL5at+qv/jMQvxUtSyt9ldIyCKm42HNx+V5U
         d5fA==
X-Gm-Message-State: AOAM5329K2xIxA5EZ+NLRtFPGyYuOq04MNkN4g2mcnnmdsl6vT8TJqnu
        RbFSUTRffsHDshnws3hJBC1ePRDTczZMciTdH+F0kthK
X-Google-Smtp-Source: ABdhPJwWuvABsj4mc6anZCe4ZbT1HuDh7LBYXWcVZFmA3FbRk8boBXsbvoFFycQKEvO9lpITE/8FUr+zzObH4I6KvSU=
X-Received: by 2002:a02:cb0e:0:b0:321:34d7:a47f with SMTP id
 j14-20020a02cb0e000000b0032134d7a47fmr4596192jap.50.1649249544826; Wed, 06
 Apr 2022 05:52:24 -0700 (PDT)
MIME-Version: 1.0
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 6 Apr 2022 14:51:48 +0200
Message-ID: <CA+JQ7M-Haf3R8xp-sqyJXPZza3VeaRf9uK=tyuviNFVZ0kdBTw@mail.gmail.com>
Subject: BUG: cannot remove new staged files in sparse checkout
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi friends!

I've stumbled across what I believe is a bug

I've found myself with new files that are staged, not part of the
sparse-checkout, that I cannot unstage using git restore --staged, ie
  git restore --staged :\
does nothing.

I'm able to get rid of the using
  git stash && git stash drop
but intuitively I would expect restore --staged to work, even if the
files are not part of the sparse checkout

I end up in this peculiar situation by doing the following.
Having branches:
  foo/bar
  origin/foo
and then running
  git switch -c foo
Updatings files: 100% (X/X) done.
fatal: cannot lock ref 'refs/heads/foo': 'refs/heads/foo/bar' exists;
cannot create 'refs/heads/foo'
