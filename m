Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E791F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 05:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeJMM5z (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 08:57:55 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43477 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeJMM5z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 08:57:55 -0400
Received: by mail-ed1-f52.google.com with SMTP id y20-v6so13248154eds.10
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 22:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZTBSVOI9x/pNq5Thci/fz37cLCXTK3krIsryA467058=;
        b=o4WKgGbTEpG4YhJHqVfIRU5QVOOHD9L8qa92+ZDfyELhfpUcqzDqFbwhnLIzpxdFYq
         fTmcBiiW/snWUR+5+bNZTRETJo2sCNuMQrisPaOMkzISzW0x1XKD6xBCAEPtc+4jJTsq
         1196DMaujDKs5csZQK+kWKVXhk1D8fSj1ll0T9ag0/b+zwold+BJ+RbBHbCCj0FL+vRn
         PXjien7+n5rwU9e6BkQHEO1Z6JpdmRv0tE6kb1wGEWBs61AVIpRic3a/BLJNmzGDBAA8
         8dMy1GD1XbiusyLOx12JL80peYFvBuh2d2i5vVIKCtgb/aAhyLhwAysZf35dkez9RJKh
         dOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZTBSVOI9x/pNq5Thci/fz37cLCXTK3krIsryA467058=;
        b=VNXtBRT4cZ+1LGqSL+q++czdWYLqDKdqqFLfrzwn8GLxtUQvbrBa+h4c9fVj03Pu1v
         uAPzf+FBUAiIoAGcW6rV3booOQ3ZaukzvPU8tyPfxdjymKS0esN+SumqV2tNERsGu0dD
         68diiRDMVzgYt82IctVW57Y5ZuS1G3qd/CglQxU7tZx9gv0r94tCSlKaOuaaoPqkF+Y1
         nGs9XDn2mln0Io+SfRjpIXmRjcgHvSsaiLiTUh8RdxrwpkitciXy1vgWBwkWFBvEvH4l
         V2O1dn+rpzhkBJg5HpX7CML6JWn7NX0WEqrpQOU9LQh/CZsV2GCRSu+4x924Bad+Fii4
         1M6Q==
X-Gm-Message-State: ABuFfogo1nliAg3VphZYOt3UcSQopPlRlMOVfGUbO7uz27qat5bmFgvO
        RXxZzeeWUioxuvT9CMpJuPoC3XYtX+d2xoObKOpUIS4z
X-Google-Smtp-Source: ACcGV60K9/aJNJpYo4LRnOvW/pw2IAROufKIBXHOCz59De592dAH/2i/WwN+TJ16KH1UH/6EUiN855htOIvKgbEUynI=
X-Received: by 2002:aa7:c458:: with SMTP id n24-v6mr12361245edr.55.1539408129118;
 Fri, 12 Oct 2018 22:22:09 -0700 (PDT)
MIME-Version: 1.0
From:   Maurice McCabe <mmcc007@gmail.com>
Date:   Fri, 12 Oct 2018 22:21:57 -0700
Message-ID: <CAGTUGAszwA63eYi2on_Pn4mSu4n2YDjv9kiakmbCT38gj30iNw@mail.gmail.com>
Subject: git issue with builds on Travis-CI
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a problem on travis-ci with doing builds on Pull Requests
with multiple jobs. For each job it will build off the FETCH_HEAD. The
problem is that if the FETCH_HEAD changes while the build is running
(due to a commit), the subsequent jobs will build off the new
FETCH_HEAD. This results in loss of integrity of the build.

The fix would have been doing a fetch by the SHA-1 (commit) instead of
the FETCH_HEAD. But this results in an error:
"error: Server does not allow request for unadvertised object"

Since this is not working, the current option available to the people
at travis-ci is to abandon the build with an error message. This is
not a good user experience. The preferred option is to trigger a new
build when a commit is made.

You can see more details about the problem in this comment:
https://github.com/travis-ci/travis-ci/issues/8577#issuecomment-336596843
and the current discussion:
https://github.com/travis-ci/travis-ci/issues/10210

BTW: on reading the git mailing list a suggestion seems to be to ask
the server operator (GitHub in this case) to set:
"git config uploadpack.allowReachableSHA1InWant 1"
Apparently this has some security implications.

Does anyone have a suggestion how to do a fetch by SHA-1? Or is there
another approach to solve this issue on travis-ci?

Thnx,

Maurice
