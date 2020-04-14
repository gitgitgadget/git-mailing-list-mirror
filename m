Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301B2C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CF12076A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="FgphWdnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633202AbgDNUd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:33:29 -0400
Received: from st43p00im-ztbu10073701.me.com ([17.58.63.183]:47762 "EHLO
        st43p00im-ztbu10073701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731389AbgDNUdY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 16:33:24 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2020 16:33:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1586896059; bh=/tKlcveqaUvljko4hr3lzYU5wVMWabhi0GOnuSuMXFc=;
        h=From:Content-Type:Subject:Date:Message-Id:To;
        b=FgphWdnP5XIXV6samOImWS9J94jx/0J70n/MLHPUiCfF9dRSQ1331iKzJRxamkFDm
         3YwLswU4Ry/1YMWdlS8A9fbCn6z+wBzi5QTiAZ7eNkUETlzxresrJZNUsm3AgRRq0I
         VQT2334n8aHhwJw2OdtsyBBey2eO8OrkJ6JTuUq38g0l8xULA7X+qZL5a85Czc88us
         OBQs7vKfvvP8Z9PQzhQlkfykxnbfLr2i6OulyRAWOM6xZ2TBBRx72U01XTzq98vUa8
         ORPnA/cxVJ+N0HnRvk93tYMTg3+kQ/gJrnwkbQFltw6Ysap8SROZRzw6nSqewoIbRs
         VQF7LhD1795eQ==
Received: from [192.168.1.127] (unknown [192.222.216.4])
        by st43p00im-ztbu10073701.me.com (Postfix) with ESMTPSA id AB8014C0B4C;
        Tue, 14 Apr 2020 20:27:39 +0000 (UTC)
From:   Philippe Blain <philippe.blain@me.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: rebase backend change interaction with rebase.abbreviateCommands and autostash
Date:   Tue, 14 Apr 2020 16:27:37 -0400
Message-Id: <34B51521-42CD-445B-AE91-4A659A7FE661@me.com>
Cc:     Elijah Newren <newren@gmail.com>
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_10:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2002250000 definitions=main-2004140145
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=20

I just had a bizarre error related to the change in the merge backend. I =
don't have a full reproducer yet but the following sequence should =
hopefully give some hints.

In my config for this repo I have `pull.rebase=3Dtrue` and in my global =
config I have=20

[rebase]
        abbreviateCommands =3D true
        autoSquash =3D true

Also my local `master` branch tracks `origin/master`.=20

If `master` on `origin` is at the same commit as my local master branch, =
and I have some uncommitted change so I must use `--autostash`:

```
$ git pull --autostash=20
Created autostash: 6a6c685
Applied autostash.
error: nothing to do

$ git pull --autostash --apply
# or right that just works for `git rebase`
```

Now if `master` on `origin` is ahead of my local `master`:=20

```
$ git pull --autostash=20
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 6 (delta 4), reused 0 (delta 0)
Unpacking objects: 100% (6/6), 758 bytes | 6.00 KiB/s, done.
=46rom <redacted>
   42033de..a3d6919  master     -> origin/master
Created autostash: cdae23b
Applied autostash.
error: nothing to do

Now if I stash manually and re-pull:

$ git stash push -m "test rebase merge"                                  =
                                                                         =
                                                                         =
=20
Saved working directory and index state On master: test rebase merge
$ git pull
Updating 42033de..a3d6919
Fast-forward
 .gitconfig | 1 +
 .tmux.conf | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
error: nothing to do
$ git pull
Already up to date.
error: nothing to do
$ git -c rebase.abbreviateCommands=3D0 pull
Already up to date.
Successfully rebased and updated refs/heads/master.

Note: I also got  "error: nothing to do"  when manually running the =
commands in the last test of t/t5572-pull-submodule.sh ("branch has no =
merge base with remote-tracking counterpart') (and again using `git -c =
rebase.abbreviateCommands=3D0` succeeded).

Cheers,
Philippe.

