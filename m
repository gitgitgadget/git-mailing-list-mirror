X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: jgit performance update
Date: Sat, 2 Dec 2006 23:59:53 -0500
Message-ID: <20061203045953.GE26668@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 05:00:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33095>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqjSb-0006OM-1D for gcvg-git@gmane.org; Sun, 03 Dec
 2006 06:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424947AbWLCE76 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 23:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424948AbWLCE76
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 23:59:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45737 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1424947AbWLCE75
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 23:59:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GqjS3-0004C7-Im for git@vger.kernel.org; Sat, 02 Dec 2006 23:59:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4AA8120FB7F; Sat,  2 Dec 2006 23:59:54 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

With the help of Robin Rosenberg I've been able to make jgit's log
operation run (on average) within a few milliseconds of core Git.

Walking the 50,000 most recent commits from the Mozilla trunk[1]:

  $ time git rev-list --max-count=50000 HEAD >/dev/null

  core Git:  1.882s (average)
  jgit:      1.932s (average)

  (times are with hot cache and from repeated executions)

I think that is actually pretty good given that jgit is written
in Java using a fairly object-oriented design and has to deal with
some of the limitations of the language.

One of the biggest annoyances has been the fact that although Java
1.4 offers a way to mmap a file into the process, the overhead to
access that data seems to be far higher than just reading the file
content into a very large byte array, especially if we are going
to access that file content multiple times.  So jgit performs worse
than core Git early on while it copies everything from the OS buffer
cache into the Java process, but then performs reasonably well once
the internal cache is hot.  On the other hand using the mmap call
reduces early latency but hurts the access times so much that we're
talking closer to 3s average read times for the same log operation.

Anyway, jgit is now hopefully fast enough that we can start to build
some real functionality on top of it, and not need to wait several
minutes for answers from those features while debugging them.  :)


**1** This is the pack file from Jon Smirl's import attempt.

-- 
