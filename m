Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9F52022D
	for <e@80x24.org>; Mon, 21 Nov 2016 20:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754732AbcKUUm6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 15:42:58 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36367 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753883AbcKUUm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 15:42:57 -0500
Received: by mail-pg0-f51.google.com with SMTP id f188so133542512pgc.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 12:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KF3zo14h44YY5V2yckDw4samL6L5PCRad97RvEc2450=;
        b=KPSXOXi/BAqhJgPED9iGS7SCfeSHvBUwBJg9cw0aPo/rh8RvG+hylbSlN5Mh09wANd
         Mt2ubJCR+ZtAHQzcMVAPfH3nHJsXPfDQ5DhBNhjuvfp0J21nDnWIMWNdL48pRkQHH3q+
         EbxFNCvW3YWGX9KHJwJM+2BgqGkxRR+tUpAxtC//H6Sb3SMSKreg7cBPskF42rzRphv5
         /xJ+p1Rwv021DrDhL2zL0uuRCGQFlVIKKmPrnPT31JCsBEQpPt/tHKd6vsjTw5O6aqPt
         3YJF3p2ca3PgTqFMNyWf+c0rRqRolc7XnTDjSK2MXcc9Wp+O3fiNf7ju++wNONj4Z1bW
         f8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KF3zo14h44YY5V2yckDw4samL6L5PCRad97RvEc2450=;
        b=XMQ26myAb9JXM6jaFRSEcyOR3hqkhvrzIP6ufL0CGNwxAb/u0HQPkcvnVNjIFvb2HJ
         2ucxm1zK78XkKP4WplCkPwxV/zUhaDWamku/MoNBYznpMK8JVuKrlywQ7R4gfuEeDI8e
         ibyx0+zsuRpRbiURQtJJM9JXa0+FxF7AqrHRaq3mXJAbSGuJ4PzUvLOpKEk/OZDqaEdS
         GBJmrgO5GBHY5KadZ2M0OqaYDNRxyZSHP3fIlNl3f6w0WU/5g8Xtnao6DlmNP3nz4/vU
         y2WKusgvH5fVVVuKzd1eaGIJ9HBcXPUROQ6tyrys9xCdqeQX5Ii/iqNoOtg4GQHymFSH
         WgTA==
X-Gm-Message-State: AKaTC01u5/uCVzPboZAKXcUBXo2NEzciVUDCyf4rIOJQahLhUP7N1cTWE/30bVYzuLvPqGiV
X-Received: by 10.99.120.13 with SMTP id t13mr34786274pgc.17.1479760917832;
        Mon, 21 Nov 2016 12:41:57 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id t184sm21511774pgt.36.2016.11.21.12.41.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 12:41:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
        hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Introduce `submodule interngitdirs`
Date:   Mon, 21 Nov 2016 12:41:43 -0800
Message-Id: <20161121204146.13665-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The discussion of the submodule checkout series revealed to me that a command
is needed to move the git directory from the submodules working tree to be
embedded into the superprojects git directory. 

So I wrote the code to intern the submodules git dir into the superproject,
but whilst writing the code I realized this could be valueable for our use
in testing too. So I exposed it via the submodule--helper. But as the
submodule helper ought to be just an internal API, we could also
offer it via the proper submodule command.

The command as it is has little value to the end user for now, but
breaking it out of the submodule checkout series hopefully makes review easier.

Thanks,
Stefan

Stefan Beller (3):
  submodule: use absolute path for computing relative path connecting
  test-lib-functions.sh: teach test_commit -C <dir>
  submodule--helper: add intern-git-dir function

 Documentation/git-submodule.txt    | 15 ++++++++++-
 builtin/submodule--helper.c        | 33 ++++++++++++++++++++++-
 git-submodule.sh                   |  7 ++++-
 submodule.c                        | 55 ++++++++++++++++++++++++++++++++++----
 submodule.h                        |  1 +
 t/t7412-submodule-interngitdirs.sh | 41 ++++++++++++++++++++++++++++
 t/test-lib-functions.sh            | 20 ++++++++++----
 7 files changed, 159 insertions(+), 13 deletions(-)
 create mode 100755 t/t7412-submodule-interngitdirs.sh

-- 
2.11.0.rc2.18.g0126045.dirty

