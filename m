Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640252013E
	for <e@80x24.org>; Sun,  5 Mar 2017 15:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbdCEPKc (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 10:10:32 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:55471 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbdCEPKb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 10:10:31 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id kXimcgMkEcpskkXimcaFY0; Sun, 05 Mar 2017 15:05:17 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=Rp_30te1BF9egnFd-KEA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <5556D465CF3A42C8B117759A170FE3A7@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
References: <xmqqvarq9vzo.fsf@gitster.mtv.corp.google.com>        <D9E30A61FAC84D3B90981B388C9699D0@PhilipOakley> <xmqqd1dx7wbl.fsf@gitster.mtv.corp.google.com>
Subject: Re: bisect-helper: we do not bisect --objects
Date:   Sun, 5 Mar 2017 15:05:19 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfFdngkaoBhc7Em/KcGRp2qSheq6xER6MeuRHHW5zkL8Qzv9j/D2VSivP5Tz+i73/FbZyK4P/HLCfcn6Yz3Gh1X6Kq7yAPRQ/KyohzTfXzJMJ6468vh5R
 /oPNu1svJNxY8niU7XvRM3rI0JRpdsrYZfbdh3aJYXuJA5j082SyrzmF4GrmmzxAk9b4/Sy0neJyXc1O7DoJ7gHfb45ND2zBT7DXmTCRxy2k9vg1JZqojVgo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Bikeshedding: If the given boundary is a tag, it could be tagging a
>> blob or tree rather than a commit. Would that be a scenario that
>> reaches this part of the code?
>
> I do not think it is relevant.
>
> Bisection is an operation over a "bisectable" commit DAG, where
> commits can be partitioned into "new" (aka "bad") and "old" (aka
> "good") camp, all descendants of a "new" commit are all "new", all
> ancestors of an "old" commit are all "old".  Think of the "new"-ness
> as a 100% inheritable disease that happens spontaneously and without
> cure.  Once you are infected with "new"-ness, all your descendants
> are forever "new".  If you know you are free of the "new"-ness, you
> know that all your ancestors are not with the "new"-ness, either.
>
> The goal of the operation is to find a "new" commit whose parents
> are all "old".
>
> The bisectability of the commit DAG is what allows you to say "this
> commit is new" to a commit somewhere in the middle of the history
> and avoid having to test any descendants, as they all inherit the
> "new"-ness from it (similarly when you have one commit that is
> "old", you do not have to test any ancestor), thereby reducing the
> number of test from N (all commits in good..bad range) to log(N).
>
> There is no room for a tree or a blob to participate in this graph
> partitioning problem.  A "bad" tree that is "new" cannot infect its
> children with the "new"-ness and a "good" tree cannot guarantee the
> lack of "new"-ness of its parents, because a tree or a blob does not
> have parent or child commits.
>
Thanks.

I was happy with how the bisect actually works. I was more responding the 
the open question about how that piece of code may have come into existance, 
and the potential thought processes that can lead to such 'mistakes'.

My line of reasoning was that it is reasonable to pass both commits and 
tags, as revisions(7), to the cli as being the bad and good points in the 
graph. This could then lead to a expectation that the objects they point to 
should be suitably marked, which is quite reasonable for commits, and for 
most tags.

However there are tags that point to the commit tree, rather than the commit 
itself, so if that initial rule was followed in a simplistic manner, then 
(falsely) the peeled tree of the tag would be marked as good/bad, which as 
your patch identifies, would be the wrong thing to do.

The study of human error is quite interesting....

regards

Philip


