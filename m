Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E962C00140
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 02:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiHVCZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 22:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiHVCZH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 22:25:07 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8041E3C6
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 19:25:04 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F39481F54E;
        Mon, 22 Aug 2022 02:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1661135104;
        bh=RfKE4cZGLi5lsTTRqEu8tynhWgaF/6soMXaViLJwYTE=;
        h=Date:From:To:Cc:Subject:From;
        b=qtfGOyfx30Dv6A68omjRLoi++yb6sUc3g7sw0YSSyIulhEc6YVvRqETws0GqGJ+7h
         nTGaM5xS55fyLsCHBXeJjeitsqHXPcL9BvPhWwS7Y50VGWaBDrCJaBRiGJQWfPgsm9
         Di8yYmRT/B/XK+JFnkO/g/qMPzmb1dZwZ3laj3Y8=
Date:   Mon, 22 Aug 2022 02:25:03 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     meta@public-inbox.org
Subject: `git patch-id --stable' vs quoted-printable
Message-ID: <20220822022503.M873583@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While poking around at the newish patchid indexing support in
public-inbox[1], I noticed an inconsistency in how it seems to
mishandle quoted-printable messages.

For instance, René's message can apply fine with `git am':

https://public-inbox.org/git/6727daf1-f077-7319-187e-ab4e55de3b2d@web.de/raw

However, note the blank context lines are truly blank, as in /^$/,
not /^ $/.  Running `git patch-id --stable' on the decoded content
of that message gives me: a245e99dbd2ce6e319955569eb8a111cb044f474
And that's the value public-inbox indexes.

That patch ends up being commit fc0f8bcd64eb0a03a7098f72da9c4008bd48cf11
in git.git.

However,
`git show fc0f8bcd64eb0a03a7098f72da9c4008bd48cf11 |git patch-id --stable'
gives me: fcac4cf581e11b703c229a129072c95c79b68bf

So, I'm wondering if the search indexing code of public-inbox
should s/^$/ /mgs before feeding stuff to `git patch-id'; and/or
if `git patch-id' should be assuming empty lines and lines with a
single SP are the same...


[1] https://public-inbox.org/meta/20220620192730.550803-3-e@80x24.org/
