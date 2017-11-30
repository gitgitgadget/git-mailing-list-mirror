Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63AA920A40
	for <e@80x24.org>; Thu, 30 Nov 2017 03:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbdK3DRI (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 22:17:08 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:42062 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbdK3DRH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 22:17:07 -0500
Received: by mail-wm0-f45.google.com with SMTP id l141so10257518wmg.1
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 19:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=j2gO+CnJd/JW3DmYyQ7AMPpww98XpherzQX0iaGEn1o=;
        b=cXhxvTJ+2od1U6EuNFRKv9Ocn89QCXyj5ODngFigpEvbbG35e2jeHZTPEW1p3I5sTu
         00BA506osoC1Win+ixBUw4FvHIOsk1yOVWxE7o3b4GMWem7L5A3mn7xx9KSuHs7ahyGj
         KFIgjJaZiPh8BKT1w4URi/XVe3ghR9oGKLdkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j2gO+CnJd/JW3DmYyQ7AMPpww98XpherzQX0iaGEn1o=;
        b=kLdV+GJLz/wtTqGTVtVuoRSpGzrXjqkMiIFDLYjAmb+/FodFeWMagohcWcsoOYKrCl
         yA3gI4Hf91gYNMsi3U3DOHaAenbXnVo2yWdWN7Tjuj7XfiMbkNKJ3CZH4TfmtALUUK9l
         hQDtzx8+5dg11q4Zdf2zskAoijgIqbmK/QH5oicDjwB+VzsiAHjgb+oMaE0sgmTQ125T
         tH3qB3RKUiQSNlTUeyjcRQYvBJsNp231QaidX2gkZpz493wFCPxMoTJfeP6VqeKWGGvv
         3Y7j3HRn21NwaCgAMCF0uJ6acs7/BNpMSlMV/s2VeKpwpIk18NrOI9ZacC31bXJKTO/y
         KKug==
X-Gm-Message-State: AJaThX7MRsOTlLEar2Ib3FW6enX/VsPakFOdbdfte6c+WoQa6zjlkYdW
        c91ytnaLZgmP74Y9DKUZkfK9dFMNhDzBM1uNJrFjvl4=
X-Google-Smtp-Source: AGs4zMYjG5+4BifP83TdPMiAH5LhaPeODNy0E+kuxJZtl9Vw05gaIokZKv6uGLxyYXMH0AF2O4IXJcV49pVZ8Lzo/hw=
X-Received: by 10.28.33.66 with SMTP id h63mr695728wmh.152.1512011826427; Wed,
 29 Nov 2017 19:17:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.213.12 with HTTP; Wed, 29 Nov 2017 19:16:45 -0800 (PST)
From:   Vitaly Arbuzov <vit@uber.com>
Date:   Wed, 29 Nov 2017 19:16:45 -0800
Message-ID: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
Subject: How hard would it be to implement sparse fetching/pulling?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,

I'm looking for ways to improve fetch/pull/clone time for large git
(mono)repositories with unrelated source trees (that span across
multiple services).
I've found sparse checkout approach appealing and helpful for most of
client-side operations (e.g. status, reset, commit, etc.)
The problem is that there is no feature like sparse fetch/pull in git,
this means that ALL objects in unrelated trees are always fetched.
It may take a lot of time for large repositories and results in some
practical scalability limits for git.
This forced some large companies like Facebook and Google to move to
Mercurial as they were unable to improve client-side experience with
git while Microsoft has developed GVFS, which seems to be a step back
to CVCS world.

I want to get a feedback (from more experienced git users than I am)
on what it would take to implement sparse fetching/pulling.
(Downloading only objects related to the sparse-checkout list)
Are there any issues with missing hashes?
Are there any fundamental problems why it can't be done?
Can we get away with only client-side changes or would it require
special features on the server side?

If we had such a feature then all we would need on top is a separate
tool that builds the right "sparse" scope for the workspace based on
paths that developer wants to work on.

In the world where more and more companies are moving towards large
monorepos this improvement would provide a good way of scaling git to
meet this demand.

PS. Please don't advice to split things up, as there are some good
reasons why many companies decide to keep their code in the monorepo,
which you can easily find online. So let's keep that part out the
scope.

-Vitaly
