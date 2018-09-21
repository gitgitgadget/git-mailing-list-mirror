Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4DD31F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeIVE1F (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:27:05 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:44840 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVE1F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:27:05 -0400
Received: by mail-yb1-f202.google.com with SMTP id 189-v6so6365904ybz.11
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2oAZ7Rbi1ZLH91bY5274KknRci58CQkBzVzbRZyxNgQ=;
        b=MkmFCGy82NNWGf8JCPsOScG2pq0K2biU2IneKg1848dttTa8v43w6xsmt+XHPEIlCZ
         /2kctxsOn5haFrmjIG/jx6oQAcTAFNx461LyIile/X7FrF/xTgihRZ/ffkS7vzgNEJbx
         6hE1DWgIRuUVx5+jV4DjcX6sFi/XJjc+c93jNOahdMR6x4mLz+graUV/oYd3Hxtvxk0S
         v3ryk3v+RCoXjkKvVZ4SEN15ZU7Ho7GkeHztokKBpBM8MZwcbJQUnjCmKNFe9/AsDo/E
         0bwtmwlWcjelebc1K+3btJ8XyDdhDAaw24s0z/MHEDebq2BH9qw9UJ9PdZAdQYZ9XbPG
         xanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2oAZ7Rbi1ZLH91bY5274KknRci58CQkBzVzbRZyxNgQ=;
        b=T/cgbJrHPo95hDzbt23yHrigsFSoGcYjmxWRj92ELWbNlWwKv2Ws6mGMd/BtbzjkMS
         B3jh+OgW5bXGiFug6g1I9hthCHZa1CqcmQ4ipr6IuRsggT/boOToApu8rVwu4eX0HPUC
         hmLRVmF+wFUqUy2R5FGanChVrrfLu/lDaMHTLqih8seMHCy4oCzo3PM7kR4laoG3zj4g
         PWtI66etReGNViNQpcwuV0zYvFBDdhQ7waoAX7tvoxzTzFXVTr67CVTmAA66Il0D6vZY
         2WFSgZYk3MDy8Y33gyaWIOCuWh5BKUaZqtyi4uxibPRNcF/RC8zeu0s8qlvGLxo+oR/u
         vuPw==
X-Gm-Message-State: APzg51C7cBC6kcTUM/I5d60MFZY8dA0WSZKH7WxNkZWsBHOVdCsd8zIA
        bthzwfxTeUX7d4AnzejdPByWZ4D25+hu+iebn3MS+VZGYxL8aPDQOaY+ymD7qSltEuO9q5ijuT9
        qqPvQiYt6pgXOybETr27m2QC95AbMi7bEqFC1mdHGEjiV1IJg8llqxsqXprd0
X-Google-Smtp-Source: ANB0VdbPzHoGmQ+d2qxbdyyTXs406ng1wF4uIlEtluxd6kkIUyvGga12+n1Qso3SbW1bXzYk94h2cxPIRgz+
X-Received: by 2002:a25:284:: with SMTP id 126-v6mr3152962ybc.34.1537569369128;
 Fri, 21 Sep 2018 15:36:09 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:35:50 -0700
Message-Id: <20180921223558.65055-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCHv3 0/8] fetch: make sure submodule oids are fetched
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:
* I discovered some issues with v2 after sending,
  which is why I rewrote the later patches completely
  and now we pass around a "task" struct that contains everything to know
  about the things to work on and what needs free()ing afterwards.
* as it is no longer string list based, this drops adding string_list_{pop, last}

v2:
* extended commit messages,
* plugged a memory leak
* rewrote the patch "sha1-array: provide oid_array_filter" to be much more like 
  object_array_fiter
* fixed a typo pointed out by Ramsay.

The range diff is below.
  
Thanks,
Stefan

v1:
Currently when git-fetch is asked to recurse into submodules, it dispatches
a plain "git-fetch -C <submodule-dir>" (and some submodule related options
such as prefix and recusing strategy, but) without any information of the
remote or the tip that should be fetched.

This works surprisingly well in some workflows, not so well in others,
which this series aims to fix.

The first patches provide new basic functionality and do some refactoring;
the interesting part is in the two last patches.

This was discussed in
https://public-inbox.org/git/20180808221752.195419-1-sbeller@google.com/
and I think I addressed all feedback so far.

Stefan Beller (8):
  sha1-array: provide oid_array_filter
  submodule.c: fix indentation
  submodule.c: sort changed_submodule_names before searching it
  submodule: move global changed_submodule_names into fetch submodule
    struct
  submodule.c: do not copy around submodule list
  submodule: fetch in submodules git directory instead of in worktree
  fetch: retry fetching submodules if needed objects were not fetched
  builtin/fetch: check for submodule updates for non branch fetches

 builtin/fetch.c             |  14 +-
 sha1-array.c                |  17 +++
 sha1-array.h                |   9 ++
 submodule.c                 | 268 ++++++++++++++++++++++++++++--------
 t/t5526-fetch-submodules.sh |  23 +++-
 5 files changed, 268 insertions(+), 63 deletions(-)

-- 
2.19.0.444.g18242da7ef-goog

