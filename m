Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3484120357
	for <e@80x24.org>; Mon, 10 Jul 2017 16:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbdGJQje (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 12:39:34 -0400
Received: from ser-smtp-vm-1.dakosy.de ([195.244.0.87]:57205 "EHLO
        ser-smtp-vm-1.dakosy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754322AbdGJQjd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 12:39:33 -0400
Received: from [10.7.2.114] (helo=ser-smtpdak-vm-1.dakosy.de)
        by ser-smtp-vm-1.dakosy.de with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <neuling@dakosy.de>)
        id 1dUbie-0002B4-7h
        for git@vger.kernel.org; Mon, 10 Jul 2017 18:39:32 +0200
Received: from daktales1.dakosy.de ([10.7.2.20])
        by ser-smtpdak-vm-1.dakosy.de with esmtp (Exim 4.82)
        (envelope-from <neuling@dakosy.de>)
        id 1dUbie-00065m-0B
        for git@vger.kernel.org; Mon, 10 Jul 2017 18:39:32 +0200
In-Reply-To: <OF9C7EC4BE.7EA71FCD-ONC1258159.003A60B3-C1258159.0058C18F@LocalDomain>
References: <OF9C7EC4BE.7EA71FCD-ONC1258159.003A60B3-C1258159.0058C18F@LocalDomain>
To:     git@vger.kernel.org
MIME-Version: 1.0
Subject: Performance improvement for git pull rebase and autostash 
X-KeepSent: 53944D94:A662A3B8-C1258159:005AD737;
 type=4; name=$KeepSent
Message-ID: <OF53944D94.A662A3B8-ONC1258159.005AD737-C1258159.005B828E@dakosy.de>
From:   neuling@dakosy.de
Date:   Mon, 10 Jul 2017 18:39:32 +0200
Content-Type: text/plain; charset="US-ASCII"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, the max characters per line restriction of the e-mail broke the 
workflow.

Here it is again. 

          git pull rebase = true or preserve
                               |
                               |
                               |
                               |
                               |
            check if local branch has no new commits
                               |
         no                    |                   yes
          ---------------------+--------------------- 
          |                                         |
          |                                         |
          |                                         |
   rebase validation                      ff merge validation for 
   for local changes                      conflicting local changes 
          |                                         |
no changes|      changes             no conflicts   |    has conflicts 
  --------+---------                    ------------+----------
  |                |                    |                     |
  |                |                    |                     |
  |                |                    |                     |
do rebase     use autostash?         do ff merge         use autostash?
  |                |                    |                     |
  |        no      |      yes           |            no       |      yes
  |        --------+---------           |            ---------+---------
  |        |                |           |            |                 |
  |        |                |           |            |                 |
  |   conflict error   stash changes    |  conflict error   stash changes
  |        |                |           |            |                 |
  |        |                |           |            |                 |
  |        |            do rebase       |            |           ff merge
  |        |                |           |            |                 |
  |        |                |           |            |                 |
  |        |            pop stash       |            |          pop stash
  |        |                |           |            |                 |
  |        |                |           |            |                 |
success  abort           success     success       abort          success



Regarda,
Mattias




Von:    Mattias Neuling/DAKOSY/DE
An:     git@vger.kernel.org
Datum:  10.07.2017 18:09
Betreff:        Performance improvement for git pull rebase and autostash 



Hi,

I have some suggestions to improve performance of 'git pull --rebase'.

1. If I have no new local commits "git pull --rebase" will do a fast 
forward merge. But if I have changes to local files I have to stash them 
also if they are not affected by the new commits from origin. I think in 
that case git should not reject changes to every local file and has to use 

the fast forward merge validation instead.

2. If I have no changes to local files and I use 'git pull --rebase 
--autostash' no stashing should take place.


The improved workflow would look like as follows.


                         git pull rebase = true or preserve
                               |
                               |
                               |
                               |
                               |
                        check if local branch has no new commits
                               |
         no                    |                   yes
          ---------------------+--------------------- 
          |                                         |
          |                                         |
          |                                         |
   rebase validation                      ff merge validation for 
   for local changes                      conflicting local changes 
          |                                         |
no changes|      changes             no conflicts   |    has conflicts 
  --------+---------                    ------------+----------
  |                |                    |                     |
  |                |                    |                     |
  |                |                    |                     |
do rebase     use autostash?         do ff merge         use autostash?
  |                |                    |                     |
  |        no      |      yes           |            no       |      yes
  |        --------+---------           |            ---------+---------
  |        |                |           |            |                 |
  |        |                |           |            |                 |
  |   conflict error   stash changes    |      conflict error     stash 
changes
  |        |                |           |            |                 |
  |        |                |           |            |                 |
  |        |            do rebase       |            |            do ff 
merge
  |        |                |           |            |                 |
  |        |                |           |            |                 |
  |        |            pop stash       |            |             pop 
stash
  |        |                |           |            |                 |
  |        |                |           |            |                 |
success  abort           success     success       abort success



Regarda,
Mattias





