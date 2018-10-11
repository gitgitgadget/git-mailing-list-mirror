Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40471F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 09:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeJKQrO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 12:47:14 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40689 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJKQrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 12:47:13 -0400
Received: by mail-ed1-f46.google.com with SMTP id r1-v6so7575339edd.7
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 02:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=jzngKKeDmhuGUWHOHaofYFCxiGaXfxvhj2odfZ+XkU0=;
        b=l2orVFzE6ivfFv+vttTQwFxOFs7kLPTTAcnWd/maOHujgdXgh4wwvqcHDqpw8cKaBj
         8dVWojzb6Vuyh2T4ux8CSpFYqZDRElQsioS+FBBTKL2En8oYv0ZizRVJxCpWcSsxSOm6
         29wI07ZfCm/UcsVq+9b4n8lrcJhMb+9zYJ9d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jzngKKeDmhuGUWHOHaofYFCxiGaXfxvhj2odfZ+XkU0=;
        b=bVjd+zjtMLtTsTkC7+If8ArzeZFUOLxf8FK5NmIOIuMTAWSEZrbQhzU0S3WPdPdeiI
         +Dw7IaDA7UI7DamRQ8Un7j0hiIkOVooeZdslkE+or9fRlWhD5RF5OriZ4wfWVXnwYXTD
         siz8PUGt0dSYDmPdoQgS8zXHAMnMoRYYP5dy9gRhnWl2aJFxro4N2A1/Bjh9a4muD1tI
         mdoy31LiBgGpEVIaLOgZYZvPI1KTGxp25XtGke53hmS9mxxYPO0ncs9xIlafM1K/SqWY
         f2zDdzzP/Tiwlrq5/4xeIRzyj4/gsVFeVGz0j3pHUSLAJMVceJmM4WrBqEgYiW4N++7p
         YWNg==
X-Gm-Message-State: ABuFfoiE9gbpcBZ5uP5rbS3YjPtg+F8EHxW35zSEr0FHTgdHeMsfniDv
        s/f37m/YMMByqXQMm1t25D5pMwbRqp+xKpoaf0meWjIiE4M=
X-Google-Smtp-Source: ACcGV63UroOjPYGEL03Qs7LNfkmfUsv4zkMv3zT+GqaG6ZRklS8HVrjITc69kdbiqvfk3h4txYpc0izDY8GhkeliLrk=
X-Received: by 2002:a50:b128:: with SMTP id k37-v6mr1579632edd.183.1539249647607;
 Thu, 11 Oct 2018 02:20:47 -0700 (PDT)
MIME-Version: 1.0
From:   Arturas Moskvinas <arturas@uber.com>
Date:   Thu, 11 Oct 2018 12:20:36 +0300
Message-ID: <CAGY-PBgsG-T3JY=awszwGMpFx+jDx-a1FcV0s6vR067bSqgZaA@mail.gmail.com>
Subject: Git wire protocol v2 fails fetching shallow changes with `pack has
 XXX unresolved deltas` on large repos with lots of tags Inbox x
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On large repositories with lots of tags - git wire protocol v2 fails
to fetch shallow changes, it fails with error `pack has XXX unresolved
deltas`. Unfortunately I didn't find easy way to reproduce it except
cloning+fetching chromium repository, the way jenkins does.
Reproduction steps:
```
$ git clone --mirror https://chromium.googlesource.com/chromium/src chromium
Cloning into bare repository 'chromium'...
remote: Sending approximately 12.66 GiB ...
remote: Counting objects: 8523271, done
remote: Finding sources: 100% (8399287/8399287)
remote: Total 19829104 (delta 11897257), reused 19828780 (delta 11897257)
Receiving objects: 100% (19829104/19829104), 20.45 GiB | 29.17 MiB/s, done.
Resolving deltas: 100% (11897257/11897257), done
$ mkdir chromium-test
$ cd chromium-test
$ git init
Initialized empty Git repository in /home/arturas/.git/
$ git -c protocol.version=2 fetch --tags file://$(pwd)/../chromium/
+refs/heads/*:refs/remotes/origin/* --depth=1
remote: Enumerating objects: 4614683, done.
remote: Counting objects: 100% (4614683/4614683), done.
remote: Compressing objects: 100% (1556691/1556691), done.
Receiving objects: 100% (4614683/4614683), 8.29 GiB | 24.71 MiB/s, done.
remote: Total 4614683 (delta 3470249), reused 3989191 (delta 2923800)
Resolving deltas: 100% (3470249/3470249), done.
From file:///home/arturas/chromium-test/../chromium
 * [new branch]                ignore/bar      -> origin/ignore/bar
 * [new branch]                ignore/foo      -> origin/ignore/foo
 * [new branch]                infra/config    -> origin/infra/config
 * [new branch]                lkgr            -> origin/lkgr
 * [new branch]                master          -> origin/master
 * [new tag]                   10.0.601.0      -> 10.0.601.0
...
$ git -c protocol.version=2 fetch --tags file://$(pwd)/../chromium/
+refs/heads/*:refs/remotes/origin/* --depth=1
remote: Enumerating objects: 642969, done.
remote: Counting objects: 100% (588314/588314), done.
remote: Compressing objects: 100% (240564/240564), done.
Receiving objects: 100% (571353/571353), 967.83 MiB | 10.52 MiB/s, done.
remote: Total 571353 (delta 372206), reused 497895 (delta 310113)
Resolving deltas:  99% (371726/372206), completed with 5582 local objects.
fatal: pack has 480 unresolved deltas
fatal: index-pack failed
$ git --version
git version 2.19.1
```
No changes are needed in mirrored repository. Crash happens both with
2.18.0 and 2.19.1 git versions. Having repository locally is not
required but reduces test runtime, you can quite reliably reproduce
issue when fetching over net directly from chromium.orgbypassing
mirroring step.

--
Arturas Moskvinas
