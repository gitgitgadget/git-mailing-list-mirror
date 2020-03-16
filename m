Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABECC0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 08:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C1320658
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 08:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgCPIf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:35:57 -0400
Received: from continuum.iocl.org ([217.140.74.2]:36217 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbgCPIf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 04:35:57 -0400
X-Greylist: delayed 725 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 04:35:56 EDT
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id 02G8NmN26700;
        Mon, 16 Mar 2020 09:23:48 +0100
X-Authentication-Warning: inner.h.uberluser.org: krey set sender to andreas@ulmdo.de using -f
Date:   Mon, 16 Mar 2020 09:23:48 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Subject: Avoid race condition between fetch and repack/gc?
Message-ID: <20200316082348.GA26581@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

we occasionally seeing things like this:

| DEBUG: 11:25:20: git -c advice.fetchShowForcedUpdates=false fetch --no-show-forced-updates -q --prune
| Warning: Permanently added '[socgit.$company.com]:7999' (RSA) to the list of known hosts.
| remote: fatal: packfile ./objects/pack/pack-20256f2be3bd51b57e519a9f2a4d3df09f231952.pack cannot be accessed        
| error: git upload-pack: git-pack-objects died with error.
| fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
| remote: aborting due to possible repository corruption on the remote side.
| fatal: protocol error: bad pack header

and when you look in the server repository there is a new packfile dated just around
that time. It looks like the fetch tries to access a packfile that it assumes to exist,
but the GC on the server throws it away just in that moment, and thus upload-pack fails.

Is there a way to avoid this?

Should there be, like git repack waiting a bit before deleting old packfiles?

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
