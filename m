Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A7F1F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 11:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbdFHL6o (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 07:58:44 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:51670 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdFHL6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 07:58:43 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jun 2017 07:58:43 EDT
Received: from [91.113.179.170] (helo=[192.168.92.20])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.84)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1dIvyf-00030G-DX
        for git@vger.kernel.org; Thu, 08 Jun 2017 13:51:49 +0200
To:     git@vger.kernel.org
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: git stash --include-untracked possible destructive behavior
Message-ID: <2b695c73-9de2-5502-6d19-ba4ad0114978@syntevo.com>
Date:   Thu, 8 Jun 2017 13:52:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of our users has just discovered a destructive behavior of git stash 
--include-untracked: ignored files within non-ignored directories will 
not be stashed as untracked files (expected), but will still be removed 
from the working tree. The problem is reproducible by following command 
sequence:

   $ git init
   $ echo "1" > file.txt
   $ mkdir Data
   $ echo "1" > Data/ignored.txt
   $ echo "Data/*" > .gitignore
   $ git add .
   $ git commit -m "initial import"
   $ echo "2" > file.txt
   $ git stash save --include-untracked
   Saved working directory and index state WIP on master: 6ce5303 initial
   import

   $ git stash show stash@{1}
    file.txt | 2 +-
    1 file changed, 1 insertion(+), 1 deletion(-)

   $ ls Data
   ls: cannot access 'Data': No such file or directory

As you can see, after saving the stash, stash@{1} doesn't contain 
Data/ignored.txt, but the entire Data directory is still gone from the 
working tree. As a consequence, applying the stash won't bring back 
Data/ignored.txt, too.

   $ git stash apply
   On branch master
   Changes not staged for commit:
     (use "git add <file>..." to update what will be committed)
     (use "git checkout -- <file>..." to discard changes in working
     directory)

           modified:   file.txt

   no changes added to commit (use "git add" and/or "git commit -a")

   $ ls Data
   ls: cannot access 'Data': No such file or directory

Note that when changing .gitignore to "Data/" instead of "Data/*", 
--include-untracked works as expected.

Tested with: git version 2.13.0.windows.1

-Marc
