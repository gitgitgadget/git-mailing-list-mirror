Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7C020958
	for <e@80x24.org>; Tue, 21 Mar 2017 00:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbdCUAVO (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:21:14 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33172 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbdCUAVN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 20:21:13 -0400
Received: by mail-pg0-f50.google.com with SMTP id n190so85120653pga.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 17:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vydycrY4ACT/Xov/63oMj43NrzzwiDdgEQQ+j0V8VX0=;
        b=Fffc1TevEVQlqflrRZTmhwi55fgm7VQ7BehG91Y0nMYgC93qfMAdZ65LEjhZSYflRc
         SGvA1LX6PRUz7SzS217xKhOfazQzkpVTG/YUQf+t/Jf8vpSwDBMfCO9FL6vCh4ml5ZRj
         gYjj95tPYq8f0ZL6ymcaNQBifrP00wd5FTjUY1fFOs3OxbpqejaXjhNsxyDwmj6SIHhI
         RKikSn7mXDraoNjs3smHIImHA5yYUG0avC58y209xZ10ogGla8lNLhBlesxtKRPgfjYo
         P3XIqOV+egWgrU/8uOPBIaXHZeRdn7wG0sftcBjYSmxm+WdaQ7oQcTnvcn+cDs449IsS
         g5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vydycrY4ACT/Xov/63oMj43NrzzwiDdgEQQ+j0V8VX0=;
        b=IHQad1gdRijFXFg1WMh2dY6M8RQlta34DqN9Nx5kxuTC260iPiN6uDBEdflXgyZraO
         VWsEguZSYNbI1TvkbfFK9dB4D/wRbj8uSvqjXiDXEkwlDxFmFKGVa+OTSdjm8xZAIwuG
         H4ZjnkuPXuH2S1WHYbz8ATMZbFDzKuw3tdARj1U4siTocS967m2Txgf8UyzML+yYo0sP
         BTgS5mEYH7GL5TB4sShpG+0YJWCMJb8Vj1icjVNpZy5pCUtcu58DB7qn9roKS45L2sTr
         RHsXthQHSrqNr8SzhzBAwcNZV+twcSoopwebR46RVM+9dU8GCTs5DuCUo/kf3mILvetJ
         nB+Q==
X-Gm-Message-State: AFeK/H0XieoeMjep560tDkkdWPI2X3K9ZmT1ifGXklc/K3j6sdngBm4cwKy8+gCYrJcb2JOl
X-Received: by 10.84.215.155 with SMTP id l27mr43876178pli.31.1490055122798;
        Mon, 20 Mar 2017 17:12:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:38a6:f549:ebc4:4d51])
        by smtp.gmail.com with ESMTPSA id o24sm35324824pfj.126.2017.03.20.17.12.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 17:12:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, mfick@codeaurora.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] git-describe deals gracefully with broken submodules
Date:   Mon, 20 Mar 2017 17:11:53 -0700
Message-Id: <20170321001156.21915-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.402.g0501f7a28e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our own version generation in GIT-VERSION-GEN is somewhat sane by testing
if we have a .git dir, and use that as a signal whether the obtained
copy of git was obtained using git (clone/fetch) or if it is just a
downloaded tar ball.

Other scripts to generate a version are not as cautious and just run
"git describe". An error from git-describe is treated as a sufficient
signal to assume it is not a git repository.

When submodules come into play, this is not true, as a submodule
may be damaged instead, such that we're still in a git repository
but error out for the sake of reporting a severly broken submodule.

Add a flag to git-describe that instructs it to treat severe submodule
errors as "dirty" instead of erroring out.

Thanks,
Stefan

Stefan Beller (3):
  submodule.c: port is_submodule_modified to use porcelain 2
  revision machinery: gentle submodule errors
  builtin/describe: introduce --submodule-error-as-dirty flag

 builtin/describe.c                           | 17 ++---
 diff-lib.c                                   | 10 ++-
 diff.h                                       |  1 +
 diffcore.h                                   |  3 +-
 revision.c                                   |  2 +
 submodule.c                                  | 94 +++++++++++++++++-----------
 submodule.h                                  | 10 ++-
 t/t4060-diff-submodule-option-diff-format.sh | 22 +++++++
 t/t6120-describe.sh                          | 17 +++++
 9 files changed, 128 insertions(+), 48 deletions(-)

-- 
2.12.0.402.g4b3201c2d6.dirty

