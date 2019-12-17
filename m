Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E432C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354752064B
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLQLFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:05:04 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40301 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfLQLFE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 06:05:04 -0500
Received: by mail-wr1-f45.google.com with SMTP id c14so10818597wrn.7
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 03:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rHcVBCoBsSlc8Y25AXCInGoMk6tE88rJ75xUXP12mQ=;
        b=gnlADFZGUS1G9uziLv5ZkyJTer8Y/ZUA/vFLd3KaqB4Tq+kTGmkkgHW4jMhvRskNeJ
         F8+ln3XcsQ9791i1yAGXzeFrqqeRABiGjYSZ0q4Q+dm3AwYa7lh4cdVoC3APkJ3nA1mp
         GZVQMD4cJzK1al3NScjXC9VzeUxxnNtNpfrtQvB/J/kmnd+oLmRZGm3cy20j0rEV7MwN
         fzlI2DvgBuGlx+iccvlfG5AvG2ZYAhE2VOyVGIRqh4xR6Wa+ITSb0Yd9fKDKw/XvX7nU
         wR5Ny4c7G8ZU+AlJ+aBwEDY9+G3i0IDed1cJ7o8weCuYRWHzeOMbifADIw3EAu+O69c/
         5BbQ==
X-Gm-Message-State: APjAAAWzSDt08wOezrVZoNRq1viio4T7dyH5m5RY+y6TglmsoQCyKv3P
        L0CR+NrtuyOMpLGmXekofJTM+n1sfWJMYK7wgFxMIw==
X-Google-Smtp-Source: APXvYqy0pVChJMcu1P6YwjsLDas/TzG47ucvJmWirS1Si9LSJdTZdCrViSakYy+Bp+zIPJFELX+7KuY6O7sut3/orNY=
X-Received: by 2002:adf:df90:: with SMTP id z16mr38599100wrl.273.1576580701714;
 Tue, 17 Dec 2019 03:05:01 -0800 (PST)
MIME-Version: 1.0
References: <CA+PLxnUR2skor9CGfDKfEEm8XTmoHwM2cDf5Kpgt-ppo=4zhbQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1912152209020.46@tvgsbejvaqbjf.bet> <CA+PLxnWLWckpZdjy8XQLbO0EVJ1khiyUYi1T=Mcy_rBkvbLpZA@mail.gmail.com>
 <20191217073306.GA3313061@coredump.intra.peff.net>
In-Reply-To: <20191217073306.GA3313061@coredump.intra.peff.net>
From:   Mikael Simonsson <m@mikaelsimonsson.com>
Date:   Tue, 17 Dec 2019 11:04:50 +0000
Message-ID: <CA+PLxnVzu0zDtpT2T660UGhZ0RvFcq50nPfZz9Que7_7mqiSyQ@mail.gmail.com>
Subject: Re: Bug? git commit fileA tries to delete fileB and other oddities
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git bisect made that pretty easy, thanks. It looks like it started
with this commit:

"unpack-trees: optimize walking same trees with cache-tree"
https://github.com/git/git/commit/b4da37380b7774248086f42bcd59397a44e1ac79

(I ran git bisect between tags v2.19.2 and v2.20.0.)


Testing the commit in question:
% git checkout b4da37380b7774248086f42bcd59397a44e1ac79
% gmake -j 6 NO_OPENSSL=YesPlease NO_PERL=YesPlease NO_TCLTK=YesPlease
NO_GETTEXT=YesPlease NO_EXPAT=YesPlease all

% ~/tmp/git-source/git version
git version 2.18.0.751.gb4da37380b

% ~/tmp/git-source/git commit null_terminated.hh

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
# Your branch is up to date with 'origin/master'.
#
# Changes to be committed:
#       deleted:    algo/find.hh
#       new file:   app/.reserved
#       deleted:    ascii/contains_icase.hh
#       deleted:    ascii/contains_icase.test.cc
#       modified:   null_terminated.hh
#
# Changes not staged for commit:
Aborting commit due to empty commit message.


Note that the latest version behaves differently (it tries to delete
another file):

% git version
git version 2.24.1

% git commit null_terminated.hh

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
# Your branch is up to date with 'origin/master'.
#
# Changes to be committed:
#       deleted:    defer.hh
#       modified:   null_terminated.hh
Aborting commit due to empty commit message.


The commit before "unpack-trees: optimize walking same trees with
cache-tree" works as it should:
% git checkout b4da37380b7774248086f42bcd59397a44e1ac79^
% gmake -j 6 NO_OPENSSL=YesPlease NO_PERL=YesPlease NO_TCLTK=YesPlease
NO_GETTEXT=YesPlease NO_EXPAT=YesPlease all

% ~/tmp/git-source/git version
git version 2.18.0.750.g0d1ed5963d

% ~/tmp/git-source/git commit null_terminated.hh

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
# Your branch is up to date with 'origin/master'.
#
# Changes to be committed:
#       modified:   null_terminated.hh
#
# Changes not staged for commit:
Aborting commit due to empty commit message.


Here's my local commit from about a week ago when the problems started.

I'm sure I ran "git commit readme.md" because I had several files
staged. The commit pulled in 3 staged files (I think there were more)
and deleted 3 files that 100% weren't staged.

% git show --numstat 7d5d43d849f1391b3cc11f12e037b8cb5174e3a3
commit 7d5d43d849f1391b3cc11f12e037b8cb5174e3a3
Author: Mikael Simonsson <m@mikaelsimonsson.com>
Date:   Sun Dec 8 10:38:38 2019 +0000

    Add short info and requirements for ranges

56      0       algo/find.hh
0       1       app/.reserved
16      0       ascii/contains_icase.hh
28      0       ascii/contains_icase.test.cc
0       41      bench/bench.hh
0       41      debug.hh
76      0       readme.md

-Mikael



On Tue, Dec 17, 2019 at 7:33 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Dec 16, 2019 at 09:50:33AM +0000, Mikael Simonsson wrote:
>
> > I will try to recreate the problem with a new repository.
> >
> > So far I think I've narrowed it down to a bug introduced in git 2.20.0.
> >
> > Not buggy:
> > [...]
>
> If you can build Git from source, you might try using "git bisect" to
> find the exact commit where the problem starts.
>
> > The buggy versions all try to delete fileX when running "git commit fileA":
> >
> > % git commit fileA
> >
> > # Please enter the commit message for your changes. Lines starting
> > # with '#' will be ignored, and an empty message aborts the commit.
> > #
> > # On branch master
> > # Your branch is up to date with 'origin/master'.
> > #
> > # Changes to be committed:
> > #       deleted:    fileX
> > #       modified:   fileA
> > #
> > # Changes not staged for commit:
>
> Is there anything about "fileX" and "fileA"'s names that might be
> relevant? E.g., might they case-fold to the same name or something?
>
> -Peff
