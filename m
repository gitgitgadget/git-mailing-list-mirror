Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFF51F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 15:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfJJP02 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 11:26:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41342 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJJP02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 11:26:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id f20so5833394edv.8
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4YhqaCRtXwStRfhM3+ZPFLYlH4B5DN/zgwkXb/qwIf4=;
        b=qDoD5qhElbpzwFYSzAXaKgsn1xLoUXrjAI0S8TYPGlafcOmZZzga4RKpdGPak1zyiR
         4g9Thlwh7XWCndgH8Kgg6lff6NIHjPF/X/Jf9uJCiUgF5u2v6+DfsuKgtHl7IDNWGXJN
         X7gsy9al4R4STiKcEUBifd/asP6fkFvok988cxPDfJub4pIP1n/tMLEw514JWaMoDbxn
         Dz6Q/1O+pnue0YqBQXpA67dfhoENvnJU+dqOx6OLqliXDWLivfCHnbLnz7cYC5H/Lao5
         na+anzztGEQro3EsiumItirAZ4KVuh3vaTHcx/+8vTjF1YLywBMzOvq20q1vf/Rblq2l
         foqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4YhqaCRtXwStRfhM3+ZPFLYlH4B5DN/zgwkXb/qwIf4=;
        b=GQckPnKwFcOLymKddw899oSKrClsTnA9VltynmC8su0M+rSLO7iOeDwMXi4Et3pryK
         AMIofQHxEhgB+Z1GTzefcapE1fD1vZFkaYRuocyOMiLTDEHqbzWLrCs620ErYdq7EtAe
         aFfefi8yl+iQLUvM4itTAb04qnLJBtImpyzW8u0nJNlWlhCLEwPjHKjxBnhucAGRYzsY
         UiEBlKhqWrkLkytEM74e4k22cKrX/G7cqkzk0sw8dAcgH19P5Fq/i5VGLWtzjXxrLqig
         IyC5ls6clCCR9oJRlE9M7ZCVx8NoQtPdXo6b8+FKrOkMJ2+3pRWcdp8UZ3AjO+3kQZTA
         a0CQ==
X-Gm-Message-State: APjAAAW74GW6JzzOlDDSM1C9iTZ+/J683yZPFTzUaFWpOeba+q/ic9K9
        dYxNAvo2rH7AeIEBvnaSkt5YPPkBlGl4CYfBasVynU4D
X-Google-Smtp-Source: APXvYqynbpaa7hNlgHe6g3eFbyZIuiEXxhH3g0RA/fT9ha71ZrX1XXNRi5DlDRm32X2MJWEiGD2ZW+GfjwdpedJJ0pU=
X-Received: by 2002:a17:906:154a:: with SMTP id c10mr8440141ejd.238.1570721186519;
 Thu, 10 Oct 2019 08:26:26 -0700 (PDT)
MIME-Version: 1.0
From:   Jakob Jarmar <jakob.j@gmail.com>
Date:   Thu, 10 Oct 2019 17:26:10 +0200
Message-ID: <CA+xNDHseTCoD+7Vbb4AG0kt9itXn0Z1Kto0vDjF9bBn+Fuk3TA@mail.gmail.com>
Subject: Possible bug in git stash with submodule.recurse
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I ran into an issue where git stash seems to be losing modified content
from submodules without warning, if submodule.recurse is true. See
below for an example:

1. enable submodule.recurse:

~ $ git config --global submodule.recurse true

2. create the repo to be used as a submodule:

~ $ git init sub
Initialized empty Git repository in /home/jakob/sub/.git/
~ $ cd sub/
~/sub $ touch sub.txt
~/sub $ git add sub.txt
~/sub $ git commit -m initial
[master (root-commit) 651a90c] initial
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 sub.txt
~/sub $ cd ..

3. create the main repo, add sub as a submodule:

~ $ git init main
Initialized empty Git repository in /home/jakob/main/.git/
~ $ cd main/
~/main $ touch main.txt
~/main $ git add main.txt
~/main $ git submodule add ../sub/
Cloning into '/home/jakob/main/sub'...
done.
~/main $ git commit -m initial
[master (root-commit) 2f9f4e8] initial
 3 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 100644 main.txt
 create mode 160000 sub

4. make *both* main and sub dirty (if main is clean, stash does nothing):

~/main $ echo changes > main.txt
~/main $ echo changes > sub/sub.txt
~/main $ git diff sub/
Submodule sub contains modified content

5. git stash and git stash pop:

~/main $ git stash
Saved working directory and index state WIP on master: 2f9f4e8 initial
~/main $ git stash pop
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   main.txt

no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (00a38b73407e7e3041c9459ef6d61bc90940b91f)
~/main $ git diff sub/
~/main $

At this point, I can't seem to find any way to retrieve the changes
made to sub/sub.txt.

Thanks,
Jakob
