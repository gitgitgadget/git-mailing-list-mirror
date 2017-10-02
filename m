Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3ED020281
	for <e@80x24.org>; Mon,  2 Oct 2017 18:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbdJBSv3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 14:51:29 -0400
Received: from siwi.pair.com ([209.68.5.199]:16023 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdJBSv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 14:51:28 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0D76584673;
        Mon,  2 Oct 2017 14:51:27 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B50388466F;
        Mon,  2 Oct 2017 14:51:26 -0400 (EDT)
Subject: Re: [idea] File history tracking hints
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>,
        Pavel Kretov <firegurafiku@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
 <E8C827ED458648F78F263F2F2712493B@PhilipOakley>
 <alpine.DEB.2.21.1.1709131322470.4132@virtualbox>
 <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley>
 <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
 <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com>
 <xmqqtvzjv987.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbghnWmvQweup=Z79HnVQQCMM65CKgEO3oqDoRp-Bj=2Q@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ea1538e3-2b2e-f7eb-9c0e-e29c15bf2ea9@jeffhostetler.com>
Date:   Mon, 2 Oct 2017 14:51:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbghnWmvQweup=Z79HnVQQCMM65CKgEO3oqDoRp-Bj=2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/2/2017 1:41 PM, Stefan Beller wrote:
>>> It would be nice if every file (and tree) had a permanent GUID
>>> associated with it.  Then the filename/pathname becomes a property
>>> of the GUIDs.  Then you can exactly know about moves/renames with
>>> minimal effort (and no guessing).
>>
> ...
> 
>> https://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/
>>
>> I'd encourge people to read and re-read that message until they can
>> recite it by heart.
> 
> I have rethought about the idea of GUIDs as proposed by Jeff and wanted
> to give a reply. After rereading this message, I think my thoughts are
> already included via:
> 
>    - you're doing the work at the wrong point for _another_ reason. You're
>       freezing your (crappy) algorithm at tree creation time, and basically
>       making it pointless to ever create something better later, because even
>       if hardware and software improves, you've codified that "we have to
>       have crappy information".
> 
> --
> My design proposal for these "rename hints" would be a special trailer,
> roughly:
> 
>      Rename: LICENSE -> legal.txt
>      Rename: t/* -> tests/*
> 
> or more generally:
> 
>      Rename: <pathspec> <delim> <pathspec>
> 
> This however has multiple issues due to potential
> human inaccuracies:
> (A) typos in the trailer key or in the pathspec
>     (resulting in different error modes)
> (B) partial hints (We currently have a world of
>     completely missing hints, so I would not expect it to
>     be worse?)
> (C) wrong hints. This ought to be no problem as Git would
>     take some CPU time to conclude the hint was bogus.
> 
> For (A), I would imagine we want a mechanism (e.g. notes)
> to "correct" the hints. This is the similar issue as a typo in a
> commit message, which we currently just ignore if the
> commit has been merged to e.g. master.
> 
> So maybe we'd just design around that, giving the option
> to give the correct hints via command line.
> 
> So if the commit has the typo'd hint
> 
>      Remame:  t/* -> tests/*
> 
> the human would see that (and also conclude that by
> the commit message), and then invoke
> 
> git log -C -C-hint="t/* -> tests/*" ...
> 
> which would have the corrected hint and hence deliver
> the best output.
> 
> Maybe the "-C-hint" flag is the best starting point when
> going in that direction?
> 
> Thanks,
> Stefan
> 

Sorry to re-re-...-re-stir up such an old topic.

I wasn't really thinking about commit-to-commit hints.
I think these have lots of problems.  (If commit A->B does
"t/* -> tests/*" and commit B->C does "test/*.c -> xyx/*",
then you need a way to compute a transitive closure to see
the net-net hints for A->C.  I think that quickly spirals
out of control.)

No, I was going in another direction.  For example, if a
tree-entry contains { file-guid, file-name, file-sha, ... }
then when diffing any 2 commits, you can match up files
(and folders) by their guids.  Renames pop out trivially when
their file-names don't match.  File moves pop out when the
file-guids appear in different trees.  Adds and deletes pop
out when file-guids don't have a peer. (I'm glossing over some
of the details, but you get the idea.)  To address Junio's
question, independently added files with the same name will
have 2 different file-guids.  We amend the merge rules to
handle this case and pick one of them (say, the one that
is sorts less than the other) as the winner and go on.
All-in-all the solution is not trivial (as there are a few
edge cases to deal with), but it better matches the (casual)
user's perception of what happened to their tree over time.
It also doesn't require expensive code to sniff for renames
on every command (which doesn't scale on really large repos).

But as I said before, that ship has passed...
Jeff
