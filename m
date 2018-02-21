Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68F41F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeBUWOp (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:14:45 -0500
Received: from titan.plasma.xg8.de ([85.10.203.189]:37612 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUWOp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:14:45 -0500
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w1LMEdLg005253
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Feb 2018 23:14:39 +0100
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w1LMEc3M005252;
        Wed, 21 Feb 2018 23:14:39 +0100
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w1LMEKfg008145;
        Wed, 21 Feb 2018 23:14:20 +0100
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w1LMEKpi008144;
        Wed, 21 Feb 2018 23:14:20 +0100
Date:   Wed, 21 Feb 2018 23:14:20 +0100
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Derek Fawcus <dfawcus+lists-git@employees.org>, git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180221221420.GA7743@helen.PLASMA.Xg8.DE>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <20180221210339.GA43094@accordion.employees.org>
 <87bmgif2pa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmgif2pa.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 10:33:05PM +0100, Ævar Arnfjörð Bjarmason wrote:
> This sounds like a sensible job for a git import tool, i.e. import a
> target directory into git, and instead of 'git add'-ing the whole thing
> it would look at the mtimes, sort files by mtime, then add them in order
> and only commit those files that had the same mtime in the same commit
> (or within some boundary).

I think that this would be The Wrong Thing to do.

The commit time is just that: The time the commit was done. The commit 
is an atomic group of changes to a number of files that hopefully bring 
the tree from one usable state into the next.

The mtime, in contrast, tells us when a file was most recently modified.

It may well be that main.c was most recently modified yesterday, and 
feature.c was modified this morning, and that only both changes taken 
together make sense as a commit, despite the long time in between.

Even worse, it may be that feature A took a long time to implement, so 
we have huge gaps in between the mtimes, but feature B was quickly done 
after A was finished. Such an algorithm would probably split feature A 
incorrectly into several commits, and group the more recently changed 
files of feature A with those of feature B.

And if Feature A and Feature B were developed in parallel, things get 
completely messy.

> The advantage of doing this via such a tool is that you could tweak it
> to commit by any criteria you wanted, e.g. not mtime but ctime or even
> atime.

Maybe, but it would be rather useless to commit by ctime or atime. You 
do one grep -r and the atime is different. You do one chmod or chown 
and the ctime is different. Those timestamps are really only useful for 
very limited purposes.

That ctime exists seems reasonable, since it's only ever updated when 
the inode is written anyway.

atime, in contrast, was clearly one of the rather nonsensical 
innovations of UNIX: Do one write to the disk for each read from the 
disk. C'mon, really? It would have been a lot more reasonable to simply 
provide a generic way for tracing read() system calls instead; then 
userspace could decide what to do with that information and which of it 
is useful and should be kept and perhaps stored on disk. Now we have 
this ugly hack called relatime to deal with the problem.

> You'd get the same thing as you'd get if git's tree format would change
> to include mtimes (which isn't going to happen), but with a lot more
> flexibility.

Well, from basic logic, I don't see how a decision not to implement a 
feature could possibly increase flexility. The opposite seems to be the 
case.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
