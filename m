Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019EB1FEB3
	for <e@80x24.org>; Tue, 10 Jan 2017 01:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031967AbdAJBpz (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 20:45:55 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35596 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934215AbdAJBpy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 20:45:54 -0500
Received: by mail-pf0-f176.google.com with SMTP id f144so27562394pfa.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 17:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4QD/fi9/GKtg5eTFUGDZ6P2ij2/WGTiELz5gg8pi/kI=;
        b=SwNhHevZSeMCUPa5yM5LFlb8BqoRujRPjyrFwmy6OvNSMXEF11DmpIJJWUX2go+Xmf
         MQSf2liztYoPUsLjPg2ICMYI4xSjnROJQknCh+KmQgMIACNPitWeBdYQFB8xmtzEC0Dl
         zhGNbGvLILRPxepsgesPwfz47/dZTSTJEjfh6Nffep/YYCyT/O1h+yNopfSvAK/VG+Ws
         MV6tClbpMJ10OERX//E1e710JDsHbni0Ulb8/e666lIcxs3lN0NHoZs5ZCHL463vk2FA
         rNv0mG3iKfoBsLW1LVDppT9FoFXVjxCjU30MvWDPvbDlk/A2umw6+/hF9AAGz2hiDSuU
         zjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4QD/fi9/GKtg5eTFUGDZ6P2ij2/WGTiELz5gg8pi/kI=;
        b=NgaUKCT7wm1aOztUyg3Slxz4Zou9ezdJqbo0stdupjcEiYDI6Crr+Gybkp+JOeS5lc
         ciB7TjpUotAY0o0peicbKPyL3zRVj+hnPOCinFy7YxFN7DfjfCh0Yho+HHF/hYOIARwz
         bn7PsYR+jehGu51mnP2Vbwi8oz37us7wSPZwvCoC0bl6SjKN05ooZBs7QaUWyOr48m8F
         Gxh0IKgcsO7Qwm/flADoE9riFpEGjr5W6d7+Qcnp4NTMlbua83epXXpLJBgP1w3ouzqd
         KoLVLyA6xVu2MpmUd01cYEo/eRV8Ld1MOpf7QRk+00s+RunqSHbRC/YelySzzWlrSQ86
         3N7Q==
X-Gm-Message-State: AIkVDXKKThMh/5SPgBsCVRkozw4zRz3plwc6jnNdzlzT++Nz9Ie5RZVnXF0U4nFyaBdyuZm7
X-Received: by 10.99.149.66 with SMTP id t2mr906903pgn.156.1484012752456;
        Mon, 09 Jan 2017 17:45:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1e2:be00:4066:92e5])
        by smtp.gmail.com with ESMTPSA id b10sm389741pga.21.2017.01.09.17.45.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 17:45:51 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, novalis@novalis.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 0/4] working tree operations: support superprefix
Date:   Mon,  9 Jan 2017 17:45:38 -0800
Message-Id: <20170110014542.19352-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As you may know, I am trying to implement "git checkout --recurse-submodules"
which recurses into submodules and update the submodules to the recorded
state of the superproject. I realized that such a huge change is a big endeavor,
and needs to be broken up into many series. 

Currently I plan to send about 4 series:

* This one; teaching the superprefix to working tree operations.

* structured tests, i.e. enhancing lib-submodule-update.sh to have a function
  to test for any corner case (File/Submodule conflict,
  Directory/Submodule conflict; non-existence of submodule commit; and such)

* the actual internal implementation, mostly touching unpack-trees.c,
  entry.c and helper functions in submodule.c
  
* Enabling commands to take advantage of the infrastructure provided.
  At that point we only need to add a --recurse-submodule flag in the
  respective command and add a line to its respective test
  
  "test_switch_submodule_recursing $cmd --recurse-submodule"

--
This patch series is the first of the four series.

It consists of 4 patches, the first 3 are refactoring to a modern style of Git,
the last patch is the actual patch that allows read-tree to be used with
the superprefix option. read-tree is already exposed there to make the
super-prefix code tested.

The series is based on master.

Thanks,
Stefan

Stefan Beller (4):
  read-tree: use OPT_BOOL instead of OPT_SET_INT
  t1000: modernize style
  t1001: modernize style
  unpack-trees: support super-prefix option

 builtin/read-tree.c         |  36 +--
 git.c                       |   2 +-
 t/t1000-read-tree-m-3way.sh | 648 +++++++++++++++++++++----------------------
 t/t1001-read-tree-m-2way.sh | 650 ++++++++++++++++++++++----------------------
 unpack-trees.c              |  39 ++-
 5 files changed, 699 insertions(+), 676 deletions(-)

-- 
2.11.0.rc2.30.g7c4be45.dirty

