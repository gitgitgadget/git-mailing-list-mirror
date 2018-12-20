Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9951F405
	for <e@80x24.org>; Thu, 20 Dec 2018 08:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbeLTIhf (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 03:37:35 -0500
Received: from mail-vs1-f46.google.com ([209.85.217.46]:45257 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbeLTIhf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 03:37:35 -0500
Received: by mail-vs1-f46.google.com with SMTP id x28so537504vsh.12
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 00:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=np3M4iPKwsRT/HXgZ3r0OymbD8xwrF0mPTWoMUH80no=;
        b=uIbVb6R7Xdei+XvwL9BUgdQra8VsWwqnxtde2rNQjgJh9eVtTM4wm+A2C9itbuRnpx
         8A+7Oh2dc3z26RbUFNWsvhcrWc5Sf5NKTnAz7aTW4jApa3sitzQ1Xtj8xOsmCelhUbX7
         /9UaeVsZYaYVk+RHxr5G42AMZ4XgAeEAGKtRZYbdwpFJE9fQ/DunmfZOCDohDAaKfOO4
         emwwF3lm1CdDfbnvJ0tf/JWEAa8t9oJU3ZmQz3d/mSLm61IZVRELnxzdl/rDqFzsN1lU
         AYyZuaCVlYJgx7aEO8lkM/sk/lkQefKvL0/fG4QZptylplCU56JDjkJ/+WhbYJecDRPm
         ginw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=np3M4iPKwsRT/HXgZ3r0OymbD8xwrF0mPTWoMUH80no=;
        b=luYhuy7DicFzvjpLzITFozFE8gsQmzxaFwJN0RAcIWvEU98G9VBCqxHMXuuij44Hzc
         NHnnlrMuOk3xGixQvkwl3lqNCbXjghaNDO5rqR4M+aL+xHwphdKPzDVFKIBVQ80bWOKf
         +PGy1K8pap+X/C0Tn4jF487W5Gek9+ynJ1c54zGjhUlQr6ldSVPe2NgUZP1LGH6yX4aL
         EsXY/xotYkkA3+KdcdCslCmTabx/O5S8JfpP/7VHfdcEXPA5YOiRoxMByZbtWNG/QD+R
         RDHM9mCT2BRfmuvfWu9Q4chs1UFOlUjoHlQt4/8Y9XlGNMaxDIC2h+aEMAajnv4Dk9y9
         aaHQ==
X-Gm-Message-State: AA+aEWZvTTar/CbNlc2lGxxMajbt5C6Ovo+wOuey5BWZmhEAzgmxIiF5
        nvifcbIcH5EnkdOpd4Bpm55buD+hdmIlwue4Uhelnnpp
X-Google-Smtp-Source: AFSGD/Xt4H+xD+kGl4yppZIlWGsovYv+U2aj5db07oKZ1axMnqDbBRtluOHiwroiHOqNVE87FxpEny2Y1NK/D8vm1bA=
X-Received: by 2002:a67:334a:: with SMTP id z71mr11910840vsz.40.1545295053399;
 Thu, 20 Dec 2018 00:37:33 -0800 (PST)
MIME-Version: 1.0
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Thu, 20 Dec 2018 10:37:21 +0200
Message-ID: <CAGHpTBKyBgPURYfuZgVwnskGSy9L1+3WMrYuPmziQ7VcGDkMcA@mail.gmail.com>
Subject: A bug in git-add with GIT_DIR?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I played around with t5403-post-checkout-hook, and noticed that its
state is not exactly what I'd expect it to be.

The test setup is:
echo Data for commit0. >a &&
echo Data for commit0. >b &&
git update-index --add a &&
git update-index --add b &&
tree0=$(git write-tree) &&
commit0=$(echo setup | git commit-tree $tree0) &&
git update-ref refs/heads/master $commit0 &&
git clone ./. clone1 &&
git clone ./. clone2 &&
GIT_DIR=clone2/.git git branch new2 &&
echo Data for commit1. >clone2/b &&
GIT_DIR=clone2/.git git add clone2/b &&
GIT_DIR=clone2/.git git commit -m new2

Now, the line before the last one executes git add clone2/b with GIT_DIR set.

I'd expect that to add b inside clone2, but instead it adds an
inexistent clone2/clone2/b, and if I stop at this line, then the
status shows:

On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        new file:   clone2/b

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   b
        deleted:    clone2/b

Is this the intended behavior? It looks like that's not what the test
meant to do anyway...

And if I change it to (cd clone2 && git add b), then the commits look
reasonable, but step 6 fails.

- Orgad
