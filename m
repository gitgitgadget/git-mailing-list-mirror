Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C723C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 19:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjEQTZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 15:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEQTZz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 15:25:55 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB33AD09
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:25:26 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 850C45AF40;
        Wed, 17 May 2023 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1684351488;
        bh=+5jCHlrxfqOz6SiVDGRSRla9LR8PzKmvrvSLwj+lzZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZkWKkjRl04kVZTbce8FTlTYRbsjx7tY0W6EchUWsRiUa01u7+K9zXYyt6OlXxECEC
         ygq4DIMRnH/JTjXf/eboGFZn+avNttCd6RNAh7vz+/oxstjRfEw3Msj/NbediuX0O+
         cOVt2sl46ugOODAm5mcyQh7LtAdJMoEA28ZNX00RLPGxngyXdJ8jCh2afvJWZKJiHl
         0ikmTcrynpn6h1PP+DyYsM9duc3aWwPyAIjDtEMXP3vXP2uctQv2oQjpIZ8oIiPoir
         fxopd1VFOBLtOfwNigHVBp4u23C6xeo8kogDSlTlHssIoYErM1WKbhCAg7lHzjXwSi
         dz3UD9U3icA09rk/wahaObG9iwPGMVScbOHWQHGVzHuFJzgMSRm2cv7ifGFThNZe2O
         pMAtSz2fCNb+axG3wFGStSDOUivIKrdENC6aKkaM//SA9rHRP3/OEqk3t9tVGzWT7U
         M51txmwxBjfq14eo6ScJJTVri0Jiwc7DnY26dACDzhTyEoGOt46
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>
Subject: [PATCH v3 0/1] Fix empty SHA-256 clones with v0 and v1
Date:   Wed, 17 May 2023 19:24:42 +0000
Message-ID: <20230517192443.1149190-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recently fixed empty clones with SHA-256 over protocol v2 by
honouring the hash algorithm specified even when no refs are present.
However, in doing so, we made it impossible to set up a v0 or v1
repository by cloning from an empty SHA-256 repository.  In doing so, we
also broke the Git LFS testsuite for SHA-256 repositories.

This series introduces the dummy `capabilities^{}` entry for fetches and
clones from an empty repository for v0 and v1, just as we do for clones.
This is already supported by older versions of Git, as well as libgit2,
dulwich, and JGit.

Changes since v2:
* Move advertisement of fake capabilities ref to a separate function to
  avoid an extra strcmp.

Changes since v1:
* Drop patch to honour GIT_DEFAULT_HASH
* Support all requests, not just HTTP.
* Add more tests.
* Fix NULL pointer dereference.

brian m. carlson (1):
  upload-pack: advertise capabilities when cloning empty repos

 t/t5551-http-fetch-smart.sh | 27 +++++++++++++++++++++++++++
 t/t5700-protocol-v1.sh      | 31 +++++++++++++++++++++++++++++--
 upload-pack.c               | 22 +++++++++++++++++-----
 3 files changed, 73 insertions(+), 7 deletions(-)

