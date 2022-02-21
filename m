Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B149FC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiBUTQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:16:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiBUTQR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:16:17 -0500
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 11:15:53 PST
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B23C22531
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:15:53 -0800 (PST)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 81FAD200A2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 14:06:18 -0500 (EST)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1nME0o-N83-00
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 20:06:18 +0100
Date:   Mon, 21 Feb 2022 20:06:18 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: rewinding interactive rebases
Message-ID: <YhPiqlM81XCjNWpk@ugly>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="JTdL+UDR2099qub7"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JTdL+UDR2099qub7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

heya,

this post is basically a continuation of 
https://public-inbox.org/git/CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com/ 
("Is there any way to "interrupt" a rebase?"), but i thought it's 
probably better to start a new thread rather than to revive a zombie.

the basic problem is that during significant reworks of (complex) 
branches, one will inevitably find oneself in the situation of wanting 
to "go back" in the process. fixup commits aren't always optimal, as 
subsequent re-ordering may cause conflicts. doing the amend in the right 
place to start with cuts away one of the conflict resolutions.

the solution to this is actually rather simple, as demonstrated by the 
attached script.

somebody feels like rewriting this as a nice 'git rebase --rewind' 
subcommand?

thanks

--JTdL+UDR2099qub7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-rebase-rewind

#! /bin/bash
# Copyright (C) 2022 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
#
# You may use this file under the terms of the 3-clause BSD license.

gitdir=$(git rev-parse --git-dir) || exit

if ! git diff --quiet HEAD; then
    echo "Working directory or index not clean." >&2
    exit 1
fi

rbdir=$gitdir/rebase-merge
if ! test -d "$rbdir"; then
    echo "No rebase ongoing?" >&2
    exit 1
fi

onto=$(<"$rbdir/onto") || exit
todo=$rbdir/git-rebase-todo

git log --reverse --pretty="tformat:pick %h %s" $onto.. > "$todo.new" || exit
(echo "break"; echo; cat "$todo") >> "$todo.new" || exit

mv "$todo" "$todo.old" || exit
mv "$todo.new" "$todo" || exit
if ! git rebase --edit-todo; then
    mv "$todo.old" "$todo"
    exit 1
fi
if ! test -s "$todo"; then
    echo "Empty todo; canceling rewind." >&2
    mv "$todo.old" "$todo"
    exit 1
fi
rm "$todo.old"
: > "$rbdir/done"

git reset --hard $onto || exit
git rebase --continue || exit

--JTdL+UDR2099qub7--
