Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81254C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 16:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiFBQk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiFBQkX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 12:40:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173E913C1F1
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 09:40:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id rq11so11062691ejc.4
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=89yMiHLp5i8h0Y3NzAEviCtCZkrcIMp4uiTBFAeuap0=;
        b=LZXpz4Nb6yIqUzblu1v9cxYvHezkcAUCMjQwmCWY9Bakg11pNtmtiJhTeWNhY0H0ym
         xFzgfDLEt3xjpfmKVUtT3zc9sUFWSzJBoauSZ/SR6EF0gfGY/aBlR0Nuri3IXdDDYcDw
         WS7lyjjYPjQ+0KzYX9Lt7FBrg2Xuo4NIFW7fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=89yMiHLp5i8h0Y3NzAEviCtCZkrcIMp4uiTBFAeuap0=;
        b=mmt01jqXpc2d2cvl7c9C4GvwIuVZw+nrnvt/CXg+azE2euj5g9AC41JBFBwXJTu2hk
         t9jd+Fam3uIEINhHC8JXaRBDIc5HR2+5SemOxIm3uZL3GVV7BrqlKRcXjU3OlEX1Qxlv
         HA7MkPPGQHREtA9AYejRMUTVnd6rYidoD8DOh6yIV5TlZk0Dg3I7jyS2mSSFB4m+70X3
         i+lWtwN7NTwda97nRiLBHliQKy2Fm7ncwgrl7WR5/srS/mvfPt7ktWzvYgzNZex8Q2W6
         3UguzFHHknQPEpdeugLDW6JhUkk7XwGFlfQgsGNaMqv7mBQ0s6g5qKXYvZhP2ODQOS0U
         juvQ==
X-Gm-Message-State: AOAM530DV7F1pAsYW6tSd7XO5Oz46DhyrNOXTYI+SyZXYyEqkED7gcCS
        A4AOQTgrQFP1JBI0Z0n87NxKwlK/Lc7hLTiWL7NIBesqRINMV54O
X-Google-Smtp-Source: ABdhPJxWmyHHz1iHSo29xpDPh1w3m74GJVfhszidm1fah5Wcl2G7YrsR/pu0wJ8mhA4Jqxmcss07HsgRmC+aKLIAX2M=
X-Received: by 2002:a17:907:6e20:b0:6ff:1541:8d34 with SMTP id
 sd32-20020a1709076e2000b006ff15418d34mr4932165ejc.447.1654188020305; Thu, 02
 Jun 2022 09:40:20 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 2 Jun 2022 18:40:09 +0200
Message-ID: <CAPMMpohvKSgcL=X=Z=Wf7zHRr_Ghex5oZ4iUTgZL7XhHSWFi8g@mail.gmail.com>
Subject: Introduce "git stash --continue" and "git stash --abort"?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I've spent a little time trying to understand how git stash behaves,
and understanding the differences wrt how a "naive user" (eg me?)
would expect it to.

So far most of the differences are about defaults, eg:
* I would expect "git stash push" (or "git stash") to
"--include-untracked" by default
* I would expect "git stash pop" to include "--index" by default
* I would expect "git checkout" (or at least "git switch") to have an
"--autostash" option like "git rebase" and "git merge" do

There's one "bigger" thing though, that sounds like a whole project:
The behavior of "stash pop" in the case of conflicts is somewhat
traumatizing:

* My worktree is left in a "conflicted" state, and the only way to
"back out" seems to be some sort of "reset" (but good luck figuring
out which one, or how to revert the stash-based changes without
impacting any other uncommitted changes that I had in my worktree)

* If I "forge on", resolve the conflicts, and stage the conflicted
files... my stash stack still contains something that I didn't intend
it to, until/unless I remember to "git stash drop"... which is an
unsafe (non-idempotent / not-easily-reversible) operation...

I would expect that some sort of merge- or rebase-like "--continue or
--abort" facility would make this much easier to understand... but of
course I have no idea how one would go about doing that. I assume the
closest existing pattern would be "git cherry-pick", but I imagine I'm
missing lots of subtleties.

I understand Brian M. Carlson has been working on big changes around
stash export, and Victoria Dye has been working on Sparse Index
support, but I'm not aware of any other major ongoing work from
skimming the mailing list in the past months.

Is this kind of direction one that's been considered before? Are there
reasons why it's a bad idea?

Thanks,
Tao
