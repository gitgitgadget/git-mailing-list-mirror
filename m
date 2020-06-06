Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADEFC433E0
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 22:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACBB20663
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 22:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgFFWhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Jun 2020 18:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgFFWhO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jun 2020 18:37:14 -0400
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA86BC03E96A
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 15:37:13 -0700 (PDT)
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id E89306FF23
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 22:37:09 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 49fZBs59Jhz44b9
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 22:37:09 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "smtp.gmail.com", Issuer "GTS CA 1O1" (verified OK))
        (Authenticated sender: kevans)
        by smtp.freebsd.org (Postfix) with ESMTPSA id A7A502A5C0
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 22:37:09 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: by mail-qv1-f45.google.com with SMTP id e20so6615891qvu.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2020 15:37:09 -0700 (PDT)
X-Gm-Message-State: AOAM532OnUQPoQumpbjzodzxNUKiZwqJ+ceZ2l7VorckbsLd5JqyhvAQ
        QI//qyIQ0THgCzebMLVGx7rA2OPN3EYwGvaxTlY=
X-Google-Smtp-Source: ABdhPJxc+0VqZLlGhu4kn0pHDtGzvozJ7YoLz9YbQExqQZsdhvdsD+9kwZTe5avJnxvvLHTe9x9TsKfYv7AlwpCwftk=
X-Received: by 2002:a0c:f745:: with SMTP id e5mr2541370qvo.150.1591483029252;
 Sat, 06 Jun 2020 15:37:09 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Evans <kevans@freebsd.org>
Date:   Sat, 6 Jun 2020 17:36:58 -0500
X-Gmail-Original-Message-ID: <CACNAnaG19QD1PbVS93nFm3XY70CZCrRosmVq-_3j+puAKSPj9Q@mail.gmail.com>
Message-ID: <CACNAnaG19QD1PbVS93nFm3XY70CZCrRosmVq-_3j+puAKSPj9Q@mail.gmail.com>
Subject: fread reading directories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was looking at FREAD_READS_DIRECTORIES to measure some performance
differences, then stumbled upon [0] that dropped fread() from the
autoconf test that causes git to use its git_fopen shim [1] even on
Linux.

I've read the commit message a couple of times, but I'm really not
seeing the rationale for *why* git wants this knob to be set on Linux.

Unless I'm missing something, this would seem to regress the almost
certainly much-more-common case of fopen() a file and fread() it with
an unconditional fstat() from grep_fopen(), rather than just using two
syscalls at all times (directories and non-directories) and letting it
get rejected in fread().

Thoughts?

Thanks,

Kyle Evans

[0] https://github.com/git/git/commit/3adf9fdecfb0cd31a83ef3af1d8d631a1acd392b
[1] https://github.com/git/git/blob/master/compat/fopen.c
