Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E514A202AF
	for <e@80x24.org>; Thu, 16 Nov 2017 11:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934298AbdKPLTa convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 16 Nov 2017 06:19:30 -0500
Received: from mailout.ip-plus.net ([164.128.36.32]:34669 "EHLO
        mailout.ip-plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934037AbdKPLTV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 06:19:21 -0500
Received: from mailhost2.helsana.ch (unknown [193.73.106.133])
        by mailout.ip-plus.net (Postfix) with ESMTP id E03E22062C
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 12:19:19 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.44,402,1505772000"; 
   d="scan'208";a="23535050"
Received: from unknown (HELO TrustMail) ([192.168.130.113])
  by mailhost2.helsana.ch with SMTP; 16 Nov 2017 12:19:19 +0100
X-FilterName: OutgointMailToTrustmailLB
X-IronPort-AV: E=Sophos;i="5.44,402,1505772000"; 
   d="scan'208";a="23535049"
From:   Ninivaggi Mattia <mattia.ninivaggi@helsana.ch>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [Feature- Request] Option to commit after checking out branch
 command is made
Thread-Topic: [Feature- Request] Option to commit after checking out branch
 command is made
Thread-Index: AdNeJI/H/NuxvwNOQkuzmHO0ARwB7gATBGc/ABblvQA=
Date:   Thu, 16 Nov 2017 11:19:19 +0000
Message-ID: <b97ebd6b7edd4c17a9c87f22af13ee6c@MSSMAILP06.ads.hel.kko.ch>
References: <670f44c0ac554f2faec5a6112376b015@MSSMAILP06.ads.hel.kko.ch>
 <xmqqtvxvxefx.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqtvxvxefx.fsf@gitster.mtv.corp.google.com>
Accept-Language: de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.30.238.29]
x-c2processedorg: cfdb09a0-13e2-4260-a47c-f8e494924444
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I like the --autostash flag. 
But actually you just could write an alias co="git stash && git checkout" and use co dev for the same purpose, rendering the change irrelevant.

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Thursday, November 16, 2017 1:20 AM
To: Ninivaggi Mattia
Cc: git@vger.kernel.org
Subject: Re: [Feature- Request] Option to commit after checking out branch command is made

Ninivaggi Mattia <mattia.ninivaggi@helsana.ch> writes:

> 1. I checkout a branch, without having commited first
>     > git checkout dev
> 2. I get this error message:
>     > error: Your local changes to the following files would be overwritten by checkout:
>     > // List of files
>     > // ..
>     > //
>     > Please commit your changes or stash them before you switch branches.
>
> But I would rather prefer a scenario like this:
> ...
> 1. I checkout a branch, without having commited first
>     > git checkout dev
> 2. I get a message like this:
>     > Your local changes to the following files would be overwritten by checkout:
>     > // List of files
>     > // ..
>     > //
>     > Would you want to commit first? (y/n))
>
> IF y --> prompt for commit message and commit automatically

I do not think you want to do this for a few reasons.

 * The "please commit or stash" is merely a suggestion whose primary
   purpose is to silence clueless newbies who would have complained
   "Git said 'error: ... overwritten by checkout' and I do not know
   what to do next; the error message is so unhelpful" otherwise.
   Majority of the time when I see this message, it is because I
   forgot that I was in the middle of doing something (meaning: I am
   far from finished with the changes I was working on), and I would
   not be ready to commit.  I'd rather keep working to get the work
   into a more reasonable shape before committing, or stash the
   changes first if the task I wanted to do on that "dev" branch is
   more urgent and what I was in the middle of doing is lower
   priority.  

   Because of this, I would expect many users (including the ones
   who are right now newbies but will have gained experience to
   become experts in the future) to appreciate "stash before switch"
   a lot more than "commit first before switch".

 * People write scripts that use "git checkout" to switch branches,
   and they rely on the command to fail in this situation, instead
   of going interactive and gets stuck waiting for an input (which
   may never come).  Because of this, the updated behaviour you
   propose must never be the default, and at least must be protected
   behind a flag, something like "git checkout --autostash dev" (or
   "--autocommit", if you insist).  With that, you could do

	[alias]
		co = checkout --autostash

   and train your fingers to say "git co dev".

Of course, you can have a "git-co" script on your $PATH, which runs "git checkout $1", lets it fail just like it does now, and then does "git commit", if you really want the behaviour.  Again, you can then use "git co dev" and you do not have to worry about breaking people's scripts that depends on "git checkout" to fail without going interactive.
