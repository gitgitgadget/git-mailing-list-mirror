Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A58C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 14:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbiHTOwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbiHTOwD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 10:52:03 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3E54DB4C
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 07:52:02 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id bj43so3555197vkb.4
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=0CCCvJqWD1f48tJwKmCzI/R6C4zf9k0GOs86jYk12nw=;
        b=p5u1XwvC4Unp0lLScPjOsbgnJbTE6DI3cVSantEtU2mqoyPSX2Q9y9u1RSVIabAV88
         j47VkhujKwOg61SDzpuk3lq4tRewjzy5tUBiWg6aZ8znKukIYqtrF3tZS5oyw8ONdwsW
         aHkqmYVaabqGp1Xw2iWWA2cVRsiJhgfpa+lR1qrsYTJpp07D68BDKjp/fjTgONeKzVzF
         7PZoahy3nlhSOito8hdmpmm+UQu3Y79yTm4QfYSMomy6Oi2F1Sju4W66NQ+fY18G0ByH
         KhJnsiovwy9YBQJkugV+AKL8vU6naefokjoL4bD+L1xoGEUS+JdGFjJxWAzfNysSbxMR
         qw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=0CCCvJqWD1f48tJwKmCzI/R6C4zf9k0GOs86jYk12nw=;
        b=3j8tBtoIycURvhYvo2Jk/ziPkrSwj039yKtcS3diMAcokP1nhtsUJCZpBRTpTNh0eH
         TzrSNFmWsqjXVK55t4l1hkd25Ow3tCh9vIiidk9Wsjd+Nmmpph766PcUBXrxKANG9Jqn
         a/3YOwYb0iQ+1TtgoNnGg7Swwhv/yEuaqvVtbVpvicRpMIACzssPe06+1e48pqmEoQYH
         t9tMsoRDPTxPYlgbEs99x1eS1ymjAxI344h92JzSdLOfYfkGTaVvdPo4UYHqbtst6lHv
         kiQrRPxMz+RNDgdPebzidrECS2Ucj0EO2P5BUFxSLKlb67VJ/Y8VzpSpCIunH6luzrOh
         UixQ==
X-Gm-Message-State: ACgBeo3ivJlRvKRF4GUYD39vSeGULhbGFeiEwt4YcKLoM1M8V4rmMeyP
        AwhH2xhNP0siM9Flw8vuHFcGFnKQAbS+KCR618Sxr87flvg6bQ1N3vbPQA==
X-Google-Smtp-Source: AA6agR7XVcuzBpRzIEZlGuPjsHePVJe9E+LmQyG6QnwokUY3TOEhRYKf45InYd/TzKl7pV74ajeznXeW4aZkuCht7Vc=
X-Received: by 2002:a05:6122:43:b0:379:35aa:69ec with SMTP id
 q3-20020a056122004300b0037935aa69ecmr5089705vkn.15.1661007121409; Sat, 20 Aug
 2022 07:52:01 -0700 (PDT)
MIME-Version: 1.0
From:   squirrel <jatjasjem@gmail.com>
Date:   Sat, 20 Aug 2022 15:51:38 +0100
Message-ID: <CAAsFbAtu0vYhwa-Kb6dfpNBZ7jSLriVODi1s7H=-Deq9J6L0ww@mail.gmail.com>
Subject: `git range-diff` lists chunks with uninteresting changes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When someone makes a PR, they may be asked to rebase their feature branch onto
main to resolve conflicts. It may be useful to quickly see what changed during
the rebase, that is how the new version of PR is different to the old one.

If the PR branch has not been reparented, you may get away with `git diff`.
But if it has, `git diff` may contain a lot of changes from upstream. Instead,
`git range-diff` can be used.

The problem with this is that in this case `git range-diff` can show chunks
with changes that have nothing to do with changes in the PR. Consider this
repository (commands are runnable):

    git init
    git branch -m main
    echo -e "a\nb\nc\nd\ne\n1\n2\n3\nf" > file
    git add file
    git commit -am "a b c d e f"

    git checkout -b foo
    echo -e "a\nb\nc\nd\ne\n1\n2\n3\nfoo" > file
    git commit -am "f -> foo"

    git checkout main
    git checkout -b cat
    echo -e "a\nb\ncat\nd\ne\n1\n2\n3\nf" > file
    git commit -am "c -> cat"

We got a few letters of alphabet on separate lines on main, and in branch
foo `f` is changed to `foo`, and in branch cat `c` is changed to `cat`.

    $ git log --all --graph --pretty=oneline
    * 90e873e3 (HEAD -> cat) c -> cat
    | * 3d8c1baf (foo) f -> foo
    |/
    * 4d2337dd (main) a b c d e f

Now, still on cat, let's combine the two changes.

    $ git rebase foo
    Successfully rebased and updated refs/heads/cat

    $ git log --all --graph --pretty=oneline
    * 98e554a0 (HEAD -> cat) c -> cat
    * 3d8c1baf (foo) f -> foo
    * 4d2337dd (main) a b c d e f

Now, `git rebase foo` worked automatically, so *the change* of the last commit
on `cat` is the same as it was without rebase, which is changing `c` to `cat`.
But if we run `git range-diff`, we will see this:

    $ git range-diff 90e873e3...cat
    -:  ------- > 1:  3d8c1ba f -> foo
    1:  90e873e ! 2:  98e554a c -> cat
        @@ file
         +cat
          d
          e
        - f
        + foo

It seems that this chunk is included for the sole reason that the change from
`foo` is sort of close. If we try the same code, but put the lines `c` and `f`
further apart, for example by replacing `e\n` with `e\n1\n2\n3\n` in the
commands above, the output would be, as expected,

    $ git range-diff f1e0a6cc3...cat
    -:  ------- > 1:  4db06be f -> foo
    1:  f1e0a6c = 2:  cc56db7 c -> cat

I suggest not showing uninteresting chunks like that, or perhaps having a
command line option that controls how close together the changes must be in
order to be included in the output.
