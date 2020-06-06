Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA85C433E0
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 00:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80FA206FA
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 00:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ePiNfrbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgFFAXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:23:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39068 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728316AbgFFAXu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jun 2020 20:23:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8A3EE6081C;
        Sat,  6 Jun 2020 00:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591402999;
        bh=jklddmiKkK4HwIiMJ+Q/NLZtAfU1LDGpmLNLwN5i8Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=ePiNfrbu2bel1UCyEM0TEeYZ+1svMz7DjZQ7rYXV8f/mMvPa430VSJ1ElI/tWC7DK
         Kj5X9SVslSs7W8yCfwxjQhxw7jiYzhVWgv1Nynk636Rgja5JbbkuIV6wW3mU5MY6zL
         j7Z/8yrweq8FDjYxxTRr57kBsxy6drDs4H0AHvL3RKyr2RtLLolZ361NA/CRpr/Fq7
         tC6oQXkcst8yo1amcNT9w38o0+YHxGhQ8EGq3uZr1R2SW2wrJRA1LXeZAKRT6csqIE
         vMNfRgei4tL//shNcjeN5Ze3OCgtdRMKHR6SXkI7SJbYe+1Yejus+ki3y6kgtJ/PEF
         /bVKKyIqQB+QH7TRKrkM/GrKv4yWgkNJoYu8oR2BAWi2mNScrBfQ2cxH+dgAW5O/EO
         MjLZeAj8moRrJbYTUunMdwJCdaM5LTYqh4Fl6eBrZOD4Q3QxRQtahGFYjhNw3NtHbR
         oNaFAiVEcjtihJxgKIgfj043HgOgvW1mUV4gvlhD9Q+VF0rI4sd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Billes Tibor <tbilles@gmx.com>
Subject: [PATCH v2 0/1] Run pipeline command in subshell in sh mode
Date:   Sat,  6 Jun 2020 00:22:40 +0000
Message-Id: <20200606002241.1578150-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200606002241.1578150-1-sandals@crustytoothpaste.net>
References: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com>
 <20200606002241.1578150-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

POSIX sh implementations run each command in a pipeline in a subshell,
although zsh (and AT&T ksh) do not: instead, they run the final command
in the main shell.  This leads to very different behavior when the final
command is a shell function which modifies variables.

zsh is starting to be used in some cases as /bin/sh, such as on macOS
Catalina.  Consequently, it makes sense to emulate the POSIX behavior as
much as possible when emulating sh, since that's the least surprising
behavior.  This patch does exactly that.

With this patch, using "zsh --emulate sh" passes the Git testsuite.  I
expect that it will also be fully functional as /bin/sh on Debian,
although I have not tested.

This patch was sent before, but didn't get picked up.  In hopes of
aiding reviewers, I've resent it with a significantly expanded commit
message so that it is easier to reason about.

I'm not subscribed to the list, so please CC me if you have questions or
comments.

brian m. carlson (1):
  exec: run final pipeline command in a subshell in sh mode

 Src/exec.c           | 10 ++++++----
 Test/B07emulate.ztst | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

