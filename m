Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5CF1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 15:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeBIPye (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 10:54:34 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:35511 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeBIPye (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 10:54:34 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:45624 helo=android-a172fe96dd584b41)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ekB0T-0006Cw-Ct
        for git@vger.kernel.org; Fri, 09 Feb 2018 10:54:33 -0500
Date:   Fri, 9 Feb 2018 10:54:31 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@android-a172fe96dd584b41
To:     Git Mailing list <git@vger.kernel.org>
Subject: should "git bisect skip" not visually reduce number of revisions
 left?
Message-ID: <alpine.LFD.2.21.1802091045380.25356@android-a172fe96dd584b41>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  perhaps i'm misreading something, but i'm trying to put together a
hands-on example on how to use "git bisect" with feature branches as
explained here:

https://blog.smart.ly/2015/02/03/git-bisect-debugging-with-feature-branches/

and i'm using the linux kernel source as the content, so i started a
bisection session with:

$ git bisect start v4.15 v4.14
Bisecting: 8497 revisions left to test after this (roughly 13 steps)
[5d352e69c60e54b5f04d6e337a1d2bf0dbf3d94a] Merge tag 'media/v4.15-1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
$

  so far, apparently, so good. now i'm running the script:

  for rev in $(git rev-list v4.14..v4.15 --merges --first-parent) ; do
        echo "=== ${rev} ==="
        git rev-list ${rev}^2 --not ${rev}^
        git rev-list ${rev}^2 --not ${rev}^ | xargs git bisect skip
  done

so students can see the "git bisect skip" operations happening (there
will be 435 of them). first few lines of output verifying the opening
skip operations:

=== 24b1cccf922914f3d6eeb84036dde8338bc03abb ===
1df37383a8aeabb9b418698f0bcdffea01f4b1b2
Bisecting: 8497 revisions left to test after this (roughly 13 steps)
[5d352e69c60e54b5f04d6e337a1d2bf0dbf3d94a] Merge tag 'media/v4.15-1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
=== 32c6cdf75c9270848d2d0ed7c814eba05b47081f ===
dd085168a74c99c3ebe7f813069e412eb8444243
8a95b74d50825067fb6c8af7f9db03e711b1cb9d
36b3a7726886f24c4209852a58e64435bde3af98
5beda7d54eafece4c974cfa9fbb9f60fb18fd20a
1d080f096fe33f031d26e19b3ef0146f66b8b0f1
7e702d17ed138cf4ae7c00e8c00681ed464587c7
40d4071ce2d20840d224b4a77b5dc6f752c9ab15
Bisecting: 8497 revisions left to test after this (roughly 13 steps)
[5d352e69c60e54b5f04d6e337a1d2bf0dbf3d94a] Merge tag 'media/v4.15-1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
=== 07b0137c0268b8d0694a5f09284449353a1a6fed ===
... and so on ...

  what's weird(?) is that, while it's running right now, every "git
bisect skip" operation doesn't change the apparent number of revisions
left to examine -- it's always:

  Bisecting: 8497 revisions left to test after this (roughly 13 steps)

is that not supposed to change to reflect the increasing number of
revisions to skip? or does that stay the same for the entire process
until i start to bisect? or am i just doing something wrong?

rday
