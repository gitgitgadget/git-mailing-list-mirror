Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A381FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbcHWQZX (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:25:23 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46960 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752483AbcHWQZW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 12:25:22 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D027E207E9
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 12:24:57 -0400 (EDT)
Received: from web6 ([10.202.2.216])
  by compute7.internal (MEProxy); Tue, 23 Aug 2016 12:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=imap.cc; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=Awj
        XWNm486ar5o18iE5O1P0IvT8=; b=t0BOT+4kcpxcj05FAw/QtaA0eGv2YwBMQ3C
        5+YHFkFWG93W4mgqGyTebYQUKbI8uWxgmgRV81aJA2C1CnSXvHZ/LB7t5kFjdQ/m
        UX2a9f7jRyAbg2VPPQHlY71q9HhAJVbeJg/OkJR9Ol+W31yTnJ/3gxSuXvAzS+Bd
        YaYO5fFU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=AwjXWNm486ar5o18iE5O1P0IvT8=; b=jjdMl
        u5pe1N4eNzsS/j7F/VStL6dzKYTnxNSBd9afcIuHT9ZoeAMqUK+5TghR+UMM2GNE
        CbuJUefEW7JdbQ96Q4MC/9NKlnU51Ask04t5AIoGjGo4lHxKpWURWo4ZFRIVEAiO
        UxOgI43ldOvHspKZp9E13tNZqfAhores7zkzU0=
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id A49501E380; Tue, 23 Aug 2016 12:24:57 -0400 (EDT)
Message-Id: <1471969497.3553135.703756633.0F6CCC4C@webmail.messagingengine.com>
X-Sasl-Enc: zj4e6KIAlLP7nSF01o1bbyfSIZVphbNf9CRqlb77oqrN 1471969497
From:   Joshua Phillips <jphillips@imap.cc>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Mailer: MessagingEngine.com Webmail Interface - ajax-668fb998
Subject: Possible bug: git pull --rebase discards local commits
Date:   Tue, 23 Aug 2016 16:24:57 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've found a case where git pull --rebase discards commits in my branch
if the remote-tracking branch was rewound (and the remote tracking
branch's reflog contains my branch's latest commit). This is due to
git-pull's usage of git merge-base --fork-point.

On one hand, this behaviour might be correct since the remote repository
essentially removed that commit from master by 'reset --hard'. On the
other hand, I was surprised that git pull --rebase discarded a commit in
my branch.

Tested on 1.9.1, 2.7.4 and 2.10-rc1.

Steps to reproduce:

    # Set up initial repository
    git init source
    cd source
    git config receive.denyCurrentBranch no # make 'git push' work - not
    relevant to bug
    echo hello > test
    git add test
    git commit -m "Initial commit."

    # Clone repository, make and push two commits.
    cd ..
    git clone source clone
    cd clone
    echo greetings >> test
    git commit -a -m "This commit is rewritten."
    echo something >> test
    git commit -a -m "This commit disappears."
    git push origin master

    # Discard the second and rewrite the first commit.
    cd ../source
    git reset --hard HEAD~ # remove "This commit disappears"
    git commit --amend -m "This commit is a rewrite."
    cd ../clone

    # Observe that "This commit disappears" is still in our branch but
    is not in origin/master
    git fetch && git log --graph master origin/master

    # Now git pull --rebase gets confused because origin/master used to
    point to "This commit disappears",
    # so it assumes that that was the fork point for master, and "This
    commit disappears" is discarded.
    git pull --rebase
    git log --graph # "This commit disappears" is completely gone!
