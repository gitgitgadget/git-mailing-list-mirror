Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB4C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 22:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJCWGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 18:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJCWGF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 18:06:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49411DEB8
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 15:06:01 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id cb7-20020a056a00430700b00561b86e0265so649830pfb.13
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=T0JERAkoNRWVTnmUrdu4PVqMmX9fLM4QP4RTL7clVME=;
        b=m9vNVx6inWPV67DBQypouf3Wlw/+46K9+D7wqQPFSuYzrYbyCIP/ZE3RfWMbqKhw2V
         pBZP534nHKKdRgJPbC4+E4aZCLwTdhaoXp6wRG5dlFZsp71F3BR3Moikood2OfRTlGET
         GJByXYPco6haUgHrAJH2ndce8kqL8YmXxZ/Z2/V4Iun/jcDNp+qOI2fJK6qWS7+MAYhZ
         35ih1DnKCcUG9OdPnXyMeW8E3spq70/5RfvuCNdS8aQ0/CDcBvf6SZPnd01dpSCo33vT
         4gYsGh22sYXRZOR5qtNaFD/UucH9H08TJl7vni6xkNDttaKUBCrj+sKVAOBl6FKHN7aa
         A5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=T0JERAkoNRWVTnmUrdu4PVqMmX9fLM4QP4RTL7clVME=;
        b=dtsEL4fYNYwUa18nh0mRnKJAdPYrtkVwUDltK2IisL9vFxPg+j8S4VNLgbYcKsP2H3
         Q3hvezM7WJjkMuuAXbUpJmsKLiHJiAKg/GesFw1gEGPhdKvh+JIFZZoqA0eEGF9/N1WQ
         fbd04gkiW4F0KCogqINxBO59LJzRxQ7ifckctUhIUjaeKqW9kVbdxQIYCc2ror0pk1ej
         2taIuRFJckow3diT1vdGh60zK0uCsC3LeJ42e0s5FDHxo3UelfmGrA+IiTfP1U7TvJkZ
         kbD0Tz7RholvDUf/xIIilO9Mau0lf8tGke0BWH6/VduBKuGNF/NDnBjazYEntywGdVDv
         +MIQ==
X-Gm-Message-State: ACrzQf2hoSux9o9D/GbLUbztwqS0r+V3U+j+korq0cRcjcqm6l360CEe
        PCMgkPIdwsCkcaTNXIYpnCafaE0Z/lH9oMAeiYtukLgXFZJG1bdVFDyWVkxJBsy/J2ZkeJxrmMp
        c8XG/7chkoFMZ0KZeafZK7XygYwls3pvJGBCRqk4oqNW9R5geQVcA+d6QZ4GfNOI=
X-Google-Smtp-Source: AMsMyM4eMkYA6hQ1Xb0dIieqwaGQU3438UVzyqz76vIiNxFkD54jwO9Yh3q7cRN4DmQe1HKUvW2QTbigQfp7uA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:186:b0:178:3af4:87b3 with SMTP id
 z6-20020a170903018600b001783af487b3mr24030204plg.117.1664834760716; Mon, 03
 Oct 2022 15:06:00 -0700 (PDT)
Date:   Mon, 03 Oct 2022 15:05:52 -0700
Mime-Version: 1.0
Message-ID: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Bug report: `git restore --source --staged` deals poorly with sparse-checkout
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Cc:     martinvonz@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Filing a `git bugreport` on behalf of a user at $DAYJOB. I'm also pretty
surprised by this behavior, perhaps someone who knows more could shed
some light?

What did you do before the bug happened? (Steps to reproduce your issue)

  git clone git@github.com:git/git.git . &&
  git sparse-checkout set t &&
  git restore --source v2.38.0-rc1 --staged Documentation &&
  git status

What did you expect to happen? (Expected behavior)

I expected to see staged changes only, since I restored only paths
outside of my sparse spec (which was t/, plus the implicit root
directory).

What happened instead? (Actual behavior)

I saw a staged modification (Documentation/cmd-list.perl) and the same
file reported as deleted in the working copy. Specifically,

  $ git status

  On branch master
  Your branch is up to date with 'origin/master'.

  You are in a sparse checkout with 64% of tracked files present.

  Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
          modified:   Documentation/cmd-list.perl

  Changes not staged for commit:
    (use "git add/rm <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
          deleted:    Documentation/cmd-list.perl

What's different between what you expected and what actually happened?

git status should not have said that the file was deleted in the
working copy

[System Info]
git version: git version 2.37.3.998.g577e59143f-goog
cpu: x86_64 no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.17.11-1rodete2-amd64 #1 SMP PREEMPT Debian
5.17.11-1rodete2 (2022-06-09) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash
