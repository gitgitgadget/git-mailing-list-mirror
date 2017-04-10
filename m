Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E39B20960
	for <e@80x24.org>; Mon, 10 Apr 2017 20:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbdDJUqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 16:46:23 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36658 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdDJUqW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 16:46:22 -0400
Received: by mail-pg0-f50.google.com with SMTP id g2so110008649pge.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ra1Vpl0VGMe0dJRCHzhOE4bgqqO/2upwSu31J9EFW38=;
        b=Nz/Ct1Hqaw+ViQcTodi5VaJ1Ea/ve+VcWqt7fVqmXR8TlU3sr1BxlWLOZoDhfeGinc
         GU7RXm6vSEg2CKAfwrOXY12jUdCyZsYMt2w8iIzpv14SOHPgt3QUhAgXGfDoiI3afdEM
         BdigQ97jtJcgi/swg9ACZBRH4wakHEK1s5Uw8mlaWcpmOF1BxhsUZ6VC85Kda7Tst0EV
         Q3imA3FysQ2I4edNYXeNfvPHkkwpPKAMnmWjq48jEbHRnc3ZkVlUXoX/s/MXR8q7XZ6O
         meHkN/58n9manYmoEbHT5EH5lQD1JstH42/SvKSyMkSuLr5KmvTem1WlUSrecp4PErld
         sJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ra1Vpl0VGMe0dJRCHzhOE4bgqqO/2upwSu31J9EFW38=;
        b=loKHri9N6nRhYcLAZy69CkW2VdDlRQcYICOQAO+7ddaNNzlF/Hcm6SulmrpKipCglW
         dQaa8FFJVqNrHp8boFPcOVjZoFeb/likyYqlTFKIBP2Kpfa9KSyy+JLPPEP2qmvQriUy
         rWO+oBAO0k011lj7ibelalluNNLDPYKZwmAxE9M60JRdN0HwvAJemwy7SY2/JJunOGLz
         PwggLu7/5phkGz3yEOqMMhXSiR226MoABoU7PsZjk30b4oJYSthrqnaTHVSVK9+XFPh2
         dNA3H+7OR1bl0q7LgOHbIaumOKt1Iy41nm2NV0uc+Ps2J2Q1kM32dbAYrBaeVpSIGMEB
         uGVQ==
X-Gm-Message-State: AFeK/H3gVNgGS9WQLmqjONB6NdrGaAiUAxGHQ2Ma39fIQQpGge4B+FrlRPMKBW9elYrW5fOD
X-Received: by 10.99.175.7 with SMTP id w7mr57900004pge.170.1491857181649;
        Mon, 10 Apr 2017 13:46:21 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id r90sm6709414pfl.120.2017.04.10.13.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 13:46:20 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 0/4] Implementation of fetch-blobs and fetch-refs
Date:   Mon, 10 Apr 2017 13:46:06 -0700
Message-Id: <cover.1491851452.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My previous proposal about a possible new server endpoint that serves
blobs and refs [1] didn't seem to garner much interest, so I thought I'd
provide a possible implementation of that proposal as a work in
progress.

In particular, patch 1 demonstrates that a new server endpoint that
serves refs without the initial ref advertisement can be done in 228
lines of code (according to "git diff --stat") while accounting for the
various special cases that upload-pack imposes (stateless RPC, inclusion
of an additional response when depth is requested, handling of "done" in
request, sending a packfile directly after a response containing "ACK
ready" without waiting for "done", and so on).

I'm hoping that these features would be of more interest to more people.
To that end, I'm sending these patches in the hope of showing that these
features are useful (omitting ref advertisements help greatly when
serving large repos, as described in the commit message of patch 1, and
serving blobs is useful for any fetch-blob-on-demand repo scheme) and
that my proposed way of implementing them can be done in a relatively
uncomplicated manner (as seen in these patches).

Patch 1-3 show what serving refs without the advertisement would look
like from the server's and fetch-pack's points of view. Patch 4 is
similar to some of the other blob-serving patches except that this
contains reachability checks and that this bundles the resulting objects
in a packfile.

[1] <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>

Jonathan Tan (4):
  server-endpoint: serve refs without advertisement
  fetch-pack: refactor "want" pkt-line generation
  fetch-pack: support new server endpoint
  server-endpoint: serve blobs by hash

 .gitignore                 |   1 +
 Makefile                   |   3 +
 builtin/fetch-pack.c       |  10 +-
 fetch-pack.c               | 129 +++++++++++------
 fetch-pack.h               |   1 +
 server-endpoint.c          | 347 +++++++++++++++++++++++++++++++++++++++++++++
 t/helper/.gitignore        |   1 +
 t/helper/test-un-pkt.c     |  40 ++++++
 t/t5573-server-endpoint.sh |  60 ++++++++
 t/t9999-mytests.sh         | 242 +++++++++++++++++++++++++++++++
 10 files changed, 790 insertions(+), 44 deletions(-)
 create mode 100644 server-endpoint.c
 create mode 100644 t/helper/test-un-pkt.c
 create mode 100644 t/t5573-server-endpoint.sh
 create mode 100644 t/t9999-mytests.sh

-- 
2.12.2.715.g7642488e1d-goog

