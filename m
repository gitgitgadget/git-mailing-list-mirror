Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33971F43C
	for <e@80x24.org>; Fri, 10 Nov 2017 09:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbdKJJp0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 04:45:26 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:32999 "EHLO mail.cixit.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751944AbdKJJpY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 04:45:24 -0500
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Nov 2017 04:45:24 EST
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
        by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id vAA9ddgm005585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 Nov 2017 10:39:39 +0100
Received: from localhost (peter@localhost)
        by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id vAA9ddIB005582;
        Fri, 10 Nov 2017 10:39:39 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Date:   Fri, 10 Nov 2017 10:39:39 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Git Mailing List <git@vger.kernel.org>
Subject: cherry-pick very slow on big repository
Message-ID: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 10 Nov 2017 10:39:39 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

On a big repository (57000 files, 2,5 gigabytes in .git/objects), git 
cherry-pick is very slow for me (v2.15.0). This is cherry-picking a 
one-file change, where the file is in the same place on both branches, 
and which applies cleanly (I am backporting a few fixes to a 
maintenance version):

$ time git cherry-pick -x 717eb328940ca2e33f14ed27576e656327854b7b
[redacted 391454f16d] Redacted
  Author: Redacted <redacted>
  Date: Mon Oct 16 15:58:05 2017 +0200
  1 file changed, 2 insertions(+), 2 deletions(-)

real    6m9,054s
user    5m49,432s
sys     0m2,292s

Something is not how it should be here. The repo shares objects 
(.git/objects/info/alternates) with another repository (I have run 
"git gc" on both repositories).

Running strace, it seems like it is doing lstat(), open(), mmap(), 
close() and munmap() on every single file in the repository, which 
takes a lot of time.

I thought it was just updating the status, but "git status" returns 
immediately, while cherry-picking takes several minutes for every 
cherry-pick I do.

-- 
\\// Peter - http://www.softwolves.pp.se/
