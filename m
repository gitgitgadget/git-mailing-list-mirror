Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266E5209B8
	for <e@80x24.org>; Mon, 11 Sep 2017 21:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdIKVsr (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 17:48:47 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:20279 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdIKVsq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 17:48:46 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id rWZQdVcLNbjdZrWZQdvClp; Mon, 11 Sep 2017 22:48:44 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=nyiQwibr_shMYxUHA5QA:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <E8C827ED458648F78F263F2F2712493B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Pavel Kretov" <firegurafiku@gmail.com>, <git@vger.kernel.org>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
Subject: Re: [idea] File history tracking hints
Date:   Mon, 11 Sep 2017 22:48:46 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170911-0, 11/09/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfOdC5PCObr3gcywnkpkQW/4prMxFnXvchYKDN1He0RPLuVRmuVCYDjxWXhM1ghTX1tNnzOvNizQpZrMOXKVCxdIWikI4Svlywgg6UVnheJgKuwNOMu/5
 o2Fog/AgMdjwOC/npOOX8aSVFxY0NQqZCgD+jq0r/1AdHmpirM8TsSNYgEbtuGr04xu+Zu0x7sqKbW2e+qahWC2RxAfQHjuwylA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Pavel Kretov" <firegurafiku@gmail.com>
> Hi all,
>
> Excuse me if the topic I'm going to raise here has been already discussed
> on the mailing list, forums, or IRC, but I couldn't find anything related.
>
>
> The problem:
>
> Git, being "a stupid content tracker", doesn't try to keep an eye on
> operations which happens to individual files; things like file renames
> aren't recorded during commit, but heuristically detected later.
>
> Unfortunately, the heuristic can only deal with simple file renames with
> no substantial content changes; it's helpless when you:
>
> - rename file and change it's content significantly;
> - split single file into several files;
> - merge several files into another;
> - copy entire file from another commit, and do other things like these.
>
> However, if we're able to preserve this information, it's possible
> not only to do more accurate 'git blame', but also merge revisions with
> fewer conflicts.
>
>
> The proposal:
>
> The idea is to let user give hints about what was changed during
> the commit. For example, if user did a rename which wasn't automatically
> detected, he would append something like the following to his commit
> message:
>
>    Tracking-hints: rename dev-vcs/git/git-1.0.ebuild ->
> dev-vcs/git/git-2.0.ebuild
>
> or (if full paths of affected files can be unambiguously omitted):
>
>    Tracking-hints: rename git-1.0.ebuild -> git-2.0.ebuild
>
> There may be other hint types:
>
>    Tracking-hint: recreate LICENSE.txt
>    Tracking-hint: split main.c -> main.c cmdline.c
>    Tracking-hint: merge linalg.py <- vector.py matrix.py
>
> or even something like this:
>
>    Tracking-hint: copy json.py <-
> libs/json.py@4db88291251151d8c5c8e4f20430fa4def2cb2ed
>
> If file transformation cannot be described by a single tracking hint, it 
> shall
> be possible to specify a sequence of hints at once:
>
>    Tracking-hint:
>        split Utils.java -> AppHelpers.java StringHelpers.java
>        recreate Utils.java
>
> Note that in the above example the order of operations really matters, so
> both lines have to reside in one 'Tracking-hint' block.
>
> * * *
>
> How do you think, is this idea worth implementing?
> Any other thoughts on this?
>
> -- Pavel Kretov.

Maybe use the "interpret-trailers" methods for standardising your hints 
locally (in your team / workplace) to see how it goes and flesh out what 
works and what doesn't. Trying to decide, a-priori, what are the right hints 
is likely to be the hard part.
--
Philip 

