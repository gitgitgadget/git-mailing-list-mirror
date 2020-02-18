Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EFCC34022
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 00:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D398F2072C
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 00:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spoje.net header.i=@spoje.net header.b="RUSF8gg4";
	dkim=pass (1024-bit key) header.d=spoje.net header.i=@spoje.net header.b="C3fmuPzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgBRAga (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 19:36:30 -0500
Received: from mail.spoje.net ([82.100.58.2]:52330 "EHLO mail.spoje.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgBRAg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 19:36:29 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 19:36:29 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.spoje.net (Postfix) with ESMTP id 1CB2162DA9F
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 01:29:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoje.net;
        s=spojemail; t=1581985767;
        bh=mluFdHpbfQitUCjK1ER0aV+1P7kn3OjUl/+kLy4HhA4=;
        h=To:Subject:Date:From:From;
        b=RUSF8gg4Spt13AOgNNUS/mnswIDWCtnvMQh6olq9gvQjXnQPtL3kfLbX6glyCSP6O
         Wat7bebGTKG89rmBnzabMloPTwfmMCf8Llthv+42d/QxnKIglLNOCbPrsZw1P1DcFn
         wy43A3ZHHY4lUC5YDl4rfIM1ubuIYahM9oPuukm8=
X-Virus-Scanned: Debian amavisd-new at mail.spoje.net
Authentication-Results: mail.spoje.net (amavisd-new); dkim=pass (1024-bit key)
        header.d=spoje.net
Received: from mail.spoje.net ([127.0.0.1])
        by localhost (mail.spoje.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o0QbA5BIUsog for <git@vger.kernel.org>;
        Tue, 18 Feb 2020 01:29:24 +0100 (CET)
Received: by mail.spoje.net (Postfix, from userid 33)
        id 94FA262DF92; Tue, 18 Feb 2020 01:29:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoje.net;
        s=spojemail; t=1581985764;
        bh=mluFdHpbfQitUCjK1ER0aV+1P7kn3OjUl/+kLy4HhA4=;
        h=To:Subject:Date:From:From;
        b=C3fmuPzJgKfpFJAmGBfDVeGU8PJ4sPubVWbLjz8fCGwDo9YMBrhXD4/ZYcCFg698v
         r0m/i5u8JDrCC8PYqU2wWdXhDryjOVZQv46nc3vdhsV8w/HmypgvclTTIBtWqwu+GL
         Oj9snpi6kIyO8lTrYpgPGgxQLtuVmhrB1LCsKsJY=
To:     git@vger.kernel.org
Subject: "Garbage collect" old commits in git repository to free disk space
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 18 Feb 2020 01:29:24 +0100
From:   Tomas Mudrunka <mudrunka@spoje.net>
Organization: SPOJE.NET s.r.o.
Message-ID: <8a4001f7b0e23e7df3172deeb32e0553@spoje.net>
X-Sender: mudrunka@spoje.net
User-Agent: Roundcube Webmail/1.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
is there safe way to garbage collect old commits from git repository? 
Lets say that i want to always keep only last 100 commits and throw 
everything older away. To achieve similar goal as git clone --depth=100, 
but on the server side. I had partial success with doing shallow clone 
and then converting to bare repo while removing the shallow flag from 
.git/config. But i didn't liked that solution and wasn't really sure 
what consequences in terms of data integrity and forward compatibility 
with newer git versions might be.

To tell you more about my USE CASE:

I want to create free opensource sofware similar to dropbox, but based 
on git. My idea is following:

1.) Automaticaly pull/commit/push changed files to/from several laptops 
to single git server (and forcefully resolve all conflicts, this will 
work unless you plan to use it for software development)
2.) On central server maintain tags indicating latest commits 
synchronized to individual laptops.
3.) On server delete old commits that are no longer needed by any laptop 
to sync their worktree. Once synced, delete these commits on laptops as 
well. (optionaly leaving eg. 1 month or 1GB of old commits in case you 
might need to rollback. Possibly keep the history only on the server, 
while deleting it from clients)

This way computers can stay in sync forever without running out of disk 
space, because old commits are removed.
Eg. If i accidentaly add some very big file to synced folder and then 
delete it, it will eventualy get deleted, once everybody gets in sync 
again.

I am aware that this is not something which git was designed for, but to 
me it seems like it should be more than doable. Do you think, any of you 
can give me some hints on how to approach this problem please?


These are some projects which inspired me to explore this route:

https://github.com/presslabs/gitfs
https://www.syncany.org/
https://www.cis.upenn.edu/~bcpierce/unison/
https://etckeeper.branchable.com/

-- 
S pozdravem
Best regards
      Tomáš Mudruňka - SPOJE.NET s.r.o.
