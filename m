Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AB9C49EAB
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 18:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3749361C2A
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 18:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhF0STw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhF0STv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 14:19:51 -0400
X-Greylist: delayed 563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Jun 2021 11:17:26 PDT
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDDDC061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 11:17:26 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id BD03658726428; Sun, 27 Jun 2021 20:08:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id BBEEC60C26FD2
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 20:08:00 +0200 (CEST)
Date:   Sun, 27 Jun 2021 20:08:00 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     git@vger.kernel.org
Subject: git-format-patch does not encode lines starting with "From"
Message-ID: <5oq2985q-o266-8p5o-n197-8nq8s6p83oon@vanv.qr>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Summary
=======

git-format-patch in 2.32.0 fails to quote/escape lines starting with
"From ", and mbox readers conclude there is an empty mail.


Observed
========

$ git commit -m 'subject

From ffffffffffffffffffffffffffffffffffffffff Mon Sep 17 00:00:00 2001
with love.'
$ git format-patch HEAD^!
$ head 0001-subject.patch
From d489071b4855a49b32e9b5ae5addd982d2ed8d7d Mon Sep 17 00:00:00 2001
From: Jan Engelhardt <jengelh@inai.de>
Date: Sun, 27 Jun 2021 20:04:20 +0200
Subject: [PATCH] subject

From ffffffffffffffffffffffffffffffffffffffff Mon Sep 17 00:00:00 2001
with love.

$ git reset --hard HEAD^
$ git am -p0 0001-subject.patch
Patch is empty.
When you have resolved this problem, run "git am --continue".


Expected to see
===============

$ head 0001-subject.patch
From d489071b4855a49b32e9b5ae5addd982d2ed8d7d Mon Sep 17 00:00:00 2001
From: Jan Engelhardt <jengelh@inai.de>
Date: Sun, 27 Jun 2021 20:04:20 +0200
Subject: [PATCH] subject

>From ffffffffffffffffffffffffffffffffffffffff Mon Sep 17 00:00:00 2001
with love.
