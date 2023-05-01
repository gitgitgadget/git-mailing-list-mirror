Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73758C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjEARH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjEARHM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:07:12 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330A5FF9
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:01:45 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B0BB45A35F;
        Mon,  1 May 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682960426;
        bh=i7rqtob+sN5i9De95xI/6OpNZUdfQTIRxn8eCeC5sbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xS50/DY7i0GJuE0+TtuKV2OGj24N8kNbu/ehEdpE3I0MxxQPDbvzPmGY4X9BsoJ1D
         AyrLgcXW0UAn71ikuixOBB72jYX7zwfuRBjLREDgisKk4B1LduAvplwDjRNXaYEJw0
         iE2LKfoG4SVtlbHBzfwJe9CYZcYaFeWnCNc2Y/E53MpL4nHNuvFN6mNQSs0DM2oF05
         0CfVqKNu/c8BoT0rV6Fxb5da5J0TD+d4oR0mqeHwB1crIrUwhcKSJa97vO8C70W7L3
         YtWwwVZi8MHts1PR+fxqsTS94sW4cWnrzFheetnBafrtJQrbr/1qX/SxOvJRAvzOeh
         Isk1NklO223pHycljUS7qsXzoEmMLL6BumM7oi1pa9gy5tYOe3qimrhKaEaZLpnVLW
         FeKFZUkistuigBjB28rhD3ej6vc8gWkuu8Pid7hPgAnnIhcxUy3+znsDNTIoEioCG6
         S2CT9QW/TlJhwHiiEPAgttoXa9ovB3vR4U6mdgjUv3QRHIaLAR7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>
Subject: [PATCH v2 0/1] Fix empty SHA-256 clones with v0 and v1
Date:   Mon,  1 May 2023 17:00:17 +0000
Message-ID: <20230501170018.1410567-1-sandals@crustytoothpaste.net>
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

Unlike in v1, we wire this up for all protocols and fix the NULL pointer
dereference that would occur in that case, as well as add some more
tests.  The second patch has been dropped, since it is no longer needed
and was not very popular.

Changes since v1:
* Drop patch to honour GIT_DEFAULT_HASH
* Support all requests, not just HTTP.
* Add more tests.
* Fix NULL pointer dereference.

brian m. carlson (1):
  upload-pack: advertise capabilities when cloning empty repos

 t/t5551-http-fetch-smart.sh | 27 +++++++++++++++++++++++++++
 t/t5700-protocol-v1.sh      | 31 +++++++++++++++++++++++++++++--
 upload-pack.c               |  7 ++++++-
 3 files changed, 62 insertions(+), 3 deletions(-)

