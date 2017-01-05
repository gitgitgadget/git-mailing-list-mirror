Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E64020756
	for <e@80x24.org>; Thu,  5 Jan 2017 02:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030354AbdAECfc (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 21:35:32 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:35091 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030356AbdAECfb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 21:35:31 -0500
Received: from homiemail-a61.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 52BCCA32EC
        for <git@vger.kernel.org>; Wed,  4 Jan 2017 18:35:20 -0800 (PST)
Received: from homiemail-a61.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTP id A4277578077
        for <git@vger.kernel.org>; Wed,  4 Jan 2017 18:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:from:date:message-id:subject:to:content-type; s=
        bit-booster.com; bh=Uc+l2zp1jW5NCUmULQmVlQVBXEY=; b=qpV7Vud/0DdW
        xvGvgcSAmJyisRdBwYw5nowdO7ArvZ6rS5w6aTbgnr38E12WLdn+qhBgmjIemtGI
        TyCtQyPRWcSIF5llwMNv0Pz7ZeJFkfo30SzCSSq3pgVhAe+XWOdK1TrDV6wnwJ4q
        NbCgUWPNX+diLCgnp94YN9hL0wbN0lg=
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTPSA id 88522578071
        for <git@vger.kernel.org>; Wed,  4 Jan 2017 18:34:19 -0800 (PST)
Received: by mail-yw0-f169.google.com with SMTP id t125so331181662ywc.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 18:34:19 -0800 (PST)
X-Gm-Message-State: AIkVDXKz9nGwAf4P2gETjmkv8GBAh74sgeu/6YNeIdA/NZkxvcZnPUovvoVr1qiQU2com2Mq9kySwiClDk1nGQ==
X-Received: by 10.129.40.141 with SMTP id o135mr60342178ywo.149.1483583658902;
 Wed, 04 Jan 2017 18:34:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.56.132 with HTTP; Wed, 4 Jan 2017 18:34:18 -0800 (PST)
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Wed, 4 Jan 2017 18:34:18 -0800
X-Gmail-Original-Message-ID: <CAAj3zPz-jMVoxNTRZ0iR1ZPTFh873gEo33QjynBE1vaHsMmg3A@mail.gmail.com>
Message-ID: <CAAj3zPz-jMVoxNTRZ0iR1ZPTFh873gEo33QjynBE1vaHsMmg3A@mail.gmail.com>
Subject: RFC: --force-with-lease default behaviour
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now the default variant does this:

> --force-with-lease alone, without specifying the details, will protect all remote refs that are going to be updated by requiring their current value to be the same as the remote-tracking branch we have for them.

The problem is people sometimes run "git fetch".   And so "git push
--force-with-lease" is going to do the push even if the local version
is stale.

Instead I think the default behavior should require that the remote
ref's current value be equal to the merge-base of the local-branch and
remote-tracking-branch.

Here's an example (password is "test" for the push):

git clone http://test@vm.bit-booster.com/bitbucket/scm/bb/a.git
cd a
git checkout bugfix/TKT-123
git reset --hard HEAD~1   (to simulate situation where local is stale,
but remote is up to date)

At this point "git push --force-with-lease" is going to work.   But I
think it shouldn't.   (Note: I use push.default = simple).

Here's how I think it should work:

git push --force-with-lease=bugfix/TKT-123:$(git merge-base HEAD
origin/bugfix/TKT-123)
To http://vm.bit-booster.com/bitbucket/scm/bb/a.git
 ! [rejected]        bugfix/TKT-123 -> bugfix/TKT-123 (stale info)


For now I'm happy with this alias:

git config --global alias.please '!sh -c "git push
--force-with-lease=$(git rev-parse --abbrev-ref HEAD):$(git merge-base
HEAD @{u})"'

But I'd like to put together a patch if people are interested in a
tweak like this to the --force-with-lease default behaviour.  I
haven't written much C in my life, but thought this might make a good
force-myself-to-learn-C exercise.


- Sylvie Davies

ps.  I never thought about the fetch problem with --force-with-lease
until reading https://developer.atlassian.com/blog/2015/04/force-with-lease/
and https://buddyreno.me/git-please-a182f28efeb5#.s291gh5jn , so
thanks to them!
