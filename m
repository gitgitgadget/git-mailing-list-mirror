Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6631FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 14:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755144AbdAAOun (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 09:50:43 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:12636 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755109AbdAAOum (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 09:50:42 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3ts36S6Ch8z5tlS;
        Sun,  1 Jan 2017 15:50:40 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 07FB6100;
        Sun,  1 Jan 2017 15:50:39 +0100 (CET)
Subject: Re: [PATCH] don't use test_must_fail with grep
To:     Luke Diamand <luke@diamand.org>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
 <CAE5ih7-7e+ZLUbE7iquWV2=qP4ofzAHUC2ZPg3b-ivSpCo4eRw@mail.gmail.com>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <285ed013-5c59-0b98-7dc0-8f729587a313@kdbg.org>
Date:   Sun, 1 Jan 2017 15:50:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAE5ih7-7e+ZLUbE7iquWV2=qP4ofzAHUC2ZPg3b-ivSpCo4eRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.01.2017 um 15:23 schrieb Luke Diamand:
> On 31 December 2016 at 11:44, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
>> index 0fe231280..2384535a7 100755
>> --- a/t/t9813-git-p4-preserve-users.sh
>> +++ b/t/t9813-git-p4-preserve-users.sh
>> @@ -126,13 +126,13 @@ test_expect_success 'not preserving user with mixed authorship' '
>>                 grep "git author charlie@example.com does not match" &&
>>
>>                 make_change_by_user usernamefile3 alice alice@example.com &&
>> -               git p4 commit |\
>> -               test_must_fail grep "git author.*does not match" &&
>> +               ! git p4 commit |\
>> +               grep "git author.*does not match" &&
>
> Would it be clearer to use this?
>
>     git p4 commit |\
>     grep -q -v "git author.*does not match" &&
>
> With your original change, I think that if "git p4 commit" fails, then
> that expression will be treated as a pass.

No. The exit code of the upstream in a pipe is ignored. For this reason, 
having a git invocation as the upstream of a pipe *anywhere* in the test 
suite is frowned upon. Hence, a better rewrite would be

	git p4 commit >actual &&
	! grep "git author.*does not match" actual &&

which makes me wonder: Is the message that we do expect not to occur 
actually printed on stdout? It sounds much more like an error message, 
i.e., text that is printed on stderr. Wouldn't we need this?

	git p4 commit >actual 2>&1 &&
	! grep "git author.*does not match" actual &&

-- Hannes

