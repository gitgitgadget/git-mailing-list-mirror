Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25601F78F
	for <e@80x24.org>; Mon,  1 May 2017 18:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbdEASBI (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 14:01:08 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36852 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdEASBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 14:01:07 -0400
Received: by mail-pf0-f178.google.com with SMTP id q66so33310402pfi.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RwGMPNcpodyBNHEd/HZYr8qIHXkvm6NQQXZkY1L+AxM=;
        b=ir6JjAPv+bTtoTAYxnRChPRVeLCUWsUKALuFTQU/ZcKmfp+T4oBBgWDOiyymYu7gMW
         RGrne4pZQdNEmkSfVn8UekIOcOUrGMChkCR7vHYni6YYNcfAX+Zh/mtoJJta8wVfb+ky
         H6m1BDKK8Slr0/V4cp/99Vidd4R+Zrshyup3ApCHzsf8PzxbciYHLamhamWJzVpWQOWo
         y6CiFrL5BfFnhgyYHivyFqpr8oQ4rP8ngGAhns0GL1Ijk458bgLgx9TrdC4UWskdGvp1
         ebE51pV9ZHTK5zvxuilgfWoLjrUvqKMZ2l75Qsp0q4N7yNijOEJwnrUlxlT+deSOgLfw
         lb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RwGMPNcpodyBNHEd/HZYr8qIHXkvm6NQQXZkY1L+AxM=;
        b=PbnK030lfdtMmsK3mEHgXRsZhsN96NXovjYEx6BfA1v8wQCXyg34MUdlBwcHFMP60v
         YHHEp28edrn248E4IE5X8OaGYEeNVnHDntN3vu7H5gnOIxlU+eSHYhSemVX0M11h3yT4
         HeAIiiN7wED3tZhVw0a9p8T74I4vto6bW7QjuZhyQOYI5hjVJcm8bYNfINcOSzdPIU9l
         QruxUyLx+eBrroF7jjChM/VpfGLXFxxzbQaUrWOz/3jqOM1ngEQiMd6zox0BsfNDNLf7
         BVlEBspqF+6mspY2hkmhhSVJGiqXZ8tKEk5NNWHLbYKIjQ1SblvQHX7B7b30KV7xYZzX
         SkTA==
X-Gm-Message-State: AN3rC/7mMyvJx2RkwKhn+dlQaQokLaYciK7fdrPXe17VHyUWwDyjCmqC
        rpnSzhOvy7XXfCsF
X-Received: by 10.98.207.131 with SMTP id b125mr13363988pfg.167.1493661666398;
        Mon, 01 May 2017 11:01:06 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c4be:9746:6a14:c7a4])
        by smtp.gmail.com with ESMTPSA id c185sm13214741pfc.132.2017.05.01.11.01.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 11:01:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/5] Some submodule bugfixes and "reattaching detached HEADs"
Date:   Mon,  1 May 2017 11:00:53 -0700
Message-Id: <20170501180058.8063-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.1.gbc33f0f778
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first three patches fix bugs in existing submodule code,
sort of independent from the last 2 patches, which are RFCs.



In submodules as of today you always end up with a detached HEAD,
which may be scary to people used to working on branches. (I myself
enjoy working with a detached HEAD).

The detached HEAD in a submodule is the correct in the submodule-as-a-lib
case, but in case you actively want to work inside submodules, you
may want to have proper branch support, e.g. when typing:

    git checkout --recuse-submodules master

you may want to have the submodules on the master branch as well.

There are a couple of challenges though:
* We'd probably want to pay attention to the branch configuration
  (.gitmodules submodule.NAME.branch to be "." or "foo")
* What if the submodule does not have a master branch?
  Jonathan proposed off list that we may just want to create the
  branch in the submodule. This is not implemented in this series.
* In case the branch exists in the submodule and doesn't point at the
  the object as recorded in the superproject, we may either want to 
  update the branch to point at the superproject record or we want to
  reject the "reattaching HEAD". Patch 4 provides the later.

Any other ideas on why this could be a bad idea or corner cases?

Thanks,
Stefan

Stefan Beller (5):
  submodule_move_head: fix leak of struct child_process
  submodule_move_head: prepare env for child correctly
  submodule: avoid auto-discovery in new working tree manipulator code
  submodule--helper: reattach-HEAD
  submodule_move_head: reattach submodule HEAD to branch if possible.

 builtin/submodule--helper.c | 12 ++++++
 submodule.c                 | 93 ++++++++++++++++++++++++++++++++++++++++-----
 submodule.h                 | 10 +++++
 3 files changed, 106 insertions(+), 9 deletions(-)

-- 
2.13.0.rc1.1.gbc33f0f778

