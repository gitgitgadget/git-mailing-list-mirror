Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CB820756
	for <e@80x24.org>; Fri, 13 Jan 2017 20:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbdAMUUS (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 15:20:18 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:27565 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdAMUUS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 15:20:18 -0500
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v0DKKCBp004167
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2017 20:20:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v0DKKCiT028674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2017 20:20:12 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v0DKKCRC010382;
        Fri, 13 Jan 2017 20:20:12 GMT
Received: from [10.175.225.84] (/10.175.225.84)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Jan 2017 12:20:11 -0800
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty
 lines in context
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
 <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
 <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
 <xmqqeg06hh6z.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <c74c260d-1a4d-39f6-a644-4f90a67d6d82@oracle.com>
Date:   Fri, 13 Jan 2017 21:20:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqeg06hh6z.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/01/2017 20:51, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
>> That's true, but I'm not sure "non-empty line before function line" is
>> good enough a definition for desirable lines.  It wouldn't work for
>> people who don't believe in empty lines.  Or for those that put a
>> blank line between comment and function.  (I have an opinion on such
>> habits, but git diff should probably stay neutral.)  And that's just
>> for C code; I have no idea how this heuristic would hold up for other
>> file types like HTML.
>
> As you are, I am fairly negative on the heuristic based on the
> "non-blank" thing.  We tried once with compaction-heuristics already
> and it did not quite perform well.  Let's not hardcode another one.

The patch will work as intended and as expected for 95% of the users out
there (javadoc, Doxygen, kerneldoc, etc. all have the comment
immediately preceding the function) and fixes a very real problem for me
(and I expect many others) _today_; for the remaining 5% (who put a
blank line between their comment and the start of the function) it will
revert back to the current behaviour, so there should be no regression
for them.

For the 0% who don't put even a single blank line between their
functions, it will probably not work as expected, but then again I have
never seen such a coding style in any language, so I am doubtful if this
is something that needs to be taken into account in the first place.

>> We can identify function lines with arbitrary precision (with a
>> xfuncname regex, if needed), but there is no accurate way to classify
>> lines as comments, or as the end of functions.  Adding optional
>> regexes for single- and multi-line comments would help, at least for
>> C.
>
> The funcline regexp is used for two related but different purposes.
> It identifies a single line to be placed on @@ ... @@ line before a
> diff hunk.  This line however does not have to be at the beginning
> of a function.  It has to be the line that conveys the most
> significant information (e.g. the name of the function).
>
> The way "diff -W" codepath used it as if it were always the very
> first line of a function was bound to invite a patch like this, and
> if we want to be extra elaborate, I agree that an extra mechanism to
> say "the line the funcline regexp matches is not the beginning of a
> function, but the beginning is a line that matches this other regexp
> before that line" may help.
>
> Do we really want to be that elaborate, though?  I dunno.

Adding a regex instead of the simple "blank line" test doesn't seem very
difficult to do, but I am doubtful that it will make any difference in
practice. But that can be done incrementally as well by the people who
would actually need it (who I strongly suspect do not exist in the first
place).

> I wonder if it would be sufficient to make -W take an optional
> number, e.g. "git show -W4", to add extre context lines before the
> funcline.
>

I don't like specifying a fixed number, that negates almost all the
reason for using -W in the first place; I would much prefer adding
a config variable to control the -W behaviour (or a new diff flag).


Vegard
