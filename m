Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5124E1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 11:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbeITQzm (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 12:55:42 -0400
Received: from forward24j.cmail.yandex.net ([5.255.227.60]:43384 "EHLO
        forward24j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbeITQzl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Sep 2018 12:55:41 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2018 12:55:38 EDT
Received: from mxback2o.mail.yandex.net (mxback2o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1c])
        by forward24j.cmail.yandex.net (Yandex) with ESMTP id 4EFF0277B9
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 14:05:25 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback2o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id UWlb42bSzh-5OTe28Cu;
        Thu, 20 Sep 2018 14:05:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1537441524;
        bh=nWsLMSMjoANV+BP5d7ulMK53GPgJa8SqhUZ7mZvEv64=;
        h=From:To:Subject:Date:Message-Id;
        b=CX9WVwYt2Gzrs8DaKvU3tm3VdXfFbWkcSrUjFZ/k5H1MREk0VbTX/4Gkmhhjrh1gW
         yKQied0UlfzJtP0XQAb8ZFTD14okaTJsbAjfpgA1llG/ZqKjVVsCLxq/Qc3vzix3wl
         CGWuOGn0rLGH4/9MJfswWQzOHdphURNPU66joXi8=
Authentication-Results: mxback2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva5-cb9df376e345.qloud-c.yandex.net with HTTP;
        Thu, 20 Sep 2018 14:05:14 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git <git@vger.kernel.org>
Subject: Work is not replayed on top while: git pull -v --rebase
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 20 Sep 2018 14:05:14 +0300
Message-Id: <6160201537441514@iva5-cb9df376e345.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

TL;DR; Some local commits are lost while `git pull -v --rebase`

[alias]
    tree        = log --graph --decorate --pretty=oneline --abbrev-commit
    changes     = log --graph --decorate --pretty=oneline --abbrev-commit --cherry-pick --boundary --left-right

<HERE I do some work, commit it and push>

<after some time>

$ git fetch origin 
remote: Counting objects: 806, done.
remote: Compressing objects: 100% (197/197), done.
remote: Total 806 (delta 587), reused 806 (delta 587)
Receiving objects: 100% (806/806), 85.96 KiB | 0 bytes/s, done.
Resolving deltas: 100% (587/587), completed with 19 local objects.
From https://tracker.feel-safe.net/gitdev/main
 + a562406d...f9015227 296_tos    -> origin/296_tos  (forced update)

Here we see that someone did 'forced update'

$ git tree -n 5
* a562406d (HEAD -> 296_tos, back) Bulk changes         ### <<< PUT ATTENTION HERE
* 177e2515 Bulk changes
* 934bbb31 Fix Profile Page
* 811d8812 Fix button's width on Authorization form
* 97ca9419 Fix Tariff Options page

Here git know that a562406d already pushed to remote

Now I want to update my branch

$ git pull -v --rebase
From https://tracker.feel-safe.net/gitdev/main
 = [up to date]        296_tos                    -> origin/296_tos
....
 = [up to date]        text-page-style            -> origin/text-page-style
Changes from f66c29158a57d687aaf48fb89f9b897563c0142e to f9015227da20ad1f858174b4b4c188338eb26640:
 cpanfile                                |   4 +
....
 templates/v2/tos/tos.html.ep            |   4 +-
 31 files changed, 1694 insertions(+), 106 deletions(-)
 create mode 100644 lib/DbMapper.pm
....
 create mode 100644 t/DbMapper/update_data.t
First, rewinding head to replay your work on top of it...

$ git tree -n 5
* f9015227 (HEAD -> 296_tos, origin/296_tos) Bulk changes
* 95064421 Fix Profile Page
* c03c930a Fix button's width on Authorization form
* e6df0662 Fix Tariff Options page
* 22b5c754 Fix header on order page

$ diff <(git show f901522) <(git show 177e2515)
1c1
< commit f9015227da20ad1f858174b4b4c188338eb26640
---
> commit 177e2515eb2bc1c9733b4374f2da373aa969a601

$ git changes a562406d...f9015227
>   50e9343a Merge branch 'orm' into dash_v2
|\  
| > 4be5e3c6 Test data fetching from DataSet
| > 11d60181 More tests: Manual condition OP for join expression
....
| < a562406d (back) Bulk changes
o f66c2915 (origin/dash_v2, dash_v2) Merge branch 'move_example_elements' into dash_v2

We can see that a562406d after rebasing **is lost**


Why a562406d is not applied on top of remote branch?

PS. for `git push --force` there is alternative: --force-with-lease
Is there something similar to --force-with-lease but for `git pull -v --rebase`?
